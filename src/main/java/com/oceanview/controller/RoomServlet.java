package com.oceanview.controller;

import com.oceanview.model.Room;
import com.oceanview.service.RoomService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@WebServlet("/rooms")
public class RoomServlet extends HttpServlet {
    private RoomService roomService;

    @Override
    public void init() {
        this.roomService = new RoomService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(req, resp);
                break;
            case "edit":
                showEditForm(req, resp);
                break;
            case "delete":
                deleteRoom(req, resp);
                break;
            default:
                listRooms(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        Room room = new Room();
        room.setRoomNumber(req.getParameter("roomNumber"));
        room.setType(req.getParameter("type"));
        room.setPricePerNight(new BigDecimal(req.getParameter("price")));
        room.setStatus(req.getParameter("status"));

        if (idStr == null || idStr.isEmpty()) {
            roomService.createRoom(room);
        } else {
            room.setId(Integer.parseInt(idStr));
            roomService.updateRoom(room);
        }
        resp.sendRedirect("rooms");
    }

    private void listRooms(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Room> listRooms = roomService.getAllRooms();
        req.setAttribute("listRooms", listRooms);
        req.getRequestDispatcher("jsp/room-list.jsp").forward(req, resp);
    }

    private void showNewForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("jsp/room-form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Optional<Room> existingRoom = roomService.getRoomById(id);
        existingRoom.ifPresent(room -> req.setAttribute("room", room));
        req.getRequestDispatcher("jsp/room-form.jsp").forward(req, resp);
    }

    private void deleteRoom(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        roomService.deleteRoom(id);
        resp.sendRedirect("rooms");
    }
}

package com.oceanview.controller;

import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import com.oceanview.service.ReservationService;
import com.oceanview.service.RoomService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/reservations")
public class ReservationServlet extends HttpServlet {
    private ReservationService reservationService;
    private RoomService roomService;

    @Override
    public void init() {
        this.reservationService = new ReservationService();
        this.roomService = new RoomService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null)
            action = "list";

        switch (action) {
            case "new":
                showNewForm(req, resp);
                break;
            case "cancel":
                cancelReservation(req, resp);
                break;
            case "confirm":
                confirmReservation(req, resp);
                break;
            default:
                listReservations(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Reservation res = new Reservation();
        res.setGuestName(req.getParameter("guestName"));
        res.setGuestEmail(req.getParameter("guestEmail"));
        res.setGuestPhone(req.getParameter("guestPhone"));
        res.setGuestAddressStreet(req.getParameter("guestAddressStreet"));
        res.setGuestAddressCity(req.getParameter("guestAddressCity"));
        res.setGuestAddressState(req.getParameter("guestAddressState"));
        res.setGuestAddressZip(req.getParameter("guestAddressZip"));
        res.setGuestAddressCountry(req.getParameter("guestAddressCountry"));
        res.setRoomId(Integer.parseInt(req.getParameter("roomId")));
        res.setCheckInDate(Date.valueOf(req.getParameter("checkIn")));
        res.setCheckOutDate(Date.valueOf(req.getParameter("checkOut")));

        boolean success = reservationService.createReservation(res);
        if (success) {
            resp.sendRedirect("reservations");
        } else {
            req.setAttribute("error", "Room not available for selected dates!");
            req.setAttribute("reservation", res);
            showNewForm(req, resp);
        }
    }

    private void listReservations(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Reservation> list = reservationService.getAllReservations();
        req.setAttribute("listReservations", list);
        req.getRequestDispatcher("jsp/reservation-list.jsp").forward(req, resp);
    }

    private void showNewForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Room> rooms = roomService.getAllRooms();
        req.setAttribute("rooms", rooms);
        req.getRequestDispatcher("jsp/reservation-form.jsp").forward(req, resp);
    }

    private void cancelReservation(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        reservationService.cancelReservation(id);
        resp.sendRedirect("reservations");
    }

    private void confirmReservation(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        reservationService.confirmReservation(id);
        resp.sendRedirect("reservations");
    }
}

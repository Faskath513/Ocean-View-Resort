package com.oceanview.service;

import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Room;
import java.util.List;
import java.util.Optional;

public class RoomService {
    private RoomDAO roomDAO;

    public RoomService() {
        this.roomDAO = new RoomDAO();
    }

    public RoomService(RoomDAO roomDAO) {
        this.roomDAO = roomDAO;
    }

    public List<Room> getAllRooms() {
        return roomDAO.findAll();
    }

    public Optional<Room> getRoomById(int id) {
        return roomDAO.findById(id);
    }

    public boolean createRoom(Room room) {
        // Validation logic could go here
        return roomDAO.save(room);
    }

    public boolean updateRoom(Room room) {
        return roomDAO.update(room);
    }

    public boolean deleteRoom(int id) {
        return roomDAO.delete(id);
    }
}

package com.oceanview.service;

import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Room;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class RoomServiceComprehensiveTest {

    @Mock
    private RoomDAO roomDAO;

    private RoomService roomService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        roomService = new RoomService(roomDAO);
    }

    @Test
    public void testGetAllRooms() {
        List<Room> mockRooms = new ArrayList<>();
        Room room1 = new Room();
        room1.setId(1);
        room1.setRoomNumber("101");
        room1.setType("SINGLE");

        mockRooms.add(room1);

        when(roomDAO.findAll()).thenReturn(mockRooms);

        List<Room> rooms = roomService.getAllRooms();
        assertEquals(1, rooms.size(), "Should return rooms");
    }

    @Test
    public void testGetRoomById_Found() {
        Room room = new Room();
        room.setId(1);
        room.setRoomNumber("101");

        when(roomDAO.findById(1)).thenReturn(Optional.of(room));

        Optional<Room> result = roomService.getRoomById(1);
        assertTrue(result.isPresent(), "Room should be found");
        assertEquals("101", result.get().getRoomNumber());
    }

    @Test
    public void testGetRoomById_NotFound() {
        when(roomDAO.findById(999)).thenReturn(Optional.empty());

        Optional<Room> result = roomService.getRoomById(999);
        assertFalse(result.isPresent(), "Room should not be found");
    }

    @Test
    public void testCreateRoom() {
        Room newRoom = new Room();
        newRoom.setRoomNumber("201");
        newRoom.setType("SUITE");
        newRoom.setPricePerNight(new BigDecimal("250.00"));

        when(roomDAO.save(newRoom)).thenReturn(true);

        boolean result = roomService.createRoom(newRoom);
        assertTrue(result, "Room should be created");
    }

    @Test
    public void testUpdateRoom() {
        Room room = new Room();
        room.setId(1);
        room.setStatus("MAINTENANCE");

        when(roomDAO.update(room)).thenReturn(true);

        boolean result = roomService.updateRoom(room);
        assertTrue(result, "Room should be updated");
    }

    @Test
    public void testRoomPriceValidation() {
        Room room = new Room();
        room.setPricePerNight(new BigDecimal("100.00"));
        assertTrue(room.getPricePerNight().compareTo(BigDecimal.ZERO) > 0, "Price should be positive");
    }
}

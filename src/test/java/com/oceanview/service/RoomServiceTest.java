package com.oceanview.service;

import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Room;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.*;

public class RoomServiceTest {

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
        Room r1 = new Room(1, "101", "Single", new BigDecimal("100"), "Available");
        Room r2 = new Room(2, "102", "Double", new BigDecimal("150"), "Occupied");
        when(roomDAO.findAll()).thenReturn(Arrays.asList(r1, r2));

        List<Room> rooms = roomService.getAllRooms();

        assertEquals(2, rooms.size());
        assertEquals("101", rooms.get(0).getRoomNumber());
    }

    @Test
    public void testGetRoomById() {
        Room r1 = new Room(1, "101", "Single", new BigDecimal("100"), "Available");
        when(roomDAO.findById(1)).thenReturn(Optional.of(r1));

        Optional<Room> result = roomService.getRoomById(1);

        assertTrue(result.isPresent());
        assertEquals("101", result.get().getRoomNumber());
    }
}

export const createBooking = (username, timeRangeIDs) => {
    return fetch('/api/v1/bookings', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            booking: {
                username: username,
                time_range_ids: timeRangeIDs,
            }
        })
    })
}
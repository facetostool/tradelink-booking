import qs from 'qs'

export const indexTimeRanges = (date) => {
    return fetch('/api/v1/time_ranges?' + qs.stringify(
        {
            filters: {
                date: date.toISOString().slice(0,10),
            }
        }
    ))
}
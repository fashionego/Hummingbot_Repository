from .pure_market_making_v3 cimport PureMarketMakingStrategyV3
from .order_filter_delegate cimport OrderFilterDelegate

from libc.stdint cimport int64_t


cdef class TimeFilterDelegate(OrderFilterDelegate):
    cdef:
        double _order_placing_timestamp





from .pure_market_making_v2 cimport PureMarketMakingStrategyV2
from .pure_market_making_v3 cimport PureMarketMakingStrategyV3


cdef class OrderFilterDelegate:
    cdef bint c_should_proceed_with_processing(self,
                                               PureMarketMakingStrategyV2 strategy,
                                               object market_info,
                                               list active_orders) except? True

    cdef bint c_should_proceed_with_processing(self,
                                               PureMarketMakingStrategyV3 strategy,
                                               object market_info,
                                               list active_orders) except? True
    cdef object c_filter_orders_proposal(self,
                                         PureMarketMakingStrategyV2 strategy,
                                         object market_info,
                                         list active_orders,
                                         object orders_proposal)

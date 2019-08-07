from typing import List

from hummingbot.strategy.market_symbol_pair import MarketSymbolPair
from .data_types import (
    OrdersProposal,
    ORDER_PROPOSAL_ACTION_CREATE_ORDERS
)
from .pure_market_making_v3 import PureMarketMakingStrategyV3

from hummingbot.core.data_type.limit_order import LimitOrder



from decimal import Decimal
import logging

from hummingbot.market.market_base cimport MarketBase
from hummingbot.market.market_base import MarketBase
from hummingbot.core.event.events import (
    TradeType,
    OrderType
)
from hummingbot.logger import HummingbotLogger



s_logger = None
s_decimal_0 = Decimal(0)

cdef class TimeFilterDelegate(OrderFilterDelegate):

    def __init__(self, order_placing_timestamp: float):
        super().__init__()
        self._order_placing_timestamp = order_placing_timestamp

    @classmethod
    def logger(cls) -> HummingbotLogger:
        global s_logger
        if s_logger is None:
            s_logger = logging.getLogger(__name__)
        return s_logger

    @property
    def order_placing_timestamp(self) -> float:
        return self._order_placing_timestamp

    cdef object c_filter_orders_proposal_v3(self,
                                            PureMarketMakingStrategyV3 strategy,
                                            object market_info,
                                            object orders_proposal):
        cdef:
            int64_t actions = orders_proposal.actions

        current_timestamp = strategy._current_timestamp
        if current_timestamp > self._order_placing_timestamp:
            return orders_proposal
        else:
            if actions & ORDER_PROPOSAL_ACTION_CREATE_ORDERS:
                # set actions to not create orders
                orders_proposal.actions = actions & 1 << 1
                # if orders_proposal.buy_order_sizes[0] > 0:
                #     orders_proposal.buy_order_sizes[0] = 0
                #
                # if orders_proposal.sell_order_sizes[0] > 0:
                #     orders_proposal.sell_order_sizes[0] = 0

            return orders_proposal

    cdef bint c_should_proceed_with_processing_v3(self,
                                               PureMarketMakingStrategyV3 strategy,
                                               object market_info,
                                               list active_orders) except? True:
        return True




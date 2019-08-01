from typing import List

from hummingbot.strategy.market_symbol_pair import MarketSymbolPair
from .data_types import (
    OrdersProposal
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


    cdef bint c_should_proceed_with_processing(self,
                                               PureMarketMakingStrategyV3 strategy,
                                               object market_info,
                                               list active_orders):
        current_timestamp = strategy._current_timestamp
        if current_timestamp > self._order_placing_timestamp:
            return True
        else:
            return False


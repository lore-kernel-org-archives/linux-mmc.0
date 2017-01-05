From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC 0/3] mmc: host: tmio: sdio irq improvements
Date: Thu,  5 Jan 2017 12:43:23 +0100
Message-ID: <20170105114326.12426-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Here is a small series with two minor improvements (patches 1+2) and one bigger
change (patch 3) for SDIO handling with TMIO/SDHI. It is marked as RFC because
I wonder why other drivers are largely not clearing interrupts before enabling
them (patch 3 again). I really think it should be done, but maybe I am missing
something?

Based on mmc/next and tested on Renesas R-Car H3 and M3-W.


Wolfram Sang (3):
  mmc: host: tmio: refactor calls to sdio irq
  mmc: host: tmio: SDIO_STATUS_QUIRK is rather SDIO_STATUS_SETBITS
  mmc: tmio: discard obsolete SDIO irqs before enabling irqs

 drivers/mmc/host/sh_mobile_sdhi.c |  6 ++----
 drivers/mmc/host/tmio_mmc_pio.c   | 18 +++++++++++++-----
 include/linux/mfd/tmio.h          |  2 +-
 3 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.11.0

From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] mmc: sh_mobile_sdhi: use SDR & card_busy only on Gen2+
Date: Wed, 24 Aug 2016 11:34:36 +0200
Message-ID: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

This series hopefully fixes a performance regression for r8a73a4 (pre Gen2)
caused by a not working card_busy. Because we don't have documentation for its
SDHI (and I don't have the hardware), just enable card_busy and SDR only for
machines known to have hardware support for it.

Geert, can you test, please?

Wolfram Sang (2):
  mmc: host: sh_mobile_sdhi: move card_busy from tmio to sdhi
  mmc: host: sh_mobile_sdhi: don't populate unneeded functions

 drivers/mmc/host/sh_mobile_sdhi.c | 16 +++++++++++++++-
 drivers/mmc/host/tmio_mmc.h       |  1 +
 drivers/mmc/host/tmio_mmc_pio.c   |  9 +--------
 3 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.9.3

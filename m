From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH 2/4] mmc: core: use mmc_power_up in hw_reset
Date: Fri, 24 Oct 2014 14:46:28 +0200
Message-ID: <1414154790-20893-3-git-send-email-johanru@axis.com>
References: <1414154790-20893-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:48653 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505AbaJXMrL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Oct 2014 08:47:11 -0400
In-Reply-To: <1414154790-20893-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

The steps performed in mmc_do_hw_reset for eMMC:s after the hardware
reset are very similar to those performed by mmc_power_up, so do a call
to this function instead.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/core/core.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5d215ee..d56e222 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2273,16 +2273,7 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 		}
 	}
 
-	if (mmc_host_is_spi(host)) {
-		host->ios.chip_select = MMC_CS_HIGH;
-		host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
-	} else {
-		host->ios.chip_select = MMC_CS_DONTCARE;
-		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
-	}
-	host->ios.bus_width = MMC_BUS_WIDTH_1;
-	host->ios.timing = MMC_TIMING_LEGACY;
-	mmc_set_ios(host);
+	mmc_power_up(host, card->ocr);
 
 	mmc_host_clk_release(host);
 
-- 
1.7.2.5


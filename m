From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/2] mmc: host: sh_mobile_sdhi: don't populate unneeded functions
Date: Wed, 24 Aug 2016 11:34:38 +0200
Message-ID: <20160824093438.2478-3-wsa+renesas@sang-engineering.com>
References: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:39573 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753030AbcHXJf3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 Aug 2016 05:35:29 -0400
In-Reply-To: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Populating card_busy caused a side-effect on a chip variant we don't
have documentation for (r8a73a4). So, enable it and voltage switching
only on devices known to support those features.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index c4e63b7790d719..d679c8a533b6e5 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -376,8 +376,14 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	host->clk_update	= sh_mobile_sdhi_clk_update;
 	host->clk_disable	= sh_mobile_sdhi_clk_disable;
 	host->multi_io_quirk	= sh_mobile_sdhi_multi_io_quirk;
-	host->card_busy	= sh_mobile_sdhi_card_busy;
-	host->start_signal_voltage_switch = sh_mobile_sdhi_start_signal_voltage_switch;
+
+	/* SDR speeds are only available on Gen2+ */
+	if (mmc_data->flags & TMIO_MMC_MIN_RCAR2) {
+		/* card_busy caused issues on r8a73a4 (pre-Gen2) CD-less SDHI */
+		host->card_busy	= sh_mobile_sdhi_card_busy;
+		host->start_signal_voltage_switch =
+			sh_mobile_sdhi_start_signal_voltage_switch;
+	}
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
 	if (!host->bus_shift && resource_size(res) > 0x100) /* old way to determine the shift */
-- 
2.9.3


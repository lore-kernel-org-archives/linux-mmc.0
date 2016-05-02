From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 3/4] mmc: sh_mobile_sdhi: only change the clock on RCar Gen2+
Date: Mon,  2 May 2016 22:25:41 +0200
Message-ID: <1462220742-4426-4-git-send-email-wsa@the-dreams.de>
References: <1462220742-4426-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34003 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755003AbcEBU0T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 May 2016 16:26:19 -0400
In-Reply-To: <1462220742-4426-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We had a regression on r8a7740 where the SDHI clock was a generic
peripheral clock, so changing its rate was not desired. This should be
fixed in the clock driver. However, it also shows that the new clock
calculation should only be used on tested systems. Add a check for that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 19e4c29e4233b0..ac9ba36da39b5b 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -168,6 +168,10 @@ static unsigned int sh_mobile_sdhi_clk_update(struct tmio_mmc_host *host,
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
 	int i;
 
+	/* tested only on RCar Gen2+ currently; may work for others */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		return clk_get_rate(priv->clk);
+
 	/*
 	 * We want the bus clock to be as close as possible to, but no
 	 * greater than, new_clock.  As we can divide by 1 << i for
-- 
2.6.2


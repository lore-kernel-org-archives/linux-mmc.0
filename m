From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC 1/5] mmc: tmio: fix power-mode interpretation
Date: Mon, 7 Mar 2011 19:47:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103071943180.29543@axis700.grange>
References: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56317 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab1CGSrw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 13:47:52 -0500
In-Reply-To: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

The power-mode sequence on MMC is MMC_POWER_OFF -> MMC_POWER_UP ->
MMC_POWER_ON and not MMC_POWER_ON -> MMC_POWER_UP, as the driver currently
is implying.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Should be tested on non-SDHI systems

 drivers/mmc/host/tmio_mmc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index f5ec5e6..91a31d2 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -1162,20 +1162,20 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->clock)
 		tmio_mmc_set_clock(host, ios->clock);
 
-	/* Power sequence - OFF -> ON -> UP */
+	/* Power sequence - OFF -> UP -> ON */
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF: /* power down SD bus */
 		if (host->set_pwr)
 			host->set_pwr(host->pdev, 0);
 		tmio_mmc_clk_stop(host);
 		break;
-	case MMC_POWER_ON: /* power up SD bus */
+	case MMC_POWER_ON: /* start bus clock */
+		tmio_mmc_clk_start(host);
+		break;
+	case MMC_POWER_UP: /* power up SD bus */
 		if (host->set_pwr)
 			host->set_pwr(host->pdev, 1);
 		break;
-	case MMC_POWER_UP: /* start bus clock */
-		tmio_mmc_clk_start(host);
-		break;
 	}
 
 	switch (ios->bus_width) {
-- 
1.7.2.3


From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: tmio: fix compiler warning
Date: Mon, 8 Jul 2013 11:38:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307081135170.19819@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65468 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3GHJiS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jul 2013 05:38:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

This patch fixes a compiler warning:

drivers/mmc/host/tmio_mmc_pio.c: In function 'tmio_mmc_power_on':
drivers/mmc/host/tmio_mmc_pio.c:798:19: warning: ignoring return value of 
'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

This warning is present in "next" and in 3.10, but since it doesn't affect 
functionality, I don't think it's needed for stable.

 drivers/mmc/host/tmio_mmc_pio.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f294708..84e1888 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -795,9 +795,13 @@ static void tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned short vdd)
 	 * omap_hsmmc.c driver does.
 	 */
 	if (!IS_ERR(mmc->supply.vqmmc) && !ret) {
-		regulator_enable(mmc->supply.vqmmc);
+		ret = regulator_enable(mmc->supply.vqmmc);
 		udelay(200);
 	}
+
+	if (ret < 0)
+		dev_dbg(&host->pdev->dev, "Regulators failed to power up: %d\n",
+			ret);
 }
 
 static void tmio_mmc_power_off(struct tmio_mmc_host *host)
-- 
1.7.2.5


From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: tmio: fix regression: restore TMIO_MMC_WRPROTECT_DISABLE
 handling
Date: Mon, 20 Jun 2011 16:51:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1106201648480.11365@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55451 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab1FTOvj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 10:51:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <damm@opensource.se>

Commit b6147490e6aac82fa2f4b9d7fce925d9891ebe8f broke handling of the
TMIO_MMC_WRPROTECT_DISABLE flag by the tmio-mmc driver. This patch
restores the original behaviour.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Chris, please push for 3.0

Thanks
Guennadi

 drivers/mmc/host/tmio_mmc_pio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index ad6347b..0b09e82 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -824,8 +824,8 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct tmio_mmc_data *pdata = host->pdata;
 
-	return ((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
-		!(sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
+	return !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
+		 (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
 }
 
 static int tmio_mmc_get_cd(struct mmc_host *mmc)
-- 
1.7.2.5


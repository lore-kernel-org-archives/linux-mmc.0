From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mmc: wmt-sdmmc: Simplify wmt_set_sd_power implementation
Date: Thu, 03 Oct 2013 17:04:40 +0800
Message-ID: <1380791080.30876.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:44133 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab3JCJEp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2013 05:04:45 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so2169396pdj.4
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2013 02:04:45 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Prisk <linux@prisktech.co.nz>, linux-mmc@vger.kernel.org

Simplify the code to set/clear BM_SD_OFF bit:

          | power_inverted: 0  | power_inverted: 1
-------------------------------------------------
enable: 0 | SET BM_SD_OFF      | CLEAR BM_SD_OFF
-------------------------------------------------
enable: 1 | CLEAR BM_SD_OFF    | SET BM_SD_OFF

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/wmt-sdmmc.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 34231d5..57858ef 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -212,28 +212,14 @@ struct wmt_mci_priv {
 
 static void wmt_set_sd_power(struct wmt_mci_priv *priv, int enable)
 {
-	u32 reg_tmp;
-	if (enable) {
-		if (priv->power_inverted) {
-			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
-			writeb(reg_tmp | BM_SD_OFF,
-			       priv->sdmmc_base + SDMMC_BUSMODE);
-		} else {
-			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
-			writeb(reg_tmp & (~BM_SD_OFF),
-			       priv->sdmmc_base + SDMMC_BUSMODE);
-		}
-	} else {
-		if (priv->power_inverted) {
-			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
-			writeb(reg_tmp & (~BM_SD_OFF),
-			       priv->sdmmc_base + SDMMC_BUSMODE);
-		} else {
-			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
-			writeb(reg_tmp | BM_SD_OFF,
-			       priv->sdmmc_base + SDMMC_BUSMODE);
-		}
-	}
+	u32 reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
+
+	if (enable ^ priv->power_inverted)
+		reg_tmp &= ~BM_SD_OFF;
+	else
+		reg_tmp |= BM_SD_OFF;
+
+	writeb(reg_tmp, priv->sdmmc_base + SDMMC_BUSMODE);
 }
 
 static void wmt_mci_read_response(struct mmc_host *mmc)
-- 
1.8.1.2




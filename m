From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] mmc: sdhci-esdhc-imx: Remove unused variables
Date: Thu, 17 Jan 2013 00:32:52 -0200
Message-ID: <1358389972-24399-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:37029 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757518Ab3AQCjr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jan 2013 21:39:47 -0500
Received: by mail-yh0-f48.google.com with SMTP id q46so345592yhf.35
        for <linux-mmc@vger.kernel.org>; Wed, 16 Jan 2013 18:39:47 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: shawn.guo@linaro.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

commit 3f175a6e5 (mmc: sdhci-esdhc-imx: remove ESDHC_CD_GPIO handling from IO 
accessory) introduced the following build warnings:

drivers/mmc/host/sdhci-esdhc-imx.c:149:30: warning: unused variable 'boarddata' [-Wunused-variable]
drivers/mmc/host/sdhci-esdhc-imx.c:181:30: warning: unused variable 'boarddata' [-Wunused-variable]

Remove the unused variables.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix offending commit id

 drivers/mmc/host/sdhci-esdhc-imx.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ae68bc9..509be3a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -144,10 +144,6 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
 
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 {
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
-
 	u32 val = readl(host->ioaddr + reg);
 
 	if (unlikely(reg == SDHCI_CAPABILITIES)) {
@@ -178,7 +174,6 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
-	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 	u32 data;
 
 	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
-- 
1.7.9.5


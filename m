From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 4/4] mmc: sdhci-esdhc-imx: Workaround for SD dat1 glitch causes system panic
Date: Thu, 10 May 2012 11:33:19 +0200
Message-ID: <1336642399-4543-5-git-send-email-dirk.behme@de.bosch.com>
References: <1336642399-4543-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:51657 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab2EJJmP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 May 2012 05:42:15 -0400
Received: from smtp2-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 112C03FE8AD5
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:37:48 +0200 (CEST)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 624E528C0172
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:30:05 +0200 (CEST)
Received: from localhost (vsgw3.fe.internet.bosch.com [10.4.98.16])
	by vsmta14.fe.internet.bosch.com (Postfix) with SMTP id 2D9861B40323
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:33:41 +0200 (CEST)
In-Reply-To: <1336642399-4543-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: RichardZhu <richard.zhu@linaro.org>, Tony Lin <tony.lin@freescale.com>

From: RichardZhu <richard.zhu@linaro.org>

Some SD cards insertions will cause a glitch on SD dat1
which is also a card interrupt signal. Thus the wrongly
generated card interrupt will make system panic because
there's no registered sdio interrupt handler.
This patch fixes this issue.

Note: This is a workaround for i.MX6 version 1.0 silicon. It's
      fixed in hardware in version 1.1 silicon.

Signed-off-by: Tony Lin <tony.lin@freescale.com>
Signed-off-by: RichardZhu <richard.zhu@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a13e75b..50a72a4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -486,6 +486,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int err;
 	struct pltfm_imx_data *imx_data;
+	u32 reg;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata);
 	if (IS_ERR(host))
@@ -513,7 +514,22 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
-	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	/* disable card interrupt enable bit, and clear status bit
+	 * the default value of this enable bit is 1, but it should
+	 * be 0 regarding to standard host controller spec 2.1.3.
+	 * if this bit is 1, it may cause some problems.
+	 * there's dat1 glitch when some cards inserting into the slot,
+	 * thus wrongly generate a card interrupt that will cause
+	 * system panic because it lacks of sdio handler
+	 * following code will solve the problem.
+	 */
+	reg = sdhci_readl(host, SDHCI_INT_ENABLE);
+	reg &= ~SDHCI_INT_CARD_INT;
+	sdhci_writel(host, reg, SDHCI_INT_ENABLE);
+	sdhci_writel(host, SDHCI_INT_CARD_INT, SDHCI_INT_STATUS);
+
+	if (!is_imx25_esdhc(imx_data))
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
 		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
-- 
1.7.0.4


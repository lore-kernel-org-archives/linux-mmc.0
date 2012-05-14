From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 4/4 v2] mmc: sdhci-esdhc-imx: Workaround for SD dat1 glitch causes system panic
Date: Mon, 14 May 2012 10:05:59 +0200
Message-ID: <1336982759-3627-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:15994 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab2ENIHG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 May 2012 04:07:06 -0400
Received: from smtp2-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 6579A28039D
	for <linux-mmc@vger.kernel.org>; Mon, 14 May 2012 10:00:31 +0200 (CEST)
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 17704B0022A
	for <linux-mmc@vger.kernel.org>; Mon, 14 May 2012 09:59:47 +0200 (CEST)
Received: from localhost (vsgw2.fe.internet.bosch.com [10.4.98.13])
	by vsmta12.fe.internet.bosch.com (Postfix) with SMTP id 93A9B1AC05D0
	for <linux-mmc@vger.kernel.org>; Mon, 14 May 2012 10:06:18 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: RichardZhu <richard.zhu@linaro.org>, Tony Lin <tony.lin@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>, Philipp Ahmann <pahmann@de.adit-jv.com>

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
CC: Wolfram Sang <w.sang@pengutronix.de>
CC: Philipp Ahmann <pahmann@de.adit-jv.com>
---
v2: * Update the comment with "the following problem"
    * Remove merge error "if (!is_imx25_esdhc(imx_data))"

Note: Patches 1 - 3 of this series are not changed and therefore not re-sent.
      They are still unchanged:
      http://marc.info/?l=linux-mmc&m=133664296609699&w=3

 drivers/mmc/host/sdhci-esdhc-imx.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a13e75b..f2e17e1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -486,6 +486,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int err;
 	struct pltfm_imx_data *imx_data;
+	u32 reg;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata);
 	if (IS_ERR(host))
@@ -513,6 +514,20 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
+	/* disable card interrupt enable bit, and clear status bit
+	 * the default value of this enable bit is 1, but it should
+	 * be 0 regarding to standard host controller spec 2.1.3.
+	 * if this bit is 1, it may cause the following problem.
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
 	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
-- 
1.7.0.4


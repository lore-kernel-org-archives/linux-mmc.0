From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 1/4] mmc: sdhci-esdhc-imx: Support 8 bit MMC
Date: Thu, 10 May 2012 11:33:16 +0200
Message-ID: <1336642399-4543-2-git-send-email-dirk.behme@de.bosch.com>
References: <1336642399-4543-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:51588 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900Ab2EJJkW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 May 2012 05:40:22 -0400
Received: from smtp2-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 025DF2803F7
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:30:42 +0200 (CEST)
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta23.fe.bosch.de (Postfix) with ESMTP id D008D28C0214
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:29:55 +0200 (CEST)
Received: from localhost (vsgw1.fe.internet.bosch.com [10.4.98.15])
	by vsmta11.fe.internet.bosch.com (Postfix) with SMTP id AD73A43C0262
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:33:31 +0200 (CEST)
In-Reply-To: <1336642399-4543-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: RichardZhu <richard.zhu@linaro.org>, Philipp Ahmann <pahmann@de.adit-jv.com>

From: RichardZhu <richard.zhu@linaro.org>

Enable 8 bit MMC mode according to mmc stack.

Signed-off-by: RichardZhu <richard.zhu@linaro.org>
Signed-off-by: Philipp Ahmann <pahmann@de.adit-jv.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8abdaf6..bb89f5c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -29,11 +29,21 @@
 #include "sdhci-esdhc.h"
 
 #define	SDHCI_CTRL_D3CD			0x08
+
+#define SDHCI_PROT_CTRL_DTW		(3 << 1)
+#define SDHCI_PROT_CTRL_8BIT		(2 << 1)
+#define SDHCI_PROT_CTRL_4BIT		(1 << 1)
+#define SDHCI_PROT_CTRL_1BIT		(0 << 1)
+
 /* VENDOR SPEC register */
 #define SDHCI_VENDOR_SPEC		0xC0
 #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
 #define SDHCI_WTMK_LVL			0x44
 #define SDHCI_MIX_CTRL			0x48
+#define  SDHCI_MIX_CTRL_EXE_TUNE	(1 << 22)
+#define  SDHCI_MIX_CTRL_SMPCLK_SEL	(1 << 23)
+#define  SDHCI_MIX_CTRL_AUTO_TUNE	(1 << 24)
+#define  SDHCI_MIX_CTRL_FBCLK_SEL	(1 << 25)
 
 /*
  * There is an INT DMA ERR mis-match between eSDHC and STD SDHC SPEC:
@@ -276,7 +286,11 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 
 		if (is_imx6q_usdhc(imx_data)) {
 			u32 m = readl(host->ioaddr + SDHCI_MIX_CTRL);
-			m = imx_data->scratchpad | (m & 0xffff0000);
+			m = imx_data->scratchpad | \
+				(m & (SDHCI_MIX_CTRL_EXE_TUNE | \
+				      SDHCI_MIX_CTRL_SMPCLK_SEL | \
+				      SDHCI_MIX_CTRL_AUTO_TUNE | \
+				      SDHCI_MIX_CTRL_FBCLK_SEL));
 			writel(m, host->ioaddr + SDHCI_MIX_CTRL);
 			writel(val << 16,
 			       host->ioaddr + SDHCI_TRANSFER_MODE);
@@ -364,6 +378,22 @@ static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
 	return -ENOSYS;
 }
 
+static int plt_8bit_width(struct sdhci_host *host, int width)
+{
+	u32 reg = sdhci_readl(host, SDHCI_HOST_CONTROL);
+
+	reg &= ~SDHCI_PROT_CTRL_DTW;
+
+	if (width == MMC_BUS_WIDTH_8)
+		reg |= SDHCI_PROT_CTRL_8BIT;
+	else if (width == MMC_BUS_WIDTH_4)
+		reg |= SDHCI_PROT_CTRL_4BIT;
+
+	sdhci_writel(host, reg, SDHCI_HOST_CONTROL);
+
+	return 0;
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -374,6 +404,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_max_clock = esdhc_pltfm_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_ro = esdhc_pltfm_get_ro,
+	.platform_8bit_width = plt_8bit_width,
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-- 
1.7.0.4


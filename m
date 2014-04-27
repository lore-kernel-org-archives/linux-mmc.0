From: Axel Lin <axel.lin@ingics.com>
Subject: [RESEND][PATCH] mmc: wmt-sdmmc: Fix settting BM_EIGHTBIT_MODE bit
 in wmt_mci_set_ios()
Date: Sun, 27 Apr 2014 18:22:51 +0800
Message-ID: <1398594171.6291.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:62750 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbaD0KW6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Apr 2014 06:22:58 -0400
Received: by mail-vc0-f177.google.com with SMTP id if17so6681184vcb.8
        for <linux-mmc@vger.kernel.org>; Sun, 27 Apr 2014 03:22:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

For MMC_BUS_WIDTH_8 case, current code missed setting BM_EIGHTBIT_MODE bit.
Also has a small refactor to make the code looks better in readability.

So the bit settings witch below logic:

SDMMC_BUSMODE register:
Set EIGHTBIT_MODE bit for 8 bit mode, Set FOURBIT_MODE bit for 4 bit mode.
Clear both EIGHTBIT_MODE and FOURBIT_MODE bits for 1 bit mode.

SDMMC_EXTCTRL register:
Set EXT_EIGHTBIT bit for 8 bit mode, Clear EXT_EIGHTBIT bit for 1/4 bit mode.

Add define for EXT_EIGHTBIT to avoid using magic number.
BM_ONEBIT_MASK is no longer used, thus remove it.

This patch is untested due to lack of platform with 8-bit hardware.
However since the code is there, it's good to make the code match the document.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This patch was sent on:
http://www.spinics.net/lists/linux-mmc/msg22926.html
The document (wm8505 sdmmc controller suppliment.pdf) is available at:
https://groups.google.com/group/vt8500-wm8505-linux-kernel/attach/ac3d5037e860a34/wm8505%20sdmmc%20controller%20suppliment.pdf?part=4&authuser=1

Regards,
Axel

 drivers/mmc/host/wmt-sdmmc.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 8a48a50..6ed18f8 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -72,7 +72,6 @@
 #define BM_SPI_CS			0x20
 #define BM_SD_POWER			0x40
 #define BM_SOFT_RESET			0x80
-#define BM_ONEBIT_MASK			0xFD
 
 /* SDMMC_BLKLEN bit fields */
 #define BLKL_CRCERR_ABORT		0x0800
@@ -120,6 +119,8 @@
 #define STS2_DATARSP_BUSY		0x20
 #define STS2_DIS_FORCECLK		0x80
 
+/* SDMMC_EXTCTRL bit fields */
+#define EXT_EIGHTBIT			0x04
 
 /* MMC/SD DMA Controller Registers */
 #define SDDMA_GCR			0x100
@@ -672,7 +673,7 @@ static void wmt_mci_request(struct mmc_host *mmc, struct mmc_request *req)
 static void wmt_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct wmt_mci_priv *priv;
-	u32 reg_tmp;
+	u32 busmode, extctrl;
 
 	priv = mmc_priv(mmc);
 
@@ -687,28 +688,26 @@ static void wmt_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->clock != 0)
 		clk_set_rate(priv->clk_sdmmc, ios->clock);
 
+	busmode = readb(priv->sdmmc_base + SDMMC_BUSMODE);
+	extctrl = readb(priv->sdmmc_base + SDMMC_EXTCTRL);
+
+	busmode &= ~(BM_EIGHTBIT_MODE | BM_FOURBIT_MODE);
+	extctrl &= ~EXT_EIGHTBIT;
+
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_8:
-		reg_tmp = readb(priv->sdmmc_base + SDMMC_EXTCTRL);
-		writeb(reg_tmp | 0x04, priv->sdmmc_base + SDMMC_EXTCTRL);
+		busmode |= BM_EIGHTBIT_MODE;
+		extctrl |= EXT_EIGHTBIT;
 		break;
 	case MMC_BUS_WIDTH_4:
-		reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
-		writeb(reg_tmp | BM_FOURBIT_MODE, priv->sdmmc_base +
-		       SDMMC_BUSMODE);
-
-		reg_tmp = readb(priv->sdmmc_base + SDMMC_EXTCTRL);
-		writeb(reg_tmp & 0xFB, priv->sdmmc_base + SDMMC_EXTCTRL);
+		busmode |= BM_FOURBIT_MODE;
 		break;
 	case MMC_BUS_WIDTH_1:
-		reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
-		writeb(reg_tmp & BM_ONEBIT_MASK, priv->sdmmc_base +
-		       SDMMC_BUSMODE);
-
-		reg_tmp = readb(priv->sdmmc_base + SDMMC_EXTCTRL);
-		writeb(reg_tmp & 0xFB, priv->sdmmc_base + SDMMC_EXTCTRL);
 		break;
 	}
+
+	writeb(busmode, priv->sdmmc_base + SDMMC_BUSMODE);
+	writeb(extctrl, priv->sdmmc_base + SDMMC_EXTCTRL);
 }
 
 static int wmt_mci_get_ro(struct mmc_host *mmc)
-- 
1.8.1.2




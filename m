From: ludovic.desroches@atmel.com
Subject: [PATCH 3/3] mmc: atmel-mci: add support for odd clock dividers
Date: Wed, 21 Mar 2012 16:41:23 +0100
Message-ID: <1332344483-3915-4-git-send-email-ludovic.desroches@atmel.com>
References: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:52320 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab2CUNms (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Mar 2012 09:42:48 -0400
In-Reply-To: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, plagnioj@jcrosoft.com

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add an odd clock divider capability available from v5xx. It also involves
changing the clock divider calculation.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci-regs.h |    1 +
 drivers/mmc/host/atmel-mci.c      |   48 ++++++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
index 000b3ad..787aba1 100644
--- a/drivers/mmc/host/atmel-mci-regs.h
+++ b/drivers/mmc/host/atmel-mci-regs.h
@@ -31,6 +31,7 @@
 # define ATMCI_MR_PDCFBYTE		(  1 << 13)	/* Force Byte Transfer */
 # define ATMCI_MR_PDCPADV		(  1 << 14)	/* Padding Value */
 # define ATMCI_MR_PDCMODE		(  1 << 15)	/* PDC-oriented Mode */
+# define ATMCI_MR_CLKODD(x)		((x) << 16)	/* LSB of Clock Divider */
 #define ATMCI_DTOR			0x0008	/* Data Timeout */
 # define ATMCI_DTOCYC(x)		((x) <<  0)	/* Data Timeout Cycles */
 # define ATMCI_DTOMUL(x)		((x) <<  4)	/* Data Timeout Multiplier */
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 9dcb236..75e28c0 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -76,6 +76,7 @@ struct atmel_mci_caps {
 	bool    has_cstor_reg;
 	bool    has_highspeed;
 	bool    has_rwproof;
+	bool	has_odd_clk_div;
 };
 
 struct atmel_mci_dma {
@@ -1124,16 +1125,27 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 
 		/* Calculate clock divider */
-		clkdiv = DIV_ROUND_UP(host->bus_hz, 2 * clock_min) - 1;
-		if (clkdiv > 255) {
-			dev_warn(&mmc->class_dev,
-				"clock %u too slow; using %lu\n",
-				clock_min, host->bus_hz / (2 * 256));
-			clkdiv = 255;
+		if (host->caps.has_odd_clk_div) {
+			clkdiv = DIV_ROUND_UP(host->bus_hz, clock_min) - 2;
+			if (clkdiv > 511) {
+				dev_warn(&mmc->class_dev,
+				         "clock %u too slow; using %lu\n",
+				         clock_min, host->bus_hz / (511 + 2));
+				clkdiv = 511;
+			}
+			host->mode_reg = ATMCI_MR_CLKDIV(clkdiv >> 1)
+			                 | ATMCI_MR_CLKODD(clkdiv & 1);
+		} else {
+			clkdiv = DIV_ROUND_UP(host->bus_hz, 2 * clock_min) - 1;
+			if (clkdiv > 255) {
+				dev_warn(&mmc->class_dev,
+				         "clock %u too slow; using %lu\n",
+				         clock_min, host->bus_hz / (2 * 256));
+				clkdiv = 255;
+			}
+			host->mode_reg = ATMCI_MR_CLKDIV(clkdiv);
 		}
 
-		host->mode_reg = ATMCI_MR_CLKDIV(clkdiv);
-
 		/*
 		 * WRPROOF and RDPROOF prevent overruns/underruns by
 		 * stopping the clock when the FIFO is full/empty.
@@ -2000,37 +2012,35 @@ static void __init atmci_get_cap(struct atmel_mci *host)
 			"version: 0x%x\n", version);
 
 	host->caps.has_dma = 0;
-	host->caps.has_pdc = 0;
+	host->caps.has_pdc = 1;
 	host->caps.has_cfg_reg = 0;
 	host->caps.has_cstor_reg = 0;
 	host->caps.has_highspeed = 0;
 	host->caps.has_rwproof = 0;
+	host->caps.has_odd_clk_div = 0;
 
 	/* keep only major version number */
 	switch (version & 0xf00) {
-	case 0x100:
-		host->caps.has_pdc = 1;
-		break;
-	case 0x200:
-		host->caps.has_pdc = 1;
-		host->caps.has_rwproof = 1;
-		break;
-	case 0x300:
-	case 0x400:
 	case 0x500:
+		host->caps.has_odd_clk_div = 1;
+	case 0x400:
+	case 0x300:
 #ifdef CONFIG_AT_HDMAC
 		host->caps.has_dma = 1;
 #else
-		host->caps.has_dma = 0;
 		dev_info(&host->pdev->dev,
 			"has dma capability but dma engine is not selected, then use pio\n");
 #endif
+		host->caps.has_pdc = 0;
 		host->caps.has_cfg_reg = 1;
 		host->caps.has_cstor_reg = 1;
 		host->caps.has_highspeed = 1;
+	case 0x200:
 		host->caps.has_rwproof = 1;
+	case 0x100:
 		break;
 	default:
+		host->caps.has_pdc = 0;
 		dev_warn(&host->pdev->dev,
 				"Unmanaged mci version, set minimum capabilities\n");
 		break;
-- 
1.7.5.4


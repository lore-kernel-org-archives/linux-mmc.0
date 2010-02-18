From: "George G. Davis" <gdavis@mvista.com>
Subject: [RFC/PATCH] mmc: sdhci: Add 8-bit bus width support
Date: Thu, 18 Feb 2010 15:05:54 -0500
Message-ID: <1266523554-23709-1-git-send-email-gdavis@mvista.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:38035 "EHLO
	qmta08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752683Ab0BRUGJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Feb 2010 15:06:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: "George G. Davis" <gdavis@mvista.com>, JiebingLi <jiebing.li@intel.com>, FengTang <feng.tang@intel.com>, GermanMonroy <german.monroy@intel.com>

Although the "SD Host Controller Simplified Specification Version 2.00"
does not clearly document support for 8-bit bus width, it does show
an "Extended Data Transfer Width" field in bit-5 of the Host Control
Register.  Furthermore, while googling around for more details on this
feature, I came across the "MMC: MMC/SD/CE-ATA/SDIO driver for Intel
Moorestown platform" [1] which implements 8-bit bus width support
but was rejected for other reasons.  My experimentation has revealed
that setting the "Extended Data Transfer Width" bit in addition to
the "Data Transfer Width" bit as done in [1] does in fact enable
8-bit mode.  Alas, we need a better method of specifying host
capabilities for the myriad SDHCI based devices, e.g. passing host
capabilities into sdhci_add_host() via platform data as done for
other host drivers.  Resolving this host capabilities issue via
platform data may also eliminate the need for some of the quirks,
e.g. SDHCI_QUIRK_FORCE_1_BIT_DATA would not be necessary if platform
data specifies bus_width = 1, etc.,.

Comments and/or feedback greatly appreciated.

[1] http://patchwork.kernel.org/patch/20993/

Signed-off-by: George G. Davis <gdavis@mvista.com>
Cc: JiebingLi <jiebing.li@intel.com>
Cc: FengTang <feng.tang@intel.com>
Cc: GermanMonroy <german.monroy@intel.com>
---
 drivers/mmc/host/sdhci.c |   17 ++++++++++++++---
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6c2978c..6c05d80 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1147,10 +1147,19 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
-	if (ios->bus_width == MMC_BUS_WIDTH_4)
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_8:
 		ctrl |= SDHCI_CTRL_4BITBUS;
-	else
+		ctrl |= SDHCI_CTRL_8BITBUS;
+		break;
+	case MMC_BUS_WIDTH_4:
+		ctrl |= SDHCI_CTRL_4BITBUS;
+		ctrl &= ~SDHCI_CTRL_8BITBUS;
+		break;
+	default:
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		ctrl &= ~SDHCI_CTRL_8BITBUS;
+	}
 
 	if (ios->timing == MMC_TIMING_SD_HS)
 		ctrl |= SDHCI_CTRL_HISPD;
@@ -1783,8 +1792,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->f_max = host->max_clk;
 	mmc->caps = MMC_CAP_SDIO_IRQ;
 
-	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
+	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA)) {
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
+		mmc->caps |= MMC_CAP_8_BIT_DATA;
+	}
 
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 9ba4268..6bd46e5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -72,6 +72,7 @@
 #define   SDHCI_CTRL_ADMA1	0x08
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
+#define  SDHCI_CTRL_8BITBUS	0x20
 
 #define SDHCI_POWER_CONTROL	0x29
 #define  SDHCI_POWER_ON		0x01
-- 
1.6.3.3.311.g43dd


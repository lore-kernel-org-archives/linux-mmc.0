From: <r66093@freescale.com>
Subject: [PATCH 4/4 v3] ESDHC: add callback esdhc_of_get_cd to detect card
Date: Fri, 9 Dec 2011 10:53:50 +0800
Message-ID: <1323399230-29118-4-git-send-email-r66093@freescale.com>
References: <1323399230-29118-1-git-send-email-r66093@freescale.com>
 <1323399230-29118-2-git-send-email-r66093@freescale.com>
 <1323399230-29118-3-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:58819
	"EHLO VA3EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751718Ab1LIDi6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2011 22:38:58 -0500
In-Reply-To: <1323399230-29118-3-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

In order to check if the card is present, we will read the PRESENT STATE
register and check the bit13(Card detect pin level) and bit15(CINS).

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- add new callback for esdhc to detect the card state
	- add the CC
changes for v3:
	- enable the controller clock when detect the card state, not core

 drivers/mmc/host/sdhci-of-esdhc.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 59e9d00..40da8f4 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1,7 +1,7 @@
 /*
  * Freescale eSDHC controller driver.
  *
- * Copyright (c) 2007, 2010 Freescale Semiconductor, Inc.
+ * Copyright (c) 2007, 2010-2011 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  *
  * Authors: Xiaobo Xie <X.Xie@freescale.com>
@@ -82,6 +82,28 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 	return pltfm_host->clock / 256 / 16;
 }
 
+/* Return: none zero - the card is presetn; 0 - card is absent */
+static int esdhc_of_get_cd(struct sdhci_host *host)
+{
+	int present;
+
+	if (host->flags & SDHCI_DEVICE_DEAD)
+		present = 0;
+	else {
+		int sysctl = sdhci_be32bs_readl(host, SDHCI_CLOCK_CONTROL);
+		/* Enable the controller clock to update the present state */
+		sdhci_be32bs_writel(host, sysctl | SDHCI_CLOCK_INT_EN,
+				SDHCI_CLOCK_CONTROL);
+		/* Detect the card present or absent */
+		present = sdhci_be32bs_readl(host, SDHCI_PRESENT_STATE);
+		present &= (SDHCI_CARD_PRESENT | SDHCI_CARD_CDPL);
+		/* Resve the previous to System control register */
+		sdhci_be32bs_writel(host, sysctl, SDHCI_CLOCK_CONTROL);
+	}
+
+	return present;
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = sdhci_be32bs_readl,
 	.read_w = esdhc_readw,
@@ -93,6 +115,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.enable_dma = esdhc_of_enable_dma,
 	.get_max_clock = esdhc_of_get_max_clock,
 	.get_min_clock = esdhc_of_get_min_clock,
+	.get_cd = esdhc_of_get_cd,
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
-- 
1.7.5.4



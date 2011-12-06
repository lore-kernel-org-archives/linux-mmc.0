From: <r66093@freescale.com>
Subject: [PATCH 5/5 v2] ESDHC: add callback esdhc_of_get_cd to detect card
Date: Tue, 6 Dec 2011 17:15:37 +0800
Message-ID: <1323162937-7742-5-git-send-email-r66093@freescale.com>
References: <1323162937-7742-1-git-send-email-r66093@freescale.com>
 <1323162937-7742-2-git-send-email-r66093@freescale.com>
 <1323162937-7742-3-git-send-email-r66093@freescale.com>
 <1323162937-7742-4-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:46522
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933235Ab1LFKeV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 05:34:21 -0500
In-Reply-To: <1323162937-7742-4-git-send-email-r66093@freescale.com>
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

 drivers/mmc/host/sdhci-of-esdhc.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 59e9d00..cb71810 100644
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
@@ -82,6 +82,21 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
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
+		present = sdhci_be32bs_readl(host, SDHCI_PRESENT_STATE);
+		present &= (SDHCI_CARD_PRESENT | SDHCI_CARD_CDPL);
+	}
+
+	return present;
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = sdhci_be32bs_readl,
 	.read_w = esdhc_readw,
@@ -93,6 +108,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.enable_dma = esdhc_of_enable_dma,
 	.get_max_clock = esdhc_of_get_max_clock,
 	.get_min_clock = esdhc_of_get_min_clock,
+	.get_cd = esdhc_of_get_cd,
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
-- 
1.7.5.4



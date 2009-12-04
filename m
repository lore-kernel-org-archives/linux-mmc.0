From: r66093@freescale.com
Subject: [PATCH 2/3] SDHCI: add sdhci_get_cd callback to detect the card
Date: Fri,  4 Dec 2009 15:54:59 +0800
Message-ID: <1259913299-27102-1-git-send-email-r66093@freescale.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:63227 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbZLDH5e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2009 02:57:34 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id nB47vfDg012857
	for <linux-mmc@vger.kernel.org>; Fri, 4 Dec 2009 00:57:41 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nB47vfYY001997
	for <linux-mmc@vger.kernel.org>; Fri, 4 Dec 2009 01:57:42 -0600 (CST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Add callback function sdhci_get_cd to detect the card.

In order to check if the card is present, we will read the PRESENT STATE register and check the bit13 (Card detect pin level).

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 drivers/mmc/host/sdhci.c |   19 +++++++++++++++++++
 drivers/mmc/host/sdhci.h |    2 +-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 711cbcd..e5ac64b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1205,6 +1205,24 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 	return !(present & SDHCI_WRITE_PROTECT);
 }
 
+static int sdhci_get_cd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int present;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->flags & SDHCI_DEVICE_DEAD)
+		present = 0;
+	else
+		present = sdhci_readl(host, SDHCI_PRESENT_STATE);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return (present & SDHCI_CARD_PRESENT);
+}
+
 static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct sdhci_host *host;
@@ -1231,6 +1249,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
 	.get_ro		= sdhci_get_ro,
+	.get_cd		= sdhci_get_cd,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 };
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cb8beea..438d32d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -58,7 +58,7 @@
 #define  SDHCI_DOING_READ	0x00000200
 #define  SDHCI_SPACE_AVAILABLE	0x00000400
 #define  SDHCI_DATA_AVAILABLE	0x00000800
-#define  SDHCI_CARD_PRESENT	0x00010000
+#define  SDHCI_CARD_PRESENT	0x00060000
 #define  SDHCI_WRITE_PROTECT	0x00080000
 
 #define SDHCI_HOST_CONTROL 	0x28
-- 
1.6.4


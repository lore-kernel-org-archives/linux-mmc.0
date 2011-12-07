From: <r66093@freescale.com>
Subject: [PATCH 4/5 v3] SDHCI: add sdhci_get_cd callback to detect the card
Date: Wed, 7 Dec 2011 09:34:33 +0800
Message-ID: <1323221673-27667-2-git-send-email-r66093@freescale.com>
References: <1323221673-27667-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:49279
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755026Ab1LGCwS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 21:52:18 -0500
In-Reply-To: <1323221673-27667-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Add callback function sdhci_get_cd to detect the card.
And one new callback added to implement the card detect in sdhci struncture.
If special platform has the card detect callback, it will return the card
state, the value zero is for absent cardi and one is for present card.
If the controller don't support card detect, sdhci_get_cd will return -ENOSYS.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- when controller don't support get_cd, return -ENOSYS
	- add new callback for sdhci to detect the card
	- add the CC
changes for v3:
	- use pin_lock only when get_cd defined

 drivers/mmc/host/sdhci.c |   22 ++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6d8eea3..fbe2f46 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2,6 +2,7 @@
  *  linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller Interface driver
  *
  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
+ *  Copyright (C) 2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -1518,6 +1519,26 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 	return ret;
 }
 
+/* Return values for the sdjco_get_cd callback:
+ *   0 for a absent card
+ *   1 for a present card
+ *   -ENOSYS when not supported (equal to NULL callback)
+ */
+static int sdhci_get_cd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int present = -ENOSYS;
+
+	if (host->ops->get_cd) {
+		spin_lock_irqsave(&host->lock, flags);
+		present = host->ops->get_cd(host);
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+
+	return present;
+}
+
 static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
 {
 	if (host->flags & SDHCI_DEVICE_DEAD)
@@ -1884,6 +1905,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
 	.get_ro		= sdhci_get_ro,
+	.get_cd		= sdhci_get_cd,
 	.hw_reset	= sdhci_hw_reset,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a5b654..82f4d27 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -69,6 +69,7 @@
 #define  SDHCI_SPACE_AVAILABLE	0x00000400
 #define  SDHCI_DATA_AVAILABLE	0x00000800
 #define  SDHCI_CARD_PRESENT	0x00010000
+#define  SDHCI_CARD_CDPL	0x00040000
 #define  SDHCI_WRITE_PROTECT	0x00080000
 #define  SDHCI_DATA_LVL_MASK	0x00F00000
 #define   SDHCI_DATA_LVL_SHIFT	20
@@ -261,6 +262,7 @@ struct sdhci_ops {
 
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
 
+	int		(*get_cd)(struct sdhci_host *host);
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
-- 
1.7.5.4



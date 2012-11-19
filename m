From: <r66093@freescale.com>
Subject: [PATCH 2/3 v6] SDHCI: add sdhci_get_cd callback to detect the card
Date: Mon, 19 Nov 2012 13:27:25 +0800
Message-ID: <1353302846-19514-2-git-send-email-r66093@freescale.com>
References: <1353302846-19514-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:3852
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751265Ab2KSGNq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 01:13:46 -0500
In-Reply-To: <1353302846-19514-1-git-send-email-r66093@freescale.com>
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
Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- when controller don't support get_cd, return -ENOSYS
	- add new callback for sdhci to detect the card
	- add the CC
changes for v3:
	- use pin_lock only when get_cd defined
changes for v4:
	- enalbe the controller clock in platform, instead of core
changes for v5:
	- remove the copyright
changes for v6:
	- fix the incorrect style and add the reviewed-by.

 drivers/mmc/host/sdhci.c |   22 ++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e746b3d6..038826a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1576,6 +1576,27 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 	return ret;
 }
 
+/*
+ * Return values for the sdhci_get_cd callback:
+ * 0: for a absent card
+ * 1: for a present card
+ * -ENOSYS: when not supported (equal to NULL callback)
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
@@ -1998,6 +2019,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
 	.get_ro		= sdhci_get_ro,
+	.get_cd		= sdhci_get_cd,
 	.hw_reset	= sdhci_hw_reset,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 71a4a7e..7c8f08d 100644
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
@@ -263,6 +264,7 @@ struct sdhci_ops {
 
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
 
+	int		(*get_cd)(struct sdhci_host *host);
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
-- 
1.7.9.5



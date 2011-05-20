From: <r66093@freescale.com>
Subject: [PATCH 1/3] SDHCI: add sdhci_get_cd callback to detect the card
Date: Fri, 20 May 2011 15:35:12 +0800
Message-ID: <1305876914-23714-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:2636 "EHLO
	VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934688Ab1ETIXX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2011 04:23:23 -0400
Received: from mail119-va3 (localhost.localdomain [127.0.0.1])	by
 mail119-va3-R.bigfish.com (Postfix) with ESMTP id BFAA616E8652	for
 <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 08:23:21 +0000 (UTC)
Received: from VA3EHSMHS015.bigfish.com (unknown [10.7.14.252])	by
 mail119-va3.bigfish.com (Postfix) with ESMTP id 9645613D8050	for
 <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 08:23:21 +0000 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <r66093@freescale.com>

From: Jerry Huang <r66093@freescale.com>

Add callback function sdhci_get_cd to detect the card.

In order to check if the card is present,
we will read the PRESENT STATE register and check the bit15.

Signed-off-by: Jerry Huang <r66093@freescale.com>
---
 drivers/mmc/host/sdhci.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..2e60372 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1262,6 +1262,24 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 		!is_readonly : is_readonly;
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
+	return present & SDHCI_CARD_PRESENT;
+}
+
 static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct sdhci_host *host;
@@ -1288,6 +1306,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
 	.get_ro		= sdhci_get_ro,
+	.get_cd		= sdhci_get_cd,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 };
 
-- 
1.7.4.1



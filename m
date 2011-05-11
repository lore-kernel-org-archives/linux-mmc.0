From: <Chang-Ming.Huang@freescale.com>
Subject: [PATCH 1/3] SDHCI: add sdhci_get_cd callback to detect the card
Date: Wed, 11 May 2011 17:32:09 +0800
Message-ID: <1305106331-21280-1-git-send-email-Chang-Ming.Huang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:10443 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab1EKPfK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 11:35:10 -0400
Received: from mail141-tx2 (localhost.localdomain [127.0.0.1])	by
 mail141-tx2-R.bigfish.com (Postfix) with ESMTP id B0CD0125831E	for
 <linux-mmc@vger.kernel.org>; Wed, 11 May 2011 10:18:59 +0000 (UTC)
Received: from TX2EHSMHS043.bigfish.com (unknown [10.9.14.254])	by
 mail141-tx2.bigfish.com (Postfix) with ESMTP id 55DD016A0050	for
 <linux-mmc@vger.kernel.org>; Wed, 11 May 2011 10:18:59 +0000 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linuxppc-dev@linux.freescale.net, Jerry Huang <Chang-Ming.Huang@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Add callback function sdhci_get_cd to detect the card.

In order to check if the card is present,
we will read the PRESENT STATE register and check the bit15.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
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



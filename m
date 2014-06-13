From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2 1/2] mmc: sdhci: add init_card callback
Date: Fri, 13 Jun 2014 12:25:33 +0200
Message-ID: <1402655134-1189-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52833 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbaFMK0B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jun 2014 06:26:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>

Currently host drivers using the sdhci-pltfm code can not configure the
host based on the type of card inserted.

The sdio driver e.g. calls the card_init callback, so the host can now
know what card is used and configure itself accordingly.

Provide a callback for users of the sdhci-pltfm code to use this callback
function.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes since v1:
	- rebased onto mmc-updates-for-3.16-rc1

 drivers/mmc/host/sdhci.c | 9 +++++++++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47055f3..0fa9004 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2071,6 +2071,14 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static void sdhci_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (host->ops->card_type_init)
+		host->ops->card_type_init(host, card);
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
@@ -2082,6 +2090,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.execute_tuning			= sdhci_execute_tuning,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
+	.init_card	= sdhci_init_card,
 };
 
 /*****************************************************************************\
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4a5cd5e..def4adf 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -292,6 +292,7 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
+	void	(*card_type_init)(struct sdhci_host *host, struct mmc_card *card);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.0.0.rc2


From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH 1/2] sdhci: add init_card callback
Date: Tue, 18 Mar 2014 09:31:29 +0100
Message-ID: <1395131490-11919-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35780 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbaCRIb3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Mar 2014 04:31:29 -0400
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
 drivers/mmc/host/sdhci.c |    9 +++++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9ddef47..20bf40b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2106,6 +2106,14 @@ static void sdhci_card_event(struct mmc_host *mmc)
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
@@ -2117,6 +2125,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.execute_tuning			= sdhci_execute_tuning,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
+	.init_card	= sdhci_init_card,
 };
 
 /*****************************************************************************\
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a3ed01..331a285 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -296,6 +296,7 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
+	void	(*card_type_init)(struct sdhci_host *host, struct mmc_card *card);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.10.4


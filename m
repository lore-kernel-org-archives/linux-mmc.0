From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 3/3] ARM: MXC: mxcmmc: work around a bug in the SDHC busy line handling
Date: Tue, 30 Mar 2010 20:32:01 +0200
Message-ID: <1269973921-29611-3-git-send-email-daniel@caiaq.de>
References: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:44830 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab0C3ScW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2010 14:32:22 -0400
In-Reply-To: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Sascha Hauer <s.hauer@pengutronix.de>, Dan Williams <dan.j.williams@intel.com>, Volker Ernst <volker.ernst@txtr.com>, Jiri Kosina <jkosina@suse.cz>

MX3 SoCs have a silicon bug which corrupts CRC calculation of
multi-block transfers when connected SDIO peripheral doesn't drive the
BUSY line as required by the specs.

One way to prevent this is to only allow 1-bit transfers.

Another way is playing tricks with the DMA engine, but this isn't
mainline yet. So for now, we live with the performance drawback of 1-bit
transfers until a nicer solution is found.

This patch introduces a new host controller callback 'init_card' which
is for now only called from mmc_sdio_init_card().

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Volker Ernst <volker.ernst@txtr.com>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 drivers/mmc/core/sdio.c   |    6 ++++++
 drivers/mmc/host/mxcmmc.c |   14 ++++++++++++++
 include/linux/mmc/host.h  |    3 +++
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 2dd4cfe..b9dee28 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -296,6 +296,12 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	card->type = MMC_TYPE_SDIO;
 
 	/*
+	 * Call the optional HC's init_card function to handle quirks.
+	 */
+	if (host->ops->init_card)
+		host->ops->init_card(host, card);
+
+	/*
 	 * For native busses:  set card RCA and quit open drain mode.
 	 */
 	if (!powered_resume && !mmc_host_is_spi(host)) {
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 83a4545..f584c1b 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -708,11 +708,25 @@ static void mxcmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static void mxcmci_init_card(struct mmc_host *host, struct mmc_card *card)
+{
+	/*
+	 * MX3 SoCs have a silicon bug which corrupts CRC calculation of
+	 * multi-block transfers when connected SDIO peripheral doesn't
+	 * drive the BUSY line as required by the specs.
+	 * One way to prevent this is to only allow 1-bit transfers.
+	 */
+
+	if (cpu_is_mx3() && card->type == MMC_TYPE_SDIO)
+		host->caps &= ~MMC_CAP_4_BIT_DATA;
+}
+
 static const struct mmc_host_ops mxcmci_ops = {
 	.request		= mxcmci_request,
 	.set_ios		= mxcmci_set_ios,
 	.get_ro			= mxcmci_get_ro,
 	.enable_sdio_irq	= mxcmci_enable_sdio_irq,
+	.init_card		= mxcmci_init_card,
 };
 
 static int mxcmci_probe(struct platform_device *pdev)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 43eaf5c..3196c84 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -108,6 +108,9 @@ struct mmc_host_ops {
 	int	(*get_cd)(struct mmc_host *host);
 
 	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
+
+	/* optional callback for HC quirks */
+	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
 };
 
 struct mmc_card;
-- 
1.7.0


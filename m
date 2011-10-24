From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 1/2] mmc: mmci: Support non-power-of-two block sizes for ux500v2 variant
Date: Mon, 24 Oct 2011 16:33:19 +0200
Message-ID: <1319466800-19884-2-git-send-email-ulf.hansson@stericsson.com>
References: <1319466800-19884-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:41532 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932546Ab1JXOdi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 10:33:38 -0400
In-Reply-To: <1319466800-19884-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

For the ux500v2 variant of the PL18x block, non power of two block
sizes are supported. This will make it possible to decrease data
overhead for SDIO transfers.

Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 50b5f99..a6387b5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -53,6 +53,7 @@ static unsigned int fmax = 515633;
  * @sdio: variant supports SDIO
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
+ * @non_power_of_2_blksize: true if block sizes can be other than power of two
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -63,6 +64,7 @@ struct variant_data {
 	bool			sdio;
 	bool			st_clkdiv;
 	bool			blksz_datactrl16;
+	bool			non_power_of_2_blksize;
 };
 
 static struct variant_data variant_arm = {
@@ -104,6 +106,7 @@ static struct variant_data variant_ux500v2 = {
 	.sdio			= true,
 	.st_clkdiv		= true,
 	.blksz_datactrl16	= true,
+	.non_power_of_2_blksize	= true,
 };
 
 /*
@@ -594,7 +597,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	writel(host->size, base + MMCIDATALENGTH);
 
 	blksz_bits = ffs(data->blksz) - 1;
-	BUG_ON(1 << blksz_bits != data->blksz);
 
 	if (variant->blksz_datactrl16)
 		datactrl = MCI_DPSM_ENABLE | (data->blksz << 16);
@@ -974,11 +976,14 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mmci_host *host = mmc_priv(mmc);
+	struct variant_data *variant = host->variant;
 	unsigned long flags;
 
 	WARN_ON(host->mrq != NULL);
 
-	if (mrq->data && !is_power_of_2(mrq->data->blksz)) {
+	if (mrq->data &&
+	    !variant->non_power_of_2_blksize &&
+	    !is_power_of_2(mrq->data->blksz)) {
 		dev_err(mmc_dev(mmc), "unsupported block size (%d bytes)\n",
 			mrq->data->blksz);
 		mrq->cmd->error = -EINVAL;
-- 
1.7.5.4


From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v4 18/25] mmc: sdhci: plug DMA mapping leak on error
Date: Fri, 29 Jan 2016 09:45:19 +0000
Message-ID: <E1aP5cF-0001qM-QU@rmk-PC.arm.linux.org.uk>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44284 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbcA2JuS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:50:18 -0500
In-Reply-To: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

If we terminate a command early, we fail to properly clean up the DMA
mappings for the data part of the request.  Move this clean up to the
tasklet, which is the common path for finishing a request so we always
clean up after ourselves.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a714c628394b..b4808ca8e497 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -900,17 +900,9 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	data = host->data;
 	host->data = NULL;
 
-	if (host->flags & SDHCI_REQ_USE_DMA) {
-		if (host->flags & SDHCI_USE_ADMA)
-			sdhci_adma_table_post(host, data);
-
-		if (data->host_cookie == COOKIE_MAPPED) {
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-				     (data->flags & MMC_DATA_READ) ?
-				     DMA_FROM_DEVICE : DMA_TO_DEVICE);
-			data->host_cookie = COOKIE_UNMAPPED;
-		}
-	}
+	if ((host->flags & (SDHCI_REQ_USE_DMA | SDHCI_USE_ADMA)) ==
+	    (SDHCI_REQ_USE_DMA | SDHCI_USE_ADMA))
+		sdhci_adma_table_post(host, data);
 
 	/*
 	 * The specification states that the block count register must
@@ -2165,6 +2157,22 @@ static void sdhci_tasklet_finish(unsigned long param)
 	mrq = host->mrq;
 
 	/*
+	 * Always unmap the data buffers if they were mapped by
+	 * sdhci_prepare_data() whenever we finish with a request.
+	 * This avoids leaking DMA mappings on error.
+	 */
+	if (host->flags & SDHCI_REQ_USE_DMA) {
+		struct mmc_data *data = mrq->data;
+
+		if (data && data->host_cookie == COOKIE_MAPPED) {
+			dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+				     (data->flags & MMC_DATA_READ) ?
+				     DMA_FROM_DEVICE : DMA_TO_DEVICE);
+			data->host_cookie = COOKIE_UNMAPPED;
+		}
+	}
+
+	/*
 	 * The controller needs a reset of internal state machines
 	 * upon error conditions.
 	 */
-- 
2.1.0


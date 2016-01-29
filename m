From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v4 25/25] mmc: sdhci: further code simplication
Date: Fri, 29 Jan 2016 09:45:56 +0000
Message-ID: <E1aP5cq-0001r2-Tj@rmk-PC.arm.linux.org.uk>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44274 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbcA2JqE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:46:04 -0500
In-Reply-To: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Further simplify the code in sdhci_prepare_data() - we don't set
SDHCI_REQ_USE_DMA anywhere else in the driver, so there is no
need to set it, and then immediately test it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cd5e62f273b3..0e706eefd7d5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -725,21 +725,20 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	host->data_early = 0;
 	host->data->bytes_xfered = 0;
 
-	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))
-		host->flags |= SDHCI_REQ_USE_DMA;
-
-	/*
-	 * FIXME: This doesn't account for merging when mapping the
-	 * scatterlist.
-	 *
-	 * The assumption here being that alignment and lengths are
-	 * the same after DMA mapping to device address space.
-	 */
-	if (host->flags & SDHCI_REQ_USE_DMA) {
+	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		struct scatterlist *sg;
 		unsigned int length_mask, offset_mask;
 		int i;
 
+		host->flags |= SDHCI_REQ_USE_DMA;
+
+		/*
+		 * FIXME: This doesn't account for merging when mapping the
+		 * scatterlist.
+		 *
+		 * The assumption here being that alignment and lengths are
+		 * the same after DMA mapping to device address space.
+		 */
 		length_mask = 0;
 		offset_mask = 0;
 		if (host->flags & SDHCI_USE_ADMA) {
-- 
2.1.0


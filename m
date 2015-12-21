From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v2 24/24] mmc: sdhci: further code simplication
Date: Mon, 21 Dec 2015 11:42:24 +0000
Message-ID: <E1aAyrA-00018U-OC@rmk-PC.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39748 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbLULmj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 06:42:39 -0500
In-Reply-To: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

Further simplify the code in sdhci_prepare_data() - we don't set
SDHCI_REQ_USE_DMA anywhere else in the driver, so there is no
need to set it, and then immediately test it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ce1259f2add3..dde388837891 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -722,21 +722,20 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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


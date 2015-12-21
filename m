From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v2 19/24] mmc: sdhci: further fix for DMA unmapping in
 sdhci_post_req()
Date: Mon, 21 Dec 2015 11:41:59 +0000
Message-ID: <E1aAyql-00017k-3l@rmk-PC.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39748 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbbLULms (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 06:42:48 -0500
In-Reply-To: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

sdhci_post_req() exists to unmap a previously mapped but already
finished request, while the next request is in progress.  However, the
state of the SDHCI_REQ_USE_DMA flag depends on the last submitted
request.

This means we can end up clearing the flag due to a quirk, which then
means that sdhci_post_req() fails to unmap the DMA buffer, potentially
leading to data corruption.

We can safely ignore the SDHCI_REQ_USE_DMA here, as testing
data->host_cookie is entirely sufficient.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4ead8b2f8f8f..9ecac99ae7e2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2068,13 +2068,12 @@ static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct sdhci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
-	if (host->flags & SDHCI_REQ_USE_DMA) {
-		if (data->host_cookie != COOKIE_UNMAPPED)
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-					 data->flags & MMC_DATA_WRITE ?
-					 DMA_TO_DEVICE : DMA_FROM_DEVICE);
-		data->host_cookie = COOKIE_UNMAPPED;
-	}
+	if (data->host_cookie != COOKIE_UNMAPPED)
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     data->flags & MMC_DATA_WRITE ?
+			       DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+	data->host_cookie = COOKIE_UNMAPPED;
 }
 
 static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
-- 
2.1.0


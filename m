From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v4 20/25] mmc: sdhci: further fix for DMA unmapping in
 sdhci_post_req()
Date: Fri, 29 Jan 2016 09:45:30 +0000
Message-ID: <E1aP5cQ-0001qY-Or@rmk-PC.arm.linux.org.uk>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44284 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbcA2Jua (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:50:30 -0500
In-Reply-To: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

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
index b4808ca8e497..7fed845797a0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2059,13 +2059,12 @@ static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
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


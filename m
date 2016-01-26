From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 16/25] mmc: sdhci: always unmap a mapped data transfer in
 sdhci_post_req()
Date: Tue, 26 Jan 2016 13:40:32 +0000
Message-ID: <E1aO3rE-0005jA-KP@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36923 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964989AbcAZNpI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:45:08 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

If the host cookie indicates that the data buffers of a request are
mapped at sdhci_post_req() time, always unmap the data buffers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 51f6678879d3..5143003f2c67 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2068,8 +2068,7 @@ static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct mmc_data *data = mrq->data;
 
 	if (host->flags & SDHCI_REQ_USE_DMA) {
-		if (data->host_cookie == COOKIE_GIVEN ||
-				data->host_cookie == COOKIE_MAPPED)
+		if (data->host_cookie != COOKIE_UNMAPPED)
 			dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
 					 data->flags & MMC_DATA_WRITE ?
 					 DMA_TO_DEVICE : DMA_FROM_DEVICE);
-- 
2.1.0


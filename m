From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v4 16/25] mmc: sdhci: always unmap a mapped data transfer in
 sdhci_post_req()
Date: Fri, 29 Jan 2016 09:45:09 +0000
Message-ID: <E1aP5c5-0001qA-2w@rmk-PC.arm.linux.org.uk>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44284 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbcA2Jug (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:50:36 -0500
In-Reply-To: <20160129094324.GA20025@n2100.arm.linux.org.uk>
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
index bd7fffa5b317..3da2a0461e4b 100644
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


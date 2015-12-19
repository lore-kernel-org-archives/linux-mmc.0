From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 14/17] mmc: sdhci: always unmap a mapped data transfer in
 sdhci_post_req()
Date: Sat, 19 Dec 2015 20:31:15 +0000
Message-ID: <E1aAO9r-0007zO-Mn@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36182 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724AbbLSUbl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Dec 2015 15:31:41 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

If the host cookie indicates that the data buffers of a request are
mapped at sdhci_post_req() time, always unmap the data buffers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 46cffb7f6841..264248ac439e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2077,8 +2077,7 @@ static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
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


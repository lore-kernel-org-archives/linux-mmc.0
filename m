From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 15/25] mmc: sdhci: pass the cookie into
 sdhci_pre_dma_transfer()
Date: Tue, 26 Jan 2016 13:40:27 +0000
Message-ID: <E1aO3r9-0005j2-EI@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36886 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965242AbcAZNko (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:40:44 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Pass the desired cookie for a successful map.  This is in preparation to
clean up the MAPPED/GIVEN states.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 27f37f562ea7..51f6678879d3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -427,7 +427,7 @@ static void sdhci_transfer_pio(struct sdhci_host *host)
 }
 
 static int sdhci_pre_dma_transfer(struct sdhci_host *host,
-				  struct mmc_data *data)
+				  struct mmc_data *data, int cookie)
 {
 	int sg_count;
 
@@ -446,7 +446,7 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 		return -ENOSPC;
 
 	data->sg_count = sg_count;
-	data->host_cookie = COOKIE_MAPPED;
+	data->host_cookie = cookie;
 
 	return sg_count;
 }
@@ -780,7 +780,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	if (host->flags & SDHCI_REQ_USE_DMA) {
-		int sg_cnt = sdhci_pre_dma_transfer(host, data);
+		int sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
 
 		if (sg_cnt <= 0) {
 			/*
@@ -2085,7 +2085,7 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	mrq->data->host_cookie = COOKIE_UNMAPPED;
 
 	if (host->flags & SDHCI_REQ_USE_DMA)
-		sdhci_pre_dma_transfer(host, mrq->data);
+		sdhci_pre_dma_transfer(host, mrq->data, COOKIE_MAPPED);
 }
 
 static void sdhci_card_event(struct mmc_host *mmc)
-- 
2.1.0


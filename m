From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 13/17] mmc: sdhci: pass the cookie into
 sdhci_pre_dma_transfer()
Date: Sat, 19 Dec 2015 20:31:10 +0000
Message-ID: <E1aAO9m-0007zI-IW@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36179 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724AbbLSUbh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Dec 2015 15:31:37 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

Pass the desired cookie for a successful map.  This is in preparation to
clean up the MAPPED/GIVEN states.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d7cc61101a1a..46cffb7f6841 100644
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
@@ -779,7 +779,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	if (host->flags & SDHCI_REQ_USE_DMA) {
-		int sg_cnt = sdhci_pre_dma_transfer(host, data);
+		int sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
 
 		if (sg_cnt <= 0) {
 			/*
@@ -2094,7 +2094,7 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	mrq->data->host_cookie = COOKIE_UNMAPPED;
 
 	if (host->flags & SDHCI_REQ_USE_DMA)
-		sdhci_pre_dma_transfer(host, mrq->data);
+		sdhci_pre_dma_transfer(host, mrq->data, COOKIE_MAPPED);
 }
 
 static void sdhci_card_event(struct mmc_host *mmc)
-- 
2.1.0


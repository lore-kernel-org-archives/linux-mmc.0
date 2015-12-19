From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 15/17] mmc: sdhci: clean up host cookie handling
Date: Sat, 19 Dec 2015 20:31:20 +0000
Message-ID: <E1aAO9w-0007zX-Py@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36189 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbbLSUc1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Dec 2015 15:32:27 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

Commit d31911b9374a ("mmc: sdhci: fix dma memory leak in sdhci_pre_req()")
added a complicated method to manage the DMA map state for the data
transfer, but this complexity is not required.

There are three states:
* Unmapped
* Mapped by sdhci_pre_req()
* Mapped by sdhci_prepare_data()

sdhci_prepare_data() needs to know when the data buffers have been
successfully mapped by sdhci_pre_req(), and if so, there is no need to
map them a second time.

When we come to tear down the mapping, we want to know whether
sdhci_post_req() will be called (which is determined by sdhci_pre_req()
having been previously called) so that we can postpone the unmap
operation.

Hence, it makes sense to simply record when the successful DMA map
happened (via COOKIE_PRE_MAPPED vs COOKIE_MAPPED) rather than having
the complex mechanics involving COOKIE_MAPPED vs COOKIE_GIVEN.

If a mapping is created by sdhci_prepare_data(), we must tear it down
ourselves, without waiting for sdhci_post_req() (hence, the new
COOKIE_MAPPED case).  If the mapping is created by sdhci_pre_req()
then sdhci_post_req() is responsible for tearing the mapping down.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 12 ++++++------
 drivers/mmc/host/sdhci.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 264248ac439e..6f23dba74cbc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -431,12 +431,12 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 {
 	int sg_count;
 
-	if (data->host_cookie == COOKIE_MAPPED) {
-		data->host_cookie = COOKIE_GIVEN;
+	/*
+	 * If the data buffers are already mapped, return the previous
+	 * dma_map_sg() result.
+	 */
+	if (data->host_cookie == COOKIE_PRE_MAPPED)
 		return data->sg_count;
-	}
-
-	WARN_ON(data->host_cookie == COOKIE_GIVEN);
 
 	sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
 				data->flags & MMC_DATA_WRITE ?
@@ -2093,7 +2093,7 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	mrq->data->host_cookie = COOKIE_UNMAPPED;
 
 	if (host->flags & SDHCI_REQ_USE_DMA)
-		sdhci_pre_dma_transfer(host, mrq->data, COOKIE_MAPPED);
+		sdhci_pre_dma_transfer(host, mrq->data, COOKIE_PRE_MAPPED);
 }
 
 static void sdhci_card_event(struct mmc_host *mmc)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 9d4aa31b683a..9dd2e1f688ea 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -311,8 +311,8 @@ struct sdhci_adma2_64_desc {
 
 enum sdhci_cookie {
 	COOKIE_UNMAPPED,
-	COOKIE_MAPPED,
-	COOKIE_GIVEN,
+	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
+	COOKIE_MAPPED,		/* mapped by sdhci_prepare_data() */
 };
 
 struct sdhci_host {
-- 
2.1.0


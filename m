From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v4 17/25] mmc: sdhci: clean up host cookie handling
Date: Fri, 29 Jan 2016 09:45:14 +0000
Message-ID: <E1aP5cA-0001qG-EU@rmk-PC.arm.linux.org.uk>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44284 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbcA2JuN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:50:13 -0500
In-Reply-To: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

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
index 3da2a0461e4b..a714c628394b 100644
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
@@ -2084,7 +2084,7 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	mrq->data->host_cookie = COOKIE_UNMAPPED;
 
 	if (host->flags & SDHCI_REQ_USE_DMA)
-		sdhci_pre_dma_transfer(host, mrq->data, COOKIE_MAPPED);
+		sdhci_pre_dma_transfer(host, mrq->data, COOKIE_PRE_MAPPED);
 }
 
 static void sdhci_card_event(struct mmc_host *mmc)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7654ae5d2b4e..19e9291e5074 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -316,8 +316,8 @@ struct sdhci_adma2_64_desc {
 
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


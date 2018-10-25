From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH] mmc: sdhci: Convert sdhci_allocate_bounce_buffer() to return void
Date: Thu, 25 Oct 2018 10:12:36 +0800
Message-ID: <1540433556-12261-1-git-send-email-zhang.chunyan@linaro.org>
References: <1540368084-32202-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540368084-32202-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The function sdhci_allocate_bounce_buffer() always return zero at
present, so there's no need to have a return value, that will also make
error path easier.

CC: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1b3fbd9..e94f4aa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3408,7 +3408,7 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
-static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
+static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 	unsigned int max_blocks;
@@ -3446,7 +3446,7 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 		 * Exiting with zero here makes sure we proceed with
 		 * mmc->max_segs == 1.
 		 */
-		return 0;
+		return;
 	}
 
 	host->bounce_addr = dma_map_single(mmc->parent,
@@ -3456,7 +3456,7 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 	ret = dma_mapping_error(mmc->parent, host->bounce_addr);
 	if (ret)
 		/* Again fall back to max_segs == 1 */
-		return 0;
+		return;
 	host->bounce_buffer_size = bounce_size;
 
 	/* Lie about this since we're bouncing */
@@ -3466,8 +3466,6 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 
 	pr_info("%s bounce up to %u segments into one, max segment size %u bytes\n",
 		mmc_hostname(mmc), max_blocks, bounce_size);
-
-	return 0;
 }
 
 int sdhci_setup_host(struct sdhci_host *host)
@@ -3987,12 +3985,9 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 */
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
 
-	if (mmc->max_segs == 1) {
+	if (mmc->max_segs == 1)
 		/* This may alter mmc->*_blk_* parameters */
-		ret = sdhci_allocate_bounce_buffer(host);
-		if (ret)
-			return ret;
-	}
+		sdhci_allocate_bounce_buffer(host);
 
 	return 0;
 
-- 
2.7.4

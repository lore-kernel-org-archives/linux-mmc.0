From: Markus Mayer <markus.mayer@linaro.org>
Subject: [PATCH v3 3/3] mmc: sdhci: Replace host->mmc with mmc where possible
Date: Thu, 12 Jun 2014 11:48:55 -0700
Message-ID: <1402598935-3701-4-git-send-email-markus.mayer@linaro.org>
References: <1402598935-3701-1-git-send-email-markus.mayer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402598935-3701-1-git-send-email-markus.mayer@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tim Kryger <tim.kryger@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>, Andrew Bresticker <abrestic@chromium.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

After the switch to the MMC core regulator infrastucture, we already
have a local "mmc" pointer in various functions. There is no longer a
need to access the data structure via host->mmc.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <mporter@linaro.org>
---
 drivers/mmc/host/sdhci.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f15720e..54b5304 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1734,7 +1734,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 						    3600000);
 			if (ret) {
 				pr_warning("%s: Switching to 3.3V signalling voltage "
-						" failed\n", mmc_hostname(host->mmc));
+						" failed\n", mmc_hostname(mmc));
 				return -EIO;
 			}
 		}
@@ -1747,7 +1747,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 			return 0;
 
 		pr_warning("%s: 3.3V regulator output did not became stable\n",
-				mmc_hostname(host->mmc));
+				mmc_hostname(mmc));
 
 		return -EAGAIN;
 	case MMC_SIGNAL_VOLTAGE_180:
@@ -1756,7 +1756,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 					1700000, 1950000);
 			if (ret) {
 				pr_warning("%s: Switching to 1.8V signalling voltage "
-						" failed\n", mmc_hostname(host->mmc));
+						" failed\n", mmc_hostname(mmc));
 				return -EIO;
 			}
 		}
@@ -1777,7 +1777,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 			return 0;
 
 		pr_warning("%s: 1.8V regulator output did not became stable\n",
-				mmc_hostname(host->mmc));
+				mmc_hostname(mmc));
 
 		return -EAGAIN;
 	case MMC_SIGNAL_VOLTAGE_120:
@@ -1786,7 +1786,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 						    1300000);
 			if (ret) {
 				pr_warning("%s: Switching to 1.2V signalling voltage "
-						" failed\n", mmc_hostname(host->mmc));
+						" failed\n", mmc_hostname(mmc));
 				return -EIO;
 			}
 		}
@@ -2826,12 +2826,12 @@ int sdhci_add_host(struct sdhci_host *host)
 		 * (128) and potentially one alignment transfer for
 		 * each of those entries.
 		 */
-		host->adma_desc = dma_alloc_coherent(mmc_dev(host->mmc),
+		host->adma_desc = dma_alloc_coherent(mmc_dev(mmc),
 						     ADMA_SIZE, &host->adma_addr,
 						     GFP_KERNEL);
 		host->align_buffer = kmalloc(128 * 4, GFP_KERNEL);
 		if (!host->adma_desc || !host->align_buffer) {
-			dma_free_coherent(mmc_dev(host->mmc), ADMA_SIZE,
+			dma_free_coherent(mmc_dev(mmc), ADMA_SIZE,
 					  host->adma_desc, host->adma_addr);
 			kfree(host->align_buffer);
 			pr_warning("%s: Unable to allocate ADMA "
@@ -2844,7 +2844,7 @@ int sdhci_add_host(struct sdhci_host *host)
 			pr_warning("%s: unable to allocate aligned ADMA descriptor\n",
 				   mmc_hostname(mmc));
 			host->flags &= ~SDHCI_USE_ADMA;
-			dma_free_coherent(mmc_dev(host->mmc), ADMA_SIZE,
+			dma_free_coherent(mmc_dev(mmc), ADMA_SIZE,
 					  host->adma_desc, host->adma_addr);
 			kfree(host->align_buffer);
 			host->adma_desc = NULL;
@@ -2859,7 +2859,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	 */
 	if (!(host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))) {
 		host->dma_mask = DMA_BIT_MASK(64);
-		mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
+		mmc_dev(mmc)->dma_mask = &host->dma_mask;
 	}
 
 	if (host->version >= SDHCI_SPEC_300)
@@ -2965,7 +2965,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
-	    !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
+	    !(mmc->caps & MMC_CAP_NONREMOVABLE))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	/* If there are external regulators, get them */
@@ -3261,7 +3261,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 		if (host->mrq) {
 			pr_err("%s: Controller removed during "
-				" transfer!\n", mmc_hostname(host->mmc));
+				" transfer!\n", mmc_hostname(mmc));
 
 			host->mrq->cmd->error = -ENOMEDIUM;
 			tasklet_schedule(&host->finish_tasklet);
@@ -3272,7 +3272,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	sdhci_disable_card_detection(host);
 
-	mmc_remove_host(host->mmc);
+	mmc_remove_host(mmc);
 
 #ifdef SDHCI_USE_LEDS_CLASS
 	led_classdev_unregister(&host->led);
@@ -3296,7 +3296,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 		regulator_disable(mmc->supply.vqmmc);
 
 	if (host->adma_desc)
-		dma_free_coherent(mmc_dev(host->mmc), ADMA_SIZE,
+		dma_free_coherent(mmc_dev(mmc), ADMA_SIZE,
 				  host->adma_desc, host->adma_addr);
 	kfree(host->align_buffer);
 
-- 
1.9.1

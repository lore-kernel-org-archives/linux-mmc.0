From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 13/38] mmc: sdhci: convert ADMA descriptors to a coherent
 allocation
Date: Wed, 23 Apr 2014 20:07:16 +0100
Message-ID: <E1Wd2Vo-0003vA-LF@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46413 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756744AbaDWTHY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:07:24 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

Rather than using the streaming API, use the coherent allocator to
provide this memory, thereby eliminating cache flushing of it each
time we map and unmap it.  This results in a 7.5% increase in
transfer speed with a UHS-1 card operating in 3.3v mode at a clock
of 49.5MHz.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 078bf43b4aae..9efa7d878731 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -44,6 +44,8 @@
 
 #define MAX_TUNING_LOOP 40
 
+#define ADMA_SIZE	((128 * 2 + 1) * 4)
+
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
 
@@ -481,11 +483,6 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 	else
 		direction = DMA_TO_DEVICE;
 
-	/*
-	 * The ADMA descriptor table is mapped further down as we
-	 * need to fill it with data first.
-	 */
-
 	host->align_addr = dma_map_single(mmc_dev(host->mmc),
 		host->align_buffer, 128 * 4, direction);
 	if (dma_mapping_error(mmc_dev(host->mmc), host->align_addr))
@@ -546,7 +543,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		 * If this triggers then we have a calculation bug
 		 * somewhere. :/
 		 */
-		WARN_ON((desc - host->adma_desc) > (128 * 2 + 1) * 4);
+		WARN_ON((desc - host->adma_desc) > ADMA_SIZE);
 	}
 
 	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
@@ -574,17 +571,8 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 			host->align_addr, 128 * 4, direction);
 	}
 
-	host->adma_addr = dma_map_single(mmc_dev(host->mmc),
-		host->adma_desc, (128 * 2 + 1) * 4, DMA_TO_DEVICE);
-	if (dma_mapping_error(mmc_dev(host->mmc), host->adma_addr))
-		goto unmap_entries;
-	BUG_ON(host->adma_addr & 0x3);
-
 	return 0;
 
-unmap_entries:
-	dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-		data->sg_len, direction);
 unmap_align:
 	dma_unmap_single(mmc_dev(host->mmc), host->align_addr,
 		128 * 4, direction);
@@ -609,9 +597,6 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	else
 		direction = DMA_TO_DEVICE;
 
-	dma_unmap_single(mmc_dev(host->mmc), host->adma_addr,
-		(128 * 2 + 1) * 4, DMA_TO_DEVICE);
-
 	dma_unmap_single(mmc_dev(host->mmc), host->align_addr,
 		128 * 4, direction);
 
@@ -2851,15 +2836,29 @@ int sdhci_add_host(struct sdhci_host *host)
 		 * (128) and potentially one alignment transfer for
 		 * each of those entries.
 		 */
-		host->adma_desc = kmalloc((128 * 2 + 1) * 4, GFP_KERNEL);
+		host->adma_desc = dma_alloc_coherent(mmc_dev(host->mmc),
+						     ADMA_SIZE, &host->adma_addr,
+						     GFP_KERNEL);
 		host->align_buffer = kmalloc(128 * 4, GFP_KERNEL);
 		if (!host->adma_desc || !host->align_buffer) {
-			kfree(host->adma_desc);
+			dma_free_coherent(mmc_dev(host->mmc), ADMA_SIZE,
+					  host->adma_desc, host->adma_addr);
 			kfree(host->align_buffer);
 			pr_warning("%s: Unable to allocate ADMA "
 				"buffers. Falling back to standard DMA.\n",
 				mmc_hostname(mmc));
 			host->flags &= ~SDHCI_USE_ADMA;
+			host->adma_desc = NULL;
+			host->align_buffer = NULL;
+		} else if (host->adma_addr & 3) {
+			pr_warning("%s: unable to allocate aligned ADMA descriptor\n",
+				   mmc_hostname(mmc));
+			host->flags &= ~SDHCI_USE_ADMA;
+			dma_free_coherent(mmc_dev(host->mmc), ADMA_SIZE,
+					  host->adma_desc, host->adma_addr);
+			kfree(host->align_buffer);
+			host->adma_desc = NULL;
+			host->align_buffer = NULL;
 		}
 	}
 
@@ -3337,7 +3336,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 		regulator_put(host->vqmmc);
 	}
 
-	kfree(host->adma_desc);
+	if (host->adma_desc)
+		dma_free_coherent(mmc_dev(host->mmc), ADMA_SIZE,
+				  host->adma_desc, host->adma_addr);
 	kfree(host->align_buffer);
 
 	host->adma_desc = NULL;
-- 
1.8.3.1


From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 15/31] mmc: sdhci: convert ADMA descriptors to a coherent
 allocation
Date: Tue, 18 Feb 2014 15:10:19 +0000
Message-ID: <E1WFmJP-0006mm-EP@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40499 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755789AbaBRPKY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:10:24 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

Rather than using the streaming API, use the coherent allocator to
provide this memory, thereby eliminating cache flushing of it each
time we map and unmap it.  This results in a 7.5% increase in
transfer speed with a UHS-1 card operating in 3.3v mode at a clock
of 49.5MHz.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e918e17c39e4..d046b4eee335 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -44,6 +44,8 @@
 
 #define MAX_TUNING_LOOP 40
 
=+DO NOT APPLY+=#define ADMA_SIZE	((128 * 2 + 1) * 4)
=+DO NOT APPLY+=
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
=+DO NOT APPLY+=		WARN_ON((desc - host->adma_desc) > ADMA_SIZE);
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
 
@@ -2854,15 +2839,29 @@ int sdhci_add_host(struct sdhci_host *host)
 		 * (128) and potentially one alignment transfer for
 		 * each of those entries.
 		 */
-		host->adma_desc = kmalloc((128 * 2 + 1) * 4, GFP_KERNEL);
=+DO NOT APPLY+=		host->adma_desc = dma_alloc_coherent(mmc_dev(host->mmc),
=+DO NOT APPLY+=						     ADMA_SIZE, &host->adma_addr,
=+DO NOT APPLY+=						     GFP_KERNEL);
 		host->align_buffer = kmalloc(128 * 4, GFP_KERNEL);
 		if (!host->adma_desc || !host->align_buffer) {
-			kfree(host->adma_desc);
=+DO NOT APPLY+=			dma_free_coherent(mmc_dev(host->mmc), ADMA_SIZE,
=+DO NOT APPLY+=					  host->adma_desc, host->adma_addr);
 			kfree(host->align_buffer);
 			pr_warning("%s: Unable to allocate ADMA "
 				"buffers. Falling back to standard DMA.\n",
 				mmc_hostname(mmc));
 			host->flags &= ~SDHCI_USE_ADMA;
=+DO NOT APPLY+=			host->adma_desc = NULL;
=+DO NOT APPLY+=			host->align_buffer = NULL;
=+DO NOT APPLY+=		} else if (host->adma_addr & 3) {
=+DO NOT APPLY+=			pr_warning("%s: unable to allocate aligned ADMA descriptor\n",
=+DO NOT APPLY+=				   mmc_hostname(mmc));
=+DO NOT APPLY+=			host->flags &= ~SDHCI_USE_ADMA;
=+DO NOT APPLY+=			dma_free_coherent(mmc_dev(host->mmc), ADMA_SIZE,
=+DO NOT APPLY+=					  host->adma_desc, host->adma_addr);
=+DO NOT APPLY+=			kfree(host->align_buffer);
=+DO NOT APPLY+=			host->adma_desc = NULL;
=+DO NOT APPLY+=			host->align_buffer = NULL;
 		}
 	}
 
@@ -3339,7 +3338,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 		regulator_put(host->vqmmc);
 	}
 
-	kfree(host->adma_desc);
=+DO NOT APPLY+=	if (host->adma_desc)
=+DO NOT APPLY+=		dma_free_coherent(mmc_dev(host->mmc), ADMA_SIZE,
=+DO NOT APPLY+=				  host->adma_desc, host->adma_addr);
 	kfree(host->align_buffer);
 
 	host->adma_desc = NULL;
-- 
1.8.3.1


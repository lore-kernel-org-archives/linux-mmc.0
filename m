From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 14/31] mmc: sdhci: avoid sync'ing the SG if there's no
 misalignment
Date: Tue, 18 Feb 2014 15:10:14 +0000
Message-ID: <E1WFmJK-0006mi-Aw@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40491 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755906AbaBRPKT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:10:19 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

On read, we don't need to sync the whole scatterlist and then check
whether any segments need copying - if we check first, we avoid
potentially expensive cache handling.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bcf4f9ec0ea4..e918e17c39e4 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -602,6 +602,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	u8 *align;
 	char *buffer;
 	unsigned long flags;
=+DO NOT APPLY+=	bool has_unaligned;
 
 	if (data->flags & MMC_DATA_READ)
 		direction = DMA_FROM_DEVICE;
@@ -614,7 +615,15 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	dma_unmap_single(mmc_dev(host->mmc), host->align_addr,
 		128 * 4, direction);
 
-	if (data->flags & MMC_DATA_READ) {
=+DO NOT APPLY+=	/* Do a quick scan of the SG list for any unaligned mappings */
=+DO NOT APPLY+=	has_unaligned = false;
=+DO NOT APPLY+=	for_each_sg(data->sg, sg, host->sg_count, i)
=+DO NOT APPLY+=		if (sg_dma_address(sg) & 3) {
=+DO NOT APPLY+=			has_unaligned = true;
=+DO NOT APPLY+=			break;
=+DO NOT APPLY+=		}
=+DO NOT APPLY+=
=+DO NOT APPLY+=	if (has_unaligned && data->flags & MMC_DATA_READ) {
 		dma_sync_sg_for_cpu(mmc_dev(host->mmc), data->sg,
 			data->sg_len, direction);
 
-- 
1.8.3.1


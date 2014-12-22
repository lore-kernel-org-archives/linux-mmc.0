From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH] mmc: sdhci: Remove redundant ADMA page boundary warnings
Date: Mon, 22 Dec 2014 06:23:21 -0600
Message-ID: <1419251001-12168-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:49960 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbaLVMX2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Dec 2014 07:23:28 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1Y321H-0003el-2P from Andrew_Gabbasov@mentor.com
	for linux-mmc@vger.kernel.org; Mon, 22 Dec 2014 04:23:27 -0800
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

The bounce buffer, used for misaligned bytes for ADMA access,
resides wholly within the (align_sz)-aligned word, just by construction.
The page addresses are aligned to (align_sz), either for 4 or 8 bytes
alignment, so that the aligned word resides wholly within a single page
and can't cross the page boundary. So, the bounce buffer can't cross
the page boundary too. That's why the warnings are never hit, and can
be safely removed.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 drivers/mmc/host/sdhci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cbb245b..9dc2770 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -533,8 +533,6 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		if (offset) {
 			if (data->flags & MMC_DATA_WRITE) {
 				buffer = sdhci_kmap_atomic(sg, &flags);
-				WARN_ON(((long)buffer & (PAGE_SIZE - 1)) >
-					(PAGE_SIZE - offset));
 				memcpy(align, buffer, offset);
 				sdhci_kunmap_atomic(buffer, &flags);
 			}
@@ -641,8 +639,6 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 				       (sg_dma_address(sg) & host->align_mask);
 
 				buffer = sdhci_kmap_atomic(sg, &flags);
-				WARN_ON(((long)buffer & (PAGE_SIZE - 1)) >
-					(PAGE_SIZE - size));
 				memcpy(buffer, align, size);
 				sdhci_kunmap_atomic(buffer, &flags);
 
-- 
2.1.0


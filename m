From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 02/15] mmc: sdhci: Fix ADMA page boundary warnings
Date: Tue,  4 Nov 2014 12:42:36 +0200
Message-ID: <1415097769-19032-3-git-send-email-adrian.hunter@intel.com>
References: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9170 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbaKDKoX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 05:44:23 -0500
In-Reply-To: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Bytes are being copied from/to a single page.  The intent
of the warning is to warn if the page boundary is crossed.
There are two problems.  First, PAGE_MASK is mistaken for
(PAGE_SIZE - 1).  Secondly, instead of using the number
of bytes to copy, the warning is using the maximum that
that value could be.  Fix both.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 41c6d3b..e759357 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -525,7 +525,8 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		if (offset) {
 			if (data->flags & MMC_DATA_WRITE) {
 				buffer = sdhci_kmap_atomic(sg, &flags);
-				WARN_ON(((long)buffer & PAGE_MASK) > (PAGE_SIZE - 3));
+				WARN_ON(((long)buffer & (PAGE_SIZE - 1)) >
+					(PAGE_SIZE - offset));
 				memcpy(align, buffer, offset);
 				sdhci_kunmap_atomic(buffer, &flags);
 			}
@@ -630,7 +631,8 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 				size = 4 - (sg_dma_address(sg) & 0x3);
 
 				buffer = sdhci_kmap_atomic(sg, &flags);
-				WARN_ON(((long)buffer & PAGE_MASK) > (PAGE_SIZE - 3));
+				WARN_ON(((long)buffer & (PAGE_SIZE - 1)) >
+					(PAGE_SIZE - size));
 				memcpy(buffer, align, size);
 				sdhci_kunmap_atomic(buffer, &flags);
 
-- 
1.9.1


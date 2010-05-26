From: akpm@linux-foundation.org
Subject: [patch 012/203] mmc: SDHCI_INT_DATA_MASK typo error
Date: Wed, 26 May 2010 14:42:02 -0700
Message-ID: <201005262142.o4QLg219015351@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37166 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754323Ab0EZV5e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 17:57:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, zgao6@marvell.com, linux-mmc@vger.kernel.org, matt@console-pimps.org

From: Zhangfei Gao <zgao6@marvell.com>

Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
Reviewed-by: Matt Fleming <matt@console-pimps.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/host/sdhci.h~mmc-sdhci_int_data_mask-typo-error drivers/mmc/host/sdhci.h
--- a/drivers/mmc/host/sdhci.h~mmc-sdhci_int_data_mask-typo-error
+++ a/drivers/mmc/host/sdhci.h
@@ -127,7 +127,7 @@
 #define  SDHCI_INT_DATA_MASK	(SDHCI_INT_DATA_END | SDHCI_INT_DMA_END | \
 		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
 		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
-		SDHCI_INT_DATA_END_BIT | SDHCI_ADMA_ERROR)
+		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR)
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
 
 #define SDHCI_ACMD12_ERR	0x3C
_

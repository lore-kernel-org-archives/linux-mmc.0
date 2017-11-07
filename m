From: Jungseung Lee <js07.lee@samsung.com>
Subject: [PATCH 1/2] mmc : Add unmmapped zero quirk flag
Date: Tue, 07 Nov 2017 16:02:58 +0900
Message-ID: <20171107070259.11664-1-js07.lee@samsung.com>
References: <CGME20171107070318eucas1p18f1f745136c9cea51468a20004a55666@eucas1p1.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44086 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755085AbdKGHDW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Nov 2017 02:03:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Christoph Hellwig <hch@lst.de>, js07.lee@gmail.com, linux-mmc@vger.kernel.org
Cc: Jungseung Lee <js07.lee@samsung.com>

Some devices return zeroes on read to unmmaped logical blocks.
This patch adds a flag to the mmc quirk list for the devices work that way.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 include/linux/mmc/card.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 279b390..f032cb0 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -268,6 +268,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
+#define MMC_QUIRK_UNMAPPED_ZEROES	(1<<14)	/* Return 0's on read to unmmaped logical blocks */
 
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
-- 
2.10.1


From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] Fix mmc_test build order
Date: Mon, 26 Jul 2010 19:09:56 +0900
Message-ID: <20100726100956.GA17996@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9321 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953Ab0GZKKY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Jul 2010 06:10:24 -0400
Received: from epmmp1. (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L6500BCZTKTVVC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Jul 2010 19:10:05 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net
 (unknown [165.213.149.150])
 by mmp1.samsung.com (Sun Java(tm) System Messaging Server 7u3-15.01 64bit
 (built Feb 12 2010)) with ESMTPA id <0L6500GRUTKTH200@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Jul 2010 19:10:05 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org
Cc: adrian.hunter@nokia.com, m.szyprowski@samsung.com

To use the mmc_test, it should be build before mmc_block.

Reported-by: Adrian Hunter <adrian.hunter@nokia.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
index 0d40751..9d50437 100644
--- a/drivers/mmc/card/Makefile
+++ b/drivers/mmc/card/Makefile
@@ -6,9 +6,9 @@ ifeq ($(CONFIG_MMC_DEBUG),y)
 	EXTRA_CFLAGS		+= -DDEBUG
 endif
 
+obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
 mmc_block-objs			:= block.o queue.o
-obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 
 obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
 

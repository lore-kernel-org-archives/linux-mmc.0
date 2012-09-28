From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: dw_mmc: convert the variable type of irq
Date: Fri, 28 Sep 2012 14:21:59 +0900
Message-ID: <00f901cd9d39$2f84c720$8e8e5560$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9153 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab2I1FWC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 01:22:02 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MB100FXIO8J5VJ0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Sep 2012 14:22:00 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MB1005MEO8NBL90@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Sep 2012 14:22:00 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

Even though platform_get_irq returns error, 'host->irq'
always has an unsigned value. Less-than-zero comparison
of an unsigned value is never true. Type of 'unsigned int'
will be changed for 'int'.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 include/linux/mmc/dw_mmc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 7c6a113..3141676 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -186,7 +186,7 @@ struct dw_mci {
 
 	struct regulator	*vmmc;	/* Power regulator */
 	unsigned long		irq_flags; /* IRQ flags */
-	unsigned int		irq;
+	int			irq;
 };
 
 /* DMA ops for Internal/External DMAC interface */
-- 
1.7.0.4



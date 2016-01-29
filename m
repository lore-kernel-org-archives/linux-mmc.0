From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RESEND PATCH 10/11] mmc: core: remove the MMC_DATA_STREAM flag
Date: Fri, 29 Jan 2016 14:40:56 +0900
Message-ID: <1454046057-32318-11-git-send-email-jh80.chung@samsung.com>
References: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36357 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbcA2FlG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 00:41:06 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P01O7Y94D6B80@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 14:41:01 +0900 (KST)
In-reply-to: <1454046057-32318-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, Jaehoon Chung <jh80.chung@samsung.com>

It's not set to MMC_DATA_STREAM anywhere.
It seems that it had been used with CMD11/CMD20.
But according to Spec, CMD11/CMD20 are obsolete command.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 include/linux/mmc/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 37967b6..b01e77d 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -113,7 +113,6 @@ struct mmc_data {
 
 #define MMC_DATA_WRITE	(1 << 8)
 #define MMC_DATA_READ	(1 << 9)
-#define MMC_DATA_STREAM	(1 << 10)
 
 	unsigned int		bytes_xfered;
 
-- 
1.9.1


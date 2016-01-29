From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 11/12] mmc: core: remove the MMC_DATA_STREAM flag
Date: Fri, 29 Jan 2016 13:06:10 +0900
Message-ID: <1454040371-31625-12-git-send-email-jh80.chung@samsung.com>
References: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43544 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbcA2EGY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 23:06:24 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P02V674QJEPE0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 13:06:19 +0900 (KST)
In-reply-to: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
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


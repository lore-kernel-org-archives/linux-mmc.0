From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 10/11] mmc: core: remove the MMC_DATA_STREAM flag
Date: Mon, 01 Feb 2016 21:07:35 +0900
Message-ID: <1454328456-22918-11-git-send-email-jh80.chung@samsung.com>
References: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46527 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbcBAMHr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 07:07:47 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1V01IY0B0Q3Z80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 01 Feb 2016 21:07:38 +0900 (KST)
In-reply-to: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, andi.shyti@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

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


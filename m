From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: host: don't access at boot partition when mode is
 HS200/HS400.
Date: Wed, 13 Aug 2014 13:46:16 +0900
Message-ID: <1407905176-6847-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21876 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbaHMEqU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 00:46:20 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NA8005KLAL6MT50@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Aug 2014 13:46:18 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>

HS200/HS400 mode is not supported during boot operation.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 include/linux/mmc/host.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7960424..ce5db96 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -445,6 +445,10 @@ static inline int mmc_host_cmd23(struct mmc_host *host)
 
 static inline int mmc_boot_partition_access(struct mmc_host *host)
 {
+	/* HS200 & HS400 mode is not supported during boot operation */
+	if (host->caps2 & (MMC_CAP2_HS200 | MMC_CAP2_HS400))
+		return 0;
+
 	return !(host->caps2 & MMC_CAP2_BOOTPART_NOACC);
 }
 
-- 
1.7.9.5


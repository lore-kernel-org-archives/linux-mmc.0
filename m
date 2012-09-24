From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v2 7/8] mmc: host: adjust uhs timing value
Date: Mon, 24 Sep 2012 16:15:57 +0800
Message-ID: <1348474558-23088-8-git-send-email-keyuan.liu@gmail.com>
References: <1348474558-23088-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43898 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755394Ab2IXIZD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Sep 2012 04:25:03 -0400
In-Reply-To: <1348474558-23088-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

Both of MMC_TIMING_LEGACY and MMC_TIMING_UHS_SDR12 are defined
to 0. And ios->timing is set to MMC_TIMING_LEGACY during power up.
But set_ios can't distinguish these two timing if host support
spec 3.0. Just adjust timing values to be different can resolve
this issue without any other impact.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 include/linux/mmc/host.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d5d9bd4..036a5cc 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -53,12 +53,12 @@ struct mmc_ios {
 #define MMC_TIMING_LEGACY	0
 #define MMC_TIMING_MMC_HS	1
 #define MMC_TIMING_SD_HS	2
-#define MMC_TIMING_UHS_SDR12	MMC_TIMING_LEGACY
-#define MMC_TIMING_UHS_SDR25	MMC_TIMING_SD_HS
-#define MMC_TIMING_UHS_SDR50	3
-#define MMC_TIMING_UHS_SDR104	4
-#define MMC_TIMING_UHS_DDR50	5
-#define MMC_TIMING_MMC_HS200	6
+#define MMC_TIMING_UHS_SDR12	3
+#define MMC_TIMING_UHS_SDR25	4
+#define MMC_TIMING_UHS_SDR50	5
+#define MMC_TIMING_UHS_SDR104	6
+#define MMC_TIMING_UHS_DDR50	7
+#define MMC_TIMING_MMC_HS200	8
 
 #define MMC_SDR_MODE		0
 #define MMC_1_2V_DDR_MODE	1
-- 
1.7.0.4


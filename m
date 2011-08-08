From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: remove not using parameter in struct mmc_ios
Date: Mon, 08 Aug 2011 18:10:52 +0900
Message-ID: <4E3FA81C.1000702@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29682 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab1HHJKx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Aug 2011 05:10:53 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LPL00HK3QTW24A0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 08 Aug 2011 18:10:52 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LPL00B1WQU4HJ@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 08 Aug 2011 18:10:52 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>

This patch is removed ddr parameter in struct mmc_ios.

If applied Seungwon's Patch([PATCH] mmc: dw_mmc: Fix DDR mode support.), no more used.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/mmc/host.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0f83858..1d09562 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -56,8 +56,6 @@ struct mmc_ios {
 #define MMC_TIMING_UHS_SDR104	4
 #define MMC_TIMING_UHS_DDR50	5
 
-	unsigned char	ddr;			/* dual data rate used */
-
 #define MMC_SDR_MODE		0
 #define MMC_1_2V_DDR_MODE	1
 #define MMC_1_8V_DDR_MODE	2

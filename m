From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: modified the DMA threshold for SD card
Date: Thu, 22 Sep 2011 19:01:59 +0900
Message-ID: <4E7B0797.4030605@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:25540 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab1IVKDk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2011 06:03:40 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LRX0078W5A2RJ90@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 22 Sep 2011 19:03:38 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LRX00LO957YNS@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 22 Sep 2011 19:02:22 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

This patch modified the DMA threshold.

I didn't know exactly why need this threshold.
But if this value is 16, we didn't read SCR register for SD card.
Because in mmc_app_send_scr this values are used data.blocks=1 and data.blksz=8.
(data.blocks * data.blksz = 8...so return -EINVAL)

We didn't read the SCR register, then maybe should be set with wrong configuration.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0ed1d28..64e08e2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -47,7 +47,7 @@
 				 DW_MCI_CMD_ERROR_FLAGS  | SDMMC_INT_HLE)
 #define DW_MCI_SEND_STATUS	1
 #define DW_MCI_RECV_STATUS	2
-#define DW_MCI_DMA_THRESHOLD	16
+#define DW_MCI_DMA_THRESHOLD	8
 
 #ifdef CONFIG_MMC_DW_IDMAC
 struct idmac_desc {

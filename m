From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: fix wrong SDMMC_GET_FCNT macro
Date: Mon, 26 Sep 2011 14:41:52 +0900
Message-ID: <4E8010A0.7060106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60981 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab1IZFm2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2011 01:42:28 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LS4003CO7UQYG30@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Sep 2011 14:42:26 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LS400IGV7UQ8350@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Sep 2011 14:42:26 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, James Hogan <james.hogan@imgtec.com>, Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

I understood that SDMMC_GET_FCNT is used to get fifo_count.
In status register, fifo_count is bit[17:29].
But this macro is control with bit[17:25].

i think right that change 0x1FFF instead of 0x1FF.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.Park@samsung.com>
---
 drivers/mmc/host/dw_mmc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index bfa3c1c..193ec94 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -117,7 +117,7 @@
 #define SDMMC_CMD_RESP_EXP		BIT(6)
 #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
 /* Status register defines */
-#define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FF)
+#define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
 /* Internal DMAC interrupt defines */
 #define SDMMC_IDMAC_INT_AI		BIT(9)
 #define SDMMC_IDMAC_INT_NI		BIT(8)

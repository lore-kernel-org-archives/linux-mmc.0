From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: fixed wrong bit operation for SDMMC_GET_FCNT()
Date: Thu, 05 Jan 2012 19:12:57 +0900
Message-ID: <4F0577A9.5080302@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58862 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab2AEKNB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2012 05:13:01 -0500
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LXB0038XLMRI7C0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 05 Jan 2012 19:13:00 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LXB0050ULPO89A0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 05 Jan 2012 19:13:00 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

In status register, fifo_count is bit[29:17].
(0x1FFF is correctly)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 72c071f..df392a1 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -126,7 +126,7 @@
 #define SDMMC_CMD_RESP_EXP		BIT(6)
 #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
 /* Status register defines */
-#define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FF)
+#define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
 /* Internal DMAC interrupt defines */
 #define SDMMC_IDMAC_INT_AI		BIT(9)
 #define SDMMC_IDMAC_INT_NI		BIT(8)

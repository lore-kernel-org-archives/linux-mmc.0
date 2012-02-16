From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: mmc: dw_mmc: fixed compile error when disable CONFIG_MMC_DW_IDMAC
Date: Thu, 16 Feb 2012 11:19:38 +0900
Message-ID: <4F3C67BA.7040309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28660 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809Ab2BPCTm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 21:19:42 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZG0015FRSTK9K0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 16 Feb 2012 11:19:41 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZG001VGRSSL460@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 16 Feb 2012 11:19:40 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

When disable CONFIG_MMC_DW_IDMAC, can see the compiler error.
Because in dw_mci_post_req(), called the dw_mci_get_dma_dir().
But that function is in #ifdef CONFIG_MMC_DW_IDMAC.

I think that function is generic function.
Not need the CONFIG_MMC_DW_IDMAC.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f9457e5..692c3ba 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -295,7 +295,6 @@ static void dw_mci_stop_dma(struct dw_mci *host)
 	}
 }
 
-#ifdef CONFIG_MMC_DW_IDMAC
 static int dw_mci_get_dma_dir(struct mmc_data *data)
 {
 	if (data->flags & MMC_DATA_WRITE)
@@ -304,6 +303,7 @@ static int dw_mci_get_dma_dir(struct mmc_data *data)
 		return DMA_FROM_DEVICE;
 }
 
+#ifdef CONFIG_MMC_DW_IDMAC
 static void dw_mci_dma_cleanup(struct dw_mci *host)
 {
 	struct mmc_data *data = host->data;

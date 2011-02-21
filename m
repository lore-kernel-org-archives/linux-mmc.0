From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] dw_mmc: set the debounce value and remove duplicated offset
Date: Mon, 21 Feb 2011 17:57:26 +0900
Message-ID: <4D6228F6.6020500@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44627 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078Ab1BUI72 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 03:59:28 -0500
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LGY00KYQM8UDE90@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 21 Feb 2011 17:58:06 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LGY008ZFM8UR2@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 21 Feb 2011 17:58:06 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch is set the debouce value..
This value do not need to be changed with every command.
So we set the value in probe function.

And DATA register offset is duplicated..

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    3 +++
 drivers/mmc/host/dw_mmc.h |    1 -
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 62c8440..b3f94ff 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1623,6 +1623,9 @@ static int dw_mci_probe(struct platform_device *pdev)
 	/* Put in max timeout */
 	mci_writel(host, TMOUT, 0xFFFFFFFF);
 
+	/* Set the debounce value */
+	mci_writel(host, DEBNCE, 0xFFFFFF);
+
 	/*
 	 * FIFO threshold settings  RxMark  = fifo_size / 2 - 1,
 	 *                          Tx Mark = fifo_size / 2 DMA Size = 8
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 5dd55a7..f492837 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -51,7 +51,6 @@
 #define SDMMC_DSCADDR		0x094
 #define SDMMC_BUFADDR		0x098
 #define SDMMC_DATA		0x100
-#define SDMMC_DATA_ADR		0x100
 
 /* shift bit field */
 #define _SBF(f, v)		((v) << (f))

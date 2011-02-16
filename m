From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] dw_mmc: modify quirks bit-shift control
Date: Wed, 16 Feb 2011 15:19:28 +0900
Message-ID: <4D5B6C70.2030809@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33799 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab1BPGUW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 01:20:22 -0500
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LGP00FFO5L3VKA0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 16 Feb 2011 15:19:52 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LGP00G265L4UZ@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 16 Feb 2011 15:19:52 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>

If we need some quirks, maybe add quirks in future
But now, quirks value set to integer..later we should be confused..
So i think that need bit-shift control.

And If we need not any quirks, we didn't set anything..
(Need not DW_MCI_QUIRK_NONE)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 include/linux/mmc/dw_mmc.h |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 16b0261..8614832 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -165,14 +165,12 @@ struct dw_mci_dma_ops {
 };
 
 /* IP Quirks/flags. */
-/* No special quirks or flags to cater for */
-#define DW_MCI_QUIRK_NONE		0
 /* DTO fix for command transmission with IDMAC configured */
-#define DW_MCI_QUIRK_IDMAC_DTO		1
+#define DW_MCI_QUIRK_IDMAC_DTO		(1 << 0)
 /* delay needed between retries on some 2.11a implementations */
-#define DW_MCI_QUIRK_RETRY_DELAY	2
+#define DW_MCI_QUIRK_RETRY_DELAY	(1 << 2)
 /* High Speed Capable - Supports HS cards (upto 50MHz) */
-#define DW_MCI_QUIRK_HIGHSPEED		4
+#define DW_MCI_QUIRK_HIGHSPEED		(1 << 3)
 
 
 struct dma_pdata;

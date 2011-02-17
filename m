From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dw_mmc: modify quirks bit-shift control
Date: Thu, 17 Feb 2011 13:09:04 +0900
Message-ID: <4D5C9F60.9020306@samsung.com>
References: <4D5B6C70.2030809@samsung.com>
 <20110216194232.GA17634@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51441 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab1BQEJx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 23:09:53 -0500
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LGQ002JAU7UPJE0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Feb 2011 13:09:30 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LGQ00A6XU7U8V@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Feb 2011 13:09:30 +0900 (KST)
In-reply-to: <20110216194232.GA17634@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Will Newton <will.newton@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi..

> Why skip (1 << 1)?  (There's also BIT(0) -> BIT(2) if you prefer.)

My mistake..sorry..and thanks for your comment..
I resend the patch applied BIT(0)-BIT(2)

Thanks,
Jaehoon Chung


Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 include/linux/mmc/dw_mmc.h |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 16b0261..3f22c20 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -165,14 +165,12 @@ struct dw_mci_dma_ops {
 };
 
 /* IP Quirks/flags. */
-/* No special quirks or flags to cater for */
-#define DW_MCI_QUIRK_NONE		0
 /* DTO fix for command transmission with IDMAC configured */
-#define DW_MCI_QUIRK_IDMAC_DTO		1
+#define DW_MCI_QUIRK_IDMAC_DTO		BIT(0)
 /* delay needed between retries on some 2.11a implementations */
-#define DW_MCI_QUIRK_RETRY_DELAY	2
+#define DW_MCI_QUIRK_RETRY_DELAY	BIT(1)
 /* High Speed Capable - Supports HS cards (upto 50MHz) */
-#define DW_MCI_QUIRK_HIGHSPEED		4
+#define DW_MCI_QUIRK_HIGHSPEED		BIT(2)
 
 
 struct dma_pdata;
-- 
1.6.0.4

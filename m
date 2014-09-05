From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/4] mmc: dw_mmc: remove the unused quirk.
Date: Fri, 05 Sep 2014 14:14:59 +0900
Message-ID: <1409894100-4713-4-git-send-email-jh80.chung@samsung.com>
References: <1409894100-4713-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36812 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbaIEFPH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Sep 2014 01:15:07 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBE00ID6X93CTD0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 05 Sep 2014 14:15:03 +0900 (KST)
In-reply-to: <1409894100-4713-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

DW_MCI_QUIRK_HIGHSPEED don't use.
If we need to set the highspeed mode by force, we can use to set
cap-mms/sd-highspeed into dt-file.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 include/linux/mmc/dw_mmc.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 6dcc1c1..2796d9c 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -211,12 +211,10 @@ struct dw_mci_dma_ops {
 #define DW_MCI_QUIRK_IDMAC_DTO			BIT(0)
 /* delay needed between retries on some 2.11a implementations */
 #define DW_MCI_QUIRK_RETRY_DELAY		BIT(1)
-/* High Speed Capable - Supports HS cards (up to 50MHz) */
-#define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
 /* Unreliable card detection */
-#define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
+#define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(2)
 /* No write protect */
-#define DW_MCI_QUIRK_NO_WRITE_PROTECT		BIT(4)
+#define DW_MCI_QUIRK_NO_WRITE_PROTECT		BIT(3)
 
 /* Slot level quirks */
 /* This slot has no write protect */
-- 
1.7.9.5


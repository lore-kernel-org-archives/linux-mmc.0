From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 13/22] mmc: dw_mmc: move supports-highspeed of quirks to caps
Date: Sat, 31 Aug 2013 00:13:22 +0900
Message-ID: <001001cea593$77bbb950$67332bf0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46317 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321Ab3H3PNX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:13:23 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC000AHNMBFUP0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:13:23 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

'supports-highspeed' is not one of the quirks but is a capability.
So, it's removed from quirks.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5f30df9..7c7cfa2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1999,9 +1999,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 	}
 
-	if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
-		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
-
 	if (host->pdata->blk_settings) {
 		mmc->max_segs = host->pdata->blk_settings->max_segs;
 		mmc->max_blk_size = host->pdata->blk_settings->max_blk_size;
@@ -2130,9 +2127,6 @@ static struct dw_mci_of_quirks {
 	int id;
 } of_quirks[] = {
 	{
-		.quirk	= "supports-highspeed",
-		.id	= DW_MCI_QUIRK_HIGHSPEED,
-	}, {
 		.quirk	= "broken-cd",
 		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
 	},
@@ -2187,6 +2181,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (of_find_property(np, "enable-sdio-wakeup", NULL))
 		pdata->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 
+	if (of_find_property(np, "supports-highspeed", NULL))
+		pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
+
 	if (of_find_property(np, "caps2-mmc-hs200-1_8v", NULL))
 		pdata->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
 
-- 
1.7.0.4



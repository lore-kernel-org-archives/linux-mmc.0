From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 05/14] mmc: dw_mmc: move supports-highspeed of quirks to caps
Date: Wed, 21 Aug 2013 22:50:14 +0900
Message-ID: <002a01ce9e75$5d15e000$1741a000$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54804 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab3HUNuR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 09:50:17 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRV00LXBVRRM3C0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Aug 2013 22:50:15 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

'supports-highspeed' is not one of the quirks but is a capability.
So, it's removed from quirks.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e8396f9..a1ce7c0 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1992,9 +1992,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 	}
 
-	if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
-		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
-
 	if (host->pdata->blk_settings) {
 		mmc->max_segs = host->pdata->blk_settings->max_segs;
 		mmc->max_blk_size = host->pdata->blk_settings->max_blk_size;
@@ -2129,9 +2126,6 @@ static struct dw_mci_of_quirks {
 	int id;
 } of_quirks[] = {
 	{
-		.quirk	= "supports-highspeed",
-		.id	= DW_MCI_QUIRK_HIGHSPEED,
-	}, {
 		.quirk	= "broken-cd",
 		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
 	},
@@ -2186,6 +2180,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (of_find_property(np, "enable-sdio-wakeup", NULL))
 		pdata->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 
+	if (of_find_property(np, "supports-highspeed", NULL))
+		pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
+
 	if (of_find_property(np, "caps2-mmc-hs200-1_8v", NULL))
 		pdata->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
 
-- 
1.7.0.4



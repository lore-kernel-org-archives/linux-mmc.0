From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw-mmc: add the capability of power-off -notify feature
Date: Fri, 13 Jan 2012 17:31:32 +0900
Message-ID: <4F0FEBE4.3070803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:11556 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab2AMIbf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 03:31:35 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LXQ00EFOABJY2U0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 13 Jan 2012 17:31:33 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LXQ00DKCACLP2Y0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 13 Jan 2012 17:31:33 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Girish K S <girish.shivananjappa@linaro.org>

This patch add the capability of power off notify for dw-mmc controller.
In order to use Girish's patch(mmc: core: Add Power Off Notify Feature eMMC 4.5)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin Park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0e34279..c842c52 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1714,6 +1714,11 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
+	if (mmc->caps2 & MMC_CAP2_POWEROFF_NOTIFY)
+		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
+	else
+		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
+
 #ifdef CONFIG_MMC_DW_IDMAC
 	mmc->max_segs = host->ring_size;
 	mmc->max_blk_size = 65536;
-- 
1.7.4.1

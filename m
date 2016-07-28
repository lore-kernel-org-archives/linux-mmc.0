From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2] mmc: dw_mmc: remove the deprecated "supports-highspeed"
 property
Date: Thu, 28 Jul 2016 18:55:27 +0900
Message-ID: <1469699727-23339-2-git-send-email-jh80.chung@samsung.com>
References: <1469699727-23339-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38238 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbcG1Jzd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2016 05:55:33 -0400
In-reply-to: <1469699727-23339-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, robh+dt@kernel.or, mark.rutland@arm.com, devicetree@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

Remvoe the deprecated "supports-highspeed" property.
DWMMC controller will not use this property anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1b719a6..e9faedd 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2890,11 +2890,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			return ERR_PTR(ret);
 	}
 
-	if (of_find_property(np, "supports-highspeed", NULL)) {
-		dev_info(dev, "supports-highspeed property is deprecated.\n");
-		pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
-	}
-
 	return pdata;
 }
 
-- 
1.9.1


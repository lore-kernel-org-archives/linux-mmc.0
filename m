From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 3/4] mmc: dw_mmc: remove the "supports-highspeed" property.
Date: Wed, 28 May 2014 14:35:50 +0900
Message-ID: <1401255351-17653-4-git-send-email-jh80.chung@samsung.com>
References: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43438 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbaE1FgA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 May 2014 01:36:00 -0400
In-reply-to: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, ludovic.desroches@atmel.com, tgih.jun@samsung.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

Removed the parser for "supports-highspeed".
It can be parsed with "cap-mmc-highsped" or "cap-sd-highspeed" at
mmc_of_parse().

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3285bdd..34b5210 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2281,9 +2281,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			return ERR_PTR(ret);
 	}
 
-	if (of_find_property(np, "supports-highspeed", NULL))
-		pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
-
 	return pdata;
 }
 
-- 
1.7.9.5


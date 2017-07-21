From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: fix the wrong condition check of getting num-slots
Date: Fri, 21 Jul 2017 16:39:56 +0800
Message-ID: <1500626396-223769-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:36087 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753435AbdGUIkt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jul 2017 04:40:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

We only need to show the deprecated information if the driver
is able to get num-slots from DT. Otherwise I was confused by
the log with:

dwmmc_rockchip fe320000.dwmmc: 'num-slots' was deprecated.

However I actually removed all num-slots from rockchip platforms.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a9dfb26..250dc6e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2957,7 +2957,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	}
 
 	/* find out number of slots supported */
-	if (device_property_read_u32(dev, "num-slots", &pdata->num_slots))
+	if (!device_property_read_u32(dev, "num-slots", &pdata->num_slots))
 		dev_info(dev, "'num-slots' was deprecated.\n");
 
 	if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
-- 
1.9.1



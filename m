From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH] mmc: dw_mmc: remove redundant num_slots check
Date: Thu, 21 Jan 2016 15:52:49 +0800
Message-ID: <1453362769-16223-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:41465 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbcAUH52 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 02:57:28 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

num_slots comes from pdata if existing, otherwise from
dw_mci_parse_dt which make it at least one slot. If
num_slots is less than 1 for the existing pdata case,
current code return -ENODEV. But dw_mci_probe seems to
treat this a optional case as it will call SDMMC_GET_SLOT_NUM
if no slot assigned.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/dw_mmc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7128351..a116ec6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2949,12 +2949,6 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	if (host->pdata->num_slots < 1) {
-		dev_err(host->dev,
-			"Platform data must supply num_slots.\n");
-		return -ENODEV;
-	}
-
 	host->biu_clk = devm_clk_get(host->dev, "biu");
 	if (IS_ERR(host->biu_clk)) {
 		dev_dbg(host->dev, "biu clock not available\n");
-- 
2.3.7



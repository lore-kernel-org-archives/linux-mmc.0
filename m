From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] mmc: dw_mmc: remove unused EVENT_XFER_ERROR
Date: Wed,  3 Feb 2016 11:26:04 +0800
Message-ID: <1454469964-21365-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

EVENT_XFER_ERROR isn't been used now, so we can
remove it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 include/linux/mmc/dw_mmc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 89df7ab..b29e06e 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -36,7 +36,6 @@ enum {
 	EVENT_XFER_COMPLETE,
 	EVENT_DATA_COMPLETE,
 	EVENT_DATA_ERROR,
-	EVENT_XFER_ERROR
 };
 
 struct mmc_data;
-- 
2.3.7

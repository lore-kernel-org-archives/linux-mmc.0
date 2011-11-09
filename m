From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: [PATCH] mmc: core: Use usleep_range for delays less than 20ms
Date: Wed,  9 Nov 2011 09:19:53 +0530
Message-ID: <1320810593-19948-1-git-send-email-sthumma@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

msleep of any delay less than 20ms (or 2 jiffies) would
give an unpredictable delay (most of the times as ~20ms).
Use usleep_range in mmc_delay() for delays less than two jiffies.

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
---
 drivers/mmc/core/core.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 14664f1..45a6a12 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -50,6 +50,8 @@ static inline void mmc_delay(unsigned int ms)
 	if (ms < 1000 / HZ) {
 		cond_resched();
 		mdelay(ms);
+	} else if (ms < jiffies_to_msecs(2)) {
+		usleep_range(ms * 1000, (ms + 1) * 1000);
 	} else {
 		msleep(ms);
 	}
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

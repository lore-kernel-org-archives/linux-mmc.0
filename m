From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 14/27] mmc: use pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 21:45:04 +0530
Message-ID: <1411575342-31048-15-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: subhransu.s.prusty@intel.com, vinod.koul@intel.com, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tim Kryger <tim.kryger@linaro.org>, Grant Grundler <grundler@chromium.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/mmc/core/core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d03a080..5081089 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -954,8 +954,7 @@ EXPORT_SYMBOL(mmc_get_card);
 void mmc_put_card(struct mmc_card *card)
 {
 	mmc_release_host(card->host);
-	pm_runtime_mark_last_busy(&card->dev);
-	pm_runtime_put_autosuspend(&card->dev);
+	pm_runtime_last_busy_and_autosuspend(&card->dev);
 }
 EXPORT_SYMBOL(mmc_put_card);
 
-- 
1.7.0.4

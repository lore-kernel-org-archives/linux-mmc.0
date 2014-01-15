From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: dw_mmc: Fix card detection regression
Date: Wed, 15 Jan 2014 14:01:07 +0530
Message-ID: <1389774667-18309-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, chris@printf.net, tgih.jun@samsung.com, sachin.kamat@linaro.org, patches@linaro.org, Zhangfei Gao <zhangfei.gao@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

mmc_gpio_get_cd returns a negative error value upon failure.
However gpio_cd was initialised with the negated return value
of the above function. This negation resulted in losing of the
error value thereby triggering the code to take a wrong path as
IS_ERR_VALUE(gpio_cd) now returned 0 even when mmc_gpio_get_cd
returned an error value. This issue introduced by commit bf626e5550f2
("mmc: dw_mmc: use slot-gpio to handle cd pin") caused card detection
failure on Exynos5 boards which is now fixed by this patch.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/dw_mmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a776f24f4311..f1683ba194ee 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1033,7 +1033,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	int present;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci_board *brd = slot->host->pdata;
-	int gpio_cd = !mmc_gpio_get_cd(mmc);
+	int gpio_cd = mmc_gpio_get_cd(mmc);
 
 	/* Use platform get_cd function, else try onboard card detect */
 	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
@@ -1041,7 +1041,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	else if (brd->get_cd)
 		present = !brd->get_cd(slot->id);
 	else if (!IS_ERR_VALUE(gpio_cd))
-		present = !!gpio_cd;
+		present = !gpio_cd;
 	else
 		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
 			== 0 ? 1 : 0;
-- 
1.7.9.5

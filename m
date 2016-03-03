From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 1/2] mmc: mediatek: Change signal voltage error to dev_dbg()
Date: Thu,  3 Mar 2016 18:19:44 +0800
Message-ID: <1457000385-2317-1-git-send-email-drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, dianders@chromium.org
List-Id: linux-mmc@vger.kernel.org

In commit ceae98f20e36 ("mmc: core: Try other signal levels
during power up") we can see that there are times when it's
valid to try several signal voltages.  Don't print an ugly
error in the logs when that happens.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Similar to b19caf379c82e99737c29bc15d7b7fd7d24279f9
mmc: dw_mmc: Change signal voltage error to dev_dbg()

 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index f01972e..07809f4 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1038,7 +1038,7 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
 		if (ret) {
-			dev_err(host->dev,
+			dev_dbg(host->dev,
 					"Regulator set error %d: %d - %d\n",
 					ret, min_uv, max_uv);
 		} else {
-- 
2.7.0.rc3.207.g0ac5344

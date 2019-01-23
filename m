From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH] mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay
Date: Wed, 23 Jan 2019 20:05:25 +0800
Message-ID: <1548245125-31664-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, jjian zhou <jjian.zhou@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

to set cmd internal delay, need set PAD_TUNE register but not PAD_CMD_TUNE
register.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 8afeaf8..833ef05 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -846,7 +846,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 
 	if (timing == MMC_TIMING_MMC_HS400 &&
 	    host->dev_comp->hs400_tune)
-		sdr_set_field(host->base + PAD_CMD_TUNE,
+		sdr_set_field(host->base + tune_reg,
 			      MSDC_PAD_TUNE_CMDRRDLY,
 			      host->hs400_cmd_int_delay);
 	dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->mmc->actual_clock,
-- 
1.8.1.1.dirty

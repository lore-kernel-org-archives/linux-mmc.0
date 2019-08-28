From: Yong Mao <yong.mao@mediatek.com>
Subject: [PATCH] mmc: mediatek: enable SDIO IRQ low level trigger function
Date: Wed, 28 Aug 2019 17:07:10 +0800
Message-ID: <1566983230-22481-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, yong mao <yong.mao@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: yong mao <yong.mao@mediatek.com>

SDIO IRQ is not defaultly triggered by low level,
but by falling edge. It needs to set related register
to enable SDIO IRQ low level trigger function.
Otherwise the SDIO IRQ may be lost in some specail condition.

Signed-off-by: Yong Mao <yong.mao@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 33f4b63..2444268 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -192,6 +192,7 @@
 #define SDC_STS_CMDBUSY         (0x1 << 1)	/* RW */
 #define SDC_STS_SWR_COMPL       (0x1 << 31)	/* RW */
 
+#define SDC_DAT1_IRQ_TRIGGER	(0x1 << 20)	/* RW */
 /* SDC_ADV_CFG0 mask */
 #define SDC_RX_ENHANCE_EN	(0x1 << 20)	/* RW */
 
@@ -1568,6 +1569,7 @@ static void msdc_init_hw(struct msdc_host *host)
 
 	/* Config SDIO device detect interrupt function */
 	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	sdr_set_bits(host->base + SDC_ADV_CFG0, SDC_DAT1_IRQ_TRIGGER);
 
 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
-- 
1.9.1

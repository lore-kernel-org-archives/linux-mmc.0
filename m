From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH] mmc: mediatek: add ops->get_cd() support
Date: Mon, 3 Jul 2017 14:24:56 +0800
Message-ID: <1499063096-10604-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

if user plug out sd card slowly, finally card is plugged out but
cat /proc/partitions can find that card is still exist in kernel.
that's because alougth get card detect interrupt but CMD13 still
can get correct response(all other pins are connected expect card
detect pin).
add ops->get_cd() can avoid this issue.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5c1e178..975c765 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1585,6 +1585,7 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	.request = msdc_ops_request,
 	.set_ios = msdc_ops_set_ios,
 	.get_ro = mmc_gpio_get_ro,
+	.get_cd = mmc_gpio_get_cd,
 	.start_signal_voltage_switch = msdc_ops_switch_volt,
 	.card_busy = msdc_card_busy,
 	.execute_tuning = msdc_execute_tuning,
-- 
1.8.1.1.dirty

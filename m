From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH] mmc: mediatek: add SD write protect support
Date: Mon, 15 Feb 2016 02:31:00 +0800
Message-ID: <1455474660-19864-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:17002 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751540AbcBOCbf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Feb 2016 21:31:35 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Daniel Kurtz <djkurtz@chromium.org>

use mmc core layer's API to support sd write protect

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 82a97ac..f01972e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -35,6 +35,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/sdio.h>
+#include <linux/mmc/slot-gpio.h>
 
 #define MAX_BD_NUM          1024
 
@@ -1452,6 +1453,7 @@ static struct mmc_host_ops mt_msdc_ops = {
 	.pre_req = msdc_pre_req,
 	.request = msdc_ops_request,
 	.set_ios = msdc_ops_set_ios,
+	.get_ro = mmc_gpio_get_ro,
 	.start_signal_voltage_switch = msdc_ops_switch_volt,
 	.card_busy = msdc_card_busy,
 	.execute_tuning = msdc_execute_tuning,
-- 
1.8.1.1.dirty


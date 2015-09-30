From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH] mmc: core: Fix init_card in 52Mhz
Date: Wed, 30 Sep 2015 11:28:08 +0800
Message-ID: <1443583688-1952-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:56603 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752320AbbI3D2Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2015 23:28:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Johan Rudholm <johan.rudholm@axis.com>, Gwendal Grignou <gwendal@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Chaotian Jing <chaotian.jing@mediatek.com>

Suppose that we got a data crc error, and it triggers the mmc_reset.
mmc_reset will call mmc_send_status to see if HW reset was supported.
before issue CMD13, it will do retune, and if EMMC was in HS400 mode,
it will reduce frequency to 52Mhz firstly, that results in card init
was doing at 52Mhz, So need ensure frequency is lower than 400Khz when
re-init card.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e726903..f2d0c2a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1945,6 +1945,7 @@ static int mmc_reset(struct mmc_host *host)
 
 	/* Set initial state and call mmc_set_ios */
 	mmc_set_initial_state(host);
+	mmc_set_clock(host, host->f_init);
 	mmc_host_clk_release(host);
 
 	return mmc_init_card(host, card->ocr, card);
-- 
1.8.1.1.dirty


From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
Date: Thu, 31 Jan 2019 15:53:31 +0800
Message-ID: <1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Simon Horman <horms+renesas@verge.net.au>, Chaotian Jing <chaotian.jing@mediatek.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Hongjie Fang <hongjiefang@asrmicro.com>, Harish Jenny K N <harish_kandiga@mentor.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
Therefore, any commands sent to the card should use HS400 timing.
It is incorrect to reduce frequency to 50Mhz before sending the switch
command, in this case, only reduce clock frequency to 50Mhz but without
host timming change, host is still in hs400 mode but clock changed from
200Mhz to 50Mhz, which makes the tuning result unsuitable and cause
the switch command gets response CRC error.

this patch refers to mmc_select_hs400(), make the reduce clock frequency
after card timing change.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/mmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index da892a5..21b811e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1239,10 +1239,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	int err;
 	u8 val;
 
-	/* Reduce frequency to HS */
-	max_dtr = card->ext_csd.hs_max_dtr;
-	mmc_set_clock(host, max_dtr);
-
 	/* Switch HS400 to HS DDR */
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
@@ -1253,6 +1249,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
+	/* Reduce frequency to HS */
+	max_dtr = card->ext_csd.hs_max_dtr;
+	mmc_set_clock(host, max_dtr);
+
 	err = mmc_switch_status(card);
 	if (err)
 		goto out_err;
-- 
1.8.1.1.dirty

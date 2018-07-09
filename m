From: Hongjie Fang <hongjiefang@asrmicro.com>
Subject: [PATCH] mmc: core: improve rationality of bus width setting for HS400es
Date: Mon, 9 Jul 2018 14:47:23 +0800
Message-ID: <1531118843-796-1-git-send-email-hongjiefang@asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, linus.walleij@linaro.org, bst@pengutronix.de, wsa+renesas@sang-engineering.com, chanho.min@lge.com, kyle.roeschley@ni.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hongjie Fang <hongjiefang@asrmicro.com>
List-Id: linux-mmc@vger.kernel.org

mmc_select_hs400es() calls mmc_select_bus_width() which will try to
set 4bit transfer mode if fail to set 8bit mode. The problem is that
the bus width should not be set to 4bit in HS400es mode.

Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
---
 drivers/mmc/core/mmc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4466f5d..94c3cc5 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1337,9 +1337,28 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	if (err)
 		goto out_err;
 
-	err = mmc_select_bus_width(card);
-	if (err < 0)
+	/* Switch card to 8 bit mode */
+	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_BUS_WIDTH,
+			 EXT_CSD_BUS_WIDTH_8,
+			 card->ext_csd.generic_cmd6_time);
+	if (err) {
+		pr_err("%s: switch to 8 bit mode for hs400es failed, err:%d\n",
+			mmc_hostname(host), err);
+		goto out_err;
+	}
+
+	mmc_set_bus_width(host, MMC_BUS_WIDTH_8);
+
+	if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
+		err = mmc_compare_ext_csds(card, MMC_BUS_WIDTH_8);
+	else
+		err = mmc_bus_test(card, MMC_BUS_WIDTH_8);
+	if (err) {
+		pr_err("%s: test 8 bit mode for hs400es failed, err:%d\n",
+			mmc_hostname(host), err);
 		goto out_err;
+	}
 
 	/* Switch card to HS mode */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-- 
1.9.1

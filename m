From: Hongjie Fang <hongjiefang@asrmicro.com>
Subject: [PATCH V4] mmc: core: improve reasonableness of bus width setting for HS400es
Date: Tue, 17 Jul 2018 17:14:25 +0800
Message-ID: <1531818865-7387-1-git-send-email-hongjiefang@asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: shawn.lin@rock-chips.com, adrian.hunter@intel.com, linus.walleij@linaro.org, wsa+renesas@sang-engineering.com, bst@pengutronix.de, chanho.min@lge.com, kyle.roeschley@ni.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hongjie Fang <hongjiefang@asrmicro.com>
List-Id: linux-mmc@vger.kernel.org

mmc_select_hs400es() calls mmc_select_bus_width() which will continue
to set 4bit transfer mode if fail to set 8bit mode. The bus width
should not be set to 4bit in HS400es.

When fail to set 8bit mode, need return error directly for HS400es.

Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
---
 drivers/mmc/core/mmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4466f5d..0dbc512 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1338,8 +1338,12 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 
 	err = mmc_select_bus_width(card);
-	if (err < 0)
+	if (err != MMC_BUS_WIDTH_8) {
+		pr_err("%s: switch to 8bit bus width failed, err:%d\n",
+			mmc_hostname(host), err);
+		err = -EIO;
 		goto out_err;
+	}
 
 	/* Switch card to HS mode */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-- 
1.9.1

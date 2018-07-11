From: Hongjie Fang <hongjiefang@asrmicro.com>
Subject: [PATCH V2] mmc: core: improve reasonableness of bus width setting for HS400es
Date: Wed, 11 Jul 2018 11:00:49 +0800
Message-ID: <1531278049-22213-1-git-send-email-hongjiefang@asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, shawn.lin@rock-chips.com, linus.walleij@linaro.org, wsa+renesas@sang-engineering.com, bst@pengutronix.de, jinqian@google.com, chanho.min@lge.com, kyle.roeschley@ni.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hongjie Fang <hongjiefang@asrmicro.com>
List-Id: linux-mmc@vger.kernel.org

mmc_select_hs400es() calls mmc_select_bus_width() which will continue
to set 4bit transfer mode if fail to set 8bit mode. The bus width
should not be set to 4bit in HS400es.

When fail to set 8bit mode, need return error directly for HS400es.

Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
---
 drivers/mmc/core/mmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4466f5d..4bd6c09 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1021,8 +1021,11 @@ static int mmc_select_bus_width(struct mmc_card *card)
 				 EXT_CSD_BUS_WIDTH,
 				 ext_csd_bits[idx],
 				 card->ext_csd.generic_cmd6_time);
-		if (err)
+		if (err) {
+			if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
+				return err;
 			continue;
+		}
 
 		bus_width = bus_widths[idx];
 		mmc_set_bus_width(host, bus_width);
-- 
1.9.1

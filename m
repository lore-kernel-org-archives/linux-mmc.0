From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v5] mmc: core: Add default timeout value for CMD6.
Date: Wed,  5 Oct 2011 19:37:51 +0900
Message-ID: <1317811071-9111-1-git-send-email-tgih.jun@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, dh.han@samsung.com, jh80.chung@samsung.com, Seungwon Jeon <tgih.jun@samsung.com>
List-Id: linux-mmc@vger.kernel.org

EXT_CSD[248] includes the default maximum timeout for CMD6.
This field is added at eMMC4.5 Spec. And it can be used for default
timeout except for some operations which don't define the timeout(i.e.
background operation, sanitize, flush cache) in eMMC4.5 Spec.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/mmc.c   |   18 +++++++++++++-----
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/mmc.h  |    1 +
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c632b1f..c37b8d2 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -414,6 +414,12 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	else
 		card->erased_byte = 0x0;

+	if (card->ext_csd.rev >= 6)
+		card->ext_csd.generic_cmd6_time = 10 *
+			ext_csd[EXT_CSD_GENERIC_CMD6_TIME];
+	else
+		card->ext_csd.generic_cmd6_time = 0;
+
 out:
 	return err;
 }
@@ -607,7 +613,7 @@ static int mmc_select_powerclass(struct mmc_card *card,
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_POWER_CLASS,
 				 pwrclass_val,
-				 0);
+				 card->ext_csd.generic_cmd6_time);
 	}

 	return err;
@@ -757,7 +763,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (card->ext_csd.enhanced_area_en) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 EXT_CSD_ERASE_GROUP_DEF, 1, 0);
+				 EXT_CSD_ERASE_GROUP_DEF, 1,
+				 card->ext_csd.generic_cmd6_time);

 		if (err && err != -EBADMSG)
 			goto free_card;
@@ -800,7 +807,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if ((card->ext_csd.hs_max_dtr != 0) &&
 		(host->caps & MMC_CAP_MMC_HIGHSPEED)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 EXT_CSD_HS_TIMING, 1, 0);
+				 EXT_CSD_HS_TIMING, 1,
+				 card->ext_csd.generic_cmd6_time);
 		if (err && err != -EBADMSG)
 			goto free_card;

@@ -880,7 +888,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
 					 ext_csd_bits[idx][0],
-					 0);
+					 card->ext_csd.generic_cmd6_time);
 			if (!err) {
 				mmc_set_bus_width(card->host, bus_width);

@@ -911,7 +919,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
 					 ext_csd_bits[idx][1],
-					 0);
+					 card->ext_csd.generic_cmd6_time);
 		}
 		if (err) {
 			printk(KERN_WARNING "%s: switch to bus width %d ddr %d "
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 5294ddf..d751ceb 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -53,6 +53,7 @@ struct mmc_ext_csd {
 	u8			rst_n_function;
 	unsigned int		part_time;		/* Units: ms */
 	unsigned int		sa_timeout;		/* Units: 100ns */
+	unsigned int		generic_cmd6_time;	/* Units: ms */
 	unsigned int		hs_max_dtr;
 	unsigned int		sectors;
 	unsigned int		card_type;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 50af227..b26c9e4 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -304,6 +304,7 @@ struct _mmc_csd {
 #define EXT_CSD_PWR_CL_DDR_52_195	238	/* RO */
 #define EXT_CSD_PWR_CL_DDR_52_360	239	/* RO */
 #define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
+#define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */

 /*
  * EXT_CSD field definitions
--
1.7.0.4

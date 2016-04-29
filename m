From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 3/6] mmc: core: implement enhanced strobe support
Date: Fri, 29 Apr 2016 10:47:09 +0800
Message-ID: <1461898029-28944-1-git-send-email-shawn.lin@rock-chips.com>
References: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1461897751-28810-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Controllers use data strobe line to latch data from devices
under hs400 mode, but not for cmd line. So since emmc 5.1, JEDEC
introduces enhanced strobe mode for latching cmd response from
emmc devices to host controllers. This new feature is optional,
so it depends both on device's cap and host's cap to decide
whether to use it or not.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v2: None

 drivers/mmc/core/bus.c   |  3 +-
 drivers/mmc/core/mmc.c   | 77 ++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/host.h | 12 ++++++++
 include/linux/mmc/mmc.h  |  3 ++
 5 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 4bc48f1..7e94b9d 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -332,12 +332,13 @@ int mmc_add_card(struct mmc_card *card)
 			mmc_card_ddr52(card) ? "DDR " : "",
 			type);
 	} else {
-		pr_info("%s: new %s%s%s%s%s card at address %04x\n",
+		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
 			mmc_hostname(card->host),
 			mmc_card_uhs(card) ? "ultra high speed " :
 			(mmc_card_hs(card) ? "high speed " : ""),
 			mmc_card_hs400(card) ? "HS400 " :
 			(mmc_card_hs200(card) ? "HS200 " : ""),
+			mmc_card_hs400es(card) ? "Enhanced strobe" : "",
 			mmc_card_ddr52(card) ? "DDR " : "",
 			uhs_bus_speed_mode, type, card->rca);
 	}
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 28b477d..f45ed10 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -235,6 +235,12 @@ static void mmc_select_card_type(struct mmc_card *card)
 		avail_type |= EXT_CSD_CARD_TYPE_HS400_1_2V;
 	}
 
+	if ((caps2 & MMC_CAP2_HS400_ENHANCED_STROBE) &&
+	    card->ext_csd.strobe_support &&
+	    ((card_type & EXT_CSD_CARD_TYPE_HS400_1_2V) ||
+	     (card_type & EXT_CSD_CARD_TYPE_HS400_1_8V)))
+		avail_type |= EXT_CSD_CARD_TYPE_HS400ES;
+
 	card->ext_csd.hs_max_dtr = hs_max_dtr;
 	card->ext_csd.hs200_max_dtr = hs200_max_dtr;
 	card->mmc_avail_type = avail_type;
@@ -383,6 +389,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			mmc_card_set_blockaddr(card);
 	}
 
+	card->ext_csd.strobe_support = ext_csd[EXT_CSD_STROBE_SUPPORT];
 	card->ext_csd.raw_card_type = ext_csd[EXT_CSD_CARD_TYPE];
 	mmc_select_card_type(card);
 
@@ -1062,9 +1069,10 @@ static int mmc_select_hs400(struct mmc_card *card)
 	u8 val;
 
 	/*
-	 * HS400 mode requires 8-bit bus width
+	 * HS400(ES) mode requires 8-bit bus width
 	 */
-	if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
+	if (!(((card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400) ||
+		(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)) &&
 	      host->ios.bus_width == MMC_BUS_WIDTH_8))
 		return 0;
 
@@ -1097,9 +1105,26 @@ static int mmc_select_hs400(struct mmc_card *card)
 	}
 
 	/* Switch card to DDR */
+	val = EXT_CSD_DDR_BUS_WIDTH_8;
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
+		val |= EXT_CSD_BUS_WIDTH_STROBE;
+		/*
+		* Make sure we are in non-enhanced strobe mode before we
+		* actually enable it in ext_csd.
+		*/
+		if (host->ops->prepare_enhanced_strobe)
+			err = host->ops->prepare_enhanced_strobe(host, false);
+
+		if (err) {
+			pr_err("%s: unprepare_enhanced strobe failed, err:%d\n",
+				mmc_hostname(host), err);
+			return err;
+		}
+	}
+
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BUS_WIDTH,
-			 EXT_CSD_DDR_BUS_WIDTH_8,
+			 val,
 			 card->ext_csd.generic_cmd6_time);
 	if (err) {
 		pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
@@ -1124,6 +1149,35 @@ static int mmc_select_hs400(struct mmc_card *card)
 	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
 	mmc_set_bus_speed(card);
 
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
+		/* Controller enable enhanced strobe function */
+		if (host->ops->prepare_enhanced_strobe)
+			err = host->ops->prepare_enhanced_strobe(host, true);
+
+		if (err) {
+			pr_err("%s: prepare enhanced strobe failed, err:%d\n",
+				mmc_hostname(host), err);
+			return err;
+		}
+
+		/*
+		 * After switching to hs400 enhanced strobe mode, we expect to
+		 * verify whether it works or not. If controller can't handle
+		 * bus width test, compare ext_csd previously read in 1 bit mode
+		 * against ext_csd at new bus width
+		 */
+		if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
+			err = mmc_compare_ext_csds(card, MMC_BUS_WIDTH_8);
+		else
+			err = mmc_bus_test(card, MMC_BUS_WIDTH_8);
+
+		if (err) {
+			pr_warn("%s: switch to enhanced strobe failed\n",
+				mmc_hostname(host));
+			return err;
+		}
+	}
+
 	if (!send_status) {
 		err = mmc_switch_status(card);
 		if (err)
@@ -1297,7 +1351,8 @@ err:
 }
 
 /*
- * Activate High Speed or HS200 mode if supported.
+ * Activate High Speed or HS200 mode if supported. For HS400
+ * with enhanced strobe mode, we should activate High Speed.
  */
 static int mmc_select_timing(struct mmc_card *card)
 {
@@ -1306,7 +1361,9 @@ static int mmc_select_timing(struct mmc_card *card)
 	if (!mmc_can_ext_csd(card))
 		goto bus_speed;
 
-	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
+		err = mmc_select_hs(card);
+	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
 		err = mmc_select_hs200(card);
 	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
 		err = mmc_select_hs(card);
@@ -1578,7 +1635,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	} else if (mmc_card_hs(card)) {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
-		if (!IS_ERR_VALUE(err)) {
+		if (IS_ERR_VALUE(err))
+			goto free_card;
+
+		if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
+			/* Directly from HS to HS400-ES */
+			err = mmc_select_hs400(card);
+			if (err)
+				goto free_card;
+		} else {
 			err = mmc_select_hs_ddr(card);
 			if (err)
 				goto free_card;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index eb0151b..22defc2 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -95,6 +95,7 @@ struct mmc_ext_csd {
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_rpmb_size_mult;	/* 168 */
 	u8			raw_erased_mem_count;	/* 181 */
+	u8			strobe_support;		/* 184 */
 	u8			raw_ext_csd_structure;	/* 194 */
 	u8			raw_card_type;		/* 196 */
 	u8			raw_driver_strength;	/* 197 */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 11e89d3..19de56c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -19,6 +19,7 @@
 
 #include <linux/mmc/core.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/pm.h>
 
 struct mmc_ios {
@@ -143,6 +144,8 @@ struct mmc_host_ops {
 
 	/* Prepare HS400 target operating frequency depending host driver */
 	int	(*prepare_hs400_tuning)(struct mmc_host *host, struct mmc_ios *ios);
+	/* Prepare enhanced strobe depending host driver */
+	int	(*prepare_enhanced_strobe)(struct mmc_host *host, bool enable);
 	int	(*select_drive_strength)(struct mmc_card *card,
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
@@ -518,6 +521,15 @@ static inline bool mmc_card_hs400(struct mmc_card *card)
 	return card->host->ios.timing == MMC_TIMING_MMC_HS400;
 }
 
+static inline bool mmc_card_hs400es(struct mmc_card *card)
+{
+	if (mmc_card_hs400(card) &&
+	    (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES))
+		return 1;
+
+	return 0;
+}
+
 void mmc_retune_timer_stop(struct mmc_host *host);
 
 static inline void mmc_retune_needed(struct mmc_host *host)
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 15f2c4a..c376209 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -297,6 +297,7 @@ struct _mmc_csd {
 #define EXT_CSD_PART_CONFIG		179	/* R/W */
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
+#define EXT_CSD_STROBE_SUPPORT		184	/* RO */
 #define EXT_CSD_HS_TIMING		185	/* R/W */
 #define EXT_CSD_POWER_CLASS		187	/* R/W */
 #define EXT_CSD_REV			192	/* RO */
@@ -380,12 +381,14 @@ struct _mmc_csd {
 #define EXT_CSD_CARD_TYPE_HS400_1_2V	(1<<7)	/* Card can run at 200MHz DDR, 1.2V */
 #define EXT_CSD_CARD_TYPE_HS400		(EXT_CSD_CARD_TYPE_HS400_1_8V | \
 					 EXT_CSD_CARD_TYPE_HS400_1_2V)
+#define EXT_CSD_CARD_TYPE_HS400ES	(1<<8)	/* Card can run at HS400ES */
 
 #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
 #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
 #define EXT_CSD_BUS_WIDTH_8	2	/* Card is in 8 bit mode */
 #define EXT_CSD_DDR_BUS_WIDTH_4	5	/* Card is in 4 bit DDR mode */
 #define EXT_CSD_DDR_BUS_WIDTH_8	6	/* Card is in 8 bit DDR mode */
+#define EXT_CSD_BUS_WIDTH_STROBE BIT(7)	/* Enhanced strobe mode */
 
 #define EXT_CSD_TIMING_BC	0	/* Backwards compatility */
 #define EXT_CSD_TIMING_HS	1	/* High speed */
-- 
2.3.7

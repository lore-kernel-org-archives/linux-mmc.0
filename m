From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V1] mmc: core: eMMC 4.5 Power Class Selection Feature
Date: Wed, 14 Sep 2011 16:16:15 +0530
Message-ID: <1315997175-5540-2-git-send-email-girish.shivananjappa@linaro.org>
References: <1315997175-5540-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1315997175-5540-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds the power class selection feature available
for mmc versions 4.0 and above.
During the enumeration stage before switching to the lower
data bus, check if the power class is supported for the
current bus width. If the power class is available then
switch to the power class and use the higher data bus. If
power class is not supported then switch to the lower data
bus in a worst case.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/mmc.c  |   90 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/mmc.h |   13 +++++++
 2 files changed, 103 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 63cc77b..bc3d942 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -536,6 +536,81 @@ static struct device_type mmc_type = {
 };
 
 /*
+ * Select the PowerClass for the current bus width
+ * If power class is defined for 4/8 bit bus in the
+ * extended CSD register, select it by executing the
+ * mmc_switch command.
+ */
+static int mmc_select_powerclass(struct mmc_card *card,
+		unsigned int bus_width, u8 *ext_csd)
+{
+	int err = 0;
+	unsigned int pwrclass_val;
+	unsigned int index = 0;
+	struct mmc_host *host = card->host;
+
+	BUG_ON(!card);
+	BUG_ON(!host);
+
+	if (ext_csd == NULL)
+		return 0;
+	/* Power class selection is supported for versions >= 4.0 */
+	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
+		return 0;
+	/*Power class values are defined only for 4/8 bit bus*/
+	if (bus_width == EXT_CSD_BUS_WIDTH_1)
+		return 0;
+
+	switch ((1 << host->ios.vdd)) {
+	case MMC_VDD_165_195:
+		if (host->ios.clock <= 26000000)
+			index = EXT_CSD_PWR_CL_26_195;
+		else if	(host->ios.clock <= 52000000)
+			index = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
+					EXT_CSD_PWR_CL_52_195 :
+					EXT_CSD_PWR_CL_DDR_52_195;
+		else if (host->ios.clock <= 200000000)
+			index = EXT_CSD_PWR_CL_200_195;
+		break;
+	case MMC_VDD_32_33:
+	case MMC_VDD_33_34:
+	case MMC_VDD_34_35:
+	case MMC_VDD_35_36:
+		if (host->ios.clock <= 26000000)
+			index = EXT_CSD_PWR_CL_26_360;
+		else if	(host->ios.clock <= 52000000)
+			index = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
+					EXT_CSD_PWR_CL_52_360 :
+					EXT_CSD_PWR_CL_DDR_52_360;
+		else if (host->ios.clock <= 200000000)
+			index = EXT_CSD_PWR_CL_200_360;
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	pwrclass_val = ext_csd[index];
+
+	if (bus_width & (EXT_CSD_BUS_WIDTH_8 | EXT_CSD_DDR_BUS_WIDTH_8))
+		pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_8BIT_MASK) >>
+					EXT_CSD_PWR_CL_8BIT_SHIFT;
+	else
+		pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_4BIT_MASK) >>
+					EXT_CSD_PWR_CL_4BIT_SHIFT;
+
+	/*If the power class is different from the default value*/
+	if (pwrclass_val > 0) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_POWER_CLASS,
+				pwrclass_val,
+				0);
+	}
+
+	return err;
+}
+
+/*
  * Handle the detection and initialisation of a card.
  *
  * In the case of a resume, "oldcard" will contain the card
@@ -802,6 +877,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			bus_width = bus_widths[idx];
 			if (bus_width == MMC_BUS_WIDTH_1)
 				ddr = 0; /* no DDR for 1-bit width */
+			err = mmc_select_powerclass(card, ext_csd_bits[idx][0],
+					ext_csd);
+			if (err)
+				printk(KERN_ERR "%s: power class selection to "
+						"bus width %d failed\n",mmc_hostname(card->host),
+						1 << bus_width);
+
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
 					 ext_csd_bits[idx][0],
@@ -825,6 +907,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 
 		if (!err && ddr) {
+			err = mmc_select_powerclass(card, ext_csd_bits[idx][1],
+					ext_csd);
+			if (err)
+				printk(KERN_ERR "%s: power class selection to "
+						"bus width %d ddr %d failed\n",
+						mmc_hostname(card->host),
+						1 << bus_width, ddr);
+
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 EXT_CSD_BUS_WIDTH,
 					 ext_csd_bits[idx][1],
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index a788e01..e183e32 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -279,10 +279,15 @@ struct _mmc_csd {
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
 #define EXT_CSD_HS_TIMING		185	/* R/W */
+#define EXT_CSD_POWER_CLASS	187
 #define EXT_CSD_REV			192	/* RO */
 #define EXT_CSD_STRUCTURE		194	/* RO */
 #define EXT_CSD_CARD_TYPE		196	/* RO */
 #define EXT_CSD_PART_SWITCH_TIME        199     /* RO */
+#define EXT_CSD_PWR_CL_52_195	200 /*RO*/
+#define EXT_CSD_PWR_CL_26_195	201 /*RO*/
+#define EXT_CSD_PWR_CL_52_360	202 /*RO*/
+#define EXT_CSD_PWR_CL_26_360	203 /*RO*/
 #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
 #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
 #define EXT_CSD_REL_WR_SEC_C		222	/* RO */
@@ -294,6 +299,10 @@ struct _mmc_csd {
 #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
 #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
 #define EXT_CSD_TRIM_MULT		232	/* RO */
+#define EXT_CSD_PWR_CL_200_195	236 /*RO*/
+#define EXT_CSD_PWR_CL_200_360	237 /*RO*/
+#define EXT_CSD_PWR_CL_DDR_52_195	238 /*RO*/
+#define EXT_CSD_PWR_CL_DDR_52_360	239 /*RO*/
 #define EXT_CSD_POWER_OFF_LONG_TIME	247 /*RO*/
 #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
 
@@ -336,6 +345,10 @@ struct _mmc_csd {
 #define EXT_CSD_POWER_OFF_SHORT	2
 #define EXT_CSD_POWER_OFF_LONG	3
 
+#define EXT_CSD_PWR_CL_8BIT_MASK	0xF0/* 8 bit PWR CLS */
+#define EXT_CSD_PWR_CL_4BIT_MASK	0x0F/* 8 bit PWR CLS */
+#define EXT_CSD_PWR_CL_8BIT_SHIFT	4
+#define EXT_CSD_PWR_CL_4BIT_SHIFT	0
 /*
  * MMC_SWITCH access modes
  */
-- 
1.7.1

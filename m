From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 3/7] OMAP4-HSMMC: Adding Card detect support
Date: Wed, 21 Apr 2010 23:50:40 +0530 (IST)
Message-ID: <63568.10.24.255.18.1271874040.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: madhu.cr@ti.com, jarkko.lavinen@nokia.com, tony@atomide.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com
List-Id: linux-mmc@vger.kernel.org

Since OMAP4's card detection doesn't support GPIO,this patch
basically moves card detection API from driver to Board file so
that it can handle in both GPIO and NON-GPIO case.
This Patch also adds a flag which can differentiate whether the
card-detect line is GPIO or NON-GPIO.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c   |    1 +
 arch/arm/mach-omap2/hsmmc.c           |   74 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/hsmmc.h           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    3 +-
 drivers/mmc/host/omap_hsmmc.c         |   29 +-----------
 5 files changed, 81 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index eae7c80..4e8f74e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -89,6 +89,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		 * but is a phoenix interrupt
 		 */
 		.gpio_cd	= 384,
+		.cd_type	= true,
 		.gpio_wp	= -EINVAL,
 	},
 	{
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 9ad2295..ca3d4c9 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/i2c/twl.h>
 #include <mach/hardware.h>
 #include <plat/control.h>
 #include <plat/mmc.h>
@@ -27,7 +29,11 @@ static u16 control_devconf1_offset;

 #define HSMMC_NAME_LEN	9

+/* Phoenix Registers */
+#define TWL6030_MMCCTRL	0xEE
+
 static struct hsmmc_controller {
+	struct omap_mmc_platform_data   *mmc;
 	char				name[HSMMC_NAME_LEN + 1];
 } hsmmc[OMAP34XX_NR_MMC];

@@ -42,6 +48,50 @@ static int hsmmc_get_context_loss(struct device *dev)
 #define hsmmc_get_context_loss NULL
 #endif

+static int twl_mmc_get_cover_state(struct device *dev, int slot)
+{
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	/* NOTE: assumes card detect signal is active-low */
+	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
+}
+
+static int twl_mmc_card_detect(int irq)
+{
+	unsigned i;
+	u8 read_reg;
+	unsigned res;
+
+
+	for (i = 0; i < ARRAY_SIZE(hsmmc); i++) {
+		struct omap_mmc_platform_data *mmc;
+
+		mmc = hsmmc[i].mmc;
+		if (!mmc)
+			continue;
+		if (irq != mmc->slots[0].card_detect_irq)
+			continue;
+
+		if (mmc->slots[0].nongpio_cd) {
+			/* BIT0 of REG_MMC_CTRL
+			 * 0 - Card not present
+			 * 1 - Card present
+			 */
+			res = twl_i2c_read_u8(TWL6030_MODULE_ID0,
+					&read_reg, TWL6030_MMCCTRL);
+			if (res >= 0)
+				return read_reg & 0x1;
+			return !gpio_get_value_cansleep
+					(mmc->slots[0].switch_pin);
+		} else {
+			/* NOTE: assumes card detect signal is active-low */
+			return !gpio_get_value_cansleep
+					(mmc->slots[0].switch_pin);
+		}
+	}
+	return -ENOSYS;
+}
+
 static void hsmmc1_before_set_reg(struct device *dev, int slot,
 				  int power_on, int vdd)
 {
@@ -189,8 +239,32 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info
 		mmc->get_context_loss_count = hsmmc_get_context_loss;

 		mmc->slots[0].switch_pin = c->gpio_cd;
+		mmc->slots[0].nongpio_cd = c->cd_type;
 		mmc->slots[0].gpio_wp = c->gpio_wp;

+		/* TWL Card detect can be GPIO based or NON-GPIO Based */
+		if (!c->cd_type) {
+			if (gpio_is_valid(c->gpio_cd)) {
+				mmc->slots[0].card_detect_irq =
+						gpio_to_irq(c->gpio_cd);
+				if (c->cover_only)
+					mmc->slots[0].get_cover_state =
+						twl_mmc_get_cover_state;
+				else
+					mmc->slots[0].card_detect =
+							twl_mmc_card_detect;
+			} else
+				mmc->slots[0].switch_pin = -EINVAL;
+		} else {
+			mmc->slots[0].card_detect_irq = c->gpio_cd;
+			if (c->cover_only)
+				mmc->slots[0].get_cover_state =
+						twl_mmc_get_cover_state;
+			else
+				mmc->slots[0].card_detect =
+							twl_mmc_card_detect;
+		}
+
 		mmc->slots[0].remux = c->remux;

 		if (c->cover_only)
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 36f0ba8..3dfc43a 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -17,6 +17,7 @@ struct omap2_hsmmc_info {
 	bool	no_off;		/* power_saving and power is not to go off */
 	bool	vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
 	int	gpio_cd;	/* or -EINVAL */
+	bool	cd_type;	/* Card detect Type:NON-GPIO=true,GPIO=flase */
 	int	gpio_wp;	/* or -EINVAL */
 	char	*name;		/* or NULL for default */
 	struct device *dev;	/* returned: pointer to mmc adapter */
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index a1bac07..521decc 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -103,6 +103,7 @@ struct omap_mmc_platform_data {
 		unsigned vcc_aux_disable_is_sleep:1;

 		int switch_pin;			/* gpio (card detect) */
+		unsigned nongpio_cd:1;	/* NON-GPIO=true , GPIO=false */
 		int gpio_wp;			/* gpio (write protect) */

 		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
@@ -132,7 +133,7 @@ struct omap_mmc_platform_data {

 		/* Card detection IRQs */
 		int card_detect_irq;
-		int (*card_detect)(struct device *dev, int slot);
+		int (*card_detect)(int irq);

 		unsigned int ban_openended:1;

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e9caf69..acf2bc7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -187,14 +187,6 @@ struct omap_hsmmc_host {
 	struct	omap_mmc_platform_data	*pdata;
 };

-static int omap_hsmmc_card_detect(struct device *dev, int slot)
-{
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-
-	/* NOTE: assumes card detect signal is active-low */
-	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
-}
-
 static int omap_hsmmc_get_wp(struct device *dev, int slot)
 {
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
@@ -203,14 +195,6 @@ static int omap_hsmmc_get_wp(struct device *dev, int slot)
 	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
 }

-static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
-{
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-
-	/* NOTE: assumes card detect signal is active-low */
-	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
-}
-
 #ifdef CONFIG_PM

 static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
@@ -467,13 +451,6 @@ static int omap_hsmmc_gpio_init
 	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
 		pdata->suspend = omap_hsmmc_suspend_cdirq;
 		pdata->resume = omap_hsmmc_resume_cdirq;
-		if (pdata->slots[0].cover)
-			pdata->slots[0].get_cover_state =
-					omap_hsmmc_get_cover_state;
-		else
-			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
-		pdata->slots[0].card_detect_irq =
-				gpio_to_irq(pdata->slots[0].switch_pin);
 		ret = gpio_request(pdata->slots[0].switch_pin, "mmc_cd");
 		if (ret)
 			return ret;
@@ -1173,7 +1150,7 @@ static void omap_hsmmc_detect(struct work_struct *work)
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");

 	if (slot->card_detect)
-		carddetect = slot->card_detect(host->dev, host->slot_id);
+		carddetect = slot->card_detect(host->slot_id);
 	else {
 		omap_hsmmc_protect_card(host);
 		carddetect = -ENOSYS;
@@ -1575,7 +1552,7 @@ static int omap_hsmmc_get_cd(struct mmc_host *mmc)

 	if (!mmc_slot(host).card_detect)
 		return -ENOSYS;
-	return mmc_slot(host).card_detect(host->dev, host->slot_id);
+	return mmc_slot(host).card_detect(host->slot_id);
 }

 static int omap_hsmmc_get_ro(struct mmc_host *mmc)
@@ -1984,7 +1961,7 @@ static int __init omap_hsmmc_probe(struct
 	mmc = mmc_alloc_host(sizeof(struct omap_hsmmc_host), &pdev->dev);
 	if (!mmc) {
 		ret = -ENOMEM;
-		goto err_alloc;
+			goto err_alloc;
 	}

 	host		= mmc_priv(mmc);
-- 
1.6.3.3



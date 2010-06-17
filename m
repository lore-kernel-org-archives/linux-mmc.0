From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v5 2/2] OMAP4 HSMMC: Adding card detect support for MMC1
     Controller
Date: Thu, 17 Jun 2010 20:57:19 +0530 (IST)
Message-ID: <43584.10.24.255.17.1276788439.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, akpm@linux-foundation.org, adrian.hunter@nokia.com
List-Id: linux-mmc@vger.kernel.org

Adding card detect callback function which gives the status of
the card .For MMC1 Controller, Card detect interrupt source is
twl6030 and card present/absent status is provided by MMCCTRL
register of twl6030.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c   |   11 +++++--
 arch/arm/mach-omap2/hsmmc.c           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    1 +
 drivers/mfd/twl6030-irq.c             |   23 ++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |   30 ++++++++++++++++++---
 include/linux/i2c/twl.h               |   46 +++++++++++++++++++++++++++++++++
 6 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index e4a5d66..1cf6f3b 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -144,6 +144,7 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 8,
+		.cd_type	= NON_GPIO,
 		.gpio_wp	= -EINVAL,
 	},
 	{
@@ -174,10 +175,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 				struct platform_device, dev);
 	struct omap_mmc_platform_data *pdata = dev->platform_data;

-	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0)
+	/* MMC1 Card detect Configuration */
+	if (pdev->id == 0) {
+		ret = omap4_hsmmc1_card_detect_config();
+		if (ret < 0)
+			pr_err("Unable to configure Card detect for MMC1\n");
 		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
-						MMCDETECT_INTR_OFFSET;
+							MMCDETECT_INTR_OFFSET;
+	}
 	return ret;
 }

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 1ef54b0..8a8f7b1 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -265,6 +265,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		mmc->get_context_loss_count = hsmmc_get_context_loss;

 		mmc->slots[0].switch_pin = c->gpio_cd;
+		mmc->slots[0].cd_type = c->cd_type;
 		mmc->slots[0].gpio_wp = c->gpio_wp;

 		mmc->slots[0].remux = c->remux;
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index ed60c0f..cd42c77 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/mmc/host.h>
+#include <linux/i2c/twl.h>

 #include <plat/board.h>

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 10bf228..f17e4e7 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -223,6 +223,29 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset)
 }
 EXPORT_SYMBOL(twl6030_interrupt_mask);

+int twl6030_mmc_card_detect(int host_id, int slot)
+{
+	int ret = -ENOSYS;
+	u8 read_reg;
+
+	switch (host_id) {
+	case 0:
+		/*
+		 * BIT0 of REG_MMC_CTRL
+		 * 0 - Card not present ,1 - Card present
+		 */
+		ret = twl_i2c_read_u8(TWL6030_MODULE_ID0,
+					&read_reg, TWL6030_MMCCTRL);
+		if (ret >= 0)
+			ret = read_reg & STS_MMC;
+		break;
+	default:
+		pr_err("Unkown MMC controller %d in %s\n", host_id, __func__);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(twl6030_mmc_card_detect);
+
 int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 {

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b032828..5d5bd29 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -189,9 +189,16 @@ struct omap_hsmmc_host {
 static int omap_hsmmc_card_detect(struct device *dev, int slot)
 {
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	struct platform_device *pdev = container_of(dev,
+				struct platform_device, dev);
+	int ret = -ENOSYS;

-	/* NOTE: assumes card detect signal is active-low */
-	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
+	if (mmc->slots[0].cd_type == GPIO)
+		/* NOTE: assumes card detect signal is active-low */
+		ret = !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
+	else
+		ret = twl6030_mmc_card_detect(pdev->id, slot);
+	return ret;
 }

 static int omap_hsmmc_get_wp(struct device *dev, int slot)
@@ -464,8 +471,6 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
 	int ret;

 	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
-		pdata->suspend = omap_hsmmc_suspend_cdirq;
-		pdata->resume = omap_hsmmc_resume_cdirq;
 		if (pdata->slots[0].cover)
 			pdata->slots[0].get_cover_state =
 					omap_hsmmc_get_cover_state;
@@ -504,6 +509,15 @@ err_free_sp:
 	return ret;
 }

+static int omap_hsmmc_non_gpio_init(struct omap_mmc_platform_data *pdata)
+{
+	if (pdata->slots[0].switch_pin > 0) {
+		pdata->slots[0].card_detect = omap_hsmmc_card_detect;
+		pdata->slots[0].card_detect_irq = pdata->slots[0].switch_pin;
+	}
+	return 0;
+}
+
 static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
 {
 	if (gpio_is_valid(pdata->slots[0].gpio_wp))
@@ -1988,7 +2002,11 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	if (res == NULL)
 		return -EBUSY;

-	ret = omap_hsmmc_gpio_init(pdata);
+	if (pdata->slots[0].cd_type == GPIO)
+		ret = omap_hsmmc_gpio_init(pdata);
+	else
+		ret =  omap_hsmmc_non_gpio_init(pdata);
+
 	if (ret)
 		goto err;

@@ -2170,6 +2188,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 				"Unable to grab MMC CD IRQ\n");
 			goto err_irq_cd;
 		}
+		pdata->suspend = omap_hsmmc_suspend_cdirq;
+		pdata->resume = omap_hsmmc_resume_cdirq;
 	}

 	omap_hsmmc_disable_irq(host);
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 6de90bf..38ef529 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -141,6 +141,14 @@
 #define TWL6030_CHARGER_CTRL_INT_MASK 	0x10
 #define TWL6030_CHARGER_FAULT_INT_MASK 	0x60

+#define TWL6030_MMCCTRL			0xEE
+#define VMMC_AUTO_OFF			(0x1 << 3)
+#define SW_FC				(0x1 << 2)
+#define STS_MMC				0x1
+
+#define TWL6030_CFG_INPUT_PUPD3		0xF2
+#define MMC_PU				(0x1 << 3)
+#define MMC_PD				(0x1 << 2)

 #define TWL4030_CLASS_ID 		0x4030
 #define TWL6030_CLASS_ID 		0x6030
@@ -173,6 +181,44 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
 int twl6030_interrupt_mask(u8 bit_mask, u8 offset);

+/* MMC1 Controller on OMAP4 uses Phoenix Irq for Card detect */
+int twl6030_mmc_card_detect(int host_id, int slot);
+
+/* Configuring Card Detect for MMC1 */
+static inline int omap4_hsmmc1_card_detect_config(void)
+{
+	int res = -1;
+	u8 reg_val = 0;
+
+	/* Unmasking the Card detect Interrupt line for MMC1 from Phoenix */
+	if (twl_class_is_6030()) {
+		twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_MASK,
+							REG_INT_MSK_LINE_B);
+		twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_MASK,
+							REG_INT_MSK_STS_B);
+	}
+
+	/*
+	 * Intially Configuring MMC_CTRL for receving interrupts &
+	 * Card status on TWL6030 for MMC1
+	 */
+	res = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val, TWL6030_MMCCTRL);
+	if (res < 0)
+		return res;
+	reg_val &= ~VMMC_AUTO_OFF;
+	reg_val |= SW_FC;
+	twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_MMCCTRL);
+
+	 /* Configuring CFG_INPUT_PUPD3 */
+	res = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
+						TWL6030_CFG_INPUT_PUPD3);
+	if (res < 0)
+		return res;
+	reg_val &= ~(MMC_PU | MMC_PD);
+	twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_CFG_INPUT_PUPD3);
+	return res;
+}
+
 /*----------------------------------------------------------------------*/

 /*
-- 
1.6.3.3



From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v2 1/4] omap4 hsmmc: Adding card detect support for MMC1
Date: Sat, 18 Sep 2010 22:03:56 +0530 (IST)
Message-ID: <33908.10.24.255.17.1284827636.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Adding card detect callback function and card detect configuration
function for MMC1 Controller.

Card detect configuration function does initial configuration of the
MMC Control & PullUp-PullDown registers of Phoenix.

For MMC1 Controller, Card detect interrupt source is
twl6030 and the card detect call back function provides card present/absent
status by reading MMC Control register.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    7 +++-
 drivers/mfd/twl6030-irq.c           |   76 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c       |    4 +-
 include/linux/i2c/twl.h             |   31 ++++++++++++++
 4 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9447644..a49f285 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -227,9 +227,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 	struct omap_mmc_platform_data *pdata = dev->platform_data;

 	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0)
+	if (pdev->id == 0) {
+		ret = twl6030_mmc_card_detect_config();
+		if (ret)
+			pr_err("Failed configuring MMC1 card detect\n");
 		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
 						MMCDETECT_INTR_OFFSET;
+		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
+	}
 	return ret;
 }

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 10bf228..de232b1 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -36,6 +36,7 @@
 #include <linux/irq.h>
 #include <linux/kthread.h>
 #include <linux/i2c/twl.h>
+#include <linux/platform_device.h>

 /*
  * TWL6030 (unlike its predecessors, which had two level interrupt handling)
@@ -223,6 +224,81 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset)
 }
 EXPORT_SYMBOL(twl6030_interrupt_mask);

+int twl6030_mmc_card_detect_config(void)
+{
+	int ret;
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
+	ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val, TWL6030_MMCCTRL);
+	if (ret < 0) {
+		pr_err("twl6030: Failed to read MMCCTRL, error %d\n", ret);
+		return ret;
+	}
+	reg_val &= ~VMMC_AUTO_OFF;
+	reg_val |= SW_FC;
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_MMCCTRL);
+	if (ret < 0) {
+		pr_err("twl6030: Failed to write MMCCTRL, error %d\n", ret);
+		return ret;
+	}
+
+	/* Configuring PullUp-PullDown register */
+	ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
+						TWL6030_CFG_INPUT_PUPD3);
+	if (ret < 0) {
+		pr_err("twl6030: Failed to read CFG_INPUT_PUPD3, error %d\n",
+									ret);
+		return ret;
+	}
+	reg_val &= ~(MMC_PU | MMC_PD);
+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
+						TWL6030_CFG_INPUT_PUPD3);
+	if (ret < 0) {
+		pr_err("twl6030: Failed to write CFG_INPUT_PUPD3, error %d\n",
+									ret);
+		return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(twl6030_mmc_card_detect_config);
+
+int twl6030_mmc_card_detect(struct device *dev, int slot)
+{
+	int ret = -EIO;
+	u8 read_reg = 0;
+	struct platform_device *pdev = container_of(dev,
+					struct platform_device, dev);
+
+	switch (pdev->id) {
+	case 0:
+		/*
+		 * BIT0 of REG_MMC_CTRL
+		 * 0 - Card not present ,1 - Card present
+		 */
+		ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &read_reg,
+							TWL6030_MMCCTRL);
+		if (ret >= 0)
+			ret = read_reg & STS_MMC;
+		break;
+	default:
+		pr_err("Unkown MMC controller %d in %s\n", pdev->id, __func__);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(twl6030_mmc_card_detect);
+
 int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 {

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 562dbbb..a51894d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -466,8 +466,6 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
 	int ret;

 	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
-		pdata->suspend = omap_hsmmc_suspend_cdirq;
-		pdata->resume = omap_hsmmc_resume_cdirq;
 		if (pdata->slots[0].cover)
 			pdata->slots[0].get_cover_state =
 					omap_hsmmc_get_cover_state;
@@ -2211,6 +2209,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 				"Unable to grab MMC CD IRQ\n");
 			goto err_irq_cd;
 		}
+		pdata->suspend = omap_hsmmc_suspend_cdirq;
+		pdata->resume = omap_hsmmc_resume_cdirq;
 	}

 	omap_hsmmc_disable_irq(host);
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 6de90bf..eba9541 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -141,6 +141,16 @@
 #define TWL6030_CHARGER_CTRL_INT_MASK 	0x10
 #define TWL6030_CHARGER_FAULT_INT_MASK 	0x60

+#define TWL6030_MMCCTRL		0xEE
+#define VMMC_AUTO_OFF			(0x1 << 3)
+#define SW_FC				(0x1 << 2)
+#define STS_MMC			0x1
+
+#define TWL6030_CFG_INPUT_PUPD3	0xF2
+#define MMC_PU				(0x1 << 3)
+#define MMC_PD				(0x1 << 2)
+
+

 #define TWL4030_CLASS_ID 		0x4030
 #define TWL6030_CLASS_ID 		0x6030
@@ -173,6 +183,27 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
 int twl6030_interrupt_mask(u8 bit_mask, u8 offset);

+/* Card detect Configuration for MMC1 Controller on OMAP4 */
+#ifdef CONFIG_TWL4030_CORE
+int twl6030_mmc_card_detect_config(void);
+#else
+static inline int twl6030_mmc_card_detect_config(void)
+{
+	pr_err("twl6030_mmc_card_detect_config not supported\n");
+	return 0;
+}
+#endif
+
+/* MMC1 Controller on OMAP4 uses Phoenix irq for Card detect */
+#ifdef CONFIG_TWL4030_CORE
+int twl6030_mmc_card_detect(struct device *dev, int slot);
+#else
+static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
+{
+	pr_err("Call back twl6030_mmc_card_detect not supported\n");
+	return -EIO;
+}
+#endif
 /*----------------------------------------------------------------------*/

 /*
-- 
1.7.0.4



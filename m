From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v2 2/5] OMAP4-HSMMC: Adding Card detect support
Date: Tue, 4 May 2010 21:31:30 +0530 (IST)
Message-ID: <35156.10.24.255.17.1272988890.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com
List-Id: linux-mmc@vger.kernel.org

In OMAP4, card detect interrupt is provided by Phoenix and also
card status is provided by MMCCTRL register of Phoenix.

Since OMAP4's card detection doesn't support GPIO,this patch
basically adds a flag which can differentiate whether the
card-detect line is GPIO or NON-GPIO based.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c   |    1 +
 arch/arm/mach-omap2/hsmmc.c           |    2 ++
 arch/arm/mach-omap2/hsmmc.h           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    2 ++
 drivers/mfd/twl6030-irq.c             |   27 +++++++++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |   18 +++++++++++++++++-
 include/linux/i2c/twl.h               |    6 ++++++
 7 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c4e61d5..41fbffe 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -102,6 +102,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		 * but is a phoenix interrupt
 		 */
 		.gpio_cd	= TWL6030_IRQ_BASE + MMCDETECT_INTR_OFFSET,
+		.cd_type	= true,
 		.gpio_wp	= -EINVAL,
 	},
 	{
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 9ad2295..f5ca16c 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/delay.h>
+#include <linux/i2c/twl.h>
 #include <mach/hardware.h>
 #include <plat/control.h>
 #include <plat/mmc.h>
@@ -189,6 +190,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info
 		mmc->get_context_loss_count = hsmmc_get_context_loss;

 		mmc->slots[0].switch_pin = c->gpio_cd;
+		mmc->slots[0].nongpio_cd = c->cd_type;
 		mmc->slots[0].gpio_wp = c->gpio_wp;

 		mmc->slots[0].remux = c->remux;
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
index a1bac07..8458a8b 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/mmc/host.h>
+#include <linux/i2c/twl.h>

 #include <plat/board.h>

@@ -103,6 +104,7 @@ struct omap_mmc_platform_data {
 		unsigned vcc_aux_disable_is_sleep:1;

 		int switch_pin;			/* gpio (card detect) */
+		unsigned nongpio_cd:1;		/* NON-GPIO=true , GPIO=false */
 		int gpio_wp;			/* gpio (write protect) */

 		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 10bf228..da3d4ec 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -36,6 +36,7 @@
 #include <linux/irq.h>
 #include <linux/kthread.h>
 #include <linux/i2c/twl.h>
+#include <linux/platform_device.h>

 /*
  * TWL6030 (unlike its predecessors, which had two level interrupt handling)
@@ -223,6 +224,32 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset)
 }
 EXPORT_SYMBOL(twl6030_interrupt_mask);

+int twl6030_mmc_card_detect(struct device *dev, int slot)
+{
+	int ret = -ENOSYS;
+	int res = 0;
+	u8 read_reg;
+	struct platform_device *pdev = container_of(dev,
+					struct platform_device, dev);
+
+	switch (pdev->id) {
+	case 0:
+		/*
+		 * BIT0 of REG_MMC_CTRL
+		 * 0 - Card not present ,1 - Card present
+		 */
+		res = twl_i2c_read_u8(TWL6030_MODULE_ID0,
+			&read_reg, TWL6030_MMCCTRL);
+		if (res >= 0)
+			ret = read_reg & 0x1;
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
index e9caf69..ac903b0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -505,6 +505,18 @@ err_free_sp:
 	return ret;
 }

+static int omap_hsmmc_non_gpio_init(struct omap_mmc_platform_data *pdata)
+{
+	if (pdata->slots[0].switch_pin) {
+		pdata->suspend = omap_hsmmc_suspend_cdirq;
+		pdata->resume = omap_hsmmc_resume_cdirq;
+		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
+		pdata->slots[0].card_detect_irq = pdata->slots[0].switch_pin;
+		return 0;
+	}
+	return -1;
+}
+
 static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
 {
 	if (gpio_is_valid(pdata->slots[0].gpio_wp))
@@ -1977,7 +1989,11 @@ static int __init omap_hsmmc_probe(struct platform_device
 	if (res == NULL)
 		return -EBUSY;

-	ret = omap_hsmmc_gpio_init(pdata);
+	if (!pdata->slots[0].nongpio_cd)
+		ret = omap_hsmmc_gpio_init(pdata);
+	else
+		ret =  omap_hsmmc_non_gpio_init(pdata);
+
 	if (ret)
 		goto err;

diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index fb6784e..eb198db 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -141,6 +141,7 @@
 #define TWL6030_CHARGER_CTRL_INT_MASK 	0x10
 #define TWL6030_CHARGER_FAULT_INT_MASK 	0x60

+#define TWL6030_MMCCTRL			0xEE

 #define TWL4030_CLASS_ID 		0x4030
 #define TWL6030_CLASS_ID 		0x6030
@@ -173,6 +174,11 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned
 int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
 int twl6030_interrupt_mask(u8 bit_mask, u8 offset);

+/*
+ * MMC1 Controller on OMAP4 uses Phoenix Irq for Card detect.
+ */
+int twl6030_mmc_card_detect(struct device *dev, int slot);
+
 /*----------------------------------------------------------------------*/

 /*
-- 
1.6.3.3


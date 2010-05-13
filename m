From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v3 3/5] OMAP4 HSMMC: Adding card detect support for MMC1
     Controller
Date: Fri, 14 May 2010 01:41:44 +0530 (IST)
Message-ID: <12500.10.24.255.17.1273781504.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46387 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692Ab0EMUL6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 May 2010 16:11:58 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com

Adds card detect callback function which gives the status of
the card.For MMC1 Controller, Card detect interrupt is provided by
twl6030 and card status is provided by MMCCTRL reg of twl6030.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    1 +
 drivers/mfd/twl6030-irq.c             |   23 +++++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |   31 ++++++++++++++++++++++++++-----
 include/linux/i2c/twl.h               |    3 +++
 5 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 9ad2295..679188c 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -189,6 +189,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		mmc->get_context_loss_count = hsmmc_get_context_loss;

 		mmc->slots[0].switch_pin = c->gpio_cd;
+		mmc->slots[0].cd_type = c->cd_type;
 		mmc->slots[0].gpio_wp = c->gpio_wp;

 		mmc->slots[0].remux = c->remux;
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index e4e595b..38fa033 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/mmc/host.h>
+#include <linux/i2c/twl.h>

 #include <plat/board.h>

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 10bf228..ca8b30b 100644
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
+			&read_reg, TWL6030_MMCCTRL);
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
index e9caf69..e25db63 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -190,9 +190,16 @@ struct omap_hsmmc_host {
 static int omap_hsmmc_card_detect(struct device *dev, int slot)
 {
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	struct platform_device *pdev = container_of(dev,
+					struct platform_device, dev);
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
@@ -465,8 +472,6 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
 	int ret;

 	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
-		pdata->suspend = omap_hsmmc_suspend_cdirq;
-		pdata->resume = omap_hsmmc_resume_cdirq;
 		if (pdata->slots[0].cover)
 			pdata->slots[0].get_cover_state =
 					omap_hsmmc_get_cover_state;
@@ -505,6 +510,16 @@ err_free_sp:
 	return ret;
 }

+static int omap_hsmmc_non_gpio_init(struct omap_mmc_platform_data *pdata)
+{
+
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
@@ -1977,7 +1992,11 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
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

@@ -2160,6 +2179,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 				"Unable to grab MMC CD IRQ\n");
 			goto err_irq_cd;
 		}
+		pdata->suspend = omap_hsmmc_suspend_cdirq;
+		pdata->resume = omap_hsmmc_resume_cdirq;
 	}

 	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index f382d59..ce67b9a 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -182,6 +182,9 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
 int twl6030_interrupt_mask(u8 bit_mask, u8 offset);

+/* MMC1 Controller on OMAP4 uses Phoenix Irq for Card detect */
+int twl6030_mmc_card_detect(int host_id, int slot);
+
 /* Configuring Card Detect for MMC1 */
 static inline int omap4_hsmmc1_card_detect_config(void)
 {
-- 
1.6.3.3



From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/4] omap4 hsmmc: Adding card detect support for MMC1
Date: Wed, 22 Sep 2010 11:51:19 +0300
Message-ID: <20100922085119.GD29725@legolas.emea.dhcp.ti.com>
References: <33908.10.24.255.17.1284827636.squirrel@dbdmail.itg.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59721 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab0IVIvY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Sep 2010 04:51:24 -0400
Content-Disposition: inline
In-Reply-To: <33908.10.24.255.17.1284827636.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Sat, Sep 18, 2010 at 11:33:56AM -0500, kishore kadiyala wrote:
>@@ -223,6 +224,81 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset)
> }
> EXPORT_SYMBOL(twl6030_interrupt_mask);
>
>+int twl6030_mmc_card_detect_config(void)
>+{
>+	int ret;
>+	u8 reg_val = 0;
>+
>+	/* Unmasking the Card detect Interrupt line for MMC1 from Phoenix */
>+	if (twl_class_is_6030()) {

which other class can this be ?

>+	/*
>+	 * Intially Configuring MMC_CTRL for receving interrupts &
>+	 * Card status on TWL6030 for MMC1
>+	 */
>+	ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val, TWL6030_MMCCTRL);
>+	if (ret < 0) {
>+		pr_err("twl6030: Failed to read MMCCTRL, error %d\n", ret);
>+		return ret;
>+	}
>+	reg_val &= ~VMMC_AUTO_OFF;
>+	reg_val |= SW_FC;
>+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_MMCCTRL);
>+	if (ret < 0) {
>+		pr_err("twl6030: Failed to write MMCCTRL, error %d\n", ret);
>+		return ret;
>+	}
>+
>+	/* Configuring PullUp-PullDown register */
>+	ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
>+						TWL6030_CFG_INPUT_PUPD3);

is this a gpio ? Could gpiolib take care of this ?

>+	if (ret < 0) {
>+		pr_err("twl6030: Failed to read CFG_INPUT_PUPD3, error %d\n",
>+									ret);
>+		return ret;
>+	}
>+	reg_val &= ~(MMC_PU | MMC_PD);
>+	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
>+						TWL6030_CFG_INPUT_PUPD3);

ditto.

>+int twl6030_mmc_card_detect(struct device *dev, int slot)
>+{
>+	int ret = -EIO;
>+	u8 read_reg = 0;
>+	struct platform_device *pdev = container_of(dev,
>+					struct platform_device, dev);

how about:

	struct platform_device *pdev = to_platform_device(dev);

>diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>index 562dbbb..a51894d 100644
>--- a/drivers/mmc/host/omap_hsmmc.c
>+++ b/drivers/mmc/host/omap_hsmmc.c
>@@ -466,8 +466,6 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
> 	int ret;
>
> 	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
>-		pdata->suspend = omap_hsmmc_suspend_cdirq;
>-		pdata->resume = omap_hsmmc_resume_cdirq;
> 		if (pdata->slots[0].cover)
> 			pdata->slots[0].get_cover_state =
> 					omap_hsmmc_get_cover_state;
>@@ -2211,6 +2209,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
> 				"Unable to grab MMC CD IRQ\n");
> 			goto err_irq_cd;
> 		}
>+		pdata->suspend = omap_hsmmc_suspend_cdirq;
>+		pdata->resume = omap_hsmmc_resume_cdirq;

this doesn't look to be part of $SUBJECT, care to explain ?

>@@ -173,6 +183,27 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
> int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
> int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
>
>+/* Card detect Configuration for MMC1 Controller on OMAP4 */
>+#ifdef CONFIG_TWL4030_CORE
>+int twl6030_mmc_card_detect_config(void);
>+#else
>+static inline int twl6030_mmc_card_detect_config(void)
>+{
>+	pr_err("twl6030_mmc_card_detect_config not supported\n");

pr_debug() would be better ??

>+/* MMC1 Controller on OMAP4 uses Phoenix irq for Card detect */
>+#ifdef CONFIG_TWL4030_CORE
>+int twl6030_mmc_card_detect(struct device *dev, int slot);
>+#else
>+static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
>+{
>+	pr_err("Call back twl6030_mmc_card_detect not supported\n");

ditto.

-- 
balbi

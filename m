From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] mmc: add dw-mmc-k3
Date: Fri, 18 Oct 2013 17:07:14 +0800
Message-ID: <CAMj5Bkgzb1yM=-PnsDNvT4n9g54HZkPK=mcfu0SbMnGbOrt-fA@mail.gmail.com>
References: <1381415813-9395-1-git-send-email-zhangfei.gao@linaro.org>
	<1381415813-9395-3-git-send-email-zhangfei.gao@linaro.org>
	<525BB90B.9060105@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:36834 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab3JRJHP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2013 05:07:15 -0400
Received: by mail-ea0-f170.google.com with SMTP id q10so1436364eaj.1
        for <linux-mmc@vger.kernel.org>; Fri, 18 Oct 2013 02:07:14 -0700 (PDT)
In-Reply-To: <525BB90B.9060105@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Dear Jaehoon

Thanks for the valueable suggestion.

On Mon, Oct 14, 2013 at 5:27 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi,
>
> If you will send the patch, plz, add the prefix "mmc: dw_mmc: xxx" at subject.
OK, got it.

> And i think good that device-tree and mmc patch is separated.
It is Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt, instead of dts.
Should be combined with initial version?

>> +* Hisilicon specific extensions to the Synopsis Designware Mobile
>> +  Storage Host Controller
> Maybe fixed the Synopsys instead of Synopsis.
OK, thanks

>> +struct dw_mci_k3_priv_data {
>> +     enum dw_mci_k3_type     type;
>> +     int                     old_timing;
>> +     u32                     id;
> You're using "id" as the "int" type at the below code. which type is exactly?
>> +     u32                     gpio_cd;
>> +     u32                     clken_reg;
>> +     u32                     clken_bit;
>> +     u32                     sam_sel_reg;
>> +     u32                     sam_sel_bit;
>> +     u32                     drv_sel_reg;
>> +     u32                     drv_sel_bit;
>> +     u32                     div_reg;
>> +     u32                     div_bit;
>> +};
> clken_reg/sam_sel_reg/drv_sel_reg can be changed? Otherwise, it's not host register?
> If it's host register, then you can use the mci_writeX().
clken_reg/sam_sel_reg/drv_sel_reg is not host register,
But other register from pctrl register, used for tuning clock, which
is silicon special requirement.

>> +
>> +static void __iomem *pctrl;
>> +static DEFINE_SPINLOCK(mmc_tuning_lock);
>> +static int k3_tuning_config[][8][6] = {
>> +     /* bus_clk, div, drv_sel, sam_sel_max, sam_sel_min, input_clk */
>> +     {
>> +             {180000000, 6, 6, 13, 13, 25000000},    /* 0: LEGACY 400k */
>> +             {0},                                    /* 1: MMC_HS */
>> +             {360000000, 6, 4, 2, 0, 50000000  },    /* 2: SD_HS */
>> +             {180000000, 6, 4, 13, 13, 25000000},    /* 3: SDR12 */
>> +             {360000000, 6, 4, 2, 0, 50000000  },    /* 4: SDR25 */
>> +             {720000000, 6, 1, 9, 4, 100000000 },    /* 5: SDR50 */
>> +             {0},                                    /* 6: SDR104 */
>> +             {360000000, 7, 1, 3, 0, 50000000  },    /* 7: DDR50 */
>> +     }, {
>> +             {26000000, 1, 1, 3, 3, 13000000  },     /* 0: LEGACY 400k */
>> +             {360000000, 6, 3, 3, 1, 50000000 },     /* 1: MMC_HS*/
>> +             {0},                                    /* 2: SD_HS */
>> +             {0},                                    /* 3: SDR12 */
>> +             {26000000, 1, 1, 3, 3, 13000000  },     /* 4: SDR25 */
>> +             {360000000, 6, 3, 3, 1, 50000000 },     /* 5: SDR50 */
>> +             {0},                                    /* 6: SDR104 */
>> +             {720000000, 6, 4, 8, 4, 100000000},     /* 7: DDR50 */
>> +     },
>> +};
> Can't this config be included the dt-file?
Yes, good suggestion, it can be.

However, additional API of_property_read_u32_array_index required.
since there is no existing API get one array from list of arrays.
Have test this API, may send out for comments, however, not sure it
can ne accepted.
What do you think?

+ * of_property_read_u32_array_index - Find and read an array of 32 bit integers
+ * pointed by index from a property.
+ *
+ * @np:                device node from which the property value is to be read.
+ * @propname:  name of the property to be searched.
+ * @out_values:        pointer to return value, modified only if
return value is 0.
+ * @sz:                number of array elements to read
+ * @index:     index of the u32 array in the list of values
+ *
+ * Search for a property in a device node and read 32-bit value(s) from
+ * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid u32 value can be decoded.
+ */
+int of_property_read_u32_array_index(const struct device_node *np,
+                              const char *propname, u32 *out_values,
+                              size_t sz, u32 index)
+{
+       const __be32 *val = of_find_property_value_of_size(np, propname,
+                               (index + 1) * (sz * sizeof(*out_values)));
+
+       if (IS_ERR(val))
+               return PTR_ERR(val);
+
+       while (index--)
+               val += sz;
+       while (sz--)
+               *out_values++ = be32_to_cpup(val++);
+       return 0;
+}
+EXPORT_SYMBOL_GPL(of_property_read_u32_array_index);


>> +
>> +static void dw_mci_k3_set_timing(struct dw_mci_k3_priv_data *priv,
>> +                             int idx, int sam, int drv, int div)
> Where is "idx" used?
Yes, it can be removed.
>
>> +{
>> +     unsigned int clken_reg = priv->clken_reg;
>> +     unsigned int clken_bit = priv->clken_bit;
>> +     unsigned int sam_sel_reg = priv->sam_sel_reg;
>> +     unsigned int sam_sel_bit = priv->sam_sel_bit;
>> +     unsigned int drv_sel_reg = priv->drv_sel_reg;
>> +     unsigned int drv_sel_bit = priv->drv_sel_bit;
>> +     unsigned int div_reg = priv->div_reg;
>> +     unsigned int div_bit = priv->div_bit;
> Can't use the priv->xxx?
OK.
>> +     int i = 0;
>> +     unsigned int temp_reg;
>> +     unsigned long flags;
>> +
>> +     spin_lock_irqsave(&mmc_tuning_lock, flags);
>> +
>> +     /* disable clock */
>> +     temp_reg = readl(pctrl + clken_reg);
> temp_reg? is it register?
OK, will use u32 val.

>> +     temp_reg &= ~(1<<clken_bit);
>> +     writel(temp_reg, pctrl + clken_reg);
>> +
>> +     temp_reg = readl(pctrl + sam_sel_reg);
>> +     if (sam >= 0) {
>> +             /* set sam delay */
>> +             for (i = 0; i < 4; i++) {
>> +                     if (sam % 2)
>> +                             temp_reg |= 1<<(sam_sel_bit + i);
>> +                     else
>> +                             temp_reg &= ~(1<<(sam_sel_bit + i));
>> +                     sam = sam >> 1;
>> +             }
>> +     }
>> +     writel(temp_reg, pctrl + sam_sel_reg);
>> +
>> +     temp_reg = readl(pctrl + drv_sel_reg);
>> +     if (drv >= 0) {
>> +             /* set drv delay */
>> +             for (i = 0; i < 4; i++) {
>> +                     if (drv % 2)
>> +                             temp_reg |= 1<<(drv_sel_bit + i);
>> +                     else
>> +                             temp_reg &= ~(1<<(drv_sel_bit + i));
>> +                     drv = drv >> 1;
>> +             }
>> +     }
>> +     writel(temp_reg, pctrl + drv_sel_reg);
>> +
>> +     temp_reg = readl(pctrl + div_reg);
>> +     if (div >= 0) {
>> +             /* set drv delay */
>> +             for (i = 0; i < 3; i++) {
>> +                     if (div % 2)
>> +                             temp_reg |= 1<<(div_bit + i);
>> +                     else
>> +                             temp_reg &= ~(1<<(div_bit + i));
>> +                     div = div >> 1;
>> +             }
>> +     }
>> +     writel(temp_reg, pctrl + div_reg);
> I think these loop can reuse..like dw_mci_k3_set_delay(). It's duplicated.
Yes, will update with function.

>> +
>> +     /* enable clock */
>> +     temp_reg = readl(pctrl + clken_reg);
>> +     temp_reg |= 1<<clken_bit;
>> +     writel(temp_reg, pctrl + clken_reg);
>> +
>> +     spin_unlock_irqrestore(&mmc_tuning_lock, flags);
>> +}
>> +
>> +static void dw_mci_k3_tun(struct dw_mci *host, int id, int index)
>> +{
>> +     struct dw_mci_k3_priv_data *priv = host->priv;
>> +     int ret;
>> +
>> +     if (!pctrl)
>> +             return;
>> +
>> +     if (priv->old_timing == index)
> index? "timing" is more readable?
OK.

>> +             return;
>> +
>> +     ret = clk_set_rate(host->ciu_clk, k3_tuning_config[id][index][0]);
>> +     if (ret)
>> +             dev_err(host->dev, "clk_set_rate failed\n");
> not need to control about error? Just print the log?
Will return then,
mmc init will fail if clock set fail, so just pirnt error.

>> +
>> +     dw_mci_k3_set_timing(priv, id,
>> +                     (k3_tuning_config[id][index][3] +
>> +                     k3_tuning_config[id][index][4]) / 2,
>> +                     k3_tuning_config[id][index][2],
>> +                     k3_tuning_config[id][index][1]);
>> +
>> +     host->bus_hz = k3_tuning_config[id][index][5];
>> +     priv->old_timing = index;
>> +}
>> +
>> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>> +{
>> +     struct dw_mci_k3_priv_data *priv = host->priv;
>> +     int id = priv->id;
>> +
>> +     if (priv->type == DW_MCI_TYPE_HI4511)
>> +             dw_mci_k3_tun(host, id, ios->timing);
> This code is just called the dw_mci_k3_tun()?
> Then codes of dw_mci_k3_tun() can place into here?
The dw_mci_k3_tun required at several places besides set_ios
for example, after resume back, before init, otherwise the CTRL
register fail to read on SD.


>> +static int dw_mci_k3_setup_clock(struct dw_mci *host)
>> +{
>> +     struct dw_mci_k3_priv_data *priv = host->priv;
>> +
>> +     if (priv->type == DW_MCI_TYPE_HI4511)
>> +             dw_mci_k3_tun(host, priv->id, MMC_TIMING_LEGACY);
>> +
>> +     return 0;
>> +}
>> +
>> +
> remove the white space
OK.

>> +int dw_mci_k3_probe(struct platform_device *pdev)
> static?
thanks for point.

>> +{
>> +     const struct dw_mci_drv_data *drv_data;
>> +     const struct of_device_id *match;
>> +     struct dw_mci *host;
>> +     int gpio, err;
>> +
>> +     match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
>> +     drv_data = match->data;
>> +
>> +     err = dw_mci_pltfm_register(pdev, drv_data);
>> +     if (err)
>> +             return err;
>> +
>> +     host = platform_get_drvdata(pdev);
>> +     if (host->pdata->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
> Why return at here, when Broken card detection is set?
>> +             return 0;
>> +
>> +     gpio = of_get_named_gpio(pdev->dev.of_node, "cd-gpio", 0);
>> +     if (gpio_is_valid(gpio)) {
>> +             if (devm_gpio_request(host->dev, gpio, "dw-mci-cd")) {
>> +                     dev_err(host->dev, "gpio [%d] request failed\n", gpio);
>> +             } else {
>> +                     struct dw_mci_k3_priv_data *priv = host->priv;
>> +                     priv->gpio_cd = gpio;
>> +                     host->pdata->get_cd = dw_mci_k3_get_cd;
>> +                     err = devm_request_irq(host->dev, gpio_to_irq(gpio),
>> +                             dw_mci_k3_card_detect,
>> +                             IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
>> +                             DRIVER_NAME, host);
>> +                     if (err)
>> +                             dev_warn(mmc_dev(host->dev), "request gpio irq error\n");
>> +             }
>> +
>> +     } else {
>> +             dev_info(host->dev, "cd gpio not available");
>> +     }
> I think it can use the slot-gpio.c.
Yes, good suggesiton.
However, dw_mmc.c will be modified accordingly, Paste here,

What's your suggestion, will send out for review.

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 018f365..9fe7f6a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -35,6 +35,7 @@
 #include <linux/workqueue.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/mmc/slot-gpio.h>

 #include "dw_mmc.h"

@@ -872,12 +873,15 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
  int present;
  struct dw_mci_slot *slot = mmc_priv(mmc);
  struct dw_mci_board *brd = slot->host->pdata;
+ int gpio_cd = !mmc_gpio_get_cd(mmc);

  /* Use platform get_cd function, else try onboard card detect */
  if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
  present = 1;
  else if (brd->get_cd)
  present = !brd->get_cd(slot->id);
+ else if (!IS_ERR_VALUE(gpio_cd))
+ present = !!gpio_cd;
  else
  present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
  == 0 ? 1 : 0;
@@ -1876,6 +1880,32 @@ static int dw_mci_of_get_wp_gpio(struct device
*dev, u8 slot)

  return gpio;
 }
+
+/* find the cd gpio for a given slot; or -1 if none specified */
+static int dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
+ struct mmc_host *mmc)
+{
+ struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
+ int gpio;
+
+ if (!np)
+ return -EINVAL;
+
+ gpio = of_get_named_gpio(np, "cd-gpios", 0);
+
+ /* Having a missing entry is valid; return silently */
+ if (!gpio_is_valid(gpio)) {
+ printk("not valid gpio\n");
+ return -EINVAL;
+ }
+
+ if (mmc_gpio_request_cd(mmc, gpio, 0)) {
+ dev_warn(dev, "gpio [%d] request failed\n", gpio);
+ return -EINVAL;
+ }
+
+ return gpio;
+}
 #else /* CONFIG_OF */
 static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
 {
@@ -1893,6 +1923,11 @@ static int dw_mci_of_get_wp_gpio(struct device
*dev, u8 slot)
 {
  return -EINVAL;
 }
+static int dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
+ struct mmc_host *mmc)
+{
+ return -EINVAL;
+}
 #endif /* CONFIG_OF */

 static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
@@ -1996,6 +2031,7 @@ static int dw_mci_init_slot(struct dw_mci *host,
unsigned int id)
  clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);

  slot->wp_gpio = dw_mci_of_get_wp_gpio(host->dev, slot->id);
+ dw_mci_of_get_cd_gpio(host->dev, slot->id, mmc);

  ret = mmc_add_host(mmc);
  if (ret)

>> +     return 0;
>> +}
>> +
>> +static int dw_mci_k3_suspend(struct device *dev)
>> +{
>> +     int ret;
>> +     struct dw_mci *host = dev_get_drvdata(dev);
>> +
>> +     ret = dw_mci_suspend(host);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return 0;
> ret = dw_mci_suspend(host); then
> Just return ret;
Yes, return dw_mci_suspend(host); will be used

>> +SIMPLE_DEV_PM_OPS(dw_mci_k3_pmops, dw_mci_k3_suspend, dw_mci_k3_resume);
>> +
>> +static struct platform_driver dw_mci_k3_pltfm_driver = {
>> +     .probe          = dw_mci_k3_probe,
>> +     .remove         = dw_mci_pltfm_remove,
>> +     .driver         = {
>> +             .name           = DRIVER_NAME,
> Just use the "dwmmc_k3" at here. not use the DRIVER_NAME.
OK

Thanks
Zhangfei

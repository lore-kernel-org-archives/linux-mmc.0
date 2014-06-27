From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: Re: [RFC PATCH v2 4/6] mmc: sdhci: host: add new f_sdh30
Date: Fri, 27 Jun 2014 11:32:21 +0800
Message-ID: <CAOEd-H3+MwT3DMqMO0XHaZQqYAN0zaQqRMjC_UjyJn5ZwCaMoQ@mail.gmail.com>
References: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<1403763812-5495-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<20140626110351.GN15240@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:46290 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaF0DcW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jun 2014 23:32:22 -0400
In-Reply-To: <20140626110351.GN15240@leverpostej>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "chris@printf.net" <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "anton@enomsg.org" <anton@enomsg.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "patches@linaro.org" <patches@linaro.org>, "andy.green@linaro.org" <andy.green@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "Vincent.Yang@tw.fujitsu.com" <Vincent.Yang@tw.fujitsu.com>

2014-06-26 19:03 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> On Thu, Jun 26, 2014 at 07:23:30AM +0100, Vincent Yang wrote:
>> This patch adds new host controller driver for
>> Fujitsu SDHCI controller f_sdh30.
>>
>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>> ---
>>  .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  35 +++
>>  drivers/mmc/host/Kconfig                           |   7 +
>>  drivers/mmc/host/Makefile                          |   1 +
>>  drivers/mmc/host/sdhci_f_sdh30.c                   | 346 +++++++++++++++++++++
>>  drivers/mmc/host/sdhci_f_sdh30.h                   |  40 +++
>>  5 files changed, 429 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
>>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>> new file mode 100644
>> index 0000000..40add438
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>> @@ -0,0 +1,35 @@
>> +* Fujitsu SDHCI controller
>> +
>> +This file documents differences between the core properties in mmc.txt
>> +and the properties used by the sdhci_f_sdh30 driver.
>> +
>> +Required properties:
>> +- compatible: "fujitsu,f_sdh30"
>
> Please use '-' rather than '_' in compatible strings.

Hi Mark,
Yes, I'll update it to '-' in next version.

>
> This seems to be the name of the driver. What is the precise name of the
> IP block?

The name of the IP block is "F_SDH30".
That's why it uses "fujitsu,f_sdh30"

>
>> +- voltage-ranges : two cells are required, first cell specifies minimum
>> +  slot voltage (mV), second cell specifies maximum slot voltage (mV).
>> +  Several ranges could be specified.
>
> Describe this as a list of pairs, it's confusing otherwise.
>
> I'm not sure I follow what having multiple pairs implies.

Yes, I'll update it in next version.

>
>> +Optional properties:
>> +- gpios: This is one optional gpio for controlling a power mux which
>> +  switches between two power supplies. 3.3V is selected when gpio is high,
>> +  and 1.8V is selected when gpio is low. This voltage is used for signal
>> +  level.
>
> Give this a more descriptive name, like power-mux-gpios. That will match
> up with the style of cd-gpios and wp-gpios.

Yes, I'll update it in next version.

>
>> +- clocks: Must contain an entry for each entry in clock-names. It is a
>> +  list of phandles and clock-specifier pairs.
>> +  See ../clocks/clock-bindings.txt for details.
>> +- clock-names: Should contain the following two entries:
>> +       "sd_sd4clk" - clock primarily used for tuning process
>> +       "sd_bclk"   - base clock for sdhci controller
>> +
>> +Example:
>> +
>> +       sdhci1: sdio@36600000 {
>> +               compatible = "fujitsu,f_sdh30";
>> +               reg = <0 0x36600000 0x1000>;
>> +               interrupts = <0 172 0x4>,
>> +                            <0 173 0x4>;
>> +               voltage-ranges = <1800 1800 3300 3300>;
>
> Place brackets around each pair to make this clearer:
>
>         voltage-ranges = <1800 1800>, <3300 3300>;

Yes, I'll update it in next version.

>
> [...]
>
>> +       if (!of_property_read_u32(pdev->dev.of_node, "vendor-hs200",
>> +                                 &priv->vendor_hs200))
>> +               dev_info(dev, "Applying vendor-hs200 setting\n");
>> +       else
>> +               priv->vendor_hs200 = 0;
>
> This wasn't in the binding document, and a grep for "vendor-hs200" in a
> v3.16-rc2 tree found me nothing.
>
> Please document this.

Yes, it is a setting for a vendor specific register.
I'll update it in next version.

>
>> +
>> +       if (!of_property_read_u32(pdev->dev.of_node, "bus-width", &bus_width)) {
>> +               if (bus_width == 8) {
>> +                       dev_info(dev, "Applying 8 bit bus width\n");
>> +                       host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>> +               }
>> +       }
>
> What if bus-width is not 8, or is not present?

In both cases, it will not touch host->mmc->caps at all. Then sdhci_add_host()
will handle it and set MMC_CAP_4_BIT_DATA as default:

[...]
/*
* A controller may support 8-bit width, but the board itself
* might not have the pins brought out.  Boards that support
* 8-bit width must set "mmc->caps |= MMC_CAP_8_BIT_DATA;" in
* their platform code before calling sdhci_add_host(), and we
* won't assume 8-bit width for hosts without that CAP.
*/
if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
mmc->caps |= MMC_CAP_4_BIT_DATA;
[...]

>
>> +
>> +       ret = mmc_of_parse_voltage(pdev->dev.of_node, &host->ocr_mask);
>> +       if (ret) {
>> +               dev_err(dev, "%s: parse voltage error\n", __func__);
>> +               goto err_voltage;
>> +       }
>> +
>> +       host->hw_name = DRIVER_NAME;
>> +       host->ops = &sdhci_f_sdh30_ops;
>> +       host->irq = irq;
>> +
>> +       host->ioaddr = of_iomap(pdev->dev.of_node, 0);
>> +       if (!host->ioaddr) {
>> +               dev_err(dev, "%s: failed to remap registers\n", __func__);
>> +               ret = -ENXIO;
>> +               goto err_remap;
>> +       }
>> +
>> +       priv->clk_sd4 = of_clk_get(pdev->dev.of_node, 0);
>> +       if (!IS_ERR(priv->clk_sd4)) {
>> +               ret = clk_prepare_enable(priv->clk_sd4);
>> +               if (ret < 0) {
>> +                       dev_err(dev, "Failed to enable sd4 clock: %d\n", ret);
>> +                       goto err_clk1;
>> +               }
>> +       }
>> +       priv->clk_b = of_clk_get(pdev->dev.of_node, 1);
>> +       if (!IS_ERR(priv->clk_b)) {
>> +               ret = clk_prepare_enable(priv->clk_b);
>> +               if (ret < 0) {
>> +                       dev_err(dev, "Failed to enable clk_b clock: %d\n", ret);
>> +                       goto err_clk2;
>> +               }
>> +       }
>
> Given you gave these names, get these by name rather than index. It's
> less surprising and more flexible.

Yes, I'll update them as below in next version.

-       priv->clk_sd4 = of_clk_get(pdev->dev.of_node, 0);
+       priv->clk_sd4 = clk_get(&pdev->dev, "sd_sd4clk");

-       priv->clk_b = of_clk_get(pdev->dev.of_node, 1);
+       priv->clk_b = clk_get(&pdev->dev, "sd_bclk");

Thanks a lot for your review!


Best regards,
Vincent Yang

>
> Thanks,
> Mark.

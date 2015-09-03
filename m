From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [RFC 3/3] mmc: sdhci-pxav3: Add ->voltage_switch callback support
Date: Fri, 4 Sep 2015 00:05:55 +0530
Message-ID: <55E8930B.1010309@linaro.org>
References: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135938-8056-4-git-send-email-vaibhav.hiremath@linaro.org>
 <55E6FEF5.9080905@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36190 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064AbbICSgC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2015 14:36:02 -0400
Received: by pacwi10 with SMTP id wi10so54210493pac.3
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2015 11:36:00 -0700 (PDT)
In-Reply-To: <55E6FEF5.9080905@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On Wednesday 02 September 2015 07:21 PM, Shawn Lin wrote:
> On 2015/9/2 3:32, Vaibhav Hiremath wrote:
>> In case PXA1928 family of devices, there is device/controller specific
>> configuration to control voltage/power on the IO pins.
>>
>> This patch implements and enables the sdhci_ops->voltage_switch()
>> callback api.
>> Note that IO pad register addresses are fetched as a memory resource.
>>
>> For example, in case of PXA1928 and family of devices, the DT property
>> would look something like,
>>
>> sdh1: sdh@d4280000 {
>>     compatible = "mrvl,pxav3-mmc";
>>     reg-names = "sdhci", "io-pwr", "io-pwr-lock-unlock";
>>     reg = <0xd4280000 0x120>,
>>         <0xd401e81c 4>,
>>         <0xd4015068 8>;
>>     ...
>> };
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   drivers/mmc/host/sdhci-pxav3.c | 59
>> ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c
>> b/drivers/mmc/host/sdhci-pxav3.c
>> index 5d26fe0..cebb2f9 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -63,11 +63,18 @@
>>   #define IO_PWR_AKEY_ASSAR        0xeb10
>>   #define IO_PWR_MMC1_PAD_1V8        BIT(2)
>>
>> +/* IO Power control */
>> +#define IO_PWR_AKEY_ASFAR        0xbaba
>> +#define IO_PWR_AKEY_ASSAR        0xeb10
>> +#define IO_PWR_MMC1_PAD_1V8        BIT(2)
>> +
>>   struct sdhci_pxa {
>>       struct clk *clk_core;
>>       struct clk *clk_io;
>>       u8    power_mode;
>>       void __iomem *sdio3_conf_reg;
>> +    void __iomem *io_pwr_reg;
>> +    void __iomem *io_pwr_lock_reg;
>>   };
>>
>>   /*
>> @@ -307,6 +314,38 @@ static void pxav3_set_uhs_signaling(struct
>> sdhci_host *host, unsigned int uhs)
>>           __func__, uhs, ctrl_2);
>>   }
>>
>> +static void pxav3_voltage_switch(struct sdhci_host *host,
>> +                        u8 signal_voltage)
>> +{
>> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +    struct sdhci_pxa *pxa = pltfm_host->priv;
>> +    unsigned int val;
>> +
>> +    if (!pxa->io_pwr_reg || !pxa->io_pwr_lock_reg)
>> +        return;
>> +
>> +    /* Lock register is 64 bit: First & Second access register */
>> +    writel(IO_PWR_AKEY_ASFAR, pxa->io_pwr_lock_reg);
>> +    writel(IO_PWR_AKEY_ASSAR, pxa->io_pwr_lock_reg + 4);
>> +    val = readl(pxa->io_pwr_reg);
>> +
>> +    switch (signal_voltage) {
>> +    case MMC_SIGNAL_VOLTAGE_180:
>> +    case MMC_SIGNAL_VOLTAGE_120:
>> +        val |= IO_PWR_MMC1_PAD_1V8;
>> +        break;
>> +    case MMC_SIGNAL_VOLTAGE_330:
>> +    default:
>> +        val &= ~IO_PWR_MMC1_PAD_1V8;
>> +        break;
>> +    }
>> +
>> +    writel(IO_PWR_AKEY_ASFAR, pxa->io_pwr_lock_reg);
>> +    writel(IO_PWR_AKEY_ASSAR, pxa->io_pwr_lock_reg + 4);
>> +
>> +    writel(val, pxa->io_pwr_reg);
>> +}
>> +
>>   static const struct sdhci_ops pxav3_sdhci_ops = {
>>       .set_clock            = sdhci_set_clock,
>>       .platform_send_init_74_clocks    = pxav3_gen_init_74_clocks,
>> @@ -314,6 +353,7 @@ static const struct sdhci_ops pxav3_sdhci_ops = {
>>       .set_bus_width            = sdhci_set_bus_width,
>>       .reset                = pxav3_reset,
>>       .set_uhs_signaling        = pxav3_set_uhs_signaling,
>> +    .voltage_switch            = pxav3_voltage_switch,
>>   };
>>
>>   static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
>> @@ -368,6 +408,7 @@ static int sdhci_pxav3_probe(struct
>> platform_device *pdev)
>>       struct sdhci_host *host = NULL;
>>       struct sdhci_pxa *pxa = NULL;
>>       const struct of_device_id *match;
>> +    struct resource *res;
>>       int ret;
>>
>>       pxa = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_pxa),
>> GFP_KERNEL);
>> @@ -408,6 +449,24 @@ static int sdhci_pxav3_probe(struct
>> platform_device *pdev)
>>               goto err_mbus_win;
>>       }
>>
>> +    res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> "io-pwr-conf");
>> +    if (res) {
>> +        pxa->io_pwr_reg = devm_ioremap_resource(&pdev->dev, res);
>> +        if (IS_ERR(pxa->io_pwr_reg)) {
>> +            ret = PTR_ERR(pxa->io_pwr_reg);
>> +            goto err_mbus_win;
>> +        }
>> +    }
>
> Hi Vaibhav,
>
> Why not get it from syscon and use regmap API to deal with it.
> IMO, that's okay, you can find examples from
> drivers/mmc/host/dw_mmc-k3.c: dw_mci_hi6220_switch_voltage
>
>

After looking more into this, things are not looking good to me -

PXA1928 (thats what I have details for) has different needs here,

The lock/unlock register located in apbc_clocks register space, and sysconf
will not be right place for it.

I think the approach which I took in this series looks better to me :)

Thanks,
Vaibhav


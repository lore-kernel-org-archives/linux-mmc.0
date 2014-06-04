From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH v2 2/3] mmc: Add APM X-Gene SoC SDHC controller support to
 Arasan SDHCI driver
Date: Wed, 4 Jun 2014 16:15:14 -0700
Message-ID: <CAPw-ZT=-_VkuUFN3RMrmOazPdOynmGHN86pP7ue5psOuDtjskg@mail.gmail.com>
References: <1401829985-5212-1-git-send-email-lho@apm.com>
	<1401829985-5212-2-git-send-email-lho@apm.com>
	<1401829985-5212-3-git-send-email-lho@apm.com>
	<9432f705-fd6a-44a6-8e04-c0455f0a551c@BN1AFFO11FD054.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:49572 "HELO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750944AbaFDXPP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 19:15:15 -0400
Received: by mail-qa0-f49.google.com with SMTP id cm18so292797qab.8
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2014 16:15:14 -0700 (PDT)
In-Reply-To: <9432f705-fd6a-44a6-8e04-c0455f0a551c@BN1AFFO11FD054.protection.gbl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: "chris@printf.net" <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jon Masters <jcm@redhat.com>, "patches@apm.com" <patches@apm.com>

Hi,

>>  #define SDHCI_ARASAN_CLK_CTRL_OFFSET 0x2c
>> @@ -34,6 +36,19 @@
>>   */
>>  struct sdhci_arasan_data {
>>       struct clk      *clk_ahb;
>> +     struct platform_device *pdev;
>> +     void __iomem    *ahb_aim_csr;
>> +     const struct sdhci_arasan_ahb_ops *ahb_ops;
>> +};
>> +
>> +/**
>> + * struct sdhci_arasan_ahb_ops
>> + * @init_ahb Initialize translation bus
>> + * @xlat_addr        Set up an 64-bit addressing translation
>
> This definitely breaking kernel-doc format. Please fix.

I will add the missing ":".

>> +                     sdhci_arasan->ahb_ops->xlat_addr(sdhci_arasan,
>> +                             sg_dma_address(host->data->sg));
>> +     }
>> +     writel(val, host->ioaddr + reg);
>> +}
>
> The same code was submitted in v1 and Arnd commented it but you are still keeping
> it here. Why?

I responded back to Arnd. If I move this code to IO MMU, what do I do
when we enable the actual IO MMU? The structure for the bus type only
has one IO MMU pointer. We would need to IO MMU pointer and not sure
how the IO MMU framework would handle this.

>
>> +
>>  static struct sdhci_ops sdhci_arasan_ops = {
>> +     .write_l = sdhci_arasan_writel,
>>       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>>       .get_timeout_clock = sdhci_arasan_get_timeout_clock,
>>  };
>> @@ -121,13 +150,83 @@ static int sdhci_arasan_resume(struct device *dev)
>>  static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
>>                        sdhci_arasan_resume);
>>
>> +static int sdhci_arasan_xgene_init_ahb(struct sdhci_arasan_data *data)
>> +{
>> +     #define AIM_SIZE_CTL_OFFSET     0x00000004
>> +     #define  AIM_EN_N_WR(src)       (((u32) (src) << 31) & 0x80000000)
>> +     #define  ARSB_WR(src)           (((u32) (src) << 24) & 0x0f000000)
>> +     #define  AWSB_WR(src)           (((u32) (src) << 20) & 0x00f00000)
>> +     #define  AIM_MASK_N_WR(src)     (((u32) (src)) & 0x000fffff)
>
> Remove that one more space between #define and name.
> I am not fan of having these defines just here - move them to the top.
>
> Also these macros are used just here at one location.
> Isn't it better just to define that BITS you want to setup instead of
> these macros which are hardly to read?

The only field that is single bit is AIM_EN_N_WR. All others are
multiple bit fields. Either I write them in the code or use these
defines. Would it be better if I just write them in the code?

>> +static void sdhci_arasn_xgene_xlat_addr(struct sdhci_arasan_data *data,
>> +                                    u64 dma_addr)
>> +{
>> +     #define AIM_AXI_HI_OFFSET       0x0000000c
>> +     #define  AIM_AXI_ADDRESS_HI_N_WR(src) \
>> +                                     (((u32) (src) << 20) & 0xfff00000)
>
> ditto with indentation.
> 20 should be shift
> 0xfff00000 is mask.
>
> Also you should take this opportunity and add function description
> in kernel doc to be exactly clear what this function is doing.

The function is pretty small, simply and don't believe it needs
function description.

>
>> +
>> +     if (!data->ahb_aim_csr)
>> +             return;
>> +
>> +     writel(AIM_AXI_ADDRESS_HI_N_WR(dma_addr >> 32),
>> +             data->ahb_aim_csr + AIM_AXI_HI_OFFSET);
>> +}
>> +
>> +static const struct sdhci_arasan_ahb_ops xgene_ahb_ops = {
>> +     .init_ahb = sdhci_arasan_xgene_init_ahb,
>> +     .xlat_addr = sdhci_arasn_xgene_xlat_addr,
>> +};
>> +
>> +static const struct of_device_id sdhci_arasan_of_match[] = {
>> +     { .compatible = "arasan,sdhci-8.9a" },
>> +     { .compatible = "apm,arasan,sdhci-8.9a", .data = &xgene_ahb_ops },
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
>> +
>>  static int sdhci_arasan_probe(struct platform_device *pdev)
>>  {
>>       int ret;
>> -     struct clk *clk_xin;
>> +     struct clk *clk_xin = NULL;
>>       struct sdhci_host *host;
>>       struct sdhci_pltfm_host *pltfm_host;
>>       struct sdhci_arasan_data *sdhci_arasan;
>> +     const struct of_device_id *of_id =
>> +                     of_match_device(sdhci_arasan_of_match, &pdev->dev);
>> +     struct resource *res;
>>
>>       sdhci_arasan = devm_kzalloc(&pdev->dev, sizeof(*sdhci_arasan),
>>                       GFP_KERNEL);
>> @@ -136,8 +235,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>
>>       sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
>>       if (IS_ERR(sdhci_arasan->clk_ahb)) {
>> -             dev_err(&pdev->dev, "clk_ahb clock not found.\n");
>> -             return PTR_ERR(sdhci_arasan->clk_ahb);
>> +             /* Clock is optional */
>> +             sdhci_arasan->clk_ahb = NULL;
>> +             goto skip_clk;
>
> Clocks are optional for your SoC but they are necessary for Zynq.
> You can't just skip clocks for zynq because if DT is wrong clocks won't be enabled
> and even checked.
> Does it mean that there are no clocks for this IP?

The clock for X-Gene is enabled by the time Linux boot. As the clock
in programmed in the SDHC register, it knows the clock frequency.

> Or do you miss clock driver?

The clock will be configured by the FW and left out intentionally as
this will also support ACPI boot.

-Loc

From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: Re: [PATCH V2 2/4] mmc: sdhci-msm: Add msm version specific ops and
 data structures
Date: Fri, 15 Jun 2018 10:26:45 +0530
Message-ID: <a6458995-a9ba-341e-425d-2092461d9626@codeaurora.org>
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-3-git-send-email-vviswana@codeaurora.org>
 <152884658650.16708.8327586252448186103@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152884658650.16708.8327586252448186103@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>, adrian.hunter@intel.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Hi Stephen,

On 6/13/2018 5:06 AM, Stephen Boyd wrote:
> Quoting Vijay Viswanath (2018-05-29 02:52:39)
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 4050c99..2a66aa0 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -226,6 +226,24 @@ struct sdhci_msm_offset {
>>          .core_ddr_config_2 = 0x1bc,
>>   };
>>   
>> +struct sdhci_msm_variant_ops {
>> +       u8 (*msm_readb_relaxed)(struct sdhci_host *host, u32 offset);
>> +       u32 (*msm_readl_relaxed)(struct sdhci_host *host, u32 offset);
>> +       void (*msm_writeb_relaxed)(u8 val, struct sdhci_host *host, u32 offset);
>> +       void (*msm_writel_relaxed)(u32 val, struct sdhci_host *host,
>> +                       u32 offset);
>> +};
>> +
>> +/*
>> + * From V5, register spaces have changed. Wrap this info in a structure
>> + * and choose the data_structure based on version info mentioned in DT.
>> + */
> 
> This is sort of odd. Usually we have a read/write function that swizzles
> based on register variants, and that's contained with that function. Now
> it's the other way.
> 
>> +struct sdhci_msm_variant_info {
>> +       bool mci_removed;
>> +       const struct sdhci_msm_variant_ops *var_ops;
>> +       const struct sdhci_msm_offset *offset;
>> +};
>> +
>>   struct sdhci_msm_host {
>>          struct platform_device *pdev;
>>          void __iomem *core_mem; /* MSM SDCC mapped address */
>> @@ -245,8 +263,45 @@ struct sdhci_msm_host {
>>          wait_queue_head_t pwr_irq_wait;
>>          bool pwr_irq_flag;
>>          u32 caps_0;
>> +       bool mci_removed;
>> +       const struct sdhci_msm_variant_ops *var_ops;
>> +       const struct sdhci_msm_offset *offset;
>>   };
>>   
>> +/*
>> + * APIs to read/write to vendor specific registers which were there in the
>> + * core_mem region before MCI was removed.
>> + */
>> +static u32 sdhci_msm_mci_variant_readl_relaxed(struct sdhci_host *host,
>> +               u32 offset)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       return readl_relaxed(msm_host->core_mem + offset);
> 
> Is core_mem assigned in the new hardware? Maybe that needs to be
> 'repurposed' for vendor specific registers on v5 and renamed to
> something like msm_host::vendor_base or something like that.
> 

There is no core_mem in the new hardware. We can assign hc_mem address 
to core_mem variable (if SDCC5) and do away with the need of special 
read/write functions, but I feel thats a bad approach and misleading.

>> +}
>> +
>> +static u32 sdhci_msm_v5_variant_readl_relaxed(struct sdhci_host *host,
>> +               u32 offset)
>> +{
>> +       return readl_relaxed(host->ioaddr + offset);
>> +}
>> +
>> +static void sdhci_msm_mci_variant_writel_relaxed(u32 val,
>> +               struct sdhci_host *host, u32 offset)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       writel_relaxed(val, msm_host->core_mem + offset);
>> +}
>> +
>> +static void sdhci_msm_v5_variant_writel_relaxed(u32 val,
>> +               struct sdhci_host *host, u32 offset)
>> +{
>> +       writel_relaxed(val, host->ioaddr + offset);
>> +}
>> +
>>   static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
>>                                                      unsigned int clock)
>>   {
>> @@ -1481,6 +1536,28 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>>          pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
>>   }
>>   
>> +static const struct sdhci_msm_variant_ops mci_var_ops = {
>> +       .msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
>> +       .msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
>> +};
>> +
>> +static const struct sdhci_msm_variant_ops v5_var_ops = {
>> +       .msm_readl_relaxed = sdhci_msm_v5_variant_readl_relaxed,
>> +       .msm_writel_relaxed = sdhci_msm_v5_variant_writel_relaxed,
>> +};
>> +
>> +static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
>> +       .mci_removed = 0,
> 
> Please use true and false instead of 0 and 1 when the type is bool.
>

Will do

>> +       .var_ops = &mci_var_ops,
>> +       .offset = &sdhci_msm_mci_offset,
>> +};
>> +
>> +static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
>> +       .mci_removed = 1,
>> +       .var_ops = &v5_var_ops,
>> +       .offset = &sdhci_msm_v5_offset,
>> +};
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

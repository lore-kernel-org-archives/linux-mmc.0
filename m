From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Properly set corecfg_clockmultipler
 on rk3399
Date: Fri, 26 Aug 2016 15:50:57 +0800
Message-ID: <d6c3b728-af01-e724-3278-1bc0801f8fb4@rock-chips.com>
References: <1472181736-17848-1-git-send-email-shawn.lin@rock-chips.com>
 <1dc7898d-ee35-4166-6313-64e9c50f8db8@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:60564 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbcHZHvY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2016 03:51:24 -0400
In-Reply-To: <1dc7898d-ee35-4166-6313-64e9c50f8db8@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziyuan Xu <xzy.xu@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>

+ Heiko

在 2016/8/26 14:38, Ziyuan Xu 写道:
> Hi Shawn,
>
>
> On 2016年08月26日 11:22, Shawn Lin wrote:
>> corecfg_clockmultipler indicates clock multiplier value of
>> programmable clock generator which should be the same value
>> of SDHCI_CAPABILITIES_1. The default value of the register,
>> corecfg_clockmultipler, is 0x10. But actually it is a mistake
> corecfg_clockmultipler==>corecfg_clockmultiplier
>> by designer as our intention was to set it to be zero which
>> means we don't support programmable clock generator. So we have
>> to made it to be zero on bootloader which seems work fine until
> made==>make
>> now. But now we find a issue that when deploying genpd support
> a issue==>an issue
>> for it, the remove callback will trigger the genpd to poweroff the
>> power domain for sdhci-of-arasan which magage the controller, phy
> magage==>manage
>> and corecfg_* stuff.
>>
>> So when we do bind/unbind the driver, we have already reinit
> do==>doing
>> the controller and phy, but without doing that for corecfg_*.
>> Regarding to only the corecfg_clockmultipler is wrong, let's
>> fix it by explicitly marking it to be zero when probing. With
>> this change, we could do bind/unbind successfully.
>>
>> Reported-by: Ziyuan Xu <xzy.xu@rock-chips.com>
>> Cc: Douglas Anderson <dianders@chromium.org>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/mmc/host/sdhci-of-arasan.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>> b/drivers/mmc/host/sdhci-of-arasan.c
>> index 0b3a9cf..c1eb263 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -67,10 +67,12 @@ struct sdhci_arasan_soc_ctl_field {
>>    * accessible via the syscon API.
>>    *
>>    * @baseclkfreq:    Where to find corecfg_baseclkfreq
>> + * @clockmultiplier:    Where to find corecfg_clockmultiplier
>>    * @hiword_update:    If true, use HIWORD_UPDATE to access the syscon
>>    */
>>   struct sdhci_arasan_soc_ctl_map {
>>       struct sdhci_arasan_soc_ctl_field    baseclkfreq;
>> +    struct sdhci_arasan_soc_ctl_field    clockmultiplier;
>>       bool                    hiword_update;
>>   };
>>   @@ -100,6 +102,7 @@ struct sdhci_arasan_data {
>>     static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
>>       .baseclkfreq = { .reg = 0xf000, .width = 8, .shift = 8 },
>> +    .clockmultiplier = { .reg = 0xf02c, .width = 8, .shit = 0},
>>       .hiword_update = true,
>>   };
>>   @@ -528,6 +531,12 @@ static int sdhci_arasan_probe(struct
>> platform_device *pdev)
>>                       ret);
>>               goto err_pltfm_free;
>>           }
>> +
>> +        if (of_device_is_compatible(pdev->dev.of_node,
>> +                        "rockchip,rk3399-sdhci-5.1"))
>> +            sdhci_arasan_syscon_write(host,
>> +                          &soc_ctl_map->clockmultiplier,
>> +                          0);
> Variable soc_ctl_map is undefined in sdhci_arasan_probe(), please fix it.

Woops, I change the code a bit after generating patch, I will fix it.

> Moreover, we can not access grf_emmccore/grf_emmcphy prior to enable
> clk_ahb, so do it after clock enable.

Hrmm, we configure the grf vai CPU and the clock for accessing
grf is aclk_emmc_grf( I saw aclk_emmc_noc is critical and it seems we
should treat aclk_emmc_* the same way). I could move this after
enabling aclk_emmc, but that is a bogus critical for aclk_emmc_* to me 
since it's off when disabling aclk_emmc, no?


>>       }
>>         sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Best Regards
Shawn Lin


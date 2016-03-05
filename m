From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RESEND PATCH v5 2/2] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Sat, 5 Mar 2016 09:55:49 +0800
Message-ID: <56DA3CA5.8020909@rock-chips.com>
References: <1455848322-2210-1-git-send-email-shawn.lin@rock-chips.com>
 <1455848420-2293-1-git-send-email-shawn.lin@rock-chips.com>
 <56D951F9.6060602@intel.com> <56D96259.20207@rock-chips.com>
 <56D97BA8.7090302@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:45899 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759066AbcCEB4N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 20:56:13 -0500
In-Reply-To: <56D97BA8.7090302@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Adrian,

On 2016/3/4 20:12, Adrian Hunter wrote:

[...]

>>>
>>> I don't know that disabling clocks is necessarily the right thing to do if
>>> the resume fails.  You might want to consider what happens if the system
>>> tries to use the device when it is in that state.  It's been a long time
>>> since I did any ARM work but aren't you risking bus errors.  Might just as
>>> well not bother and save a few lines of code.
>>>
>>
>> Firstly, I really just follow the orginal err handle.
>> It's risking bus errors if disabling ahb clk, but ahb clk is most very
>> likely to shared by many controllers. So regarding to the clk reference
>> count, the ahb_clk is not *really* disabled and just decrease the
>> reference count. How about keep these handles here?
>
> I would remove the error handling on the grounds that it does not do
> anything useful.

Take another ronud of thinking it, probably you are right. When failing
to resume from deelp sleep, we return err to dpm. dpm still roll-forward
to wakeup by calling resume callback one-by-one. It means that finally
when system in wakeup state with disabled ahb_clk, but we then going to
access mmc as normal, which is not acceptable. Especially for debuging
the failure, we have to enable ahb_clk manually.

Will remove the error handling.

Thanks.

>
>>
>>
>>>> +    return ret;
>>>>    }
>>>>    #endif /* ! CONFIG_PM_SLEEP */
>>>>
>>>> @@ -183,6 +207,30 @@ static int sdhci_arasan_probe(struct platform_device
>>>> *pdev)
>>>>            goto clk_disable_all;
>>>>        }
>>>>
>>>> +    sdhci_arasan->phy = ERR_PTR(-ENODEV);
>>>> +    if (of_device_is_compatible(pdev->dev.of_node,
>>>> +                    "arasan,sdhci-5.1")) {
>>>> +        sdhci_arasan->phy = devm_phy_get(&pdev->dev,
>>>> +                         "phy_arasan");
>>>> +        if (IS_ERR(sdhci_arasan->phy)) {
>>>> +            ret = PTR_ERR(sdhci_arasan->phy);
>>>> +            dev_err(&pdev->dev, "No phy for arasan,sdhci-5.1.\n");
>>>> +            goto clk_disable_all;
>>>> +        }
>>>> +
>>>> +        ret = phy_init(sdhci_arasan->phy);
>>>> +        if (ret < 0) {
>>>> +            dev_err(&pdev->dev, "phy_init err.\n");
>>>> +            goto clk_disable_all;
>>>> +        }
>>>> +
>>>> +        ret = phy_power_on(sdhci_arasan->phy);
>>>> +        if (ret < 0) {
>>>> +            dev_err(&pdev->dev, "phy_power_on err.\n");
>>>> +            goto err_phy_power;
>>>> +        }
>>>> +    }
>>>> +
>>>>        ret = sdhci_add_host(host);
>>>>        if (ret)
>>>>            goto err_pltfm_free;
>>>> @@ -190,7 +238,12 @@ static int sdhci_arasan_probe(struct platform_device
>>>> *pdev)
>>>>        return 0;
>>>>
>>>>    err_pltfm_free:
>>>> +    if (!IS_ERR(sdhci_arasan->phy))
>>>> +        phy_power_off(sdhci_arasan->phy);
>>>>        sdhci_pltfm_free(pdev);
>>>> +err_phy_power:
>>>> +    if (!IS_ERR(sdhci_arasan->phy))
>>>
>>> Looks like you are using sdhci_arasan after it has been free'd by
>>> sdhci_pltfm_free().
>>>
>>> Also there seem to be cases where sdhci_arasan_probe() can exit after
>>> sdhci_pltfm_init() without calling sdhci_pltfm_free().
>>
>> Good catch, will fix it.
>>
>>>
>>>> +        phy_exit(sdhci_arasan->phy);
>>>>    clk_disable_all:
>>>>        clk_disable_unprepare(clk_xin);
>>>>    clk_dis_ahb:
>>>> @@ -205,6 +258,11 @@ static int sdhci_arasan_remove(struct
>>>> platform_device *pdev)
>>>>        struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>        struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
>>>>
>>>> +    if (!IS_ERR(sdhci_arasan->phy)) {
>>>> +        phy_power_off(sdhci_arasan->phy);
>>>> +        phy_exit(sdhci_arasan->phy);
>>>> +    }
>>>> +
>>>
>>> When you re-base, take care to keep this chunk above
>>> sdhci_pltfm_unregister().
>>
>> sure.
>>
>> Thanks for reviewing it.
>>
>>>
>>>>        clk_disable_unprepare(sdhci_arasan->clk_ahb);
>>>>
>>>>        return sdhci_pltfm_unregister(pdev);
>>>>
>>>
>>>
>>>
>>>
>>
>>
>
>
>
>


-- 
Best Regards
Shawn Lin


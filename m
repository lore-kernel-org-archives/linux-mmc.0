From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [RESEND PATCH v5 2/2] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Fri, 4 Mar 2016 18:24:25 +0800
Message-ID: <56D96259.20207@rock-chips.com>
References: <1455848322-2210-1-git-send-email-shawn.lin@rock-chips.com>
 <1455848420-2293-1-git-send-email-shawn.lin@rock-chips.com>
 <56D951F9.6060602@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56D951F9.6060602-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 2016/3/4 17:14, Adrian Hunter wrote:
> On 19/02/16 04:20, Shawn Lin wrote:
>> This patch adds Generic PHY access for sdhci-of-arasan. Driver

[...]

>>   /**
>>    * sdhci_arasan_suspend - Suspend method for the driver
>>    * @dev:	Address of the device structure
>> - * Returns 0 on success and error value on error
>> + * Return: 0 on success and error value on error
>
> Really should be a separate patch for the comment fixes.

yep, I won't touch it when I rebase my patch for this topic.

>
>>    *
>>    * Put the device in a low power state.
>>    */
>> @@ -88,6 +91,14 @@ static int sdhci_arasan_suspend(struct device *dev)
>>   	if (ret)
>>   		return ret;
>>
>> +	if (!IS_ERR(sdhci_arasan->phy)) {
>> +		ret = phy_power_off(sdhci_arasan->phy);
>> +		if (ret) {
>> +			dev_err(dev, "Cannot power off phy.\n");
>
> I would expect you ought to call sdhci_resume_host() here.

oh, got it.

>
>> +			return ret;
>> +		}
>> +	}
>> +
>>   	clk_disable(pltfm_host->clk);
>>   	clk_disable(sdhci_arasan->clk_ahb);
>>
>> @@ -97,7 +108,7 @@ static int sdhci_arasan_suspend(struct device *dev)
>>   /**
>>    * sdhci_arasan_resume - Resume method for the driver
>>    * @dev:	Address of the device structure
>> - * Returns 0 on success and error value on error
>> + * Return: 0 on success and error value on error
>>    *
>>    * Resume operation after suspend
>>    */
>> @@ -118,11 +129,24 @@ static int sdhci_arasan_resume(struct device *dev)
>>   	ret = clk_enable(pltfm_host->clk);
>>   	if (ret) {
>>   		dev_err(dev, "Cannot enable SD clock.\n");
>> -		clk_disable(sdhci_arasan->clk_ahb);
>> -		return ret;
>> +		goto err_clk_en;
>> +	}
>> +
>> +	if (!IS_ERR(sdhci_arasan->phy)) {
>> +		ret = phy_power_on(sdhci_arasan->phy);
>> +		if (ret) {
>> +			dev_err(dev, "Cannot power on phy.\n");
>> +			goto err_phy_power;
>> +		}
>>   	}
>>
>>   	return sdhci_resume_host(host);
>> +
>> +err_phy_power:
>> +	clk_disable(pltfm_host->clk);
>> +err_clk_en:
>> +	clk_disable(sdhci_arasan->clk_ahb);
>
> I don't know that disabling clocks is necessarily the right thing to do if
> the resume fails.  You might want to consider what happens if the system
> tries to use the device when it is in that state.  It's been a long time
> since I did any ARM work but aren't you risking bus errors.  Might just as
> well not bother and save a few lines of code.
>

Firstly, I really just follow the orginal err handle.
It's risking bus errors if disabling ahb clk, but ahb clk is most very
likely to shared by many controllers. So regarding to the clk reference
count, the ahb_clk is not *really* disabled and just decrease the
reference count. How about keep these handles here?


>> +	return ret;
>>   }
>>   #endif /* ! CONFIG_PM_SLEEP */
>>
>> @@ -183,6 +207,30 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>   		goto clk_disable_all;
>>   	}
>>
>> +	sdhci_arasan->phy = ERR_PTR(-ENODEV);
>> +	if (of_device_is_compatible(pdev->dev.of_node,
>> +				    "arasan,sdhci-5.1")) {
>> +		sdhci_arasan->phy = devm_phy_get(&pdev->dev,
>> +						 "phy_arasan");
>> +		if (IS_ERR(sdhci_arasan->phy)) {
>> +			ret = PTR_ERR(sdhci_arasan->phy);
>> +			dev_err(&pdev->dev, "No phy for arasan,sdhci-5.1.\n");
>> +			goto clk_disable_all;
>> +		}
>> +
>> +		ret = phy_init(sdhci_arasan->phy);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev, "phy_init err.\n");
>> +			goto clk_disable_all;
>> +		}
>> +
>> +		ret = phy_power_on(sdhci_arasan->phy);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev, "phy_power_on err.\n");
>> +			goto err_phy_power;
>> +		}
>> +	}
>> +
>>   	ret = sdhci_add_host(host);
>>   	if (ret)
>>   		goto err_pltfm_free;
>> @@ -190,7 +238,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>   	return 0;
>>
>>   err_pltfm_free:
>> +	if (!IS_ERR(sdhci_arasan->phy))
>> +		phy_power_off(sdhci_arasan->phy);
>>   	sdhci_pltfm_free(pdev);
>> +err_phy_power:
>> +	if (!IS_ERR(sdhci_arasan->phy))
>
> Looks like you are using sdhci_arasan after it has been free'd by
> sdhci_pltfm_free().
>
> Also there seem to be cases where sdhci_arasan_probe() can exit after
> sdhci_pltfm_init() without calling sdhci_pltfm_free().

Good catch, will fix it.

>
>> +		phy_exit(sdhci_arasan->phy);
>>   clk_disable_all:
>>   	clk_disable_unprepare(clk_xin);
>>   clk_dis_ahb:
>> @@ -205,6 +258,11 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>   	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
>>
>> +	if (!IS_ERR(sdhci_arasan->phy)) {
>> +		phy_power_off(sdhci_arasan->phy);
>> +		phy_exit(sdhci_arasan->phy);
>> +	}
>> +
>
> When you re-base, take care to keep this chunk above sdhci_pltfm_unregister().

sure.

Thanks for reviewing it.

>
>>   	clk_disable_unprepare(sdhci_arasan->clk_ahb);
>>
>>   	return sdhci_pltfm_unregister(pdev);
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

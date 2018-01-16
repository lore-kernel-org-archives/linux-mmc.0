From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add CQHCI support for
 arasan,sdhci-5.1
Date: Tue, 16 Jan 2018 11:46:41 +0800
Message-ID: <740e75a7-fb0b-b1e6-1473-2a06dfae5bb7@rock-chips.com>
References: <1515739370-102434-1-git-send-email-shawn.lin@rock-chips.com>
 <0eb8b184-f8e1-0d8b-6845-1bc961282321@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:56743 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbeAPDqw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jan 2018 22:46:52 -0500
In-Reply-To: <0eb8b184-f8e1-0d8b-6845-1bc961282321@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>

Hi Adrian,

On 2018/1/15 21:38, Adrian Hunter wrote:
> On 12/01/18 08:42, Shawn Lin wrote:
>> Add CQHCI initialization and implement CQHCI operations for Arasan

[...]

>> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> 
> Did you intend to leave out 	.set_power = sdhci_arasan_set_power,

My bad. will add it in v2.

> 
>> +	.irq = sdhci_arasan_cqhci_irq,
>> +};
>> +
>> +static struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>> +	.ops = &sdhci_arasan_cqe_ops,
>> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>> +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>> +};
>> +
>>   #ifdef CONFIG_PM_SLEEP
>>   /**
>>    * sdhci_arasan_suspend - Suspend method for the driver
>> @@ -309,6 +367,12 @@ static int sdhci_arasan_suspend(struct device *dev)
>>   	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>>   		mmc_retune_needed(host->mmc);
>>   
>> +	if (sdhci_arasan->has_cqe) {
>> +		ret = cqhci_suspend(host->mmc);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	ret = sdhci_suspend_host(host);
>>   	if (ret)
>>   		return ret;
>> @@ -365,10 +429,18 @@ static int sdhci_arasan_resume(struct device *dev)
>>   		sdhci_arasan->is_phy_on = true;
>>   	}
>>   
>> -	return sdhci_resume_host(host);
>> +	ret = sdhci_resume_host(host);
>> +	if (ret) {
>> +		dev_err(dev, "Cannot resume host.\n");
>> +		return ret;
>> +	}
>> +
>> +	if (sdhci_arasan->has_cqe)
>> +		return cqhci_resume(host->mmc);
>> +
>> +	return 0;
>>   }
>>   #endif /* ! CONFIG_PM_SLEEP */
>> -
> 
> Better with that blank line left there
> 
>>   static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
>>   			 sdhci_arasan_resume);
>>   
>> @@ -568,6 +640,49 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
>>   	of_clk_del_provider(dev->of_node);
>>   }
>>   
>> +static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
>> +{
>> +	struct sdhci_host *host = sdhci_arasan->host;
>> +	struct cqhci_host *cq_host;
>> +	bool dma64;
>> +	int ret;
>> +
>> +	if (!sdhci_arasan->has_cqe)
>> +		return sdhci_add_host(host);
>> +
>> +	ret = sdhci_setup_host(host);
>> +	if (ret)
>> +		return ret;
>> +
>> +	cq_host = devm_kzalloc(host->mmc->parent,
>> +			       sizeof(*cq_host), GFP_KERNEL);
>> +	if (!cq_host) {
>> +		ret = -ENOMEM;
>> +		goto cleanup;
>> +	}
>> +
>> +	cq_host->mmio = host->ioaddr + SDHCI_ARASAN_CQE_BASE_ADDR;
>> +	cq_host->ops = &sdhci_arasan_cqhci_ops;
>> +
>> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
>> +	if (dma64)
>> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
>> +
>> +	ret = cqhci_init(cq_host, host->mmc, dma64);
>> +	if (ret)
>> +		goto cleanup;
>> +
>> +	ret = __sdhci_add_host(host);
>> +	if (ret)
>> +		goto cleanup;
>> +
>> +	return 0;
>> +
>> +cleanup:
>> +	sdhci_cleanup_host(host);
>> +	return ret;
>> +}
>> +
>>   static int sdhci_arasan_probe(struct platform_device *pdev)
>>   {
>>   	int ret;
>> @@ -579,8 +694,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>   	struct sdhci_arasan_data *sdhci_arasan;
>>   	struct device_node *np = pdev->dev.of_node;
>>   
>> -	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
>> -				sizeof(*sdhci_arasan));
>> +	if (of_device_is_compatible(pdev->dev.of_node,
>> +				    "arasan,sdhci-5.1"))
> 
> Unneeded line wrap
> 
>> +		host = sdhci_pltfm_init(pdev, &sdhci_arasan_cqe_pdata,
>> +					sizeof(*sdhci_arasan));
>> +	else
>> +		host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
>> +					sizeof(*sdhci_arasan));
> 
> Perhaps slightly prettier to assign pdata e.g.
> 
> 	const struct sdhci_pltfm_data *pdata;
> 
> 	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-5.1"))
> 		pdata = &sdhci_arasan_cqe_pdata;
> 	else
> 		pdata = &&sdhci_arasan_pdata;
> 
> 	host = sdhci_pltfm_init(pdev, pdata, sizeof(*sdhci_arasan));
> 

Looks good.

>> +
>>   	if (IS_ERR(host))
>>   		return PTR_ERR(host);
>>   
>> @@ -675,9 +796,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>   					sdhci_arasan_hs400_enhanced_strobe;
>>   		host->mmc_host_ops.start_signal_voltage_switch =
>>   					sdhci_arasan_voltage_switch;
>> +		sdhci_arasan->has_cqe = true;
>> +		host->mmc->caps2 |= (MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
> 
> The parentheses are not needed

okay.

> 
>>   	}
>>   
>> -	ret = sdhci_add_host(host);
>> +	ret = sdhci_arasan_add_host(sdhci_arasan);
>>   	if (ret)
>>   		goto err_add_host;
>>   
>>
> 
> 
> 
> 


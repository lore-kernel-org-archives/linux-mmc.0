From: Zhoujie Wu <zjwu@marvell.com>
Subject: Re: [PATCH v2] mmc: sdhci-xenon: add runtime pm support and reimplement
 standby
Date: Tue, 29 Aug 2017 11:52:26 -0700
Message-ID: <59A5B7EA.7090300@marvell.com>
References: <1503946540-30777-1-git-send-email-zjwu@marvell.com>
 <e85b2790-292f-7efa-c42d-af3a2e061d22@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:60775 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751186AbdH2Swa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Aug 2017 14:52:30 -0400
In-Reply-To: <e85b2790-292f-7efa-c42d-af3a2e061d22@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, xswang@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com



On 08/28/2017 11:48 PM, Adrian Hunter wrote:
> On 28/08/17 21:55, Zhoujie Wu wrote:
>> Enable runtime pm support for xenon controller, which uses 50ms
>> auto runtime suspend by default.
>> Reimplement system standby based on runtime pm API.
>> Introduce restore_needed to restore the Xenon specific registers
>> when resume.
>>
>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> There are a few small comments below.
Thanks for your comments, updated per your suggestion.
>
>> ---
>> v2: Combined two previous patches(runtime pm support and reimplement standby)
>> to one according to the suggestion from Adrian.
>>
>>   drivers/mmc/host/sdhci-xenon.c | 76 ++++++++++++++++++++++++++++++++----------
>>   drivers/mmc/host/sdhci-xenon.h |  1 +
>>   2 files changed, 60 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
>> index 306ffaf..f97a78e 100644
>> --- a/drivers/mmc/host/sdhci-xenon.c
>> +++ b/drivers/mmc/host/sdhci-xenon.c
>> @@ -18,6 +18,8 @@
>>   #include <linux/ktime.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/pm.h>
>> +#include <linux/pm_runtime.h>
>>   
>>   #include "sdhci-pltfm.h"
>>   #include "sdhci-xenon.h"
>> @@ -506,13 +508,24 @@ static int xenon_probe(struct platform_device *pdev)
>>   	if (err)
>>   		goto err_clk;
>>   
>> +	pm_runtime_get_noresume(&pdev->dev);
>> +	pm_runtime_set_active(&pdev->dev);
>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>> +	pm_runtime_use_autosuspend(&pdev->dev);
>> +	pm_runtime_enable(&pdev->dev);
> I would expect to see a corresponding pm_runtime_disable() in xenon_remove()
> e.g.
>
> 	pm_runtime_get_sync(dev);
> 	pm_runtime_disable(dev);
> 	pm_runtime_put_noidle(dev);
>
> 	sdhci_remove_host(host, 0);
>
>> +	pm_suspend_ignore_children(&pdev->dev, 1);
>> +
>>   	err = sdhci_add_host(host);
>>   	if (err)
>>   		goto remove_sdhc;
>>   
>> +	pm_runtime_put_autosuspend(&pdev->dev);
>> +
>>   	return 0;
>>   
>>   remove_sdhc:
>> +	pm_runtime_disable(&pdev->dev);
>> +	pm_runtime_put_noidle(&pdev->dev);
>>   	xenon_sdhc_unprepare(host);
>>   err_clk:
>>   	clk_disable_unprepare(pltfm_host->clk);
>> @@ -542,40 +555,69 @@ static int xenon_suspend(struct device *dev)
>>   {
>>   	struct sdhci_host *host = dev_get_drvdata(dev);
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>   	int ret;
>>   
>> -	ret = sdhci_suspend_host(host);
>> -	if (ret)
>> -		return ret;
>> +	ret = pm_runtime_force_suspend(dev);
>>   
>> -	clk_disable_unprepare(pltfm_host->clk);
>> +	priv->restore_needed = true;
>>   	return ret;
>>   }
>> +#endif
>>   
>> -static int xenon_resume(struct device *dev)
>> +#ifdef CONFIG_PM
>> +static int xenon_runtime_suspend(struct device *dev)
>>   {
>>   	struct sdhci_host *host = dev_get_drvdata(dev);
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>   	int ret;
>>   
>> -	ret = clk_prepare_enable(pltfm_host->clk);
>> -	if (ret)
>> -		return ret;
>> +	ret = sdhci_runtime_suspend_host(host);
> Return on error.
>
>> +
>> +	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>> +		mmc_retune_needed(host->mmc);
>>   
>> +	clk_disable_unprepare(pltfm_host->clk);
>>   	/*
>> -	 * If SoCs power off the entire Xenon, registers setting will
>> -	 * be lost.
>> -	 * Re-configure Xenon specific register to enable current SDHC
>> +	 * Need to update the priv->clock here, or when runtime resume
>> +	 * back, phy don't aware the clock change and won't adjust phy
>> +	 * which will cause cmd err
>>   	 */
>> -	ret = xenon_sdhc_prepare(host);
>> -	if (ret)
>> +	priv->clock = 0;
>> +	return ret;
>> +}
>> +
>> +static int xenon_runtime_resume(struct device *dev)
>> +{
>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(pltfm_host->clk);
>> +	if (ret) {
>> +		dev_err(dev, "can't enable mainck\n");
>>   		return ret;
>> +	}
>> +
>> +	if (priv->restore_needed) {
>> +		xenon_sdhc_prepare(host);
> Check for error and then clk_disable_unprepare()
>
>> +		priv->restore_needed = false;
>> +	}
>>   
>> -	return sdhci_resume_host(host);
>> +	return sdhci_runtime_resume_host(host);
> Check for error and then clk_disable_unprepare()
>
>>   }
>> -#endif
>> +#endif /* CONFIG_PM */
>> +
>> +static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(xenon_suspend,
>> +				pm_runtime_force_resume)
>> +	SET_RUNTIME_PM_OPS(xenon_runtime_suspend,
>> +			   xenon_runtime_resume,
>> +			   NULL)
>> +};
>>   
>> -static SIMPLE_DEV_PM_OPS(xenon_pmops, xenon_suspend, xenon_resume);
> This leaves two blank lines.
>
>>   
>>   static const struct of_device_id sdhci_xenon_dt_ids[] = {
>>   	{ .compatible = "marvell,armada-ap806-sdhci",},
>> @@ -589,7 +631,7 @@ static int xenon_resume(struct device *dev)
>>   	.driver	= {
>>   		.name	= "xenon-sdhci",
>>   		.of_match_table = sdhci_xenon_dt_ids,
>> -		.pm = &xenon_pmops,
>> +		.pm = &sdhci_xenon_dev_pm_ops,
>>   	},
>>   	.probe	= xenon_probe,
>>   	.remove	= xenon_remove,
>> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
>> index 01937f1..2bc0510 100644
>> --- a/drivers/mmc/host/sdhci-xenon.h
>> +++ b/drivers/mmc/host/sdhci-xenon.h
>> @@ -91,6 +91,7 @@ struct xenon_priv {
>>   	 */
>>   	void		*phy_params;
>>   	struct xenon_emmc_phy_regs *emmc_phy_regs;
>> +	bool restore_needed;
>>   };
>>   
>>   int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
>>


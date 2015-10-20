From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 3/3] mmc: sdhci-of-arasan: add runtime pm support
Date: Tue, 20 Oct 2015 16:41:22 +0800
Message-ID: <5625FE32.9050506@rock-chips.com>
References: <1445324727-31448-1-git-send-email-shawn.lin@rock-chips.com>
 <5625F544.8000600@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5625F544.8000600@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, soren.brinkmann@xilinx.com
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2015/10/20 16:03, Michal Simek wrote:
> Hi,
>
> On 10/20/2015 09:05 AM, Shawn Lin wrote:
>> This patch add runtime_suspend and runtime_resume for
>> sdhci-of-arasan. Currently we also suspend phy at
>> runtime_suspend for power-saving.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/mmc/host/sdhci-of-arasan.c | 80 ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 77 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index 85bd0f9d..579f7bb 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -30,6 +30,8 @@
>>   #define CLK_CTRL_TIMEOUT_MASK		(0xf << CLK_CTRL_TIMEOUT_SHIFT)
>>   #define CLK_CTRL_TIMEOUT_MIN_EXP	13
>>
>> +#define ARASAN_RPM_DELAY_MS		50
>> +
>>   /**
>>    * struct sdhci_arasan_data
>>    * @clk_ahb:	Pointer to the AHB clock
>> @@ -183,8 +185,70 @@ static int sdhci_arasan_resume(struct device *dev)
>>   }
>>   #endif /* ! CONFIG_PM_SLEEP */
>>
>> -static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
>> -			 sdhci_arasan_resume);
>> +
>> +#ifdef CONFIG_PM
>> +static int sdhci_arasan_runtime_suspend(struct device *dev)
>> +{
>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
>> +	int ret;
>> +
>> +	ret = sdhci_runtime_suspend_host(host);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!IS_ERR(sdhci_arasan->phy)) {
>> +		ret = sdhci_arasan_suspend_phy(sdhci_arasan->phy);
>> +		if (ret) {
>> +			dev_err(dev, "Cannot suspend phy at runtime.\n");
>> +			sdhci_runtime_resume_host(host);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	clk_disable_unprepare(sdhci_arasan->clk_ahb);
>> +	clk_disable_unprepare(pltfm_host->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sdhci_arasan_runtime_resume(struct device *dev)
>> +{
>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
>> +	int ret;
>> +
>> +	clk_prepare_enable(pltfm_host->clk);
>> +	clk_prepare_enable(sdhci_arasan->clk_ahb);
>> +
>> +	if (!IS_ERR(sdhci_arasan->phy)) {
>> +		ret = sdhci_arasan_resume_phy(sdhci_arasan->phy);
>> +		if (ret) {
>> +			dev_err(dev, "Cannot resume phy at runtime.\n");
>> +			clk_disable_unprepare(sdhci_arasan->clk_ahb);
>> +			clk_disable_unprepare(pltfm_host->clk);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return sdhci_runtime_resume_host(host);
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM
>> +static const struct dev_pm_ops sdhci_arasan_pmops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend, sdhci_arasan_resume)
>> +	SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
>> +				sdhci_arasan_runtime_resume, NULL)
>> +};
>> +
>> +#define SDHCI_ARASAN_PMOPS (&sdhci_arasan_pmops)
>> +
>> +#else
>> +#define SDHCI_ARASAN_PMOPS NULL
>> +#endif
>
> This is completely wrong. SET_SYSTEM_SLEEP_PM_OPS, SET_RUNTIME_PM_OPS
> have both declarations for !PM_SLEEP, !PM cases. It means you can remove
> this ifdef mess.
>
> I was doing experiment with your code and you need to add __maybe_unused
> for functions which are not used when certain functions are not wired
> for !PM, !PM_SLEEP cases.
>
> Something like this should be added to any SDHCI header. (or Using
> macros). Definitely this should be tested for all combinations.
> #if !defined(CONFIG_PM)
> static inline int sdhci_suspend_host(struct sdhci_host *host)	{ return -1; }
> static inline int sdhci_resume_host(struct sdhci_host *host)	{ return -1; }
> static inline int sdhci_runtime_suspend_host(struct sdhci_host *host)	{
> return -1; }
> static inline int sdhci_runtime_resume_host(struct sdhci_host *host)	{
> return -1; }
> #endif
>

Thanks for pointing out it.

Actually I took a little bit from
sdhci-pxav3.c and sdhci-s3c.c. So I didn't find the mistake.

I now look into the SET_SYSTEM_SLEEP_PM_OPS, SET_RUNTIME_PM_OPS, yes,
it matches the case you mentioned.

Definitely I will fix it. :)

So let me wait for Ulf if he has some comments for this patchset and 
then re-spin my the next version.

>
>>
>>   static int sdhci_arasan_probe(struct platform_device *pdev)
>>   {
>> @@ -272,6 +336,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>   		goto clk_disable_all;
>>   	}
>>
>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, ARASAN_RPM_DELAY_MS);
>> +	pm_runtime_use_autosuspend(&pdev->dev);
>> +	pm_runtime_enable(&pdev->dev);
>> +	pm_suspend_ignore_children(&pdev->dev, 1);
>> +
>>   	ret = sdhci_add_host(host);
>>   	if (ret)
>>   		goto err_pltfm_free;
>> @@ -279,6 +348,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>   	return 0;
>>
>>   err_pltfm_free:
>> +	pm_runtime_disable(&pdev->dev);
>>   	sdhci_pltfm_free(pdev);
>>   clk_disable_all:
>>   	clk_disable_unprepare(clk_xin);
>> @@ -297,6 +367,10 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>>   	if (!IS_ERR(sdhci_arasan->phy))
>>   		phy_exit(sdhci_arasan->phy);
>>
>> +	pm_runtime_get_sync(&pdev->dev);
>> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>> +	pm_runtime_disable(&pdev->dev);
>> +
>>   	clk_disable_unprepare(sdhci_arasan->clk_ahb);
>>
>>   	return sdhci_pltfm_unregister(pdev);
>> @@ -314,7 +388,7 @@ static struct platform_driver sdhci_arasan_driver = {
>>   	.driver = {
>>   		.name = "sdhci-arasan",
>>   		.of_match_table = sdhci_arasan_of_match,
>> -		.pm = &sdhci_arasan_dev_pm_ops,
>> +		.pm = SDHCI_ARASAN_PMOPS,
>
> Keep origin name here. No reason for this macro at all.

Got it.

>
>>   	},
>>   	.probe = sdhci_arasan_probe,
>>   	.remove = sdhci_arasan_remove,
>>
>
> Thanks,
> Michal
>
>
>


-- 
Best Regards
Shawn Lin

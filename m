From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Thu, 8 Sep 2016 11:00:28 +0300
Message-ID: <d6680c7c-8373-1ad4-dd7f-9d0281b3a258@intel.com>
References: <1466080509-24015-1-git-send-email-pramod.gurav@linaro.org>
 <79066adb-c45b-158f-99af-6d86e6de7513@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79066adb-c45b-158f-99af-6d86e6de7513@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Pramod Gurav <pramod.gurav@linaro.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ritesh Harjani <riteshh@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 08/09/16 10:47, Adrian Hunter wrote:
> On 16/06/16 15:35, Pramod Gurav wrote:
>> Provides runtime PM callbacks to enable and disable clock resources
>> when idle. Also support system PM callbacks to be called during system
>> suspend and resume.
>>
>> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
> 
> Can we get some Tested/Reviewed/Acked-by from people using this driver?

Oops wrong version of the patch.  Please disregard the comment for this
patch, and see instead the later patch.

> 
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 0653fe7..f4394c8 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/of_device.h>
>>  #include <linux/delay.h>
>>  #include <linux/mmc/mmc.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/slab.h>
>>  
>>  #include "sdhci-pltfm.h"
>> @@ -549,6 +550,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto clk_disable;
>>  
>> +	platform_set_drvdata(pdev, msm_host);
>> +
>> +	pm_runtime_set_active(&pdev->dev);
>> +	pm_runtime_enable(&pdev->dev);
>> +
>>  	return 0;
>>  
>>  clk_disable:
>> @@ -580,12 +586,63 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +static int sdhci_msm_runtime_suspend(struct device *dev)
>> +{
>> +	struct sdhci_msm_host *msm_host = dev_get_drvdata(dev);
>> +
>> +	clk_disable_unprepare(msm_host->clk);
>> +	clk_disable_unprepare(msm_host->pclk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sdhci_msm_runtime_resume(struct device *dev)
>> +{
>> +	struct sdhci_msm_host *msm_host = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(msm_host->clk);
>> +	if (ret) {
>> +		dev_err(dev, "clk_enable failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +	ret = clk_prepare_enable(msm_host->pclk);
>> +	if (ret) {
>> +		dev_err(dev, "clk_enable failed: %d\n", ret);
>> +		clk_disable_unprepare(msm_host->clk);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int sdhci_msm_suspend(struct device *dev)
>> +{
>> +	pm_runtime_force_suspend(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sdhci_msm_resume(struct device *dev)
>> +{
>> +	pm_runtime_force_resume(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dev_pm_ops sdhci_msm_pm_ops = {
>> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(sdhci_msm_suspend, sdhci_msm_resume)
>> +	SET_RUNTIME_PM_OPS(sdhci_msm_runtime_suspend, sdhci_msm_runtime_resume,
>> +				NULL)
>> +};
>> +
>>  static struct platform_driver sdhci_msm_driver = {
>>  	.probe = sdhci_msm_probe,
>>  	.remove = sdhci_msm_remove,
>>  	.driver = {
>>  		   .name = "sdhci_msm",
>>  		   .of_match_table = sdhci_msm_dt_match,
>> +		   .pm = &sdhci_msm_pm_ops,
>>  	},
>>  };
>>  
>>
> 
> 

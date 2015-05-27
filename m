From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v3 1/2] mmc: sdhci: fix abort due to missing runtime PM
Date: Wed, 27 May 2015 12:40:11 +0200
Message-ID: <6af042a9e109b258ac7ba49958bf6ab4@agner.ch>
References: <1432192504-3601-1-git-send-email-stefan@agner.ch>
 <20150527100524.GA1294@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150527100524.GA1294@shlinux1.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: ulf.hansson@linaro.org, gregory.clement@free-electrons.com, zhangfei.gao@marvell.com, jszhang@marvell.com, chris@printf.net, anton@enomsg.org, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2015-05-27 12:05, Dong Aisheng wrote:
<snip>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 82f512d..7b7b3a3 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -1132,7 +1132,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>>  #endif
>>
>>  static const struct dev_pm_ops sdhci_esdhc_pmops = {
>> -	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_pltfm_resume)
>> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_rpm_suspend, sdhci_pltfm_rpm_resume)
>>  	SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
>>  				sdhci_esdhc_runtime_resume, NULL)
>>  };
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>> index a207f5a..38c03cd 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/err.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/pm_runtime.h>
>>  #ifdef CONFIG_PPC
>>  #include <asm/machdep.h>
>>  #endif
>> @@ -256,6 +257,41 @@ const struct dev_pm_ops sdhci_pltfm_pmops = {
>>  	.resume		= sdhci_pltfm_resume,
>>  };
>>  EXPORT_SYMBOL_GPL(sdhci_pltfm_pmops);
>> +
>> +int sdhci_pltfm_rpm_suspend(struct device *dev)
> 
> Why invent a new API?
> Can't put into sdhci_pltfm_suspend?

There are several drivers making use of the API without runtime PM
support. Afaik, you can't call the pm_runtime functions without having
runtime PM support, at least pm_runtime_force_suspend seems to return an
error when runtime_suspend callback is not there... Maybe I'm wrong on
that?

--
Stefan

> 
> Regards
> Dong Aisheng
> 
>> +{
>> +	int ret;
>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +	pm_runtime_get_sync(dev);
>> +	ret = sdhci_suspend_host(host);
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_put_autosuspend(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return pm_runtime_force_suspend(dev);
>> +}
>> +EXPORT_SYMBOL_GPL(sdhci_pltfm_rpm_suspend);
>> +
>> +int sdhci_pltfm_rpm_resume(struct device *dev)
>> +{
>> +	int ret;
>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +	ret = pm_runtime_force_resume(dev);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	pm_runtime_get_sync(dev);
>> +	ret = sdhci_resume_host(host);
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_put_autosuspend(dev);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(sdhci_pltfm_rpm_resume);
>>  #endif	/* CONFIG_PM */
>>
>>  static int __init sdhci_pltfm_drv_init(void)
>> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
>> index 04bc248..ac5f6ea 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.h
>> +++ b/drivers/mmc/host/sdhci-pltfm.h
>> @@ -114,6 +114,8 @@ static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
>>  extern int sdhci_pltfm_suspend(struct device *dev);
>>  extern int sdhci_pltfm_resume(struct device *dev);
>>  extern const struct dev_pm_ops sdhci_pltfm_pmops;
>> +extern int sdhci_pltfm_rpm_suspend(struct device *dev);
>> +extern int sdhci_pltfm_rpm_resume(struct device *dev);
>>  #define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
>>  #else
>>  #define SDHCI_PLTFM_PMOPS NULL
>> --
>> 2.4.1
>>

From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pxav3: add pm runtime support
Date: Fri, 21 Dec 2012 20:48:50 +0800
Message-ID: <CADz5_gKi8LjeHC5zC6QbaqiHKdx0kZyQCeVoT1tBnJfvyk704w@mail.gmail.com>
References: <1356001887-31793-1-git-send-email-kliu5@marvell.com>
	<1356001887-31793-2-git-send-email-kliu5@marvell.com>
	<CAPDyKFq9Y7gYCajbEt8ti51AvyQOErNS3r-uqa-Y-qKECWnJWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:48856 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab2LUMsv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Dec 2012 07:48:51 -0500
Received: by mail-we0-f173.google.com with SMTP id z2so2139351wey.18
        for <linux-mmc@vger.kernel.org>; Fri, 21 Dec 2012 04:48:50 -0800 (PST)
In-Reply-To: <CAPDyKFq9Y7gYCajbEt8ti51AvyQOErNS3r-uqa-Y-qKECWnJWw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@amd.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Al Cooper <acooper@gmail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>

2012/12/21 Ulf Hansson <ulf.hansson@linaro.org>:
> On 20 December 2012 12:11, Kevin Liu <kliu5@marvell.com> wrote:
>> Signed-off-by: Jialing Fu <jlfu@marvell.com>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>>  drivers/mmc/host/sdhci-pxav3.c |   89 ++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 86 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index fad0966..ba3a524 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -32,10 +32,15 @@
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/of_gpio.h>
>> +#include <linux/pm.h>
>> +#include <linux/pm_runtime.h>
>> +#include <plat/pm.h>
>>
>>  #include "sdhci.h"
>>  #include "sdhci-pltfm.h"
>>
>> +#define PXAV3_RPM_DELAY_MS     50
>> +
>>  #define SD_CLOCK_BURST_SIZE_SETUP              0x10A
>>  #define SDCLK_SEL      0x100
>>  #define SDCLK_DELAY_SHIFT      9
>> @@ -253,8 +258,9 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>                 goto err_clk_get;
>>         }
>>         pltfm_host->clk = clk;
>> +#ifndef CONFIG_PM_RUNTIME
>
> I think it would be better to always enable the clk and the resourses
> you need in the probe function.
>
> To reflect that in runtime PM you shall use:
> pm_runtime_enable
> pm_runtime_get_noresume
> pm_runtime_set_active
>
> When you leave your probe function do pm_runtime_put*, to put back
> your resources and maybe enter
>
> Thus you can get rid of the ifdefs in the probe function.
>

The original patch did as above way but I want to use pm runtime even
during probe, so I change to current code.
I agree keep clock on during probe make things easier...so I will
update the patch.

>>         clk_prepare_enable(clk);
>> -
>> +#endif
>>         host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>>                 | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
>>                 | SDHCI_QUIRK_32BIT_ADMA_SIZE
>> @@ -303,9 +309,17 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>
>>         sdhci_get_of_property(pdev);
>>
>> +       pm_runtime_enable(&pdev->dev);
>> +       pm_runtime_set_autosuspend_delay(&pdev->dev,
>> +                       PXAV3_RPM_DELAY_MS);
>> +       pm_runtime_use_autosuspend(&pdev->dev);
>> +       pm_suspend_ignore_children(&pdev->dev, 1);
>> +
>>         ret = sdhci_add_host(host);
>>         if (ret) {
>>                 dev_err(&pdev->dev, "failed to add host\n");
>> +               pm_runtime_forbid(&pdev->dev);
>> +               pm_runtime_get_noresume(&pdev->dev);
>>                 goto err_add_host;
>>         }
>>
>> @@ -314,7 +328,9 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>         return 0;
>>
>>  err_add_host:
>> +#ifndef CONFIG_PM_RUNTIME
>>         clk_disable_unprepare(clk);
>> +#endif
>>         clk_put(clk);
>>         mmc_gpio_free_cd(host->mmc);
>>  err_cd_req:
>> @@ -332,8 +348,10 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
>>         struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
>>
>>         sdhci_remove_host(host, 1);
>> -
>> +       pm_runtime_disable(&pdev->dev);
>> +#ifndef CONFIG_PM_RUNTIME
>>         clk_disable_unprepare(pltfm_host->clk);
>> +#endif
>>         clk_put(pltfm_host->clk);
>>
>>         if (gpio_is_valid(pdata->ext_cd_gpio))
>> @@ -347,6 +365,71 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
>>         return 0;
>>  }
>>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int sdhci_pxav3_suspend(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +       return sdhci_suspend_host(host);
>> +}
>> +
>> +static int sdhci_pxav3_resume(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +       return sdhci_resume_host(host);
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM_RUNTIME
>> +static int sdhci_pxav3_runtime_suspend(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       unsigned long flags;
>> +
>> +       if (pltfm_host->clk) {
>> +               spin_lock_irqsave(&host->lock, flags);
>> +               host->runtime_suspended = true;
>> +               spin_unlock_irqrestore(&host->lock, flags);
>> +
>> +               clk_disable_unprepare(pltfm_host->clk);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int sdhci_pxav3_runtime_resume(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       unsigned long flags;
>> +
>> +       if (pltfm_host->clk) {
>> +               clk_prepare_enable(pltfm_host->clk);
>> +
>> +               spin_lock_irqsave(&host->lock, flags);
>> +               host->runtime_suspended = false;
>> +               spin_unlock_irqrestore(&host->lock, flags);
>> +       }
>> +
>> +       return 0;
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM
>> +static const struct dev_pm_ops sdhci_pxav3_pmops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_pxav3_suspend, sdhci_pxav3_resume)
>> +       SET_RUNTIME_PM_OPS(sdhci_pxav3_runtime_suspend,
>> +               sdhci_pxav3_runtime_resume, NULL)
>> +};
>> +
>> +#define SDHCI_PXAV3_PMOPS (&sdhci_pxav3_pmops)
>> +
>> +#else
>> +#define SDHCI_PXAV3_PMOPS NULL
>> +#endif
>> +
>>  static struct platform_driver sdhci_pxav3_driver = {
>>         .driver         = {
>>                 .name   = "sdhci-pxav3",
>> @@ -354,7 +437,7 @@ static struct platform_driver sdhci_pxav3_driver = {
>>                 .of_match_table = sdhci_pxav3_of_match,
>>  #endif
>>                 .owner  = THIS_MODULE,
>> -               .pm     = SDHCI_PLTFM_PMOPS,
>> +               .pm     = SDHCI_PXAV3_PMOPS,
>>         },
>>         .probe          = sdhci_pxav3_probe,
>>         .remove         = sdhci_pxav3_remove,
>> --
>> 1.7.0.4
>>
>
> Kind regards
> Ulf Hansson

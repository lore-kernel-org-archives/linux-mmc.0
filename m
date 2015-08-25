From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] mmc: sdhci: fix abort due to missing runtime PM
Date: Tue, 25 Aug 2015 14:04:49 +0200
Message-ID: <CAPDyKFosM5QHLL4bGXYtVRpEFisoOOUNJtSfcRLroiv1feAARA@mail.gmail.com>
References: <1432192504-3601-1-git-send-email-stefan@agner.ch>
	<f2ab27135652e987ba9bf3b152e9652d@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36695 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbbHYMEu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:04:50 -0400
Received: by iodv127 with SMTP id v127so182985306iod.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:04:50 -0700 (PDT)
In-Reply-To: <f2ab27135652e987ba9bf3b152e9652d@agner.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>, zhangfei.gao@marvell.com, Jisheng Zhang <jszhang@marvell.com>, Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Dong Aisheng <b29396@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 30 July 2015 at 13:37, Stefan Agner <stefan@agner.ch> wrote:
> Hi Ulf,
>
> What is the status on that?
>
> --
> Stefan
>
> On 2015-05-21 09:15, Stefan Agner wrote:
>> When using i.MX ESDHC driver, while entering suspend while the device
>> is in runtime PM, the sdhci_(suspend|resume)_host function are called
>> with disabled clocks. Since this functions access the SDHC host
>> registers, this leads to an external abort on Vybrid SoC:
>>
>> [   37.772967] Unhandled fault: imprecise external abort (0x1c06) at 0x76f5f000
>> [   37.780304] Internal error: : 1c06 [#1] ARM
>> [   37.784670] Modules linked in:
>> [   37.787908] CPU: 0 PID: 428 Comm: sh Not tainted
>> 3.18.0-rc5-00119-geefd097-dirty #1540
>> [   37.796142] task: 8e246c00 ti: 8ca6c000 task.ti: 8ca6c000
>> [   37.801785] PC is at esdhc_writel_le+0x40/0xec
>> [   37.806431] LR is at sdhci_set_card_detection+0xe0/0xe4
>> [   37.811877] pc : [<803f0584>]    lr : [<803eaaa0>]    psr: 400f0013
>> [   37.811877] sp : 8ca6dd28  ip : 00000001  fp : 8ca6dd3c
>> [   37.823766] r10: 807a233c  r9 : 00000000  r8 : 8e8b7210
>> [   37.829194] r7 : 802d8a08  r6 : 8082e928  r5 : 00000000  r4 : 00000002
>> [   37.835974] r3 : 8ea34e90  r2 : 00000038  r1 : 00000000  r0 : 8ea32ac0
>> ...
>>
>> Clocks need to be enabled to access the registers. Fix the issue by
>> add runtime PM enabled pltfm implementation of suspend/resume which
>> take care of clocks by using the runtime PM API properly.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Changes since v2:
>> - Implement a generic pltfm suspend/resume function instead of a local
>>   function in sdhci-esdhc-imx.c
>> - Convert sdhci-pxav3 to use the runtime PM enabled pltfm suspend/resume
>>   function too
>>
>>  drivers/mmc/host/sdhci-esdhc-imx.c |  2 +-
>>  drivers/mmc/host/sdhci-pltfm.c     | 36 ++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/sdhci-pltfm.h     |  2 ++
>>  3 files changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
>> b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 82f512d..7b7b3a3 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -1132,7 +1132,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>>  #endif
>>
>>  static const struct dev_pm_ops sdhci_esdhc_pmops = {
>> -     SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_pltfm_resume)
>> +     SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_rpm_suspend, sdhci_pltfm_rpm_resume)
>>       SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
>>                               sdhci_esdhc_runtime_resume, NULL)
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
>>       .resume         = sdhci_pltfm_resume,
>>  };
>>  EXPORT_SYMBOL_GPL(sdhci_pltfm_pmops);
>> +
>> +int sdhci_pltfm_rpm_suspend(struct device *dev)
>> +{
>> +     int ret;
>> +     struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +     pm_runtime_get_sync(dev);
>> +     ret = sdhci_suspend_host(host);
>> +     pm_runtime_mark_last_busy(dev);
>> +     pm_runtime_put_autosuspend(dev);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return pm_runtime_force_suspend(dev);
>> +}
>> +EXPORT_SYMBOL_GPL(sdhci_pltfm_rpm_suspend);
>> +
>> +int sdhci_pltfm_rpm_resume(struct device *dev)
>> +{
>> +     int ret;
>> +     struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +     ret = pm_runtime_force_resume(dev);
>> +
>> +     if (ret)
>> +             return ret;
>> +
>> +     pm_runtime_get_sync(dev);
>> +     ret = sdhci_resume_host(host);
>> +     pm_runtime_mark_last_busy(dev);
>> +     pm_runtime_put_autosuspend(dev);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(sdhci_pltfm_rpm_resume);
>>  #endif       /* CONFIG_PM */
>>
>>  static int __init sdhci_pltfm_drv_init(void)
>> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
>> index 04bc248..ac5f6ea 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.h
>> +++ b/drivers/mmc/host/sdhci-pltfm.h
>> @@ -114,6 +114,8 @@ static inline void *sdhci_pltfm_priv(struct
>> sdhci_pltfm_host *host)
>>  extern int sdhci_pltfm_suspend(struct device *dev);
>>  extern int sdhci_pltfm_resume(struct device *dev);
>>  extern const struct dev_pm_ops sdhci_pltfm_pmops;
>> +extern int sdhci_pltfm_rpm_suspend(struct device *dev);
>> +extern int sdhci_pltfm_rpm_resume(struct device *dev);
>>  #define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
>>  #else
>>  #define SDHCI_PLTFM_PMOPS NULL
>

This is a bit complicated, mostly due to the code structure of sdhci
and around how it handles wakeup settings. I do understand that you
want to fix a real bug, but in this case I think we need to figure out
a long term solution, else we will be solving one problem but
inserting another.

Obviously the sdhci device needs to be runtime resumed while accessing
it. Now, I wonder *why* sdhci-pltfm drivers need to access their
devices during system suspend? Normally that's because you want to
apply a different wakeup configuration in system suspend than in
runtime suspend, but is that really the case? And if so, could we
teach sdhci_runtime_suspend_host() to deal with this?

So, I think we first need to understand how to let sdhci deal with
wakeups. By cleaning up that piece of code and possibly also
converting it to use the new wakeirq API
(drivers/base/power/wakeirq.c) we should be better prepared to apply a
proper fix for your issue.

Kind regards
Uffe

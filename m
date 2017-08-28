From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH v4 3/4] mmc: sdhci: enable/disable the clock in sdhci_pltfm_suspend/resume
Date: Mon, 28 Aug 2017 11:35:18 -0400
Message-ID: <CAOGqxeXSS+tCvDg-=FjZCCk133qy4juUxHyMgSnOxqz=VD1ZVg@mail.gmail.com>
References: <1503461703-16225-1-git-send-email-yamada.masahiro@socionext.com>
 <1503461703-16225-4-git-send-email-yamada.masahiro@socionext.com> <a91d1893-997b-e132-3c5b-03adb81aaa6c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38108 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdH1PfU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Aug 2017 11:35:20 -0400
In-Reply-To: <a91d1893-997b-e132-3c5b-03adb81aaa6c@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc <linux-mmc@vger.kernel.org>, Piotr Sroka <piotrs@cadence.com>, Hu Ziji <huziji@marvell.com>, Christian Daudt <csd@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Barry Song <baohua@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

> On 23/08/17 07:15, Masahiro Yamada wrote:
> > This commit provides similar cleanups as commit 83eacdfa2529 ("mmc:
> > sdhci: disable the clock in sdhci_pltfm_unregister()") did for
> > unregister hooks.
> >
> > sdhci-brcmstb.c and sdhci-sirf.c implement their own suspend/resume
> > hooks to handle pltfm_host->clk.  Move clock handling to sdhci_pltfm.c
> > so that the drivers can reuse sdhci_pltfm_pmops.
> >
> > The following drivers did not previously touch pltfm_host->clk during
> > suspend/resume, but now do:
> >   - sdhci-bcm-kona.c
> >   - sdhci-dove.c
> >   - sdhci-iproc.c
> >   - sdhci-pxav2.c
> >   - sdhci-tegra.c
> >   - sdhci-xenon.c
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Would have been nice to see some more Acks on this but from sdhci point of view:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Looks good for sdhci-brcmstb.c

Acked-by: Al Cooper <alcooperx@gmail.com>



On Mon, Aug 28, 2017 at 6:34 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 23/08/17 07:15, Masahiro Yamada wrote:
>> This commit provides similar cleanups as commit 83eacdfa2529 ("mmc:
>> sdhci: disable the clock in sdhci_pltfm_unregister()") did for
>> unregister hooks.
>>
>> sdhci-brcmstb.c and sdhci-sirf.c implement their own suspend/resume
>> hooks to handle pltfm_host->clk.  Move clock handling to sdhci_pltfm.c
>> so that the drivers can reuse sdhci_pltfm_pmops.
>>
>> The following drivers did not previously touch pltfm_host->clk during
>> suspend/resume, but now do:
>>   - sdhci-bcm-kona.c
>>   - sdhci-dove.c
>>   - sdhci-iproc.c
>>   - sdhci-pxav2.c
>>   - sdhci-tegra.c
>>   - sdhci-xenon.c
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Would have been nice to see some more Acks on this but from sdhci point of view:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
>> ---
>>
>> Changes in v4:
>>   - Disable clk when resume fails
>>
>> Changes in v3: None
>> Changes in v2:
>>   - Fix build error reported by kbuild test robot
>>
>>  drivers/mmc/host/sdhci-brcmstb.c | 37 +------------------------------------
>>  drivers/mmc/host/sdhci-pltfm.c   | 22 ++++++++++++++++++++--
>>  drivers/mmc/host/sdhci-sirf.c    | 39 +--------------------------------------
>>  3 files changed, 22 insertions(+), 76 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
>> index e2f638338e8f..6d461fcdd663 100644
>> --- a/drivers/mmc/host/sdhci-brcmstb.c
>> +++ b/drivers/mmc/host/sdhci-brcmstb.c
>> @@ -21,41 +21,6 @@
>>
>>  #include "sdhci-pltfm.h"
>>
>> -#ifdef CONFIG_PM_SLEEP
>> -
>> -static int sdhci_brcmstb_suspend(struct device *dev)
>> -{
>> -     struct sdhci_host *host = dev_get_drvdata(dev);
>> -     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> -     int res;
>> -
>> -     if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>> -             mmc_retune_needed(host->mmc);
>> -
>> -     res = sdhci_suspend_host(host);
>> -     if (res)
>> -             return res;
>> -     clk_disable_unprepare(pltfm_host->clk);
>> -     return res;
>> -}
>> -
>> -static int sdhci_brcmstb_resume(struct device *dev)
>> -{
>> -     struct sdhci_host *host = dev_get_drvdata(dev);
>> -     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> -     int err;
>> -
>> -     err = clk_prepare_enable(pltfm_host->clk);
>> -     if (err)
>> -             return err;
>> -     return sdhci_resume_host(host);
>> -}
>> -
>> -#endif /* CONFIG_PM_SLEEP */
>> -
>> -static SIMPLE_DEV_PM_OPS(sdhci_brcmstb_pmops, sdhci_brcmstb_suspend,
>> -                     sdhci_brcmstb_resume);
>> -
>>  static const struct sdhci_ops sdhci_brcmstb_ops = {
>>       .set_clock = sdhci_set_clock,
>>       .set_bus_width = sdhci_set_bus_width,
>> @@ -131,7 +96,7 @@ MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
>>  static struct platform_driver sdhci_brcmstb_driver = {
>>       .driver         = {
>>               .name   = "sdhci-brcmstb",
>> -             .pm     = &sdhci_brcmstb_pmops,
>> +             .pm     = &sdhci_pltfm_pmops,
>>               .of_match_table = of_match_ptr(sdhci_brcm_of_match),
>>       },
>>       .probe          = sdhci_brcmstb_probe,
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>> index e090d8c42ddb..4c0135e184e9 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -212,18 +212,36 @@ EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
>>  static int sdhci_pltfm_suspend(struct device *dev)
>>  {
>>       struct sdhci_host *host = dev_get_drvdata(dev);
>> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +     int ret;
>>
>>       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>>               mmc_retune_needed(host->mmc);
>>
>> -     return sdhci_suspend_host(host);
>> +     ret = sdhci_suspend_host(host);
>> +     if (ret)
>> +             return ret;
>> +
>> +     clk_disable_unprepare(pltfm_host->clk);
>> +
>> +     return 0;
>>  }
>>
>>  static int sdhci_pltfm_resume(struct device *dev)
>>  {
>>       struct sdhci_host *host = dev_get_drvdata(dev);
>> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +     int ret;
>> +
>> +     ret = clk_prepare_enable(pltfm_host->clk);
>> +     if (ret)
>> +             return ret;
>>
>> -     return sdhci_resume_host(host);
>> +     ret = sdhci_resume_host(host);
>> +     if (ret)
>> +             clk_disable_unprepare(pltfm_host->clk);
>> +
>> +     return ret;
>>  }
>>  #endif
>>
>> diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
>> index c251c6c0a112..0c7aa89df4e2 100644
>> --- a/drivers/mmc/host/sdhci-sirf.c
>> +++ b/drivers/mmc/host/sdhci-sirf.c
>> @@ -230,43 +230,6 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
>>       return ret;
>>  }
>>
>> -#ifdef CONFIG_PM_SLEEP
>> -static int sdhci_sirf_suspend(struct device *dev)
>> -{
>> -     struct sdhci_host *host = dev_get_drvdata(dev);
>> -     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> -     int ret;
>> -
>> -     if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>> -             mmc_retune_needed(host->mmc);
>> -
>> -     ret = sdhci_suspend_host(host);
>> -     if (ret)
>> -             return ret;
>> -
>> -     clk_disable(pltfm_host->clk);
>> -
>> -     return 0;
>> -}
>> -
>> -static int sdhci_sirf_resume(struct device *dev)
>> -{
>> -     struct sdhci_host *host = dev_get_drvdata(dev);
>> -     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> -     int ret;
>> -
>> -     ret = clk_enable(pltfm_host->clk);
>> -     if (ret) {
>> -             dev_dbg(dev, "Resume: Error enabling clock\n");
>> -             return ret;
>> -     }
>> -
>> -     return sdhci_resume_host(host);
>> -}
>> -#endif
>> -
>> -static SIMPLE_DEV_PM_OPS(sdhci_sirf_pm_ops, sdhci_sirf_suspend, sdhci_sirf_resume);
>> -
>>  static const struct of_device_id sdhci_sirf_of_match[] = {
>>       { .compatible = "sirf,prima2-sdhc" },
>>       { }
>> @@ -277,7 +240,7 @@ static struct platform_driver sdhci_sirf_driver = {
>>       .driver         = {
>>               .name   = "sdhci-sirf",
>>               .of_match_table = sdhci_sirf_of_match,
>> -             .pm     = &sdhci_sirf_pm_ops,
>> +             .pm     = &sdhci_pltfm_pmops,
>>       },
>>       .probe          = sdhci_sirf_probe,
>>       .remove         = sdhci_pltfm_unregister,
>>
>

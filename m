From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: fix abort due to missing
 runtime PM
Date: Wed, 06 May 2015 22:23:41 +0200
Message-ID: <21627fa7fae565d09ea07fe24bd78b09@agner.ch>
References: <1427715434-20881-1-git-send-email-stefan@agner.ch>
 <CAPDyKFo+6mA4aKWfrUWmPvdairJN6KMCD0XTe3HDDB2pirEJXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo+6mA4aKWfrUWmPvdairJN6KMCD0XTe3HDDB2pirEJXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Dong Aisheng <b29396@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2015-05-06 14:07, Ulf Hansson wrote:
> On 30 March 2015 at 13:37, Stefan Agner <stefan@agner.ch> wrote:
>> When entering suspend while the device is in runtime PM, the
>> sdhci_(suspend|resume)_host function are called with disabled clocks.
>> Since this functions access the SDHC host registers, this leads to an
>> external abort on Vybrid SoC:
>>
>> [   37.772967] Unhandled fault: imprecise external abort (0x1c06) at 0x76f5f000
>> [   37.780304] Internal error: : 1c06 [#1] ARM
>> [   37.784670] Modules linked in:
>> [   37.787908] CPU: 0 PID: 428 Comm: sh Not tainted 3.18.0-rc5-00119-geefd097-dirty #1540
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
>> add driver specific implementation of suspend/resume functions which
>> take care of clocks using runtime PM API.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Hi Stefan,
> 
> Sorry for the delay.
> 
> Indeed sdhci seems to have some issues when combining runtime PM and system PM.
> 
>> ---
>> The first version of this patch was part of a patchset sent back in
>> december. While the second patch of the patchset back then is invalid,
>> this fix is required to avoid the abort when switching into suspend
>> mode on Vybrid SoC.
>>
>> During review of this patch I realized that my proposed solution to
>> fix this in the suspend/resume functions in sdhci-pltfm.c is not a
>> good idea since a lot of drivers use this functions without using the
>> runtime PM APIs.
>>
>> Changes since v1:
>> - Create new sdhci_esdhc_(suspend|resume) functions in favor of adding a
>>   hard requirement for runtime PM on SDHC platform implementations
>>
>>  drivers/mmc/host/sdhci-esdhc-imx.c | 28 +++++++++++++++++++++++++++-
>>  1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 10ef824..84b3365 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -1119,6 +1119,32 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>>  }
>>
>>  #ifdef CONFIG_PM
>> +static int sdhci_esdhc_suspend(struct device *dev)
>> +{
>> +       int ret;
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +       pm_runtime_get_sync(dev);
> 
> This is indeed needed, since else it isn't safe to invoke sdhci_suspend_host().
> 
>> +       ret = sdhci_suspend_host(host);
>> +       pm_runtime_mark_last_busy(dev);
>> +       pm_runtime_put_autosuspend(dev);
> 
> The problem is, that this wont do what you think I believe.
> 
> The device will be kept runtime PM resumed, since the PM core has
> increased a runtime PM reference count for your device, in the
> ->prepare() phase (pm_runtime_get_noresume()).

Which ->prepare() phase do you mean exactly? I don't see where
pm_runtime_get_noresume gets from this driver.

> 
> Potentially pm_runtime_force_suspend() could help you accomplish what you want.

I copied the implementation from the PXA driver (sdhci-pxav3.c), is the
driver suffering the same issue?

--
Stefan

> 
>> +
>> +       return ret;
>> +}
>> +
>> +static int sdhci_esdhc_resume(struct device *dev)
>> +{
>> +       int ret;
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +       pm_runtime_get_sync(dev);
>> +       ret = sdhci_resume_host(host);
>> +       pm_runtime_mark_last_busy(dev);
>> +       pm_runtime_put_autosuspend(dev);
>> +
> 
> Similar comments as above.
> 
>> +       return ret;
>> +}
>> +
>>  static int sdhci_esdhc_runtime_suspend(struct device *dev)
>>  {
>>         struct sdhci_host *host = dev_get_drvdata(dev);
>> @@ -1154,7 +1180,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>>  #endif
>>
>>  static const struct dev_pm_ops sdhci_esdhc_pmops = {
>> -       SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_pltfm_resume)
>> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
>>         SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
>>                                 sdhci_esdhc_runtime_resume, NULL)
>>  };
>> --
>> 2.3.3
>>
> 
> Kind regards
> Uffe

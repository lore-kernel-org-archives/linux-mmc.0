From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: core: fix performance regression initializing
 MMC host controllers
Date: Fri, 05 Apr 2013 16:30:06 +0300
Message-ID: <515ED1DE.6070106@intel.com>
References: <1365082866-28404-1-git-send-email-adrian.hunter@intel.com> <1365082866-28404-3-git-send-email-adrian.hunter@intel.com> <CAPDyKFry9CUmguXw0u4Vxa6YXixF-vVzGrvT_MorFjg=1wS+pA@mail.gmail.com> <515E7CB2.9020602@intel.com> <CAPDyKFp2gKuJNY-X5obsDZVvj1V=JN2rnyfkpNKB=HZQd+_pJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3593 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161369Ab3DENYs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Apr 2013 09:24:48 -0400
In-Reply-To: <CAPDyKFp2gKuJNY-X5obsDZVvj1V=JN2rnyfkpNKB=HZQd+_pJg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Namjae Jeon <linkinjeon@gmail.com>, Sergey Yanovich <ynvich@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On 05/04/13 12:49, Ulf Hansson wrote:
> On 5 April 2013 09:26, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 05/04/13 00:02, Ulf Hansson wrote:
>>> On 4 April 2013 15:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> Commit fa5501890d8974301042e0202d342a6cbe8609f4 introduced a performance
>>>> regression by adding mmc_power_up() to mmc_start_host().  mmc_power_up()
>>>> is not necessary to host controller initialization, it is part of card
>>>> initialization and is performed anyway asynchronously.
>>>
>>> This commit message is a bit miss-leading. In eMMC case, when the host
>>> driver has no possibility of power cycle the VCCQ power supply but
>>> only the VCC, this is the only proper way to prevent violation of the
>>> eMMC spec.
>>
>> But that is not true.  The host controller driver can manage the voltages.
>> The patch is a workaround for the regulator_init_complete late initcall.
> 
> In my view, the host driver is not responsible for implementing the
> mmc/sd/sdio protocol as such, that is the core layer responsibility.

Having VCC always on is not part of the MMC protocol.  For example, you
can't look up EXT_CSD and find out if VCC is always on.  Consequently,
the core does not support it.  If a platform requires it, it should be
added as a new feature and flagged as such, not introduced as a "fix".

> Moreover I don't think you should consider this as a workaround, it is
> a proper fix to make sure we follow eMMC spec.

It won't work if the host controller driver is loaded as a module.

Also it causes attempts to initialize cards without first powering off
thereby ensuring they are in a known state.

> 
> I noticed you V2 patch, but would still like some more clear
> information in there and maybe mention "boot time performance" instead
> of just "performance".



> 
> Kind regards
> Ulf Hansson
> 
>>
>> I deliberately did not paraphrase the original commit so that people who
>> wanted to know would have to look at it for themselves.  I really cannot add
>> things to my commit message that do not make sense to me.
>>
>>>
>>> >From SD-card point of view, it is not needed, so this can be optimized
>>> to be done as before in an asynchronous mode.
>>>
>>>>
>>>> This patch allows a driver to leave the power up in asynchronous code
>>>> (as it was before).
>>>>
>>>> On my current target platform this reduces driver initialization from:
>>>>
>>>> [    1.313220] initcall sdhci_acpi_driver_init+0x0/0x12 returned 0 after 102008 usecs
>>>>
>>>> to this:
>>>>
>>>> [    1.217209] initcall sdhci_acpi_driver_init+0x0/0x12 returned 0 after 8331 usecs
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  drivers/mmc/core/core.c       | 3 ++-
>>>>  drivers/mmc/host/sdhci-acpi.c | 2 ++
>>>>  include/linux/mmc/host.h      | 1 +
>>>>  3 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 3bf1c46..c1893c9 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -2416,7 +2416,8 @@ void mmc_start_host(struct mmc_host *host)
>>>>  {
>>>>         host->f_init = max(freqs[0], host->f_min);
>>>>         host->rescan_disable = 0;
>>>> -       mmc_power_up(host);
>>>> +       if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP))
>>>> +               mmc_power_up(host);
>>>>         mmc_detect_change(host, 0);
>>>>  }
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>>>> index 2592ddd..7bcf74b 100644
>>>> --- a/drivers/mmc/host/sdhci-acpi.c
>>>> +++ b/drivers/mmc/host/sdhci-acpi.c
>>>> @@ -195,6 +195,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>>>                 host->mmc->pm_caps  |= c->slot->pm_caps;
>>>>         }
>>>>
>>>> +       host->mmc->caps2 |= MMC_CAP2_NO_PRESCAN_POWERUP;
>>>> +
>>>>         err = sdhci_add_host(host);
>>>>         if (err)
>>>>                 goto err_free;
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index 17d7148..8873e83 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -280,6 +280,7 @@ struct mmc_host {
>>>>  #define MMC_CAP2_PACKED_WR     (1 << 13)       /* Allow packed write */
>>>>  #define MMC_CAP2_PACKED_CMD    (MMC_CAP2_PACKED_RD | \
>>>>                                  MMC_CAP2_PACKED_WR)
>>>> +#define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)  /* Don't power up before scan */
>>>>
>>>>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>>>>
>>>> --
>>>> 1.7.11.7
>>>>
>>>
>>>
>>> Some update to the commit msg, then I am happy.
>>>
>>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>>
>>
> 
> 


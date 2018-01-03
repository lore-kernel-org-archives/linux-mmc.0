From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Enable/Disable mmc clock during
 runtime suspend
Date: Wed, 3 Jan 2018 18:26:34 +0100
Message-ID: <CAOf5uwnLcuzohy-j15AJgNcNzz9T-vDCPksJ7yOaSvsEOSgXgA@mail.gmail.com>
References: <1513862546-20221-1-git-send-email-michael@amarulasolutions.com>
 <CAPDyKFpHG2YsdWWYG_XsVqE05fcVyRp4P7-FgbR9LPDF9OjtYA@mail.gmail.com>
 <CAOf5uwmd0qJhE8YEJeGdySqsXf1u+28WoeRCvUQ0MQcVSGopkg@mail.gmail.com>
 <CAPDyKFqjszhT1C-5KkMVJ9HvEWcow6+QPdJW2dt0i1EFv+Nvcw@mail.gmail.com> <CAOf5uwkO3bVr06Au0hoz6ibh4Zpm4VB1k2Q-w7CnkbBXHpWM+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:41277 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeACR0g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jan 2018 12:26:36 -0500
Received: by mail-it0-f65.google.com with SMTP id x28so2489626ita.0
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jan 2018 09:26:35 -0800 (PST)
In-Reply-To: <CAOf5uwkO3bVr06Au0hoz6ibh4Zpm4VB1k2Q-w7CnkbBXHpWM+Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Ulf

I have still a small question because I'm changing this driver:

We have in sdhci_pxav3_runtime_suspend

        ret = sdhci_runtime_suspend_host(host);
        if (ret)
                return ret;

        clk_disable_unprepare(pxa->clk_io);
        if (!IS_ERR(pxa->clk_core))
                clk_disable_unprepare(pxa->clk_core);

and in the other driver like this one

        ret = sdhci_runtime_suspend_host(host);

        if (!sdhci_sdio_irq_enabled(host)) {
                imx_data->actual_clock = host->mmc->actual_clock;
                esdhc_pltfm_set_clock(host, 0);
                clk_disable_unprepare(imx_data->clk_per);
                clk_disable_unprepare(imx_data->clk_ipg);
        }
        clk_disable_unprepare(imx_data->clk_ahb);

Now to be more funny we have

int sdhci_runtime_suspend_host(struct sdhci_host *host)
{
        unsigned long flags;

        mmc_retune_timer_stop(host->mmc);
        if (host->tuning_mode != SDHCI_TUNING_MODE_3)
                mmc_retune_needed(host->mmc);

        spin_lock_irqsave(&host->lock, flags);
        host->ier &= SDHCI_INT_CARD_INT;
        sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
        sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
        spin_unlock_irqrestore(&host->lock, flags);

        synchronize_hardirq(host->irq);

        spin_lock_irqsave(&host->lock, flags);
        host->runtime_suspended = true;
        spin_unlock_irqrestore(&host->lock, flags);

        return 0;
}

Anyway. What we need to do with the clock in general if we have a fail before?

Michael

On Wed, Jan 3, 2018 at 5:58 PM, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi
>
> On Wed, Jan 3, 2018 at 5:56 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 3 January 2018 at 17:38, Michael Nazzareno Trimarchi
>> <michael@amarulasolutions.com> wrote:
>>> Hi
>>>
>>> On Wed, Jan 3, 2018 at 5:26 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> On 21 December 2017 at 14:22, Michael Trimarchi
>>>> <michael@amarulasolutions.com> wrote:
>>>>> mmc clock can be stopped during runtime suspend and restart during runtime
>>>>> resume. This let us know to not have any clock running and this reduce
>>>>> the EMI of the device when the bus is not in use
>>>>>
>>>>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>>>>> ---
>>>>>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>>>>> index 7123ef9..9a5e96f 100644
>>>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>>>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>>>>> @@ -196,6 +196,7 @@ struct pltfm_imx_data {
>>>>>         struct clk *clk_ipg;
>>>>>         struct clk *clk_ahb;
>>>>>         struct clk *clk_per;
>>>>> +       unsigned int actual_clock;
>>>>>         enum {
>>>>>                 NO_CMD_PENDING,      /* no multiblock command pending*/
>>>>>                 MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
>>>>> @@ -1346,6 +1347,9 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
>>>>>
>>>>>         ret = sdhci_runtime_suspend_host(host);
>>>>>
>>>>> +       imx_data->actual_clock = host->mmc->actual_clock;
>>>>> +       esdhc_pltfm_set_clock(host, 0);
>>>>
>>>> I guess want the clock to stay on "if sdhci_sdio_irq_enabled(host)".
>>>> So you should probably move the above inside the below if statement.
>>>>
>>>
>>> Well I'm not quite sure about it. Some wifi chipset has the wakeup
>>> interrupt on external gpio
>>> and someone wakeup from DAT1. Why clock should be required?
>>
>> The clock should not be needed when using external GPIO (also
>> described as an out-band IRQ/wakeup), but from DAT1.
>>
>
> Ok, I will re-post new patches
>
>> When sdhci_sdio_irq_enabled() returns true, that *should* indicate
>> that DAT1 is used. Although, there may be reasons to re-visit this
>> later, because the hole SDIO irq thing around wakeups for sdhci, is
>> being reworked by Adrian [1].
>
> I will take a look on this post
>
> Regards
>
> Michael
>
>>
>>>
>>> Anyway I should even rebalance resume.
>>
>> Yes.
>>
>> [...]
>>
>> Kind regards
>> Uffe
>>
>> [1]
>> https://www.spinics.net/lists/linux-mmc/msg47512.html



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |

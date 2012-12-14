From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 1/3] mmc: core: enhance the code for signal voltage setting
Date: Fri, 14 Dec 2012 23:28:28 +0800
Message-ID: <CADz5_gL++4M0_acNBaNTRYxEgAAtq74oXCjmtSe5UiSYhubUrg@mail.gmail.com>
References: <1355482438-16836-1-git-send-email-kliu5@marvell.com>
	<1355482438-16836-2-git-send-email-kliu5@marvell.com>
	<CAPDyKFrLxOHLVwcR11f89ubO5GX64uFBzsd_aPq+regWSpFhSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:65122 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309Ab2LNP2a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 10:28:30 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so573286wib.1
        for <linux-mmc@vger.kernel.org>; Fri, 14 Dec 2012 07:28:28 -0800 (PST)
In-Reply-To: <CAPDyKFrLxOHLVwcR11f89ubO5GX64uFBzsd_aPq+regWSpFhSQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, johan.rudholm@stericsson.com, per.forlin@stericsson.com, fredrik.soderstedt@stericsson.com, dsd@laptop.org, leafy.myeh@allwinnertech.com, subhashj@codeaurora.org, prakity@nvidia.com, zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com

2012/12/14 Ulf Hansson <ulf.hansson@linaro.org>:
> On 14 December 2012 11:53, Kevin Liu <kliu5@marvell.com> wrote:
>> 1. if host does NOT implement signal voltage setting function,
>> should return error.
>> 2. add the check for data signal before voltage change according
>> to the spec. If host does NOT detect a low signal level, the host
>> should abort the voltage switch sequence. (phisical layer spec 4.2.4.2(4))
>> 3. if voltage change failed then no need to restore the clock
>> before cycle power the card.
>> 4. call mmc_power_cycle here since it's a part of voltage switch.
>> besides -EAGAIN, any other error returned should also cycle power the card.
>>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>>  drivers/mmc/core/core.c |   71 ++++++++++++++++++++++++++++------------------
>>  1 files changed, 43 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index d1aa8ab..da93186 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1226,6 +1226,9 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
>>
>>         BUG_ON(!host);
>>
>> +       if (!host->ops->start_signal_voltage_switch)
>> +               return -EPERM;
>> +
>
> No, this is not OK.
> For example, eMMC might default use 1.8V as I/O voltage, you don't
> want to force host drivers implementing this function to make this
> work.
>
I agree.
But then how can we make sure emmc's voltage?
Only depend on the voltage by default?
I will update the patch and move this judgement withine cmd11.

>>         /*
>>          * Send CMD11 only if the request is to switch the card to
>>          * 1.8V signalling.
>> @@ -1245,47 +1248,59 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
>>
>>         host->ios.signal_voltage = signal_voltage;
>>
>> -       if (host->ops->start_signal_voltage_switch) {
>> -               u32 clock;
>> +       u32 clock;
>> +
>> +       mmc_host_clk_hold(host);
>> +
>> +       if (cmd11) {
>> +               if (!host->ops->card_busy)
>> +                       pr_warning("%s: cannot verify signal voltage switch\n",
>> +                                       mmc_hostname(host));
>>
>> -               mmc_host_clk_hold(host);
>>                 /*
>>                  * During a signal voltage level switch, the clock must be gated
>>                  * for a certain period of time according to the SD spec
>>                  */
>> -               if (cmd11) {
>> -                       clock = host->ios.clock;
>> -                       host->ios.clock = 0;
>> -                       mmc_set_ios(host);
>> -               }
>> +               clock = host->ios.clock;
>> +               host->ios.clock = 0;
>> +               mmc_set_ios(host);
>>
>> -               err = host->ops->start_signal_voltage_switch(host, &host->ios);
>> +               if (host->ops->card_busy && !host->ops->card_busy(host)) {
>> +                       err = -EAGAIN;
>> +               } else {
>
> Great that you spotted this! We should check busy before we do the
> actual voltage switch.
>
> Although, I think it would make sense to do this before the clock is
> set to 0. Especially important for those host controllers that do
> support busy-detection, a qualified guess would be that those also
> could require the clock to be on to detect this. Or what do you think?
> From spec point of view it shall be safe to do it before setting clk
> to 0.
>
I considered this when I draft this patch.
My only concern is whether DAT level is stable at that point.
According to the spec, the card driver DAT[3:0] to low at the NEXT
clock of the end bit for R1 response after completing the R1 response.
I'm not sure whether the status is stable if we query the DAT level
just after cmd11.

I agree with you that it will be safer to keep clock on when detecting.

>>
>> -               if (err && cmd11) {
>> -                       host->ios.clock = clock;
>> -                       mmc_set_ios(host);
>> -               } else if (cmd11) {
>> -                       /* Keep clock gated for at least 5 ms */
>> -                       mmc_delay(5);
>> -                       host->ios.clock = clock;
>> -                       mmc_set_ios(host);
>> +                       err = host->ops->start_signal_voltage_switch(host, &host->ios);
>>
>> -                       /* Wait for at least 1 ms according to spec */
>> -                       mmc_delay(1);
>> +                       if (!err) {
>> +                               /* Keep clock gated for at least 5 ms */
>> +                               mmc_delay(5);
>> +                               host->ios.clock = clock;
>> +                               mmc_set_ios(host);
>>
>> -                       /*
>> -                        * Failure to switch is indicated by the card holding
>> -                        * dat[0:3] low
>> -                        */
>> -                       if (!host->ops->card_busy)
>> -                               pr_warning("%s: cannot verify signal voltage switch\n",
>> +                               /* Wait for at least 1 ms according to spec */
>> +                               mmc_delay(1);
>> +
>> +                               /*
>> +                                * Failure to switch is indicated by the card holding
>> +                                * dat[0:3] low
>> +                                */
>> +                               if (host->ops->card_busy && host->ops->card_busy(host))
>> +                                       err = -EAGAIN;
>> +                       }
>> +               }
>> +               if (err) {
>> +                       /* Power cycle card */
>> +                       pr_debug("%s: Signal voltage switch failed, "
>> +                                       "power cycling card \n",
>>                                         mmc_hostname(host));
>> -                       else if (host->ops->card_busy(host))
>> -                               err = -EAGAIN;
>> +                       mmc_power_cycle(host);
>>                 }
>> -               mmc_host_clk_release(host);
>> +       } else {
>> +               err = host->ops->start_signal_voltage_switch(host, &host->ios);
>>         }
>>
>> +       mmc_host_clk_release(host);
>> +
>>         return err;
>>  }
>>
>> --
>> 1.7.0.4
>>
>
> Kind regards
> Ulf Hansson

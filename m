From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] mmc: pwrseq: Use highest priority for eMMC restart handler
Date: Thu, 22 Oct 2015 10:43:03 +0900
Message-ID: <56283F27.9060804@samsung.com>
References: <1445440540-21525-1-git-send-email-javier@osg.samsung.com>
 <56282F71.2070408@samsung.com> <562839F7.3040005@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <562839F7.3040005@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 22.10.2015 10:20, Javier Martinez Canillas wrote:> Hello Krzysztof,
> 
> Thanks for your feedback.
> 
> On 10/22/2015 02:36 AM, Krzysztof Kozlowski wrote:
>> On 22.10.2015 00:15, Javier Martinez Canillas wrote:
>>> The pwrseq_emmc driver does a eMMC card reset before a system reboot to
>>> allow broken or limited ROM boot-loaders (that don't have an eMMC reset
>>> logic) to be able to read the second stage from the eMMC.
>>>
>>> But this has to be called before a system reboot handler and while most
>>> of them use the priority 128, there are other restart handlers (such as
>>> the syscon-reboot one) that use a higher priority. So, use the highest
>>> priority to make sure that the eMMC hw is reset before a system reboot.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>>> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
>>>
>>> ---
>>> Hello,
>>>
>>> This patch was needed since a recent series from Alim [0] added
>>> syscon reboot and poweroff support to Exynos SoCs and removed
>>> the reset handler in the Exynos Power Management Unit (PMU) code.
>>>
>>> But the PMU and syscon-reboot restart handler have a different
>>> priority so [0] breaks restart when eMMC is used on these boards.
>>>
>>> [0]: http://www.spinics.net/lists/arm-kernel/msg454396.html
>>>
>>> So this patch must be merged before [0] to avoid regressions.
>>>
>>> Best regards,
>>> Javier
>>>
>>>  drivers/mmc/core/pwrseq_emmc.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
>>> index 137c97fb7aa8..ad4f94ec7e8d 100644
>>> --- a/drivers/mmc/core/pwrseq_emmc.c
>>> +++ b/drivers/mmc/core/pwrseq_emmc.c
>>> @@ -84,11 +84,11 @@ struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
>>>  
>>>  	/*
>>>  	 * register reset handler to ensure emmc reset also from
>>> -	 * emergency_reboot(), priority 129 schedules it just before
>>> -	 * system reboot
>>> +	 * emergency_reboot(), priority 255 is the highest priority
>>> +	 * so it will be executed before any system reboot handler.
>>>  	 */
>>>  	pwrseq->reset_nb.notifier_call = mmc_pwrseq_emmc_reset_nb;
>>> -	pwrseq->reset_nb.priority = 129;
>>> +	pwrseq->reset_nb.priority = 255;
>>
>> I see the problem which you are trying to solve but this may be tricker
>> then just kicking the number. Some of restart handlers are registered
>> with priority 192. I found few of such, like: at91_restart_nb,
>> zynq_slcr_restart_nb, rmobile_reset_nb (maybe more, I did not grep too
>> much).
>>
> 
> Yes, the syscon-reboot restart handler also uses a priority 192 and that
> is why reboot with eMMC broke with Alim's patches since the PMU restart
> handler priority is 128.
> 
>> I guess they chose the "192" priority on purpose.
>>
> 
> I tried to understand what's the policy w.r.t priority numbering for
> restart handlers but only found this in the register_restart_handler
> kernel-doc [0]:
> 
> /**
>  *	register_restart_handler - Register function to be called to reset
>  *				   the system
>  *	@nb: Info about handler function to be called
>  *	@nb->priority:	Handler priority. Handlers should follow the
>  *			following guidelines for setting priorities.
>  *			0:	Restart handler of last resort,
>  *				with limited restart capabilities
>  *			128:	Default restart handler; use if no other
>  *				restart handler is expected to be available,
>  *				and/or if restart functionality is
>  *				sufficient to restart the entire system
>  *			255:	Highest priority restart handler, will
>  *				preempt all other restart handlers
> 
> So, reading that is not clear to me if only the values 0, 128 and 255
> should be used or any value from 0-255.
> 
> What's clear to me is that restart handlers to reset a specific hw block
> should be called before the restart handler that resets the whole system.
> 
> The 192 seems to be used because there are other default restart handlers
> that are using a prio of 128. See for example the commit that changed the
> syscon-reboot prio from 128 to 192:
> 
> b81180b3fd48 power: reset: adjust priority of simple syscon reboot driver

But were are here not talking about syscon handler but the others. Now
you will be ahead of them.

> 
> So probably the 192 value was chosen because is in the middle of 128 and
> 255 but it seems to me a rather arbitrary value and I would prefer it to
> be documented in some place.
> 
>> Effectively, now the emmc handler will be executed before their
>> handlers... is it an issue? Maybe some testing on these platforms is
>> necessary?
>>
> 
> I don't think is an issue, the reason why I chose 255 is that it is
> a documented value in the kernel-doc and since is the highest prio,
> it makes sure the eMMC will be reset before any system restart handler.
> 
> Also, the pwrseq_emmc driver is only used in platforms whose SoC ROM
> can either leave the eMMC in an unknown state so the kernel needs to
> hw reset the eMMC or does not have a reset logic so it can only read
> from an eMMC if is in a known state (i.e: after a reset from kernel).

I think at least one platform may be affected because it used
mmc-pwrseq-emmc and gpio-restart.

Look at rk3288-veyron.dtsi.

Both of restart handlers had the priority of 129 which means that the
order of execution depends on probing sequence. Now you will make the
sequence strict - first mmc then gpio.

You seems convinced that this is not a problem... I don't know. I would
prefer test this on affected platforms before risking to break them.
It's annoying if fix for one SoC breaks another.

> 
> Since the current mmc_pwrseq_emmc_reset_nb notifier priority is 129,
> eMMC reset will not work if one of the platforms you mentioned needs
> this since the system restart handler with prio 192 will be executed
> before the eMMC one, leaving the eMMC in an unknown state on reboot.

And now you will "fix this" by making eMMC working correctly. So let's
make it straight:
1. Previously the eMMC could be left on these platforms in an unknown
state (because emmc handler was not executed).
2. No one complained! Which could mean that in fact this was working fine...
3. Now you will change it.
4. Maybe someone will complain?

Just test it (or get an ack/tested tag). That's all what is needed.


> And $SUBJECT should not cause any regressions for the platforms that
> are currently using the pwrseq_emmc, since the restart handler was
> already being called before the system restart handler so bumping
> the priority should not cause any effect.

I found at least one platform where the sequence *might* change. There
could be more of them.

Best regards,
Krzysztof

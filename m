From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] mmc: pwrseq: Use highest priority for eMMC restart
 handler
Date: Thu, 22 Oct 2015 18:07:58 +0200
Message-ID: <562909DE.1000202@osg.samsung.com>
References: <1445440540-21525-1-git-send-email-javier@osg.samsung.com>
 <56282F71.2070408@samsung.com> <562839F7.3040005@osg.samsung.com>
 <56283F27.9060804@samsung.com>
 <CAD=FV=VZJ9Tc4G-Xiw60DmfC4izU_6dVwwa0N0ePM0eaJfcqkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:46504 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965091AbbJVQIG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Oct 2015 12:08:06 -0400
In-Reply-To: <CAD=FV=VZJ9Tc4G-Xiw60DmfC4izU_6dVwwa0N0ePM0eaJfcqkg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>

Hello Doug,

On 10/22/2015 05:34 PM, Doug Anderson wrote:
> Krzysztof,
> 
> On Wed, Oct 21, 2015 at 6:43 PM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> I think at least one platform may be affected because it used
>> mmc-pwrseq-emmc and gpio-restart.
>>
>> Look at rk3288-veyron.dtsi.
>>
>> Both of restart handlers had the priority of 129 which means that the
>> order of execution depends on probing sequence. Now you will make the
>> sequence strict - first mmc then gpio.
>>
>> You seems convinced that this is not a problem... I don't know. I would
>> prefer test this on affected platforms before risking to break them.
>> It's annoying if fix for one SoC breaks another.
> 
> Assuming I'm understanding things properly, veyron isn't using 129 as
> a priority.  In the dts file:
> 
>         gpio-restart {
>                 compatible = "gpio-restart";
>                 gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&ap_warm_reset_h>;
>                 priority = <200>;
>         };
> 
> ...so it overrides the default 129 with 200.  Ah, but Javier already
> pointed that out in his reply.
> 
>>> Since the current mmc_pwrseq_emmc_reset_nb notifier priority is 129,
>>> eMMC reset will not work if one of the platforms you mentioned needs
>>> this since the system restart handler with prio 192 will be executed
>>> before the eMMC one, leaving the eMMC in an unknown state on reboot.
>>
>> And now you will "fix this" by making eMMC working correctly. So let's
>> make it straight:
>> 1. Previously the eMMC could be left on these platforms in an unknown
>> state (because emmc handler was not executed).
>> 2. No one complained! Which could mean that in fact this was working fine...
>> 3. Now you will change it.
>> 4. Maybe someone will complain?
> 
> On veyron boards the reset shouldn't hurt.  The eMMC reset will
> actually get asserted at reset anyway since the reset will reset GPIO
> states and the default GPIO state for the eMMC line asserts reset.
>

Exactly, that was my point. Either the board is wired to do a eMMC reset
on reboot (like veyron), the SoC ROM bootloader has some logic to reset
the eMMC or the boards requires the kernel to do a eMMC reset so the hw
is in a known state to read from the eMMC on reboot (like Odroids).

So that's why I was arguing that it's very unlikely that doing an eMMC
reset could cause issues in other boards... but Krzysztof is correct
that you can't be sure without testing.
 
> OK, I just picked this onto Heiko's somewhat "stable-tree"
> (v4.3-rc3-876-g6509232) from
> <https://github.com/mmind/linux-rockchip/>.  I put printouts in
> __mmc_pwrseq_emmc_reset() to confirm it was getting called.  I then
> rebooted.  I then saw:
> 
> [   36.175732] reboot: Restarting system
> [   36.179400] DOUG: resetting emmc
> [   36.182829] DOUG: resetting emmc done
> 
> ...and the reboot worked normally (which means that the GPIO restart
> got called since otherwise I would have gotten TPM errors).
> 
> So I'd say that for rk3288-veyron-jerry:
> 
> Tested-by: Douglas Anderson <dianders@chromium.org>
> 

Thanks a lot for testing!

> 
> Note that personally I would only choose the "highest" priority as an
> absolute last resort.  Leaving a little extra slack in there means
> that when the next person comes up with a really good reason to run
> before you do that they can do it without changing your code.  All
> good BASIC programmers know to skip "10" in their first version for
> just this reason.  ;)
>
> If I were to pick a number, I suppose I'd pick something like "220",
> but that's pretty arbitrary.  I would have picked 200 except that it
> appears that would race with veyron's choice.
>

Yes, I actually gave some thought about choosing a number since I didn't
want to come with another arbitrary one. That's why I tried to understand
the policy as I mentioned before but I didn't find anything besides the
values listed in the register_restart_handler() doc: 0, 128 and 255.

It seems that most default system restart handlers use 128 and that's
the reason why gpio-restart and mmc-pwrseq-emmc use 129 and other restart
handlers that can be registered via DT use 192 (which is in the middle of
128 and 255).

So I actually thought to use a number in between 192 and 255 (i.e: 220)
but then there could be another platform that uses 221 instead of 200
so eMMC restart won't work there. That's why I finally chose the highest.

Do you know why the priority 200 was chosen for veyron gpi-restart ooi?

> -Doug
> --

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

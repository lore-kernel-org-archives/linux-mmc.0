From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/4] mmc: core: add support for hardware reset gpio line
Date: Fri, 30 Jan 2015 11:37:01 +0100
Message-ID: <54CB5ECD.4090909@samsung.com>
References: <1422453595-21160-1-git-send-email-m.szyprowski@samsung.com>
 <1422453595-21160-2-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFpowidghwadJS+gYP0EVo6gRUhAG8s14CMEbwatFadP2Q@mail.gmail.com>
 <54C9FA48.5050705@samsung.com>
 <CABxcv=nbTcuzcmhYHKnDom5XFd+gqUbKRF0THCKsN5tL8-cBGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43919 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbbA3KhN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Jan 2015 05:37:13 -0500
In-reply-to: <CABxcv=nbTcuzcmhYHKnDom5XFd+gqUbKRF0THCKsN5tL8-cBGA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <liquid.acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Joonyoung Shim <jy0922.shim@samsung.com>

Hello,

On 2015-01-29 11:56, Javier Martinez Canillas wrote:
> On Thu, Jan 29, 2015 at 10:15 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>>> Also, I wonder whether we could extend the mmc-pwrseq to cover your
>>> case? Did you consider that as an option?
>>
>> I didn't consider mmc-pwrseq yet. For me it looked straightforward to
> I agree with Ulf that using mmc-pwrseq would be a good solution and in
> fact I think the pwrseq_simple [0] driver will fit your use case since
> it supports a reset GPIO pin which is what many WLAN chips attached to
> a SDIO interface use.

Ok, I've checked mmc-prwseq and mmc-pwrseq-simple. I also checked the
hardware and it mmc-pwrseq-simple cannot be used directly.

Although the signal is called RSTN (on Odroid U3 schema), the eMMC card
gets resetted not on low line level, but during the rising edge. This RSTN
line is also pulled up by the external resistor. However, the strangest
thing is the fact that the default SoC configuration (which is applied
during hw reset) for this GPIO line is input, pulled-down. The SoC
internal pull-down is stronger than the external pull up, so in the end,
during the SoC reboot the RSTN signal is set to zero. Later bootloader
disables the internal pull-down.

To sum up - to perform proper reboot on Odroid U3/XU3, one need to set
RSTN to zero, wait a while and the set it back to 1.

To achieve this with mmc-pwrseq-simple, I would need to modify the power_off
callback to toggle reset line to zero and back to one. This however might
not be desired to other sd/mmc cards used with mmc-pwrseq-simple.

I can also provide separate mmc-pwrsrq-odroid driver, which will be very
similar to mmc-pwrseq-simple.

Ulf - which approach would you prefer?


>
>> implement
>> it just like card detect or write-protection gpio pins. I already noticed
>> that
>> there is code for some mmc host driver, which perform mmc hardware reset. If
>> you
>> think that extending pwrseq is the better approach, I will try to update my
>> patches. This will add reboot handler to mmc-pwrseq then. The only question
>> is
> I don't think that adding a reboot handler to mmc-pwrseq is needed.
> AFAICT the call chain is:
>
> sys_reboot() -> kernel_restart() -> device_shutdown() ->
> mmc_bus_shutdown() -> _mmc_suspend() -> mmc_power_off() ->
> mmc_pwrseq_power_off() -> struct mmc_pwrseq_ops .power_off
>
> So since the pwrseq_simple already asserts the reset GPIO in
> .power_off, it should be enough to ensure the eMMC will be reset to
> its default configuration for the iROM to work properly.
>
> It also asserts the GPIO pin in .pre_power_on and de-asserts in
> .post_power_on which should be needed as well for the other case you
> mentioned when a broken bootloader left the emmc card in some unknown
> state.

emergency_restart() doesn't call device_shutdown(), so I think it still 
makes
sense to add real reset handler to mmc-pwrseq to ensure that power_off will
be called even during emergency_restart().

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


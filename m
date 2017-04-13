From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Don't allow Runtime PM for SDIO cards
Date: Thu, 13 Apr 2017 08:05:52 -0700
Message-ID: <CAD=FV=Udz1-9ptu8FdGJGZZw-T_pCF2nnm7AfB=GaA4-wzuKAQ@mail.gmail.com>
References: <20170411225543.987-1-dianders@chromium.org> <CAPDyKFo4FMu0F5DwBNb4b5JTp5UwHAUBQdvk00J5zzvbk6OZSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37406 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbdDMPFz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Apr 2017 11:05:55 -0400
Received: by mail-wm0-f42.google.com with SMTP id u2so48993177wmu.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Apr 2017 08:05:54 -0700 (PDT)
In-Reply-To: <CAPDyKFo4FMu0F5DwBNb4b5JTp5UwHAUBQdvk00J5zzvbk6OZSQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Brian Norris <briannorris@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, kevin@archlinuxarm.org, Alexandru Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, "# 4.0+" <stable@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Thu, Apr 13, 2017 at 2:32 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 April 2017 at 00:55, Douglas Anderson <dianders@chromium.org> wrote:
>> According to the SDIO standard interrupts are normally signalled in a
>> very complicated way.  They require the card clock to be running and
>> require the controller to be paying close attention to the signals
>> coming from the card.  This simply can't happen with the clock stopped
>> or with the controller in a low power mode.
>
> Right - unless we have a possibility to re-route the SDIO irq line to
> GPIO irq for wake-up when the controller enters low power state.

Yup.  Hence the "normally signalled".  ;)


>> To that end, we'll disable runtime_pm when we detect that an SDIO card
>> was inserted.  This is much like with what we do with the special
>> "SDMMC_CLKEN_LOW_PWR" bit that dw_mmc supports.
>
> I wonder whether this is related to SDIO IRQs but not generic to SDIO.
>
> For example, when we have a WIFI chip with a dedicated and separate
> IRQ line, enabling SDMMC_CLKEN_LOW_PWR could make sense.

Yes, I believe this to be the case too.  It has always been on my TODO
list to see if I could figure out how to make this work, but it never
rose to the top.

One thing I wasn't sure about: is SDIO truly stateless enough that you
could fully power down the controller while you were waiting for an
interrupt?  I've never dug down that far into the protocol.

For certain, though, you wouldn't want to remove VMMC from an SDIO
card while waiting for an interrupt.  This contrasts to an SD or eMMC
memory card where you could plausibly do that if you're not actively
reading from or writing to the card (though I think some cards may do
background garbage collection, so maybe?? you could interfere with
that?)


>> To fix the above isues we'd want to put something in the standard
>> sdio_irq code that makes sure to call pm_runtime get/put when
>> interrupts are being actively being processed.  That's possible to do,
>> but it seems like a more complicated mechanism when we really just
>> want the runtime pm disabled always for SDIO cards given that all the
>> other bits needed to get Runtime PM vs. SDIO just aren't there.
>>
>> NOTE: at some point in time someone might come up with a fancy way to
>> do SDIO interrupts and still allow (some) amount of runtime PM.
>> Technically we could turn off the card clock if we used an alternate
>> way of signaling SDIO interrupts (and out of band interrupt is one way
>> to do this).  We probably wouldn't actually want to fully runtime
>> suspend in this case though--at least not with the current
>> dw_mci_runtime_resume() which basically fully resets the controller at
>> resume time.
>
> I understand this "quick" fix in dw_mmc takes care of the problem.
> However, allow me to try to make this a bit more generic. I intend to
> post something within a few days. If I fail, let's go with this
> solution.

Most certainly!  If you can come up with something better then I'd be happy!

-Doug

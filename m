From: Doug Anderson <dianders@google.com>
Subject: Re: [REGRESSION 4.10] dw_mmc: failures on Rockchip rk3288 veyron boards
Date: Thu, 13 Apr 2017 08:45:45 -0700
Message-ID: <CAD=FV=UyvnkzbDq_Qhnx-GJq1zL8_BshSUVXeXUbSbdJwPXdjA@mail.gmail.com>
References: <20170330011709.GA110687@google.com> <CAD=FV=WWt=20WUT8jhZ3fBPiQq9UM-bEuFSXuuNu_7d3ONLdLQ@mail.gmail.com>
 <23842930-ece6-8879-daa5-c2220cfbf09f@rock-chips.com> <CAD=FV=U+SQ8RwPz+8tVzoLgTLNM=jca1FtLBgsZ+GTY24rhTKQ@mail.gmail.com>
 <CAPDyKFrv+BR-tz8zp93vLwW9JBybp7BCjW4nSn3H9u4Kxt56EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36250 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdDMPpt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Apr 2017 11:45:49 -0400
Received: by mail-wm0-f48.google.com with SMTP id o81so114420828wmb.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Apr 2017 08:45:48 -0700 (PDT)
In-Reply-To: <CAPDyKFrv+BR-tz8zp93vLwW9JBybp7BCjW4nSn3H9u4Kxt56EA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Brian Norris <briannorris@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru M Stan <amstan@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, kevin@archlinuxarm.org

Hi,

On Thu, Apr 13, 2017 at 12:17 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 April 2017 at 18:12, Doug Anderson <dianders@google.com> wrote:
>> Shawn
>>
>> On Tue, Apr 11, 2017 at 5:54 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>> This doesn't surprise me at all.  What surprises me, though, is that
>>>> nobody else seems to be able to reproduce this.
>>>>
>>>> On veyron, WiFi is connected via SDIO.  For good speed, it uses SDIO
>>>> Interrupts.  See this bit in the device tree:
>>>>
>>>>   cap-sdio-irq;
>>>>
>>>
>>> all of *my* boards are using side-band interrupt, so there are no
>>> "cap-sdio-irq".
>>
>> They are all using side-band interrupt?  What WiFi device do you have connected?
>>
>> If you're truly using a side-band interrupt using the dedicated SDIO
>> interrupt pin on your SoC, I'm pretty sure you still need to define
>> cap-sdio-irq in order for things to work properly.  If you don't do
>> that, you'll get "polling mode" for SDIO Interrupts.  See
>> sdio_irq_thread() where you can see that the kernel will poll your
>> device every 10 ms if MMC_CAP_SDIO_IRQ isn't set.
>
> In these cases I would expect the WIFI driver to deal with the SDIO
> IRQ itself and not requesting it via calling sdio_claim_irq(). Because
> of this, there should be no polling performed by the sdio_irq_thread.

You're the boss here, but that's not how I envisioned it if I ever
found time to dig deeper.

My vision of the world is probably colored by the dw_mmc IP block,
though.  Both of the two SoC families that I've dealt with that have
dw_mmc (both Exynos and Rockchip) have always had a pin that could be
muxed as "SDIO Interrupt".  If you choose this pinmux, my
understanding is that it will assert the dw_mmc's normal SDIO
interrupt in the IP block.  The DesignWare datasheet talks about this
in terms of eSDIO.  It does talk a little bit about the fact that this
method of interrupting can happen even when the card clock is off.

Given that this concept seems generic, is directly supported by the
dw_mmc hardware, and is talked about in the dw_mmc datasheet, it seems
as if dw_mmc would be the place to deal with it.

If other controllers don't support this concept in a generic way, I
see no reason why we still couldn't handle it in a generic way (via a
GPIO) at the mmc level rather than forcing each WiFi driver to invent
this themselves.

...but obviously I haven't worked through all the details and have
never actually coded this up successfully.

>> Maybe you should try defining cap-sdio-irq and see if you get a big
>> performance boost?
>
> No, that seems like a bad idea. I think it would rather add overhead -
> decreasing performance. Likely it will also make us wake up the mmc
> host from its low power state, when when it actually isn't needed.

Sounds like Shawn is using an out-of-tree driver, but if it's anything
like the in-tree driver then there's no Runtime PM anyway.  See the
pm_runtime_forbid() in brcmf_sdiod_probe().

-Doug

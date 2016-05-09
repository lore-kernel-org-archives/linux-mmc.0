From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] dt-bindings: rockchip-dw-mshc: add rockchip,default-drv-phase
Date: Mon, 9 May 2016 09:31:54 -0700
Message-ID: <CAD=FV=XToSzqSh=SShHuQU9W_m7gfyQn8wRXkLy79t+tnqZknA@mail.gmail.com>
References: <1462527648-24443-1-git-send-email-shawn.lin@rock-chips.com>
	<1462527673-24711-1-git-send-email-shawn.lin@rock-chips.com>
	<CAD=FV=WSkBwBjVsRoDsfjD+sNfR70mKGRA0khjPKKW0zS2=PTw@mail.gmail.com>
	<b15dcb4f-1584-8219-2fe0-97eecb0c64a6@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35627 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbcEIQbz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2016 12:31:55 -0400
Received: by mail-vk0-f50.google.com with SMTP id f66so72662004vkh.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 May 2016 09:31:55 -0700 (PDT)
In-Reply-To: <b15dcb4f-1584-8219-2fe0-97eecb0c64a6@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi,

On Mon, May 9, 2016 at 4:12 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> 1. Specifying a single number for this property in terms of "degrees"
>> is probably not right.  The whole point of setting the "drive phase"
>> is to meet hold times, which are specified in the spec in terms of ns
>> in the spec and also specified differently for different SD/MMC speed
>> modes.  Note also that "phase" translates to very different delays (in
>> terms of ns) depending on the clock rate:
>>
>> At 400 kHz, period is 2.5 us, so 90 degree phase offset is a delay of 625
>> ns
>> At 25 MHz, period is 40 ns, so a 90 degree phase offset represents a
>> delay of 10 ns.
>> At 50 MHz, period is 20 ns, so a 90 degree phase offset represents a
>> delay of 5 ns.
>> At 200 MHz, period is period is 5 ns, so a 90 degree phase offset
>> represents a delay of 1.25 ns.
>
>
> yes, if we use degrees only(0/90/180/270), the timing is always right.
> But considering the delay number, we need to do some crazy calculation
> in the set_ios callback.

Great, so let's limit it to 0/90/180/270 for the drive phase offset.
We don't need lots of precision for the drive phase offset (right?)
and accuracy is more important.


>> 2. As I understand it, the value needed for the drive phase is not
>> board specific unless you've got super crazy layout on a board (where
>> the clock line takes a very different path than everything else).
>> It's also not even terribly SoC-specific unless you've got some very
>> strange incarnation of dw_mmc that has very different internal delays
>> than everyone else.  Said another way, until we see an instance of an
>> SoC/board that really needs to do things special I'd say that we
>> should just implement this all in code (no device tree bindings).
>>
>
> I'm prone to think it should be Soc specific if making sure the layout
> for data lines is in equal length.

Sure, it can be SoC specific.  ...though at the moment, I'd bet that
you can come up with a single rule for the drive phase offset that
will work for every Rockchip SoC produced so far, especially if you
are using only 0/90/180/270.  I'd imagine that they all have similar
enough internal delays.


>> 3. If this property was actually board specific and actually needed to
>> be tuned board-by-board, you'd have a bug because your new device tree
>> bindings are not backward compatible and you'd probably be breaking
>> old boards.  Specifically you're changing the definition of what
>> happens when "rockchip,default-drv-phase" is not specified.  Old
>> behavior was to leave the value that was setup by the firmware (or
>> perhaps the hardware default if the firmware didn't touch this).
>
>
> drv_phase is for all the data lines instead of tuning the lines
> one-by-one. So this patch can't save the terrible board layout.
> But I agree that it will break the compatibility backward if firware
> touch this value.
>
>>
>> ---
>>
>> OK, so what should we do?
>>
>> We could certainly do lots of crazy math to come up with the ideal
>> hold time for all different speed modes and all different types of
>> cards.  With my reading of the Designware Databook this would mean
>> that somewhere we'd want to specify which delay method we're using
>> (phase shift vs. delay line) and how long all the delays timings all
>> are on your particular SoC.  That all sounds quite difficult, though.
>
>
> delay line is diff from chip to chip, soc-to-soc, board-to-board. For
> sample-phase we have tuning process and re-tune, but not for drv-phase.
> So We bascially should avoid to use it for drv-phase. Another
> consideration is the temperature drift of delay line.
>
> Maybe we should do some tricky limitation on clk-mmc-phase to only
> support fixed degrees?

As per above, let's not use delay line for drive delay.  On all
Rockchip SoCs that I have seen it's possible to make 0/90/180/270 very
accurately.  That means no board-to-board differences.  Current
mainline Linux kernel source code will always make 0/90/180/270 using
phase offset (not delay line).

For sampling we use tuning and using the delay elements makes some
sense (since 90 degrees is not quite accurate enough to fully tune
UHS).  ...but for driving where the only requirement is hold times we
don't need delay elements.


>> Probably you could just add a simple function that looked at the clock
>> and speed mode and always chose an offset of 90 or 180 degrees.  At
>> least on Rockchip devices you can be certain that you can make 90 and
>> 180 degrees using phase shifts and thus the timings should be
>> consistent.  By default you could just always choose 180.  The
>> Designware databook has some examples where it picked 90 degrees
>> (SDR50, DDR50, SDR25, MMC High Speed), but I'm not enough of an MMC
>> expert to know if there is some benefit to choosing 90.  Would we
>> violate any specs if we just chose 180 degrees all the time everywhere
>> on all Rockchip devices?
>
>
> It needs more waveform test to see how things going. But most of
> rockchip platforms in the pass years didn't touch drv-phase stuff not
> only in kernel but also in firmware, then we still cannot see the
> violation against the spec when using defalut reset value, namely 180, for
> drv-phase.

Right, most Rockchip platforms simply don't touch this and it works
OK.  ...but I don't think it defaults to 180.  Grepping through on my
veyron (rk3288) device shows

       sdio1_drv - 90
       sdio0_drv - 90
       sdmmc_drv - 90
       emmc_drv -180

...and, as we've seen, these values appear to be 270 on some other SoCs.


The claim from the Designware Databook says that SDR104 and SDR12, and
identification mode need 180 degrees to work properly.  It would be
interesting to hook up rk3288 to a signal analyzer and see hold times
are OK or if we need to move up to 180 degrees for those modes.

Note that the Designware Databook assumes "Delay_O" of 1.4ns.  If
yours is shorter then maybe 90 degrees is OK for those modes?


Also: I still haven't heard whether there is any downside to using 180
degrees for modes that only require 90 degrees.  Does it cause
problems to just always use 180 degrees?  If not, we could possibly
use 180 degrees everywhere and just hardcode it?


...but if 180 is ideal everywhere, can you answer:

* Why does dw_mmc manual spend so much time talking about it?  It
could just say "set to 180 degrees".

* Why do Rockchip SoCs default to values that are not 180 degrees?

-Doug

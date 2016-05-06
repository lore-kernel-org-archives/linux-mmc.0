From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] dt-bindings: rockchip-dw-mshc: add rockchip,default-drv-phase
Date: Fri, 6 May 2016 10:26:34 -0700
Message-ID: <CAD=FV=WSkBwBjVsRoDsfjD+sNfR70mKGRA0khjPKKW0zS2=PTw@mail.gmail.com>
References: <1462527648-24443-1-git-send-email-shawn.lin@rock-chips.com>
	<1462527673-24711-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36806 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758517AbcEFR0f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2016 13:26:35 -0400
Received: by mail-qk0-f176.google.com with SMTP id x7so63795416qkd.3
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2016 10:26:35 -0700 (PDT)
In-Reply-To: <1462527673-24711-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Shawn,

On Fri, May 6, 2016 at 2:41 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> rockchip,default-drv-phase is used to set the default drv degrees.
> drv phases will decide the write timing of mmc controller.

Device tree bindings should probably have been patch 1/2, then the
code patch 2/2.


> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> index ea5614b..c48dba6 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> @@ -29,6 +29,9 @@ Optional Properties:
>    probing, low speeds or in case where all phases work at tuning time.
>    If not specified 0 deg will be used.
>
> +* rockchip,default-drv-phase: The default phase to set ciu_drv at probing
> +  for host to write data to devices. If not specified 180 deg will be used.

This is probably not right for a few reasons.

1. Specifying a single number for this property in terms of "degrees"
is probably not right.  The whole point of setting the "drive phase"
is to meet hold times, which are specified in the spec in terms of ns
in the spec and also specified differently for different SD/MMC speed
modes.  Note also that "phase" translates to very different delays (in
terms of ns) depending on the clock rate:

At 400 kHz, period is 2.5 us, so 90 degree phase offset is a delay of 625 ns
At 25 MHz, period is 40 ns, so a 90 degree phase offset represents a
delay of 10 ns.
At 50 MHz, period is 20 ns, so a 90 degree phase offset represents a
delay of 5 ns.
At 200 MHz, period is period is 5 ns, so a 90 degree phase offset
represents a delay of 1.25 ns.


2. As I understand it, the value needed for the drive phase is not
board specific unless you've got super crazy layout on a board (where
the clock line takes a very different path than everything else).
It's also not even terribly SoC-specific unless you've got some very
strange incarnation of dw_mmc that has very different internal delays
than everyone else.  Said another way, until we see an instance of an
SoC/board that really needs to do things special I'd say that we
should just implement this all in code (no device tree bindings).



3. If this property was actually board specific and actually needed to
be tuned board-by-board, you'd have a bug because your new device tree
bindings are not backward compatible and you'd probably be breaking
old boards.  Specifically you're changing the definition of what
happens when "rockchip,default-drv-phase" is not specified.  Old
behavior was to leave the value that was setup by the firmware (or
perhaps the hardware default if the firmware didn't touch this).

---

OK, so what should we do?

We could certainly do lots of crazy math to come up with the ideal
hold time for all different speed modes and all different types of
cards.  With my reading of the Designware Databook this would mean
that somewhere we'd want to specify which delay method we're using
(phase shift vs. delay line) and how long all the delays timings all
are on your particular SoC.  That all sounds quite difficult, though.

Probably you could just add a simple function that looked at the clock
and speed mode and always chose an offset of 90 or 180 degrees.  At
least on Rockchip devices you can be certain that you can make 90 and
180 degrees using phase shifts and thus the timings should be
consistent.  By default you could just always choose 180.  The
Designware databook has some examples where it picked 90 degrees
(SDR50, DDR50, SDR25, MMC High Speed), but I'm not enough of an MMC
expert to know if there is some benefit to choosing 90.  Would we
violate any specs if we just chose 180 degrees all the time everywhere
on all Rockchip devices?



-Doug

From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 2/2] dt-bindings: rockchip-dw-mshc: add
 rockchip,default-drv-phase
Date: Mon, 9 May 2016 19:12:17 +0800
Message-ID: <b15dcb4f-1584-8219-2fe0-97eecb0c64a6@rock-chips.com>
References: <1462527648-24443-1-git-send-email-shawn.lin@rock-chips.com>
 <1462527673-24711-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=WSkBwBjVsRoDsfjD+sNfR70mKGRA0khjPKKW0zS2=PTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=WSkBwBjVsRoDsfjD+sNfR70mKGRA0khjPKKW0zS2=PTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 2016/5/7 1:26, Doug Anderson wrote:
> Shawn,
>
> On Fri, May 6, 2016 at 2:41 AM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> rockchip,default-drv-phase is used to set the default drv degrees.
>> drv phases will decide the write timing of mmc controller.
>
> Device tree bindings should probably have been patch 1/2, then the
> code patch 2/2.
>
>
>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>
>>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
>> index ea5614b..c48dba6 100644
>> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
>> @@ -29,6 +29,9 @@ Optional Properties:
>>    probing, low speeds or in case where all phases work at tuning time.
>>    If not specified 0 deg will be used.
>>
>> +* rockchip,default-drv-phase: The default phase to set ciu_drv at probing
>> +  for host to write data to devices. If not specified 180 deg will be used.
>
> This is probably not right for a few reasons.
>
> 1. Specifying a single number for this property in terms of "degrees"
> is probably not right.  The whole point of setting the "drive phase"
> is to meet hold times, which are specified in the spec in terms of ns
> in the spec and also specified differently for different SD/MMC speed
> modes.  Note also that "phase" translates to very different delays (in
> terms of ns) depending on the clock rate:
>
> At 400 kHz, period is 2.5 us, so 90 degree phase offset is a delay of 625 ns
> At 25 MHz, period is 40 ns, so a 90 degree phase offset represents a
> delay of 10 ns.
> At 50 MHz, period is 20 ns, so a 90 degree phase offset represents a
> delay of 5 ns.
> At 200 MHz, period is period is 5 ns, so a 90 degree phase offset
> represents a delay of 1.25 ns.

yes, if we use degrees only(0/90/180/270), the timing is always right.
But considering the delay number, we need to do some crazy calculation
in the set_ios callback.

>
>
> 2. As I understand it, the value needed for the drive phase is not
> board specific unless you've got super crazy layout on a board (where
> the clock line takes a very different path than everything else).
> It's also not even terribly SoC-specific unless you've got some very
> strange incarnation of dw_mmc that has very different internal delays
> than everyone else.  Said another way, until we see an instance of an
> SoC/board that really needs to do things special I'd say that we
> should just implement this all in code (no device tree bindings).
>

I'm prone to think it should be Soc specific if making sure the layout
for data lines is in equal length.

>
>
> 3. If this property was actually board specific and actually needed to
> be tuned board-by-board, you'd have a bug because your new device tree
> bindings are not backward compatible and you'd probably be breaking
> old boards.  Specifically you're changing the definition of what
> happens when "rockchip,default-drv-phase" is not specified.  Old
> behavior was to leave the value that was setup by the firmware (or
> perhaps the hardware default if the firmware didn't touch this).

drv_phase is for all the data lines instead of tuning the lines
one-by-one. So this patch can't save the terrible board layout.
But I agree that it will break the compatibility backward if firware
touch this value.

>
> ---
>
> OK, so what should we do?
>
> We could certainly do lots of crazy math to come up with the ideal
> hold time for all different speed modes and all different types of
> cards.  With my reading of the Designware Databook this would mean
> that somewhere we'd want to specify which delay method we're using
> (phase shift vs. delay line) and how long all the delays timings all
> are on your particular SoC.  That all sounds quite difficult, though.

delay line is diff from chip to chip, soc-to-soc, board-to-board. For 
sample-phase we have tuning process and re-tune, but not for drv-phase.
So We bascially should avoid to use it for drv-phase. Another
consideration is the temperature drift of delay line.

Maybe we should do some tricky limitation on clk-mmc-phase to only
support fixed degrees?

>
> Probably you could just add a simple function that looked at the clock
> and speed mode and always chose an offset of 90 or 180 degrees.  At
> least on Rockchip devices you can be certain that you can make 90 and
> 180 degrees using phase shifts and thus the timings should be
> consistent.  By default you could just always choose 180.  The
> Designware databook has some examples where it picked 90 degrees
> (SDR50, DDR50, SDR25, MMC High Speed), but I'm not enough of an MMC
> expert to know if there is some benefit to choosing 90.  Would we
> violate any specs if we just chose 180 degrees all the time everywhere
> on all Rockchip devices?

It needs more waveform test to see how things going. But most of
rockchip platforms in the pass years didn't touch drv-phase stuff not
only in kernel but also in firmware, then we still cannot see the
violation against the spec when using defalut reset value, namely 180, 
for drv-phase.

>
>
>
> -Doug
>
>
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

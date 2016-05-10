From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] dt-bindings: rockchip-dw-mshc: add rockchip,default-drv-phase
Date: Tue, 10 May 2016 08:57:03 -0700
Message-ID: <CAD=FV=UGbrJRyUbbgzbcYf9GjPG+Fh_gpQ3rX2G=wi2w5Lw=Sg@mail.gmail.com>
References: <1462527648-24443-1-git-send-email-shawn.lin@rock-chips.com>
	<1462527673-24711-1-git-send-email-shawn.lin@rock-chips.com>
	<CAD=FV=WSkBwBjVsRoDsfjD+sNfR70mKGRA0khjPKKW0zS2=PTw@mail.gmail.com>
	<b15dcb4f-1584-8219-2fe0-97eecb0c64a6@rock-chips.com>
	<CAD=FV=XToSzqSh=SShHuQU9W_m7gfyQn8wRXkLy79t+tnqZknA@mail.gmail.com>
	<1f2f43c7-2672-e448-eddb-2d613bb8dc48@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1f2f43c7-2672-e448-eddb-2d613bb8dc48@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

(again, but not HTML)

On Tue, May 10, 2016 at 3:19 AM, Shawn Lin <shawn.lin@rock-chips.com> w=
rote:
> =E5=9C=A8 2016/5/10 0:31, Doug Anderson =E5=86=99=E9=81=93:
>>
>> Hi,
>>
>> On Mon, May 9, 2016 at 4:12 AM, Shawn Lin <shawn.lin@rock-chips.com>
>> wrote:
>>>>
>>>> 1. Specifying a single number for this property in terms of "degre=
es"
>>>> is probably not right.  The whole point of setting the "drive phas=
e"
>>>> is to meet hold times, which are specified in the spec in terms of=
 ns
>>>> in the spec and also specified differently for different SD/MMC sp=
eed
>>>> modes.  Note also that "phase" translates to very different delays=
 (in
>>>> terms of ns) depending on the clock rate:
>>>>
>>>> At 400 kHz, period is 2.5 us, so 90 degree phase offset is a delay=
 of
>>>> 625
>>>> ns
>>>> At 25 MHz, period is 40 ns, so a 90 degree phase offset represents=
 a
>>>> delay of 10 ns.
>>>> At 50 MHz, period is 20 ns, so a 90 degree phase offset represents=
 a
>>>> delay of 5 ns.
>>>> At 200 MHz, period is period is 5 ns, so a 90 degree phase offset
>>>> represents a delay of 1.25 ns.
>>>
>>>
>>>
>>> yes, if we use degrees only(0/90/180/270), the timing is always rig=
ht.
>>> But considering the delay number, we need to do some crazy calculat=
ion
>>> in the set_ios callback.
>>
>>
>> Great, so let's limit it to 0/90/180/270 for the drive phase offset.
>> We don't need lots of precision for the drive phase offset (right?)
>> and accuracy is more important.
>
>
> yes.
>
>>
>>
>>>> 2. As I understand it, the value needed for the drive phase is not
>>>> board specific unless you've got super crazy layout on a board (wh=
ere
>>>> the clock line takes a very different path than everything else).
>>>> It's also not even terribly SoC-specific unless you've got some ve=
ry
>>>> strange incarnation of dw_mmc that has very different internal del=
ays
>>>> than everyone else.  Said another way, until we see an instance of=
 an
>>>> SoC/board that really needs to do things special I'd say that we
>>>> should just implement this all in code (no device tree bindings).
>>>>
>>>
>>> I'm prone to think it should be Soc specific if making sure the lay=
out
>>> for data lines is in equal length.
>>
>>
>> Sure, it can be SoC specific.  ...though at the moment, I'd bet that
>> you can come up with a single rule for the drive phase offset that
>> will work for every Rockchip SoC produced so far, especially if you
>> are using only 0/90/180/270.  I'd imagine that they all have similar
>> enough internal delays.
>
>
> For a specific Soc, it's the basic rule to make sure the internal del=
ays
> is the same(nearly the same) for all of the lines.

Right.  I was saying that not only are all lines within a given SoC
similar in terms of delay, but I was suggesting that perhaps the
internal delay for rk3188, rk3288, rk3228, ... is probably fairly
similar.  That's only a guess, though.


>>>> 3. If this property was actually board specific and actually neede=
d to
>>>> be tuned board-by-board, you'd have a bug because your new device =
tree
>>>> bindings are not backward compatible and you'd probably be breakin=
g
>>>> old boards.  Specifically you're changing the definition of what
>>>> happens when "rockchip,default-drv-phase" is not specified.  Old
>>>> behavior was to leave the value that was setup by the firmware (or
>>>> perhaps the hardware default if the firmware didn't touch this).
>>>
>>>
>>>
>>> drv_phase is for all the data lines instead of tuning the lines
>>> one-by-one. So this patch can't save the terrible board layout.
>>> But I agree that it will break the compatibility backward if firwar=
e
>>> touch this value.
>>>
>>>>
>>>> ---
>>>>
>>>> OK, so what should we do?
>>>>
>>>> We could certainly do lots of crazy math to come up with the ideal
>>>> hold time for all different speed modes and all different types of
>>>> cards.  With my reading of the Designware Databook this would mean
>>>> that somewhere we'd want to specify which delay method we're using
>>>> (phase shift vs. delay line) and how long all the delays timings a=
ll
>>>> are on your particular SoC.  That all sounds quite difficult, thou=
gh.
>>>
>>>
>>>
>>> delay line is diff from chip to chip, soc-to-soc, board-to-board. F=
or
>>> sample-phase we have tuning process and re-tune, but not for drv-ph=
ase.
>>> So We bascially should avoid to use it for drv-phase. Another
>>> consideration is the temperature drift of delay line.
>>>
>>> Maybe we should do some tricky limitation on clk-mmc-phase to only
>>> support fixed degrees?
>>
>>
>> As per above, let's not use delay line for drive delay.  On all
>> Rockchip SoCs that I have seen it's possible to make 0/90/180/270 ve=
ry
>> accurately.  That means no board-to-board differences.  Current
>> mainline Linux kernel source code will always make 0/90/180/270 usin=
g
>> phase offset (not delay line).
>
>
> yes, 0/90/180/270 is very accurate and mainline kernel use phase offs=
et
> for these four phase.
>
>>
>> For sampling we use tuning and using the delay elements makes some
>> sense (since 90 degrees is not quite accurate enough to fully tune
>> UHS).  ...but for driving where the only requirement is hold times w=
e
>> don't need delay elements.
>
>
> Right. We care hold time here.
>
>>
>>
>>>> Probably you could just add a simple function that looked at the c=
lock
>>>> and speed mode and always chose an offset of 90 or 180 degrees.  A=
t
>>>> least on Rockchip devices you can be certain that you can make 90 =
and
>>>> 180 degrees using phase shifts and thus the timings should be
>>>> consistent.  By default you could just always choose 180.  The
>>>> Designware databook has some examples where it picked 90 degrees
>>>> (SDR50, DDR50, SDR25, MMC High Speed), but I'm not enough of an MM=
C
>>>> expert to know if there is some benefit to choosing 90.  Would we
>>>> violate any specs if we just chose 180 degrees all the time everyw=
here
>>>> on all Rockchip devices?
>>>
>>>
>>>
>>> It needs more waveform test to see how things going. But most of
>>> rockchip platforms in the pass years didn't touch drv-phase stuff n=
ot
>>> only in kernel but also in firmware, then we still cannot see the
>>> violation against the spec when using defalut reset value, namely 1=
80,
>>> for
>>> drv-phase.
>>
>>
>> Right, most Rockchip platforms simply don't touch this and it works
>> OK.  ...but I don't think it defaults to 180.  Grepping through on m=
y
>> veyron (rk3288) device shows
>>
>>        sdio1_drv - 90
>>        sdio0_drv - 90
>>        sdmmc_drv - 90
>>        emmc_drv -180
>>
>> ...and, as we've seen, these values appear to be 270 on some other S=
oCs.
>>
>
> Have your code touched them? I check the TRM and find it should be 18=
0
> always.
>
> Also for rk3036/3368/3399/3228.... the reset vaule is 180...

I have less faith than you in the TRM.  The TRM is full of minor
errors and is often wrong about the default state of things.  IMHO the
only true way to find out is to boot up some SoCs and check.

As far as whether code touches these values:

* I'm 100% certain that the kernel on rk3288 I tested doesn't touch.

* I'm 100% certain that the kernel on rk3399 I tested doesn't touch.

* I'm 95% certain that the BIOS (coreboot/depthcharge) on rk3288 I
tested doesn't touch.

* I'm 95% certain that the BIOS (coreboot/depthcharge) on rk3399 I
tested doesn't touch.  Note that the TRM on rk3399 does say 180
degrees is the default, but I believe you have also verified that it
comes up as 270.  Have you found any reason for this?


Also note that I look at V1.1 of the rk3288 TRM in the CRU section and =
I see:

* CRU_SDMMC_CON0: drive degree defaults to 0x1
* CRU_SDIO0_CON0: drive degree defaults to 0x1
* CRU_SDIO1_CON0: drive degree defaults to 0x1
* CRU_EMMC_CON0: drive degree defaults to 0x1

That actually means that they default to 90.  Of course you can also
see that the TRM is probably flawed because it claims that all the
bits here are "WO" (write only).  They are clearly not.

The TRM is also internally inconsistent.  When I then go into the
Mobile Storage Host section (Variable Delay/Clock Generation), I see
that it does in fact claim that the default is 180.


>> The claim from the Designware Databook says that SDR104 and SDR12, a=
nd
>> identification mode need 180 degrees to work properly.  It would be
>> interesting to hook up rk3288 to a signal analyzer and see hold time=
s
>> are OK or if we need to move up to 180 degrees for those modes.
>>
>> Note that the Designware Databook assumes "Delay_O" of 1.4ns.  If
>> yours is shorter then maybe 90 degrees is OK for those modes?
>>
>
> maybe. But I think 180(downside) is the better.

I'm OK with using 180 always as long as SD cards continue to work OK.
Best would be if someone could actually run a protocol analyzer for
all the different speed modes.


>> Also: I still haven't heard whether there is any downside to using 1=
80
>> degrees for modes that only require 90 degrees.  Does it cause
>> problems to just always use 180 degrees?  If not, we could possibly
>> use 180 degrees everywhere and just hardcode it?
>
>
> From tons of test on rockchip products which always use 180, I didn't
> see failure. Hardcoding it doesn't look so decent maybe... but anyway
> it works.

Hardcoding in this case is much better than putting in a device tree
binding.  I'm nearly certain that having a device tree binding that
doesn't account for different clock rates / speed modes is not a good
idea, and device tree bindings are supposed to be "set in stone".
Let's just hardcode it for now.

I can post up a CL.


>> ...but if 180 is ideal everywhere, can you answer:
>>
>> * Why does dw_mmc manual spend so much time talking about it?  It
>> could just say "set to 180 degrees".
>
>
> I'm sure all the rockchip Socs defaultly use 180 for drv_phase if I g=
ot
> the right TRMs these years.
>
> Anyway let me check it with my ASIC team and I will let you know
> the result.

You probably have the right TRMs.  The TRMs are just not accurate.  ;)

From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 4/4] ARM: shmobile: ag5evm, ap4: Make use of irq index enum
Date: Fri, 19 Aug 2011 15:51:49 +0900
Message-ID: <CANqRtoTu6G=Dut8eQb+aZPrQ9pF383tGHnQ6JNbH=R2wcuuNiA@mail.gmail.com>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
	<1313716221-20136-5-git-send-email-horms@verge.net.au>
	<CANqRtoQL4cw2+71P5+1hU-2TUyV=gQJ9X2NN+_e_S3dgKeWWJA@mail.gmail.com>
	<20110819052004.GB17548@verge.net.au>
	<20110819063857.GC16419@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110819063857.GC16419@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 19, 2011 at 3:39 PM, Simon Horman <horms@verge.net.au> wrot=
e:
> On Fri, Aug 19, 2011 at 02:20:11PM +0900, Simon Horman wrote:
>> On Fri, Aug 19, 2011 at 01:16:09PM +0900, Magnus Damm wrote:
>> > On Fri, Aug 19, 2011 at 10:10 AM, Simon Horman <horms@verge.net.au=
> wrote:
>> > > This is intended to make it easier to correctly order IRQs.
>> > >
>> > > As suggested by Guennadi Liakhovetski.
>> >
>> > > --- a/arch/arm/mach-shmobile/board-ag5evm.c
>> > > +++ b/arch/arm/mach-shmobile/board-ag5evm.c
>> > > @@ -352,15 +352,15 @@ static struct resource sdhi0_resources[] =3D=
 {
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.end =A0 =A0=3D 0xee1000ff,
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_MEM,
>> > > =A0 =A0 =A0 =A0},
>> > > - =A0 =A0 =A0 [1] =3D {
>> > > + =A0 =A0 =A0 [1 + SH_MOBILE_SDHI_IRQ_CARD_DETECT] =3D {
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =A0=3D gic_spi(83),
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_IRQ,
>> > > =A0 =A0 =A0 =A0},
>> > > - =A0 =A0 =A0 [2] =3D {
>> > > + =A0 =A0 =A0 [1 + SH_MOBILE_SDHI_IRQ_SDCARD] =3D {
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =A0=3D gic_spi(84),
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_IRQ,
>> > > =A0 =A0 =A0 =A0},
>> > > - =A0 =A0 =A0 [3] =3D {
>> > > + =A0 =A0 =A0 [1 + SH_MOBILE_SDHI_IRQ_SDIO] =3D {
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =A0=3D gic_spi(85),
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_IRQ,
>> > > =A0 =A0 =A0 =A0},
>> >
>> > Hm...
>> >
>> > So I know you guys have been discussing this back and forth, so I'=
m
>> > not sure if jumping in to this thread makes things any better. But
>> > anyhow, here are my opinions. Feel free to ignore them. =3D)
>> >
>> > First of all, having some kind of association with each IRQ is a g=
ood
>> > thing. I am however not convinced that using the index number of t=
he
>> > platform device resource irq is the best option. Consider the case
>> > when someone modifies the SDHI resource in the code above to only
>> > include this interrupt:
>> >
>> > =A0 =A0 =A0 =A0 [1 + SH_MOBILE_SDHI_IRQ_SDCARD] =3D {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D gic_spi(84),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
>> > =A0 =A0 =A0 =A0 },
>> >
>> > >From my point of view, the common sense for this would be that on=
ly
>> > the SDCARD interrupt would be enabled and the rest would be disabl=
ed
>> > since they are unspecified. However, with the current code the
>> > behavior would be something else, and since the index number of SD=
CARD
>> > is not matching it will be detected as CARD_DETECT.
>> >
>> > So isn't it really ugly to depend on the number of IRQs when they =
are
>> > supposed to be used as an index? I've been toying around with this
>> > driver for a few years now, and when I have a hard time creating
>> > correct platform data then it's _probably_ a sign that there must =
be
>> > better ways to implement this.
>> >
>> > I would propose just adding interrupts in struct resource [] as us=
ual,
>> > and then have thee separate flags in the platform data for each
>> > interrupt type. If the number of IRQ bits set in the platform data
>> > flags doesn't match the number of interrupt resources then return
>> > error. If they match then simply go through each flag set in the
>> > platform data flags and assign next available interrupt resource. =
And
>> > if no flags are set then go for the combined interrupt handler for=
 all
>> > available interrupt resources.
>> >
>> > That's what I would do at least. Any other ideas? Perhaps just kee=
p an
>> > array of interrupt numbers in the platform data as the sh-sci driv=
er
>> > does and use the fixed indexes there if non-zero?
>>
>> Hi Magnus,
>>
>> unfortunately during the course of the review of this series a numbe=
r
>> of changes have crept in which I regard as being tangential to the
>> goal of the series - which is to introduce broken-out handlers (I ha=
ve
>> already introduce support for broken-out IRQ sources).
>>
>> One area where such changes have occurred is in the subtle altering =
of the
>> list of IRQ sources that it is valid to supply (again, support for
>> broken-out IRQ sources is not introduced by this series).
>>
>> With regards to your comment and example above. I believe that your
>> understanding of my code is incorrect. The configuration you suggest=
 will
>> be rejected because CARD_DETECT is not supplied, not because of an i=
ndex
>> miss-match. It could be made acceptable within the current framework=
 by
>> simply loosening up the logic a little (specifically to allow CARD_D=
ETECT
>> to be omitted even if only one other IRQ source is supplied). =A0Inc=
idently,
>> I think that would make sense but Guennadi specifically asked for th=
at
>> combination to be regarded as invalid.
>
> [snip]
>
> After some discussion off-line I now realise that there is a problem
> with my implementation. Specifically that it assumes that
> platform_get_irq() takes into account the index of resource entries -
> it does not.

Right, this is a thing that only bites you once. =3D)

> As we are already on the slippery slope of allowing combinations
> other than 1 (legacy) or 3 (specific) IRQ sources I plan to implement
> a variant of your flag idea. The variation being to use names instead
> because a) that allows the use of platform_get_irq_byname() and b)
> the flags bits seem to be full and not driver-specific.

Great, platform_get_irq_byname() seems like a perfect match.

May I suggest "hotplug", "data" and "sdio" as names? I don't care very
much about names except keeping them short and precise to prevent
errors that can only be caught during runtime.

> And as are already on the slippery slope of allowing combinations
> if IRQ sources beyond 1 and 3 I intend to implement logic to allow
> any number of unique specific IRQ sources to be handled. In practice
> hardware for some of these combinations is unlikely to exist. But tha=
t
> doesn't seem to be a particularly good reason to add extra logic
> to disallow them in the driver - its up to platform data to specify
> something valid.

Yes, I totally agree. Thanks a lot for your help!

/ magnus

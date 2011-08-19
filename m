From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 4/4] ARM: shmobile: ag5evm, ap4: Make use of irq index enum
Date: Fri, 19 Aug 2011 13:16:09 +0900
Message-ID: <CANqRtoQL4cw2+71P5+1hU-2TUyV=gQJ9X2NN+_e_S3dgKeWWJA@mail.gmail.com>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
	<1313716221-20136-5-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313716221-20136-5-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 19, 2011 at 10:10 AM, Simon Horman <horms@verge.net.au> wro=
te:
> This is intended to make it easier to correctly order IRQs.
>
> As suggested by Guennadi Liakhovetski.

> --- a/arch/arm/mach-shmobile/board-ag5evm.c
> +++ b/arch/arm/mach-shmobile/board-ag5evm.c
> @@ -352,15 +352,15 @@ static struct resource sdhi0_resources[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.end =A0 =A0=3D 0xee1000ff,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_MEM,
> =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 [1] =3D {
> + =A0 =A0 =A0 [1 + SH_MOBILE_SDHI_IRQ_CARD_DETECT] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =A0=3D gic_spi(83),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_IRQ,
> =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 [2] =3D {
> + =A0 =A0 =A0 [1 + SH_MOBILE_SDHI_IRQ_SDCARD] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =A0=3D gic_spi(84),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_IRQ,
> =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 [3] =3D {
> + =A0 =A0 =A0 [1 + SH_MOBILE_SDHI_IRQ_SDIO] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =A0=3D gic_spi(85),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_IRQ,
> =A0 =A0 =A0 =A0},

Hm...

So I know you guys have been discussing this back and forth, so I'm
not sure if jumping in to this thread makes things any better. But
anyhow, here are my opinions. Feel free to ignore them. =3D)

=46irst of all, having some kind of association with each IRQ is a good
thing. I am however not convinced that using the index number of the
platform device resource irq is the best option. Consider the case
when someone modifies the SDHI resource in the code above to only
include this interrupt:

        [1 + SH_MOBILE_SDHI_IRQ_SDCARD] =3D {
                .start  =3D gic_spi(84),
                .flags  =3D IORESOURCE_IRQ,
        },

=46rom my point of view, the common sense for this would be that only
the SDCARD interrupt would be enabled and the rest would be disabled
since they are unspecified. However, with the current code the
behavior would be something else, and since the index number of SDCARD
is not matching it will be detected as CARD_DETECT.

So isn't it really ugly to depend on the number of IRQs when they are
supposed to be used as an index? I've been toying around with this
driver for a few years now, and when I have a hard time creating
correct platform data then it's _probably_ a sign that there must be
better ways to implement this.

I would propose just adding interrupts in struct resource [] as usual,
and then have thee separate flags in the platform data for each
interrupt type. If the number of IRQ bits set in the platform data
flags doesn't match the number of interrupt resources then return
error. If they match then simply go through each flag set in the
platform data flags and assign next available interrupt resource. And
if no flags are set then go for the combined interrupt handler for all
available interrupt resources.

That's what I would do at least. Any other ideas? Perhaps just keep an
array of interrupt numbers in the platform data as the sh-sci driver
does and use the fixed indexes there if non-zero?

Thanks,

/ magnus

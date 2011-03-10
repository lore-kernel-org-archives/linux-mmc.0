From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] [rfc] mmc, ARM: Add zboot from eSD support for SuperH
 Mobile ARM
Date: Thu, 10 Mar 2011 17:42:02 +0900
Message-ID: <20110310084158.GB6508@verge.net.au>
References: <1299743892-3668-1-git-send-email-horms@verge.net.au>
 <AANLkTimiaTpz+Cjq_s0U=whNvwSAaZdk8UVKAS6mVkNC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33727 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab1CJImG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 03:42:06 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimiaTpz+Cjq_s0U=whNvwSAaZdk8UVKAS6mVkNC@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Thu, Mar 10, 2011 at 05:07:17PM +0900, Magnus Damm wrote:
> Hi Simon,
>=20
> On Thu, Mar 10, 2011 at 4:58 PM, Simon Horman <horms@verge.net.au> wr=
ote:
> > This allows a ROM-able zImage to be written to eSD and for SuperH M=
obile
> > ARM to boot directly from the SDHI hardware block.
> >
> > This is achieved by the MaskROM loading the first portion of the im=
age into
> > MERAM and then jumping to it. =C2=A0This portion contains loader co=
de which
> > copies the entire image to SDRAM and jumps to it. From there the zI=
mage
> > boot code proceeds as normal, uncompressing the image into its fina=
l
> > location and then jumping to it.
> >
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
>=20
> Nice to see some SDHI loader code!
>=20
> > --- /dev/null
> > +++ b/arch/arm/boot/compressed/sdhi-shmobile.c
>=20
> > +#define PORT179CR =C2=A0 =C2=A0 =C2=A00xe60520b3
> > +#define PORT180CR =C2=A0 =C2=A0 =C2=A00xe60520b4
> > +#define PORT181CR =C2=A0 =C2=A0 =C2=A00xe60520b5
> > +#define PORT182CR =C2=A0 =C2=A0 =C2=A00xe60520b6
> > +#define PORT183CR =C2=A0 =C2=A0 =C2=A00xe60520b7
> > +#define PORT184CR =C2=A0 =C2=A0 =C2=A00xe60520b8
> > +
> > +#define SMSTPCR3 =C2=A0 =C2=A0 =C2=A0 0xe615013c
> > +#define SDGENCNTA =C2=A0 =C2=A0 =C2=A00xfe40009c
>=20
> These...
>=20
> > + =C2=A0 =C2=A0 =C2=A0 /* Initialise SDHI1 */
> > + =C2=A0 =C2=A0 =C2=A0 /* PORT184CR: GPIO_FN_SDHICMD1 Control */
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writeb(CR_FUNCTION1, PORT184CR);
> > + =C2=A0 =C2=A0 =C2=A0 /* PORT179CR: GPIO_FN_SDHICLK1 Control */
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writeb(CR_INPUT_ENABLE|CR_FUNCTION1, P=
ORT179CR);
> > + =C2=A0 =C2=A0 =C2=A0 /* PORT181CR: GPIO_FN_SDHID1_3 Control */
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writeb(CR_FUNCTION1, PORT183CR);
> > + =C2=A0 =C2=A0 =C2=A0 /* PORT182CR: GPIO_FN_SDHID1_2 Control */
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writeb(CR_FUNCTION1, PORT182CR);
> > + =C2=A0 =C2=A0 =C2=A0 /* PORT183CR: GPIO_FN_SDHID1_1 Control */
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writeb(CR_FUNCTION1, PORT181CR);
> > + =C2=A0 =C2=A0 =C2=A0 /* PORT180CR: GPIO_FN_SDHID1_0 Control */
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writeb(CR_FUNCTION1, PORT180CR);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 /* Enable clock to SDHI1 hardware block */
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writel(__raw_readl(SMSTPCR3) & ~(1 << =
13), SMSTPCR3);
>=20
> ...and these are sh7372 specific.
>=20
> If possible I'd like to reuse your SDHI code on sh73a0, so please
> consider splitting up the code in a SDHI specific portion and in a
> processor specific portion.

Sure.

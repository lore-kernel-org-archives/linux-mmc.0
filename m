From: Koen Beel <koen.beel.barco@gmail.com>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Mon, 4 Jul 2011 12:59:29 +0200
Message-ID: <CAHMSPgMxCqFzigAzMc7nbTB_0NyLcK3FrVDW8arKa0ip15TH3Q@mail.gmail.com>
References: <20110701091753.GE1922@pengutronix.de>
	<BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
	<20110701122709.GJ1922@pengutronix.de>
	<BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
	<20110701144409.GA3825@pengutronix.de>
	<20110701154628.GD8631@S2100-06.ap.freescale.net>
	<20110702131225.GA5478@pengutronix.de>
	<20110703092850.GA9938@S2100-06.ap.freescale.net>
	<20110703103124.GA1333@pengutronix.de>
	<20110703115418.GB9938@S2100-06.ap.freescale.net>
	<20110704103402.GA3990@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63740 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab1GDK7b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2011 06:59:31 -0400
Received: by wwe5 with SMTP id 5so4975861wwe.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 Jul 2011 03:59:30 -0700 (PDT)
In-Reply-To: <20110704103402.GA3990@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-mmc@vger.kernel.org

On Mon, Jul 4, 2011 at 12:34 PM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
>
>> > > > Well, maybe not. My colleague complained and I think he is rig=
ht that we are
>> > > > mapping div2 from the range 0 to 256 (inclusive!) to an 8-bit =
range. This must
>> > > > be wrong for one value per se.
>> > > >
>> > > If you look at the context of the patch, you will find it's 'div=
2 - 1'
>> > > than 'div2' gets written into register.
>> >
>> > Exactly. The '- 1' is why Koen changed the upper limit from < 256 =
to <=3D 256.
>> > The lower limit fix is currently 'if (div2 =3D=3D 0) div2 =3D=3D 1=
', which is a 2:1
>> > mapping. Not good, or?
>> >
>> So you are saying the patch is a right fix but not the most optimal
>> one? =C2=A0In that case, it does not concern me. =C2=A0I acked it as=
 an valid
>> fix.
>
> The patches fixes a few things, but for div2, it is curing the sympto=
ms,
> not the cause, I think. If you look at the formula in the datasheet:
>
> rate =3D ssp / (clock_divide * (1 + clock_rate));
>
> In the code, the calculation of div2 is equal to '1 + clock_rate' (th=
e 1
> gets subtracted when the value is written to the register which is a =
bit
> unfortunate; doing it earlier would reduce confusion IMO). So that ca=
n
> never be 0, it is a divisor. We should really use DIV_ROUND_UP here.
> Even when not dealing with 0, this seems needed. Assume:
>
> ssp =3D 57600000, wanted_rate =3D 25000000, div1 =3D 2
>
> will give
>
> div2 =3D int(1.152) =3D 1 (meaning 0 + 1, because div2 - 1 will be wr=
itten)
>
> The rate will thus be:
>
> actual_rate =3D 57600000 / 2 * (0 + 1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 28800000
>
> -> too fast!
>
> Or did I get something wrong?
>
> Regards,
>
> =C2=A0 Wolfram

Well, right now the clock freq. is set to the minimum clock value
reaching the requested rate. In current implementation, the rate will
be higher in lot's of cases (all cases where the requested clock freq.
cannot exactly be made).

But the thing is, the driver now enters dev_err, and returns without
changing anything when the clock cannot be made as low as requested.
In that case you will almost certainly end up with a clock being even
higher then the lowest possible. So that not good I think.
I might be better to set the clock as low as possible not matter what
you to after that.

About the rounding. I don't think rounding is good. I think it would
be better to choose between having at least the requested rate (as it
is now; will result is somewhat higher clock then requested in many
cases), or having at maximum the requested clock rate. Both have there
problems.




>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk4RlxoACgkQD27XaX1/VRuf7ACgqQ4PvBf9d0am2ButvDT0ZHy1
> CQwAn1iHNXcl6t46IW7L/l3UkW7J2nxb
> =3DkbX8
> -----END PGP SIGNATURE-----
>
>

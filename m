From: Koen Beel <koen.beel.barco@gmail.com>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Wed, 6 Jul 2011 11:53:07 +0200
Message-ID: <CAHMSPgPZ6xJ3FQrR5wkJZiu5KCqg7k9bcxRq-ad9_TDJsyzx5g@mail.gmail.com>
References: <20110701122709.GJ1922@pengutronix.de>
	<BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
	<20110701144409.GA3825@pengutronix.de>
	<20110701154628.GD8631@S2100-06.ap.freescale.net>
	<20110702131225.GA5478@pengutronix.de>
	<20110703092850.GA9938@S2100-06.ap.freescale.net>
	<20110703103124.GA1333@pengutronix.de>
	<20110703115418.GB9938@S2100-06.ap.freescale.net>
	<20110704103402.GA3990@pengutronix.de>
	<CAHMSPgMxCqFzigAzMc7nbTB_0NyLcK3FrVDW8arKa0ip15TH3Q@mail.gmail.com>
	<20110706093848.GC2117@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47727 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab1GFJxJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 05:53:09 -0400
Received: by wyg8 with SMTP id 8so4544223wyg.19
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2011 02:53:07 -0700 (PDT)
In-Reply-To: <20110706093848.GC2117@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-mmc@vger.kernel.org

On Wed, Jul 6, 2011 at 11:38 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> On Mon, Jul 04, 2011 at 12:59:29PM +0200, Koen Beel wrote:
>> On Mon, Jul 4, 2011 at 12:34 PM, Wolfram Sang <w.sang@pengutronix.de=
> wrote:
>> >
>> >> > > > Well, maybe not. My colleague complained and I think he is =
right that we are
>> >> > > > mapping div2 from the range 0 to 256 (inclusive!) to an 8-b=
it range. This must
>> >> > > > be wrong for one value per se.
>> >> > > >
>> >> > > If you look at the context of the patch, you will find it's '=
div2 - 1'
>> >> > > than 'div2' gets written into register.
>> >> >
>> >> > Exactly. The '- 1' is why Koen changed the upper limit from < 2=
56 to <=3D 256.
>> >> > The lower limit fix is currently 'if (div2 =3D=3D 0) div2 =3D=3D=
 1', which is a 2:1
>> >> > mapping. Not good, or?
>> >> >
>> >> So you are saying the patch is a right fix but not the most optim=
al
>> >> one? =C2=A0In that case, it does not concern me. =C2=A0I acked it=
 as an valid
>> >> fix.
>> >
>> > The patches fixes a few things, but for div2, it is curing the sym=
ptoms,
>> > not the cause, I think. If you look at the formula in the datashee=
t:
>> >
>> > rate =3D ssp / (clock_divide * (1 + clock_rate));
>> >
>> > In the code, the calculation of div2 is equal to '1 + clock_rate' =
(the 1
>> > gets subtracted when the value is written to the register which is=
 a bit
>> > unfortunate; doing it earlier would reduce confusion IMO). So that=
 can
>> > never be 0, it is a divisor. We should really use DIV_ROUND_UP her=
e.
>> > Even when not dealing with 0, this seems needed. Assume:
>> >
>> > ssp =3D 57600000, wanted_rate =3D 25000000, div1 =3D 2
>> >
>> > will give
>> >
>> > div2 =3D int(1.152) =3D 1 (meaning 0 + 1, because div2 - 1 will be=
 written)
>> >
>> > The rate will thus be:
>> >
>> > actual_rate =3D 57600000 / 2 * (0 + 1)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 28800000
>> >
>> > -> too fast!
>> >
>> > Or did I get something wrong?
>> >
>> > Regards,
>> >
>> > =C2=A0 Wolfram
>>
>> Well, right now the clock freq. is set to the minimum clock value
>> reaching the requested rate.
>
> Sorry, it gets a bit confusing: what do you mean with "right now"?

I mean: in current mainline the actual clock is set to be at least the
requested clock rate.

>
>> In current implementation, the rate will
>> be higher in lot's of cases (all cases where the requested clock fre=
q.
>> cannot exactly be made).
>
> Yes.

This is just the consequence of the fact that the actual clock is set
to be at least the requested clock rate.

>
>> But the thing is, the driver now enters dev_err, and returns without
>> changing anything when the clock cannot be made as low as requested.
>> In that case you will almost certainly end up with a clock being eve=
n
>> higher then the lowest possible. So that not good I think.
>> I might be better to set the clock as low as possible not matter wha=
t
>> you to after that.
>
> Yes, might be a bit academic (who would want 4kHz ;)), but still
> correct. Shawn, do you agree?
>
>> About the rounding. I don't think rounding is good. I think it would
>
> We do rounding already (int conversion). Just in the wrong direction.
>
>> be better to choose between having at least the requested rate (as i=
t
>> is now; will result is somewhat higher clock then requested in many
>> cases)
>
> You want a rate faster than what the card could do?

Correct, you don't want the clock to be faster then the requested clock=
=2E
So the rounding is indeed in the wrong direction now.

>
>>, or having at maximum the requested clock rate. Both have there
>> problems.
>
> If I understood you correctly, this is my DIV_ROUND_UP suggestion. Wh=
ich
> problems does it have?

I think I misunderstood this suggestion previously. Using DIV_ROUND_UP
would do the rounding in the correct direction.
This should result in: "the actual clock is as high as possible
without being higher then the requested clock."

>
> Regards,
>
> =C2=A0 Wolfram
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk4ULSgACgkQD27XaX1/VRsorQCfVRVm9Vpv4YSsfiMqIFctTKG9
> 7qkAnicSrjSzwObzBjyISDnXz6+Sze2s
> =3D5LIq
> -----END PGP SIGNATURE-----
>
>

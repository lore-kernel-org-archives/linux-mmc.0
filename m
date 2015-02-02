From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH V4 1/4] mmc: core: Initial support for MMC power
 sequences
Date: Tue, 3 Feb 2015 09:10:42 +1100
Message-ID: <20150203091042.379c7948@notabene.brown>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
	<1421658784-11980-2-git-send-email-ulf.hansson@linaro.org>
	<CABxcv==xBNsh+NrVb8PcBVtxQOKDL79YMkwK=wOL0gJZriEUjw@mail.gmail.com>
	<CAPDyKFoze-26fPm+C=D_o3tMSXWeTV4=2ZfOKaC3uLtxCrtjvg@mail.gmail.com>
	<20150131092715.566fa33c@notabene.brown>
	<CAPDyKFo6G+PpV7QpxBEOS_xUxXTQ14v=qVLGpBjT_z6T0vP85A@mail.gmail.com>
	<20150202150537.GE8656@n2100.arm.linux.org.uk>
	<CAPDyKFqjeg0d7r5XSK0d1EYfm2dvET3PQiHsDE_XchqFVYyC6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/kTr5/gqM.qjweh.U70m730_"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47012 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964916AbbBBWLB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Feb 2015 17:11:01 -0500
In-Reply-To: <CAPDyKFqjeg0d7r5XSK0d1EYfm2dvET3PQiHsDE_XchqFVYyC6g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org
	<linux-arm-kernel@lists.infradead.org>," <mark.rutland@arm.com>

--Sig_/kTr5/gqM.qjweh.U70m730_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Feb 2015 16:10:29 +0100 Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:

> On 2 February 2015 at 16:05, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Feb 02, 2015 at 03:57:37PM +0100, Ulf Hansson wrote:
> >> On 30 January 2015 at 23:27, NeilBrown <neilb@suse.de> wrote:
> >> > Shortly before this call is
> >> >
> >> >         host->ios.power_mode =3D MMC_POWER_ON;
> >> >         mmc_set_ios(host);
> >> >
> >> > and omap_hsmmc_set_ios() contains:
> >> >
> >> >                 switch (ios->power_mode) {
> >> >                 ....
> >> >                 case MMC_POWER_ON:
> >> >                         do_send_init_stream =3D 1;
> >> >                         break;
> >> >
> >> >
> >> >         if (do_send_init_stream)
> >> >                 send_init_stream(host);
> >> >
> >> > Which sends the "init stream" to the card.
> >> > If the card is still being reset at this time, the stream may not
> >> > be effective.
> >> >
> >> > I find that about 10%-20% of the time when I release the reset line
> >> > *after* the sequence is sent, my card fails to initialised.  When I
> >> > release *before* the sequence is sent, it never fails.
> >>
> >> Okay, thanks for providing these details.
> >
> > The right thing to do then is to pulse the reset line at the pre-power-=
up
> > stage.
>=20
> I don't think that will work, since the card hasn't yet been powered
> and will thus not respond properly to the reset.

My understanding, at least in the case of my hardware, is that the power-on
is sufficient to reset the device.
In my case, the one supply is shared between two devices (wifi and bluetoot=
h)
so if the bluetooth is on, then the wifi cannot be power-cycled.  That is
when the reset is particularly needed.

I'll try to arrange some testing to confirm this is the case.  Of course,
this would not be general result, it would only be relevant for my hardware.

NeilBrown

--Sig_/kTr5/gqM.qjweh.U70m730_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVM/14jnsnt1WYoG5AQLsXw//WrNwMcvb9eteqT+vHBcp/A3Qn2kfurty
uZnwlpMXUwEZ+wucwOIw2QmeycLs1QDZ/3KpaNS0gc5j2dD3bHEaZMi+fjVwxBe5
upTQLTb/rHHjR4x/l+lRqsyHQXv3D8eqnFJBccuEeexUyiW+h0BN8pHRXelnpyi0
GiQ2wz5SdGVSmMvDYwKDFC14ddDxxfnPgEb4Z53OJWnB9bPEpdRPLLQ8r1ycjbIX
DRLFeLgzyR7b2JTXLMxNnnzQXqiExznNbskZ4Up1Tbhvect0svyHl18gCNUIGk1b
345uCFGikt5fuqN1WolwO3TtPYp1H6iUWNNdkVKrTlKAeP3kL7257LEFz8YEp4am
tgwEkRj21wlxHBLHk8tAVtmY9aGwO0EzHT3j/Ye7aUzddY33P9qt9moMleq/lFGp
vqMINRgeCt90kV4Z/UDrqovVlaIAEb2DfoLkstYX0RVP7XxgDnvBWlKJ/+0nde+l
17snoMUSqnss3GKGrXeknVhktBlALIeg9OnNHB9a42Jx9Ouj4bj9p1kJw9cwngd4
xhf9nK8+Ij8SZyjOWA7K5LsYKTJsL/LkHhdjK4/n++cB6a2CkeeGr3bjJKhvDWhw
JomMJ+J433Y6QGSbMGQz1wEnO1nwFArUATlm9pOdbedYczbN6WrgJ2kW4Uy8C6IK
w1JwhEyPWRQ=
=Sn6S
-----END PGP SIGNATURE-----

--Sig_/kTr5/gqM.qjweh.U70m730_--

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/29] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Fri, 18 May 2012 16:18:38 +0100
Message-ID: <20120518151837.GD4039@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-8-git-send-email-g.liakhovetski@gmx.de>
 <20120503154252.GO3955@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1205181059560.23140@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35700 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750835Ab2ERPSl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 May 2012 11:18:41 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1205181059560.23140@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2012 at 11:28:31AM +0200, Guennadi Liakhovetski wrote:

> 1. A regulator that can (in principle) change state, i.e., switch on and=
=20
> off. Such a regulator is good to keep for the runtime to power up and dow=
n=20
> the card.

> 2. A regulator, that cannot switch, but at least can tell its supplied=20
> voltage is used ones to read out supported voltages and released again.

This doesn't make sense, you can only change the voltages if you hold a
reference to the regulator.

> 3. A regulator that can do none of the above is defined as "useless"

> > You may also run into trouble on boards that use the ability to disable
> > unused regulators at the end of boot - they'll power things off even
> > without the ability to change status at runtime.

> Aha, you mean, I shouldn't put() the regulator, even if it cannot change=
=20
> status itself?

Yes, you ought to to be safe and like I say if you want to manage the
voltage then you need to keep a reference to the regulator.

> Can this also happen with a dummy regulator?

Obviously not, though if you've got explicit code in to handle dummy
regulators you're rather missing the point.  Their entire purpose is to
provide a crutch to keep the system going if bits are missing from the
bindings, they're not intended to be used in production.

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPtmhIAAoJEBus8iNuMP3dZyMP/R8mxcP+4l2+rtVneMCS3jKI
+L8/Pi2LNFUmIx/+x8/zMZuOE1IEwXmNnEpZEraSkCbb4wmlcKpx3q/6C3AenK4y
MtCUz60FQU1aaFlTg25PJFqBBaC0NTnhDtOkM9UlQrWjFF6bUuOKMGKteSKVOZ8h
93ltLHUdsB0CrKjH+d/7r4yOFEo6ZWVot52/f7VEEw3+bBmZ/P3PJRPqOqx/maER
9ZrtUVE6qDNdmkIfog7Xm2IRpzxn1JQbf1sEyIZTPydma9qR/IZOFQs1EL7fHrzJ
GpFgB/yEf8m4wyGmQ0Ysw6qDimAQ+Pan1H+3xC4yxcDoGd3R5TdD7A1crTDIkEvw
t5dEIcqGOz5ktXCaBobNARBHDWVINQQcEu88XFZRzBFiQzbFdCdcAe1uh45YGFFc
jygTgAf26Oi5DqOPsBmerd4kPDoEsqmA0rcodbvKWHV1o02Cy0Pqn4SeB/AekgOB
3N4k/kTg5/NeXX+0cMise/6kZn1VTeW/J4mIF3VnK2XhxNqi56AKDF3broJ5OlrP
rJc46kM6dsUL4ko+5d0keqQroccnJAkL8uM83EDjtcWdfsRdHDWwoB2iylV9mMnY
lvny7QCRH72FF5QUMCVjLWuAbSoKZRR6wXt2f3itj1hi7dS0VEUt3YELmKlXF2rm
PqU/hnRLpBHzxzIpxmmE
=bSrK
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--

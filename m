From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/29] mmc: tmio: add regulator support
Date: Fri, 18 May 2012 16:34:18 +0100
Message-ID: <20120518153416.GE4039@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-14-git-send-email-g.liakhovetski@gmx.de>
 <20120503155655.GQ3955@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1205181137570.23140@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37194 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754065Ab2ERPeY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 May 2012 11:34:24 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1205181137570.23140@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2012 at 11:55:53AM +0200, Guennadi Liakhovetski wrote:
> On Thu, 3 May 2012, Mark Brown wrote:

> > should it be being factored out into the core?

> Weeeell, it's not a lot of code. We could make this a library function,=
=20
> provided by the core, but I don't think it would be very straight forward=
=20
> to also automate its calling, thus freeing individual drivers from this=
=20
> task. As you can see in these two drivers, one of them turns the card on=
=20
> already upon MMC_POWER_UP, the other one only in MMC_POWER_ON. I'm not=20
> sure off the top of my head why this difference is there, but in any case=
=20
> different drivers might have different ideas about this. So, I'm not sure=
=20
> whether this micro-optimisation is worth it.

My take on this would be that we shouldn't even have to think about what
the differences are and that if there are genuine tradeoffs here it's
likely that we should be offering them at runtime or to boards or
something rather than picking something in an individual driver.  If
there are meaningful differences I'd at least expect to be able to tell
what they are.

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPtmvyAAoJEBus8iNuMP3dgDkP/1XtwriOZNsYa6PcZASxrcGa
nxfucveaK0Cma8bvQzElC2sZ03DEGiE/8HdH9omo32nFL0QIJ/v0W2jzsrxpzVpL
87Jfil5C+fiK7ccbIwBYrG6lCKRDM8hY+l4CthYVtoR+JTCB6JaaUcR36ZAISUHl
jtVRcXqhpqC4HjkoSPoeBCEyn5b2pR2Ogs/3Pgm3sw0Be7YfPi5TFPx6i/LlUzcF
sE3Bh7+GRsjkIZB5+dce8koxmAW/Su8dW0CO8DM+BSenL7UmPkrGCjMGdxGRHj4E
QBQ3iXjr1VYb5T0o3nxkOJbjDxaD719jUE+ZKCqDtKJ3lzVaMzmf4Xg1xIy1TB+q
AesNio/INlWiPaiISP8iNcowUyj3DfXrNRdbvf4WDgc+C65xoBx0NxU8nO3/VGE4
mDPzn7G3xA25GOEy61VuP4p2nNoZW0HODdzVXdcQjzTByiz0qJeb0fjtlvLaNv2J
s/crMYWvcceXmYmzJvwIIR7AKsCockLaFX3pYS5Kbamatg4A7Zy+suA2CBIPwkto
E1WtD+2Qks0Flwvgp40Jdam262zvVNbtiuZS//MvqNZlO55pO2CCPzc0IGQFFazu
iusjPaRUzpAuhHSN1gL1EGOE+K1ehK1xfzSvZMLeeNWCj4X382VH6MO4BiBWTKrR
QvLOLlwQm6gzMEEubliA
=5PGr
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--

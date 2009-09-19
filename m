From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH] sdhci: Increase timeout for internal clock
 stabilization.
Date: Sat, 19 Sep 2009 22:41:58 +0200
Message-ID: <20090919224158.0e30d05a@mjolnir.ossman.eu>
References: <m3ocp7c31f.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-27869-1253392924-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:38484 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbZISUmB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 19 Sep 2009 16:42:01 -0400
In-Reply-To: <m3ocp7c31f.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, HaraldWelte@viatech.com, Deepak Saxena <dsaxena@laptop.org>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-27869-1253392924-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sep 2009 18:15:56 -0400
Chris Ball <cjb@laptop.org> wrote:

> On an OLPC XO-1.5 development board with Via VX855 chipset, the sdhci
> controller can take up to 12ms to stabilize its clock, but the current
> timeout at which we give up on the controller is 10ms.
>=20
> The patch increases the timeout delay rather than using a device-specific
> quirk -- since we exit the loop when the clock comes up, increasing the
> timeout value will only make us mdelay() longer in the errant case of a
> device with a clock that is not stabilizing, which it seems worth waiting
> a little longer for in general.
>=20
> Signed-off-by: Chris Ball <cjb@laptop.org>
> Cc: Harald Welte <HaraldWelte@viatech.com>
> ---

Seems reasonable enough to me. The initial limit was completely
arbitrary anyway.

Acked-by: Pierre Ossman <pierre@ossman.eu>

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-27869-1253392924-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkq1QhgACgkQ7b8eESbyJLicDACgu7Vw9WaUmPnQBTJkWgMZAxYV
xp8AoMUPGSAJazmjDz6Aye0w+87dR2My
=9XQy
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-27869-1253392924-0001-2--

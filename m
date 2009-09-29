From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: TMIO MMC: full patchset.
Date: Tue, 29 Sep 2009 20:32:35 +0200
Message-ID: <20090929203235.7426cb1f@mjolnir.ossman.eu>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	<20090929132058.GC6934@console-pimps.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-31791-1254249159-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:39816 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbZI2Scf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Sep 2009 14:32:35 -0400
In-Reply-To: <20090929132058.GC6934@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, magnus.damm@gmail.com, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-31791-1254249159-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Sep 2009 14:20:58 +0100
Matt Fleming <matt@console-pimps.org> wrote:

>=20
> I'm not sure that propagating this magical 400kHz constant around the
> MMC code is the best way to go. It could do with a #define.
>=20
> You're the second person to run into issues with the lower limit
> initialisation patch. Does anybody know where that value came from? Is
> it definitely the best value to use or has it just been picked out of
> the air?

The MMC and SD specs state that init must be done at < 400 kHz. We
originally used the lowest possible freq. the controller could handle,
but there was one controller who went so ridiculously low that it caused
other problems.

Re this patch, I'd think it would be more sensible to lower the init
frequency a bit than some retry logic. It is possible to init a card
and for it to end up in a weird state, so we should have margins
already at the first attempt.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-31791-1254249159-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrCUsUACgkQ7b8eESbyJLj0SgCgw2sbdOkzJM7NjTWB5DqaFQKJ
ArgAoNSfCMPJ7ogeNWjoZifs9Ab82PLL
=SA1b
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-31791-1254249159-0001-2--

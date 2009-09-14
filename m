From: Pierre Ossman <pierre-list@ossman.eu>
Subject: Re: MMC retry mechanism
Date: Mon, 14 Sep 2009 21:37:16 +0200
Message-ID: <20090914213716.639c5ccd@mjolnir.ossman.eu>
References: <011c01ca2dac$2de779d0$544ff780@am.dhcp.ti.com>
	<20090906162041.1f4d939d@mjolnir.ossman.eu>
	<004b01ca2f1b$b2ebc9e0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-32544-1252957040-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:43834 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932418AbZINThS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Sep 2009 15:37:18 -0400
In-Reply-To: <004b01ca2f1b$b2ebc9e0$544ff780@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Adrian Hunter' <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-32544-1252957040-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Sep 2009 12:58:54 -0500
"Madhusudhan" <madhu.cr@ti.com> wrote:

> Okay. Thanks for the info. I would like to read those discussions and the
> patches, any reference? Or where do I look for them and any good way to
> search such threads in general?
>=20

The subjects have been a bit unclear unfortunately, but you have a
couple of threads on LKML with the subject "mmc_spi: do proper retry
management in the block layer".

There is also an ancient thread with the subject "MMC performance",
which was back when I tried to tackle the issue originally.

There have been more threads over the years, but I'm afraid I don't
remember enough about them to find them again.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-32544-1252957040-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkqum28ACgkQ7b8eESbyJLg/HQCgxwnI2VQXYwvhS7bNSWf8QM86
QcoAnR4WpSya/DULSE8XGHPZrhFJtfNy
=m5U9
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-32544-1252957040-0001-2--

From: Pierre Ossman <pierre-list@ossman.eu>
Subject: Re: MMC retry mechanism
Date: Sun, 6 Sep 2009 16:20:41 +0200
Message-ID: <20090906162041.1f4d939d@mjolnir.ossman.eu>
References: <011c01ca2dac$2de779d0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-25059-1252246844-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:56208 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757964AbZIFOUm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Sep 2009 10:20:42 -0400
In-Reply-To: <011c01ca2dac$2de779d0$544ff780@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Adrian Hunter' <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-25059-1252246844-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Sep 2009 17:08:05 -0500
"Madhusudhan" <madhu.cr@ti.com> wrote:

> Hi Adrian,
>=20
> With respect to the below commit, It looks like currently the retry
> mechanism only handles the READ path.
>=20
> I wonder could a similar retry logic feasible for the WRITE path?
>=20

The claim is that doing so can break some filesystem drivers (notably
the journaling ones). There has been several threads and patches about
this in the past.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-25059-1252246844-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkqjxTsACgkQ7b8eESbyJLj5tACdGHovc7jgFk/c7AJEfwgTun7l
r/4An2h9OsHNB0cGA+iAkldIMsrC0EyW
=ZIdU
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-25059-1252246844-0001-2--

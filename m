From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Tue, 29 Sep 2009 23:37:32 +0200
Message-ID: <20090929233732.62f470e0@mjolnir.ossman.eu>
References: <1254160269.10634.15.camel@localhost>
	<4AC0FBF0.6090007@csr.com>
	<20090928192548.11da5c3c@fido2.homeip.net>
	<20090929202833.179fb521@mjolnir.ossman.eu>
	<f6ee8ef9d3da123c11433b52ec8d6a60@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-1015-1254260257-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:39091 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbZI2Vhd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Sep 2009 17:37:33 -0400
In-Reply-To: <f6ee8ef9d3da123c11433b52ec8d6a60@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: David Vrabel <david.vrabel@csr.com>, Ohad Ben-Cohen <ohad@bencohen.org>, akpm@linux-foundation.org, p <hilipl@overt.org>, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-1015-1254260257-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Sep 2009 16:20:38 -0400
Philip Langdale <philipl@overt.org> wrote:

>=20
> My understanding from the previous discussion was that SD 3.0 (and
> presumably
> a matching SDHCI 3.0) fully define the low voltage range. As such, a
> controller
> that is documented to conform to this spec, or is otherwise documented to
> implement the functionality, can be safely allowed to run SD cards that
> also
> claim to support the bit.
>=20

I must have missed that part of discussion. If the voltage fully
overlaps with the MMC definition, then I don't see the controllers
having to be designed explicitly for SD 3.0. If not, then we probably
need a new voltage bit for the hosts. In that case separating
supporting from non-supporting should sort itself out easily.

> Yes, there is a danger of pre 3.0 cards claiming to suport the low voltage
> range,
> but I think there's a credible chance that no such cards actually exist,
> and if
> they do, I think they're obscure enough to ignore - if they were a proble=
m,
> the
> SD association would have had to abandon using the same bit as MMC uses.
>=20

Agreed.

Btw, you really need to whip some sense into the line handling of your
email client. :)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-1015-1254260257-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrCfh8ACgkQ7b8eESbyJLj4HQCbBVweXsdOowtpuivfLHvuQyqM
08UAoI0E1+nFOObCGrlSD8Yj3xZXhHcv
=+dlH
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-1015-1254260257-0001-2--

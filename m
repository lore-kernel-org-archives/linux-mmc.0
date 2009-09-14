From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: EXT_CSD  Register : CSD_STRUCTURE vs CSD_CSD_REV
Date: Mon, 14 Sep 2009 21:51:40 +0200
Message-ID: <20090914215140.7efe4671@mjolnir.ossman.eu>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-32588-1252957904-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:60167 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756803AbZINTvl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Sep 2009 15:51:41 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Benjamin.Telya@sandisk.com" <Benjamin.Telya@sandisk.com>, "drzeus-list@drzeus.cx" <drzeus-list@drzeus.cx>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Joshi, Rhishi" <rhishi@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Raju, Veeramanikandan" <veera@ti.com>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-32588-1252957904-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2009 20:34:35 +0530
"Ghorai, Sukumar" <s-ghorai@ti.com> wrote:

> Hello,
>=20
> I am working in Linux MMC driver.
> Recently I came across one 16GB MMC card where EXT_CSD Register having EX=
T_CSD_REV[192] field as ZERO, which is valid according to Specification. Bu=
t card is not working due to following reason -
>=20
>  1.  As we know there are two fields in Extended CSD Register -  CSD_STRU=
CTURE Version[194] & EXT_CSD_REV Revision [192].
>=20
>=20
>  1.  In mmc.c/ mmc_read_ext_csd ()
>     *   Implementation expecting EXT_CSD_REV non zero (e.g. >3 in current=
 code)
>     *   I think it could be checking for CSD_STRUCTURE version.
>     *   Because EXT_CSD_REV having Zero is the valid Field.
>     *   This is the way it's done in other OS too.

The opposite, it expects the version to be below 3 as those are the
only ones it knows about. Checking the CSD version for the EXT_CSD
would just be silly.

>=20
>=20
>  1.  To check the high capacity card.
>     *   We could check in access mode from OCR.  This is not in Linux exa=
ctly and steps to check the EXT_CSD_REV.
>     *   This is done in some other OS too.
>=20

Checking the OCR is insufficient if I remember the spec correctly, so
we ignore it completely. The EXT_CSD needs to be correct for high
capacity to work anyway.

> So do you think we can update the code to check the CSD_STRUCTURE Version=
? Please let us know your opinion.

No, as that would violate the spec and possibly misinterpret some cards
as high-capacity.

To handle your card you would have to build some kind of quirks system
so that the kernel can identify that this card is buggy and compensate
for it.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-32588-1252957904-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkquns4ACgkQ7b8eESbyJLjmGQCg9VkPcSVc1p8BgwD+mYOh1J6M
fHwAn3RrSMlcijJYZgrlYsgs9tlgPwxx
=bQ3N
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-32588-1252957904-0001-2--

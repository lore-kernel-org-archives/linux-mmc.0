From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH  RFC] MMC card of Size > 4GB support in Linu
Date: Wed, 23 Sep 2009 08:06:52 +0200
Message-ID: <20090923080652.0fffadad@mjolnir.ossman.eu>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B02F64D8199@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-12073-1253686018-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:36059 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbZIWGGz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 23 Sep 2009 02:06:55 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B02F64D8199@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Benjamin.Telya@sandisk.com" <Benjamin.Telya@sandisk.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Kamat, Nishant" <nskamat@ti.com>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-12073-1253686018-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Sep 2009 17:52:23 +0530
"Ghorai, Sukumar" <s-ghorai@ti.com> wrote:

>=20
> IV). And what I understood from MMCA specification is that -=20
> EXT_CSD[EXT_CSD_REV]: Defines the fixed parameters and related to the EXT=
_CSD register, according to its revision. And it's nothing to do with MMCA =
specification version or to support > 4GB card.
>=20
> V). But in current Linux MMC code it's expecting EXT_CSD_REV should be >=
=3D2;=20
> And if any card of size >=3D 4GB and EXT_CSD_REV field value is <2,=20
> And MMC card won't work.
>=20
> I have seen cards which having EXT_CSD_REV is <2 and working in other OS.
> So, Here I am sending the possible solution. `
>=20

We've been over this already. Your card is broken. Making the stack
misbehave for not only your card, but every card, is not a good
solution.

The SEC_COUNT field wasn't added until MMC v4.2, and they changed the
EXT_CSD_REV to 1.2 to indicate this new format. You're suggesting that
we ignore the revision field and just read undefined bits, hoping that
they are meaningful. Nobody can consider that a reliable system.

> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 14b81f3..c4e97a9 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -252,6 +252,7 @@ struct _mmc_csd {
>  #define EXT_CSD_BUS_WIDTH      183     /* R/W */
>  #define EXT_CSD_HS_TIMING      185     /* R/W */
>  #define EXT_CSD_CARD_TYPE      196     /* RO */
> +#define EXT_CSD_STRUCT_REV 194     /* RO */
>  #define EXT_CSD_REV            192     /* RO */
>  #define EXT_CSD_SEC_CNT                212     /* RO, 4 bytes */
>=20

And this is just even more wrong. You're telling the stack to check the
revision of the CSD, a completely different structure, for what fields
are valid in the EXT_CSD.

--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-12073-1253686018-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkq5uv8ACgkQ7b8eESbyJLi77gCg5NFwGb2q65aFRqDm+XtTEf1C
R8IAoJlGewBhZEV/9Ts1SewdX2na0e9z
=qAUp
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-12073-1253686018-0001-2--

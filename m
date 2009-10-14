From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Wed, 14 Oct 2009 10:48:49 +0200
Message-ID: <20091014104849.3c441249@mjolnir.ossman.eu>
References: <1254160269.10634.15.camel@localhost>
	<20090928192548.11da5c3c@fido2.homeip.net>
	<20090929202833.179fb521@mjolnir.ossman.eu>
	<f6ee8ef9d3da123c11433b52ec8d6a60@localhost>
	<20090929233732.62f470e0@mjolnir.ossman.eu>
	<20090929231013.5d67b36a@fido2.homeip.net>
	<20091008203826.5e027347@mjolnir.ossman.eu>
	<20091010114215.5f9d8c94@fido2.homeip.net>
	<4AD32B01.5000600@csr.com>
	<20091012193952.1482e322@fido2.homeip.net>
	<da15981b0910140056j9a62fccvdb256b851455c686@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-31059-1255510135-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:59045 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbZJNItb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 14 Oct 2009 04:49:31 -0400
In-Reply-To: <da15981b0910140056j9a62fccvdb256b851455c686@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Philip Langdale <philipl@overt.org>, David Vrabel <david.vrabel@csr.com>, akpm@linux-foundation.org, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-31059-1255510135-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Oct 2009 09:56:28 +0200
Ohad Ben-Cohen <ohad@wizery.com> wrote:

> On Tue, Oct 13, 2009 at 4:39 AM, Philip Langdale <philipl@overt.org> wrot=
e:
> > Interesting. But that means that Ohad's patch doesn't make much sense;
> > his uses the MMC low voltage OCR bit in an SDIO context. So either, the
> > patch is wrong, or he's dealing with out-of-spec hardware.
>=20
> Yes, the hardware is out-of-spec. It uses the undefined low voltage
> OCR bit to achieve 1.8V SDIO voltage. By removing the MMC_VDD_165_195
> restriction, commit 27cce39f555def6f5ebe7f03d69ccc44ab25f0b2 makes it
> possible for the hardware to work with unpatched kernels.
>=20
> Philip, David, Pierre - would you like to remove the MMC_VDD_165_195
> restriction differently ? maybe to revive the MMC_CAP_VDD_165_195 host
> capability patch in some way (see
> http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg00386.html) ?
>=20

Since this is out-of-spec and therefore possibly dangerous behaviour,
I'd like it to be opt-in for the user. And since it's so early in the
init process, we can't automate it based on card id.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-31059-1255510135-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrVkHMACgkQ7b8eESbyJLgNRwCgsG0ThNzAcaOy6XbWfKlv2evE
KxMAoNbf+pGCjs0xBwvhwjK9NTstKtqm
=WU3Y
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-31059-1255510135-0001-2--

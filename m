From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH 1/1] Implementation for knowing speed_class of inserted
 SD  card from user space
Date: Wed, 30 Sep 2009 14:17:57 +0200
Message-ID: <20090930141757.293dd589@mjolnir.ossman.eu>
References: <bd31ea570909300452u49ec17b3h4399da986dd2f78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-8381-1254313084-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:47520 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320AbZI3MSA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Sep 2009 08:18:00 -0400
In-Reply-To: <bd31ea570909300452u49ec17b3h4399da986dd2f78@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mahadev Cholachagudda <mgudda@gmail.com>
Cc: linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-8381-1254313084-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Sep 2009 17:22:14 +0530
Mahadev Cholachagudda <mgudda@gmail.com> wrote:

>=20
> Let me know if you have any comments/suggestions?
>=20

I have a few:

1. The obvious one; why? When does user space need to know the speed
rating, and is the speed rating still meaningful after all the layers
in the kernel? Userspace ABI stuff should be added with great care.

2. I think it's better to not show the attribute when it isn't relevant
rather than return 0xFF.

3. Isn't this a SD 2.0 feature? So you should check the version of the
card before populating/showing this field.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-8381-1254313084-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrDTHcACgkQ7b8eESbyJLgH1gCgi39/F2KESaPQdVrBlYrjev+f
yYYAmwTzSG5y/bIAko30mbTsh5Vwv37X
=2vaI
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-8381-1254313084-0001-2--

From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH 1/4] [MMC] core SDIO suspend/resume support
Date: Sun, 6 Sep 2009 16:17:41 +0200
Message-ID: <20090906161741.33a56583@mjolnir.ossman.eu>
References: <1251916646-3537-1-git-send-email-nico@cam.org>
	<1251916646-3537-2-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-25038-1252246664-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:35475 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827AbZIFORm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Sep 2009 10:17:42 -0400
In-Reply-To: <1251916646-3537-2-git-send-email-nico@cam.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
Cc: linux-mmc@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-25038-1252246664-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 02 Sep 2009 14:37:23 -0400
Nicolas Pitre <nico@cam.org> wrote:

>=20
> When resuming, we make sure the same card is still inserted by comparing
> the vendor and product IDs.  If there is a mismatch, or if there is simply
> no card anymore in the slot, then the previous card is "removed" and the
> new card is detected.
>=20

I know this is an area with a lot of differing views, but I see this as
totally insufficient. Like storage cards, this card might have a
non-volatile state that drivers and upper layers rely on being the same
before and after suspend.

(Then there's also the issue of e.g. having two "identical" wifi cards
but with different MAC addresses).

I think the right way to go is to retain enough power to the card for
it to stay initialised and then poke it at resume to see if it is still
running in the same state we left it.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-25038-1252246664-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkqjxIcACgkQ7b8eESbyJLj/XwCgu7ipf5MlySpqZUzMPz7wRb4A
SvoAoOqo6uKXLhDzGjYzjRbzlFj+kcUT
=Atd/
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-25038-1252246664-0001-2--

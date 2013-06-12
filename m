From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH 00/12] mmc: core: mmc_bus to handle
 suspend|resume|shutdown
Date: Wed, 12 Jun 2013 10:15:59 +0200
Message-ID: <20130612101559.052e40ef@mjolnir.ossman.eu>
References: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdb7Xn88zsZ2Dg2GxC1sG9h=zn15ZrJUsV8R+TSFncjyUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-17505-1371024963-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from saehrimnir.ossman.eu ([193.12.253.10]:34115 "EHLO
	smtp-relay.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974Ab3FLIVL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 04:21:11 -0400
In-Reply-To: <CACRpkdb7Xn88zsZ2Dg2GxC1sG9h=zn15ZrJUsV8R+TSFncjyUg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-17505-1371024963-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jun 2013 11:24:49 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

>=20
> Hm a significant portion of this patch set hits code which has not
> been touched since Pierre Ossman wrote the first MMC code.
> E.g. patch 1.

In the spirit of giving credit where credit is due, the MMC code
existed long before I got involved (mostly written by Russell King
AFAIK). I just happen to change a lot of it. :)

>=20
> I know Pierre has long since moved on to other things, but I'm
> pinging him anyway since it's his code after all...
>=20
> Pierre: tell us if you want a copy of this patch set.
>=20

I had a quick look, but I'm afraid I've managed to purge more or less
all knowledge of that code. You're on your own on this one. ;)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-17505-1371024963-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iF4EAREIAAYFAlG4LkIACgkQopDLsoqlmEKzEQEApBqwx0hS3/8TIDSX+aymBvM3
xV9N63TttAOlXX2okpwA/AmSnqxMEvm+HuenOmg2bCpMegP5rQY/D1MkOukgNL0Q
=lS+P
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-17505-1371024963-0001-2--

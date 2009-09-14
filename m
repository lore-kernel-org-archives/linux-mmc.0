From: Pierre Ossman <pierre-list@ossman.eu>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Mon, 14 Sep 2009 22:05:10 +0200
Message-ID: <20090914220510.5558d215@mjolnir.ossman.eu>
References: <c4e36d110909040213t4d4258b4w3e2d4725e0b2a161@mail.gmail.com>
	<87iqfx5mss.fsf@devron.myhome.or.jp>
	<20090907125130.GA1595@ucw.cz>
	<87ljko5k3v.fsf@devron.myhome.or.jp>
	<20090910192354.GD23356@elf.ucw.cz>
	<87bplim1ce.fsf@devron.myhome.or.jp>
	<20090911200922.GF8137@elf.ucw.cz>
	<c4e36d110909111414n716a06b1mdd0cd741230595b5@mail.gmail.com>
	<20090911213204.GC25544@elf.ucw.cz>
	<c4e36d110909111445nb6592cfue01543f5d04c2cda@mail.gmail.com>
	<20090911215117.GA11441@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-32671-1252958714-0001-2"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757021AbZINUFP@vger.kernel.org>
In-Reply-To: <20090911215117.GA11441@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Zdenek Kabelac <zdenek.kabelac@gmail.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk
List-Id: linux-mmc@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-32671-1252958714-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Sep 2009 23:51:17 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Fri 2009-09-11 23:45:01, Zdenek Kabelac wrote:
> >=20
> > Well system could check basic card ids if they match after resume - if
> > some users wants to crash his card by randomly swapping it during
> > suspend/resume - I'd have no problem with that....
>=20
> Well, I do have small problem with that :-).
>=20
> Anyway, patch for rechecking IDs would probably be accepted, but
> that's not how it works now.
> 								Pavel

It _does_ check the card id when you have UNSAFE_RESUME selected. It
doesn't just hook up whatever card you happen to have in the slot with
your old block device. I may have a lot of opponents when it comes
to my suspend design choices, but I'm not completely crazy. ;)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-32671-1252958714-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkquofgACgkQ7b8eESbyJLhs2QCdEpWDZZjgtrh0MIFNQo4b0p/p
/jwAoPAMComgt/y4lahtlwM5D6l792vp
=adci
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-32671-1252958714-0001-2--

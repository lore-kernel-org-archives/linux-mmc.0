From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: + sdio-recognize-io-card-without-powercycle.patch added to -mm
 tree
Date: Tue, 16 Mar 2010 21:25:11 +0100
Message-ID: <20100316212511.0e1932c9@mjolnir.ossman.eu>
References: <200909132245.n8DMj4P5007763@imap1.linux-foundation.org>
	<4B9184F2.7040004@yahoo.es>
	<20100305143949.29101892.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-21362-1268771113-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:42116 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757634Ab0CPUav (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Mar 2010 16:30:51 -0400
In-Reply-To: <20100305143949.29101892.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linux-mmc@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-21362-1268771113-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Mar 2010 14:39:49 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

>=20
> I have a note here to check with Pierre, who said
>=20
> : I had problems with cards already in the idle state crashing when I
> : sent them a reset. I suggest a big round of testing before merging this.
>=20
> I guess there's no more testing we can do so I'll merge it?

Sounds reasonable. Although the question is if anyone has -mm on a
system which lacks slot power control. :)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-21362-1268771113-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAkuf6SkACgkQ7b8eESbyJLhU5wCg7GntfMo67rZFKHrgauV7gD9C
HMcAn1amB1TOi9Ph/b8/TBnHlylrveDD
=kjCV
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-21362-1268771113-0001-2--

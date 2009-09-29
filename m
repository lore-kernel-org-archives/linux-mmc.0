From: Pierre Ossman <pierre-list@ossman.eu>
Subject: Re: stalled mmc patches
Date: Tue, 29 Sep 2009 23:56:47 +0200
Message-ID: <20090929235647.1c79e421@mjolnir.ossman.eu>
References: <20090929131540.27d72d52.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-1080-1254261411-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:54269 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159AbZI2V4r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Sep 2009 17:56:47 -0400
In-Reply-To: <20090929131540.27d72d52.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <damm@opensource.se>, Paul Mundt <lethal@linux-sh.org>, Albert Herranz <albert_herranz@yahoo.es>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-1080-1254261411-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Sep 2009 13:15:40 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

>=20
> http://userweb.kernel.org/~akpm/mmotm/broken-out/sdio-recognize-io-card-w=
ithout-powercycle.patch

I think it was a libertas card that I had problems with. So if someone
has one of those and some time for hacking and testing. They'd need to
make sure the card remains powered between inits to fully expose the
bug I saw.

PS. try to clear my @drzeus.cx addresses from your address books. They
will cease to function in the future.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-1080-1254261411-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrCgqEACgkQ7b8eESbyJLgZ6gCg9SRRk9GKVcx/LSqLr7UiIrJc
ZooAn02XMvFjKUa9hDTPFoUjZcbaNKn0
=3lpI
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-1080-1254261411-0001-2--

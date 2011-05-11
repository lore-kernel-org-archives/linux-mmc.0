From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2 1/2] pxamci: remove the ifdef CONFIG_REGULATOR
Date: Wed, 11 May 2011 22:19:14 +0200
Message-ID: <20110511221914.b09c1753.ospite@studenti.unina.it>
References: <20110510203629.GB8726@opensource.wolfsonmicro.com>
	<1305109145-16567-1-git-send-email-ospite@studenti.unina.it>
	<m38vud2taw.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__11_May_2011_22_19_14_+0200_dzmZcg727iEwn4RH"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:40037 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643Ab1EKUTc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 May 2011 16:19:32 -0400
In-Reply-To: <m38vud2taw.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, openezx-devel@lists.openezx.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

--Signature=_Wed__11_May_2011_22_19_14_+0200_dzmZcg727iEwn4RH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 11 May 2011 10:41:43 -0400
Chris Ball <cjb@laptop.org> wrote:

> On Wed, May 11 2011, Antonio Ospite wrote:
[...]
> >  drivers/mmc/host/pxamci.c |    5 ++---
> >  1 files changed, 2 insertions(+), 3 deletions(-)
[...]
>=20
> Thanks, I've merged this and squashed the 2/2 punctuation patch into it;
> it didn't seem worth having a separate patch when both touch the same cod=
e.
>=20

That's perfectly fine with me.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__11_May_2011_22_19_14_+0200_dzmZcg727iEwn4RH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3K70IACgkQ5xr2akVTsAHIswCeIJLCouXjz9pIYuIitLno6cps
augAn2qR6dShaWQCNHFQhujnlh9yJ9WN
=ZSwJ
-----END PGP SIGNATURE-----

--Signature=_Wed__11_May_2011_22_19_14_+0200_dzmZcg727iEwn4RH--

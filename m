From: Mike Kelly <pioto@pioto.org>
Subject: Re: [Bugme-new] [Bug 18602] New: mmc_block / tifm_sd not completely
 registering when a new sd card is inserted
Date: Mon, 20 Sep 2010 23:25:17 -0400
Message-ID: <20100920232517.4299f662@aether.home.pioto.org>
References: <20100919105632.6fb34fa5@aether.home.pioto.org>
	<513651.95215.qm@web37608.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/F_CORi=GDGv+VEv4PTsRUlm"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.pioto.org ([207.192.71.235]:57766 "EHLO
	everglades.pioto.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753866Ab0IUDZ1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 23:25:27 -0400
In-Reply-To: <513651.95215.qm@web37608.mail.mud.yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Dubov <oakad@yahoo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org

--Sig_/F_CORi=GDGv+VEv4PTsRUlm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Sep 2010 17:50:30 -0700 (PDT)
Alex Dubov <oakad@yahoo.com> wrote:

> It's not created, because media times out. Why it happens is a
> different question. It may be that clock parameters or something
> similar are not properly configured (I don't have any datasheets for
> these devices). There can also be a mechanical failure of the SD
> socket (these things do happen).
>=20
> Can you confirm that the socket and media are good, by trying them out
> under windows or something?

The same SD card and reader work fine under Windows Vista on this same
machine. Ditto other SD cards in this reader. The fact that I am
occasionally able to get this reader to work under Linux, though does
make it seem like some timing or race issue that I'm hitting, though.

I may give SDHCI a go at some point, but I'll have to read up on it
more.

--=20
Mike Kelly


--Sig_/F_CORi=GDGv+VEv4PTsRUlm
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkyYJZ0ACgkQokMzJ47YCzohHwCeJhYio3uM1WA3W1fzRz0ODHGb
K+wAn3Nciiu9FMqandsjeIfXPyoQQIaq
=panb
-----END PGP SIGNATURE-----

--Sig_/F_CORi=GDGv+VEv4PTsRUlm--

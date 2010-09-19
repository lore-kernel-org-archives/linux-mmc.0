From: Mike Kelly <pioto@pioto.org>
Subject: Re: [Bugme-new] [Bug 18602] New: mmc_block / tifm_sd not completely
 registering when a new sd card is inserted
Date: Sun, 19 Sep 2010 10:56:32 -0400
Message-ID: <20100919105632.6fb34fa5@aether.home.pioto.org>
References: <20100918050127.39ab1e8b@aether.home.pioto.org>
	<929512.43617.qm@web37607.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/LDza2sz_=.d6vmnneGn1Uk5"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.pioto.org ([207.192.71.235]:52091 "EHLO
	everglades.pioto.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753042Ab0ISO4i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Sep 2010 10:56:38 -0400
In-Reply-To: <929512.43617.qm@web37607.mail.mud.yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Dubov <oakad@yahoo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org

--Sig_/LDza2sz_=.d6vmnneGn1Uk5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Sep 2010 22:19:42 -0700 (PDT)
Alex Dubov <oakad@yahoo.com> wrote:

> The driver appears to do everything right. The problem is that your
> media timeouts on the initialization commands, so driver decides it's
> not worth operating.
>=20
> There's a module option of tifm_sd called "fixed_timeout" (check it
> out with modinfo). It will preclude setting of hardware timeout
> register. Lets see what it does on your setup.

Unfortunately, it doesn't seem to make a difference here. When I plug
in my sd card, it looks like tifm_sd gets loaded, lots of debugging
output. But, no /dev/mmcblk0 shows up, and mmc_block does not get
loaded.

--=20
Mike Kelly

--Sig_/LDza2sz_=.d6vmnneGn1Uk5
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkyWJKQACgkQokMzJ47YCzqvPgCguHRN821+ZD525TSY3+QLv4lL
OrsAoJLHfzrvfzFejyDaDMoQRKdcK0LV
=fN4Z
-----END PGP SIGNATURE-----

--Sig_/LDza2sz_=.d6vmnneGn1Uk5--

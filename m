From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: Re: [PATCH v3 11/12] mmc: sunxi: Convert MMC driver to the standard clock phase API
Date: Fri, 26 Sep 2014 16:27:10 +0200
Message-ID: <3992138.y6J8TjIuMq@pagira.o2s.ch>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com> <1410466706-27386-12-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart64174242.DlQWOzDDiA"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kolab.o2s.ch ([77.109.136.180]:59654 "EHLO kolab.o2s.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755123AbaIZObA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Sep 2014 10:31:00 -0400
In-Reply-To: <1410466706-27386-12-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, wens@csie.org


--nextPart64174242.DlQWOzDDiA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hello
> Now that we have proper support to use the generic phase API in our c=
lock
> driver, switch the MMC driver to use it.
> [...]
>  =09/* determine delays */
>  =09if (rate <=3D 400000) {
> -=09=09oclk_dly =3D 0;
> -=09=09sclk_dly =3D 7;
> +=09=09oclk_dly =3D 180;
> +=09=09sclk_dly =3D 42;
> [...]
How did you calculate the actual phase values from the original paramet=
ers?

greatings
=2D-=20
David Lanzend=F6rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
--nextPart64174242.DlQWOzDDiA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlQld8QACgkQAeZw77btGjoJ2ACdHJ7p45e0wf1ZPmsy+7FpVfs+
SFcAoKWruth0hUhjwzAUF4UPdmtdurRS
=jltd
-----END PGP SIGNATURE-----

--nextPart64174242.DlQWOzDDiA--


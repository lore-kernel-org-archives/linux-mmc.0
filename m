From: Pierre Ossman <pierre@ossman.eu>
Subject: [PATCH] Orphaning sdhci driver and list
Date: Sun, 6 Sep 2009 15:56:32 +0200
Message-ID: <20090906155632.3ef835e3@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-24961-1252245396-0001-2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:37925 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772AbZIFN4d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Sep 2009 09:56:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: sdhci-devel@lists.ossman.eu, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Ben Dooks <ben@fluff.org>, Anton Vorontsov <avorontsov@ru.mvista.com>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-24961-1252245396-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Remove myself as maintainer from the sdhci driver and steer people
towards the new MMC list for discussing it.

Signed-off-by: Pierre Ossman <pierre@ossman.eu>
---

I've noticed that people have already begun sending their sdhci patches
to Andrew, so this is more or less a formality at this point.

I won't be turning off the sdhci-devel list anytime soon, but please
try to move your conversations to the linux-mmc list.

And as with the core MMC stuff, I'm not falling of the face of the
planet, just prioritising different things in my life for a while.


diff --git a/MAINTAINERS b/MAINTAINERS
index d6befb2..ad5daf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4449,20 +4449,20 @@ S:      Maintained
 F:     drivers/mmc/host/sdricoh_cs.c
=20
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
-M:     Pierre Ossman <pierre@ossman.eu>
-L:     sdhci-devel@lists.ossman.eu
-S:     Maintained
+S:     Orphan
+L:     linux-mmc@vger.kernel.org
+F:     drivers/mmc/host/sdhci.*
=20
 SECURE DIGITAL HOST CONTROLLER INTERFACE, OPEN FIRMWARE BINDINGS (SDHCI-OF)
 M:     Anton Vorontsov <avorontsov@ru.mvista.com>
 L:     linuxppc-dev@ozlabs.org
-L:     sdhci-devel@lists.ossman.eu
+L:     linux-mmc@vger.kernel.org
 S:     Maintained
-F:     drivers/mmc/host/sdhci.*
+F:     drivers/mmc/host/sdhci-of.*
=20
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
 M:     Ben Dooks <ben-linux@fluff.org>
-L:     sdhci-devel@lists.ossman.eu
+L:     linux-mmc@vger.kernel.org
 S:     Maintained
 F:     drivers/mmc/host/sdhci-s3c.c
=20

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-24961-1252245396-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkqjv5IACgkQ7b8eESbyJLi2oACeNCdkvNoUThFg7+KnUm/zZO4G
72cAoO2e2nEkRKzn8iAIHEZ6eispONnF
=A/St
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-24961-1252245396-0001-2--

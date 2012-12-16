From: NeilBrown <neilb@suse.de>
Subject: Problem with "mmc: core: Do not rescan non-removable devices"
Date: Sun, 16 Dec 2012 16:36:35 +1100
Message-ID: <20121216163635.47537729@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/NxTZHU/Jp/RzaUaM+thXbUC"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38043 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab2LPFhA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 16 Dec 2012 00:37:00 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

--Sig_/NxTZHU/Jp/RzaUaM+thXbUC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


hi,
 the commit below causes my wifi to disappear on suspend and never
 reappear.
 Unfortunately the commentary says what the patch does but not why, so I
 cannot tell if simply reverting it is correct, or if something more subtle
 in needed.

 My wifi chip is a "libertas" driven "Marvell" chip.  It is permanently
 attached to port 1 on an OMAP3 'hsmmc' interface.  So MMC_CAP_NONREMOVABLE
 seem appropriate and is set.

 It is normally inactive and when the suspend code notices this it doesn't
 bother trying to suspend through the driver but just removes the core:
			/*
			 * We simply "remove" the card in this case.
			 * It will be redetected on resume.  (Calling
			 * bus_ops->remove() with a claimed host can
			 * deadlock.)
			 */
 (in mmc_suspend_host).  Only it isn't redetected on resume because
 rescan_entered is set.

 I guess we could clear rescan_entered at this point.  Would that make sens=
e?
 It seems to work.

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 06c42cf..65b8935 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2433,6 +2433,7 @@ int mmc_suspend_host(struct mmc_host *host)
 			mmc_claim_host(host);
 			mmc_detach_bus(host);
 			mmc_power_off(host);
+			host->rescan_entered =3D 0;
 			mmc_release_host(host);
 			host->pm_flags =3D 0;
 			err =3D 0;


Thanks,
NeilBrown



=46rom 3339d1e33185798a45dbdb5ea6c0bec1c27ca5fd Mon Sep 17 00:00:00 2001
From: Johan Rudholm <johan.rudholm@stericsson.com>
Date: Thu, 23 Aug 2012 13:40:55 +0200
Subject: [PATCH] mmc: core: Do not rescan non-removable devices

If MMC_CAP_NONREMOVABLE is set, only issue a detect job on init.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Chris Ball <cjb@laptop.org>

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 835c9f0..af2c4d2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2053,6 +2053,11 @@ void mmc_rescan(struct work_struct *work)
 	if (host->rescan_disable)
 		return;
=20
+	/* If there is a non-removable card registered, only scan once */
+	if ((host->caps & MMC_CAP_NONREMOVABLE) && host->rescan_entered)
+		return;
+	host->rescan_entered =3D 1;
+
 	mmc_bus_get(host);
=20
 	/*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f578a71..d5d9bd4 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -300,6 +300,7 @@ struct mmc_host {
 #endif
=20
 	int			rescan_disable;	/* disable card detection */
+	int			rescan_entered;	/* used with nonremovable devices */
=20
 	struct mmc_card		*card;		/* device attached to this host */
=20

--Sig_/NxTZHU/Jp/RzaUaM+thXbUC
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUM1d4znsnt1WYoG5AQI/Sg//QR/pj1w4Nj9ZGuSUSV1vMNYDXkvVzFfO
i0C9yjEB/NMXO/4en9yY4sKYpCfVZ636QGAe/maq3eW/B7rJG1cKsxxM6xB3f4hn
vN3q9D/smehiQArwbDhaojWTM9+di+7G4DYBrzsmnD+aBgPhbXy1OivJAslEdN0r
dZ+8RIEGf+quMUlDf8kWW0qjFDliZ9si7qSgaGaYl4XcHbQTURM3zoxvM70YWDyS
7mUODT2DgOKlKdJhKOQdtYvuac7NRlmtwyRMYEXAQimqPzrO2klC20bGmEZ0HTPe
/ibz9MVege7U0Lu29MSwXIuporDrYiSs45AGSXJyLN6HpEtPi9YgXwuhFYYRe0E3
OwNkM3bSnTGUjFiZnyQFmVGHaQ11zmm6AsTLUJUQkvJ8iWdfqhSqEFQrwI42YCMr
b7BUyV+6pVexkIvmP6kFZ9DHpKqZTRg3Qh0py3Cv3eDcQQrPDtyd/rSFaFkZuQ2G
9vzXZUSQcPwsSSXWtdVteW9E46qou9Tx2QITgbJxg8FMqtSlRKYy+EaQ007YesxT
rJK4VIQ85Xm3BvVXAdPVssGfZmFGlJ0CzlvyYv3y6kT+Q2vmcud9KaKYAtpwoeMr
GTyCX2u3sCfwbiNPpWv6H9wrA/QBuan/NB6XpTojZKuGUDjVDnJdGmJ5A0rmm5pb
6DpoYrDML48=
=xRh1
-----END PGP SIGNATURE-----

--Sig_/NxTZHU/Jp/RzaUaM+thXbUC--

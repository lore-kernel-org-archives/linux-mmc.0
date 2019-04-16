From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] mmc: core: Fix warning and undefined behavior in mmc voltage
 handling
Date: Tue, 16 Apr 2019 09:58:45 +0200
Message-ID: <20190416075845.GA15615@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


!voltage_ranges is tested for too late, allowing warning and undefined
behavior. Fix that.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 3a4402a..b3fa9c9 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -363,11 +363,11 @@ int mmc_of_parse_voltage(struct device_node *np, u32 =
*mask)
 	int num_ranges, i;
=20
 	voltage_ranges =3D of_get_property(np, "voltage-ranges", &num_ranges);
-	num_ranges =3D num_ranges / sizeof(*voltage_ranges) / 2;
 	if (!voltage_ranges) {
 		pr_debug("%pOF: voltage-ranges unspecified\n", np);
 		return 0;
 	}
+	num_ranges =3D num_ranges / sizeof(*voltage_ranges) / 2;
 	if (!num_ranges) {
 		pr_err("%pOF: voltage-ranges empty\n", np);
 		return -EINVAL;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly1izUACgkQMOfwapXb+vIFqQCguv0iUggvSG5uhkfdCupeHilV
i+oAoJ60rRtMfaVr8bxpOe5/8/rUidMO
=tLFN
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

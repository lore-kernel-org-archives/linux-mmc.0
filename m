From: NeilBrown <neilb@suse.de>
Subject: [PATCH] mmc: pwrseq_simple: fix error path in
 mmc_pwrseq_simple_alloc.
Date: Sat, 21 Feb 2015 15:15:16 +1100
Message-ID: <20150221151516.1b3bc8ae@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/L0CKNDdns+zjMICPqJAq2Xl"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46070 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011AbbBUEP1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Feb 2015 23:15:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-mmc@vger.kernel.org

--Sig_/L0CKNDdns+zjMICPqJAq2Xl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


From: NeilBrown <neil@brown.name>

The current error-path code (when gpiod_get_index() reports
an error) can never free pwrseq->reset_gpios[0], but might
try to tree pwrseq->reset_gpios[-1], which has unfortunate
consequences.

Signed-off-by: NeilBrown <neil@brown.name>
Fixes: 934f1f48330ed695927a51fa068dc5d673f2da19


diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_sim=
ple.c
index e9f1d8d84613..c53f14a7ce54 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -124,7 +124,7 @@ int mmc_pwrseq_simple_alloc(struct mmc_host *host, stru=
ct device *dev)
 		    PTR_ERR(pwrseq->reset_gpios[i]) !=3D -ENOSYS) {
 			ret =3D PTR_ERR(pwrseq->reset_gpios[i]);
=20
-			while (--i)
+			while (i--)
 				gpiod_put(pwrseq->reset_gpios[i]);
=20
 			goto clk_put;

--Sig_/L0CKNDdns+zjMICPqJAq2Xl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVOgGVDnsnt1WYoG5AQI4zRAAvsuQR5VYywiBLuJBxLnCNxHrKdMM+iWs
AbO7z8rbTW/1ZT/JcesYNzMBiUoGncOdTmZwjP+aF+6rE5Ss19vI6rriQoUqD1CX
xHeMXHORmoUFjm8kH8ZPA1NB4RP3VH8kWKh02Th35dhz2R7U/q19mNEvDmMR61Jr
xbziesekOajjIYase65k2SQLP6Xn7dIbl4thLNy0VBVY/OiW0JViMa4Lo03wT1nQ
lC6MfSOWRjW2CKAxaur0jenCMzQpSJc5UhmfbKcvSjPEqd4og01njgRB+l/nH4AP
6/yxcrU0NaHGOhUM05anVHdFUx3qyDhCgNHFhuEglBn4lSKKf8Iyj9OZaNIlY/HJ
vm/9VjJ+PU1WQjE6rrl2kqQxti3b3gACvDWe4PJGNqMWhkHTpEOJ5gceGtytCiYC
UmKbqFrLCphdVvdycsN4ENuEECmqoTdY4JesgU8Jazl9/p4M5DuDAtLeuRXp7qr6
6VLAPaHvXKe88jP2XoUI11Q9pxWefsxmx29RbZpc3xS/onwKrKPUUypYvJiF0E/y
HsaLAcbD6d6sLJq1ihFTVuMpW/Uoa4e70NyKEtHtezdHMjyRH2wJAjx9kncpLmbI
x91yVRJdwOpHs10R6icpRm0wo4+hixDkAd/C3rUSDi/Nim7iEel2p5nuDLB8BVhQ
TXUXVYA63Yk=
=FWP6
-----END PGP SIGNATURE-----

--Sig_/L0CKNDdns+zjMICPqJAq2Xl--

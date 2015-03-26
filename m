From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 1/2] mmc: omap_hsmmc: stop using .enable and .disable
 method.
Date: Thu, 26 Mar 2015 12:18:23 +1100
Message-ID: <20150326121823.148da0f4@notabene.brown>
References: <20150325213419.11463.33321.stgit@notabene.brown>
	<20150325214337.11463.93489.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/aqubwoBokYYETH//pVv0M_j"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41297 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbbCZBSf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Mar 2015 21:18:35 -0400
In-Reply-To: <20150325214337.11463.93489.stgit@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <chris@printf.net>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

--Sig_/aqubwoBokYYETH//pVv0M_j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Mar 2015 08:43:37 +1100 NeilBrown <neil@brown.name> wrote:

> enable and disable are only used to get and put
> runtime pm references.  .set_ios already does this
> itself, and other drivers just do it in set_ios
> and .request without using enable/disable.
>=20
> So add pm_runtime get/put to omap_hsmmc_request(),
> and discard the enable/disable methods.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>

Sorry, that patch wasn't much good.  This one I have really tested properly
and checked that the 'put' match the 'get's and  that the device to regular=
ly
go to sleep as expected.

NeilBrown


From: NeilBrown <neil@brown.name>
Date: Thu, 26 Mar 2015 08:28:43 +1100
Subject: [PATCH] mmc: omap_hsmmc: stop using .enable and .disable method.

enable and disable are only used to get and put
runtime pm references.  .set_ios already does this
itself, and other drivers just do it in set_ios
and .request without using enable/disable.

So add pm_runtime get/put to omap_hsmmc_request(),
and discard the enable/disable methods.

Signed-off-by: NeilBrown <neil@brown.name>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f84cfb01716d..2cb81538a612 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -882,6 +882,8 @@ static void omap_hsmmc_request_done(struct omap_hsmmc_h=
ost *host, struct mmc_req
 		return;
 	host->mrq =3D NULL;
 	mmc_request_done(host->mmc, mrq);
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
 }
=20
 /*
@@ -1305,6 +1307,8 @@ static void omap_hsmmc_dma_callback(void *param)
=20
 		host->mrq =3D NULL;
 		mmc_request_done(host->mmc, mrq);
+		pm_runtime_mark_last_busy(host->dev);
+		pm_runtime_put_autosuspend(host->dev);
 	}
 }
=20
@@ -1537,6 +1541,7 @@ static void omap_hsmmc_request(struct mmc_host *mmc, =
struct mmc_request *req)
=20
 	BUG_ON(host->req_in_progress);
 	BUG_ON(host->dma_ch !=3D -1);
+	pm_runtime_get_sync(host->dev);
 	if (host->protect_card) {
 		if (host->reqs_blocked < 3) {
 			/*
@@ -1553,6 +1558,8 @@ static void omap_hsmmc_request(struct mmc_host *mmc, =
struct mmc_request *req)
 			req->data->error =3D -EBADF;
 		req->cmd->retries =3D 0;
 		mmc_request_done(mmc, req);
+		pm_runtime_mark_last_busy(host->dev);
+		pm_runtime_put_autosuspend(host->dev);
 		return;
 	} else if (host->reqs_blocked)
 		host->reqs_blocked =3D 0;
@@ -1566,6 +1573,8 @@ static void omap_hsmmc_request(struct mmc_host *mmc, =
struct mmc_request *req)
 			req->data->error =3D err;
 		host->mrq =3D NULL;
 		mmc_request_done(mmc, req);
+		pm_runtime_mark_last_busy(host->dev);
+		pm_runtime_put_autosuspend(host->dev);
 		return;
 	}
 	if (req->sbc && !(host->flags & AUTO_CMD23)) {
@@ -1778,25 +1787,6 @@ static void omap_hsmmc_conf_bus_power(struct omap_hs=
mmc_host *host)
 	set_sd_bus_power(host);
 }
=20
-static int omap_hsmmc_enable_fclk(struct mmc_host *mmc)
-{
-	struct omap_hsmmc_host *host =3D mmc_priv(mmc);
-
-	pm_runtime_get_sync(host->dev);
-
-	return 0;
-}
-
-static int omap_hsmmc_disable_fclk(struct mmc_host *mmc)
-{
-	struct omap_hsmmc_host *host =3D mmc_priv(mmc);
-
-	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
-
-	return 0;
-}
-
 static int omap_hsmmc_multi_io_quirk(struct mmc_card *card,
 				     unsigned int direction, int blk_size)
 {
@@ -1808,8 +1798,6 @@ static int omap_hsmmc_multi_io_quirk(struct mmc_card =
*card,
 }
=20
 static struct mmc_host_ops omap_hsmmc_ops =3D {
-	.enable =3D omap_hsmmc_enable_fclk,
-	.disable =3D omap_hsmmc_disable_fclk,
 	.post_req =3D omap_hsmmc_post_req,
 	.pre_req =3D omap_hsmmc_pre_req,
 	.request =3D omap_hsmmc_request,

--Sig_/aqubwoBokYYETH//pVv0M_j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVRNeXznsnt1WYoG5AQLA4RAAk4tdtR6RaOaSVkL2Qa3cQAmy3KULpFtA
0Fg9qho/v2J01ifyHooBWMfseAlc/Fi70UOuMoRHGazkd0l3yW4FA7CLskdoyWxJ
MjnkAMVHBLPpkv8VYgnDP7E258YizGKCcx/93+X/UZFq/XatGiid2soEF/PEJ0Sr
qMXB8FxjhX/qLsnTGKe8lN2PhRfztNVidPmqicE5wufTzxlEpwXx8cMM3oMDf9/J
qt+5uJPO+QYbaQAl1HQnBAmsm9TNCweWe5OLzejwKZXX5yQV0vNyx5R0kloPdk49
6GwciVA66g/ZI8N96955may+YogUK8DsRye5IsSLI6XirjCUIWxvmCaL/kjVDBMg
EYcbvRDENCinqfV+5qOB65DGMrSHzM3n8qfuZxA/s73fU9WwwYqzBRj6dM7+wSZt
6Vf+I0dDPPgLEvKhkYYwbABJUeu09L/DKSok76h6NMa9RkKvRgbZaPjuprdxlR2M
q2NZRyklhYRHgUKFSb9FrOOgTQpB6J8S9IFhkzmZ+svwVQdDprZhBBDeQniyp45n
Gd6lWkmstaFNEhnSFyTteJK4MMs7gqfxTC7+nR6bFtMNQuQx3T/j92TVLr0aqEgJ
XiaQuEf/+UfTodbRDnCXeJlCCHH6mZgkGBcsvGp7Qmdywq1sabe55ep8pxc4qTxQ
tryMblzS64Q=
=K0JG
-----END PGP SIGNATURE-----

--Sig_/aqubwoBokYYETH//pVv0M_j--

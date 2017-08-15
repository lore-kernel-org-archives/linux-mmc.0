From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Tue, 15 Aug 2017 11:16:19 +0200
Message-ID: <20170815091618.ydnwlqx5ahwvn33e@ninjato>
References: <1502152045-150457-1-git-send-email-shawn.lin@rock-chips.com>
 <20170814175831.bgwr6hwc4tvbkmoc@ninjato>
 <f4f100a0-9edd-db13-1c21-9f986345c733@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p5d53keytwq2hiyu"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:52435 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751807AbdHOJQU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Aug 2017 05:16:20 -0400
Content-Disposition: inline
In-Reply-To: <f4f100a0-9edd-db13-1c21-9f986345c733@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--p5d53keytwq2hiyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> So that implies we only need to care about open-ending mode.

I see. Thanks for the explanation.

> I could fold in the description from the spec see explain why
> we don't need to check this for the CMD23 cases.

That would be great.

> Does all the above sound goot to you?

Basically, yes. If we need to check for CMD23 then, I wonder if why we
really need to do (md->flags & MMC_BLK_CMD23) or if we can't simply
check the presence of brq->mrq.sbc? That could then lead to the
following refactorization which is a lot easier to read IMO (but only
compile tested, just to give you an idea what I had in mind):

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f1bbfd389367ff..1cf905d0e88e77 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1371,12 +1371,17 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_=
request *brq,
 	 R1_CC_ERROR |		/* Card controller error */		\
 	 R1_ERROR)		/* General/unknown error */
=20
-static bool mmc_blk_has_cmd_err(struct mmc_command *cmd)
+/* Map R1 errors to error codes */
+static void mmc_blk_eval_resp_error(struct mmc_blk_request *brq)
 {
-	if (!cmd->error && cmd->resp[0] & CMD_ERRORS)
-		cmd->error =3D -EIO;
+	u32 val;
=20
-	return cmd->error;
+	/* If there is no error yet, check R1 response */
+	if (!brq->stop.error) {
+		val =3D brq->stop.resp[0] & CMD_ERRORS;
+		if (val && !(val & R1_OUT_OF_RANGE && brq->mrq.sbc))
+			brq->stop.error =3D -EIO;
+	}
 }
=20
 static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
@@ -1400,8 +1405,10 @@ static enum mmc_blk_status mmc_blk_err_check(struct =
mmc_card *card,
 	 * stop.error indicates a problem with the stop command.  Data
 	 * may have been transferred, or may still be transferring.
 	 */
-	if (brq->sbc.error || brq->cmd.error || mmc_blk_has_cmd_err(&brq->stop) ||
-	    brq->data.error) {
+
+	mmc_blk_eval_resp_error(brq);
+
+	if (brq->sbc.error || brq->cmd.error || brq->stop.error || brq->data.erro=
r) {
 		switch (mmc_blk_cmd_recovery(card, req, brq, &ecc_err, &gen_err)) {
 		case ERR_RETRY:
 			return MMC_BLK_RETRY;

Regards,

   Wolfram


--p5d53keytwq2hiyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmSu94ACgkQFA3kzBSg
KbbOdQ//eKPUv/YWyF4HTEToRfjBWulD8K3EYt4EWEPG9EvM5XP7vCRKiDojoUeA
xs8G6RwE4CiDkHxg0NasYOuhJRU3c8GhSj/i/HnJECbP/vsVhwLZROI8CnFydiMr
iWiSzS6F/bECJivr/h0yfRfQvtoQeVqb/bf1IRkbHXcwo+YJ4/EbIpZ2AYSFmT+P
FIC8p97aAemx163c3INhik5IiQcs5YpeXf/Dv2arr0NIyUHOdetpUHbeWOxpXvWy
FGC6YxV4Y215RP7XxRSFWM2DLg/zvJSB92Ea9nP7bQ7n2ClLDjNqE0RNJ4XPYYgK
4jqQLXzV9wDmizoB7voxwAhpc8nJ5uqGtXP+r52K16nBkv8tr9q1R6oeE9f8iIKi
8ElVlnTAIiDVA9TKPGVba+RKOITAt08x3srLQp1pxVkPJGh2PDZh+JD747r3c1kf
FlMB07qTVIFw/4zV4FagdssOCMFze39GaidnX4wnLXpu/JknGJ+8+aPwrrV17MBZ
fmsv14uRlWd7wVsegMAZBsQmRb72mX8Wg3jxvvl70vp4mbEGRTuNsQwOz4JJEO7e
a2BXXbwsmcvgEaayy3nLv2u422ytahnjCDSp8OaaGrSNPYU/RPl4n/2yE7vgceRm
IkYf8ijX3NoRU9Vud/nHEW5qoVeQGZfu+/ilH5JqnBLZHGm9VbU=
=pDgf
-----END PGP SIGNATURE-----

--p5d53keytwq2hiyu--

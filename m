From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Mon, 14 Aug 2017 19:58:31 +0200
Message-ID: <20170814175831.bgwr6hwc4tvbkmoc@ninjato>
References: <1502152045-150457-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vgcv3t4zz55elkbi"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50248 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752411AbdHNR6d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Aug 2017 13:58:33 -0400
Content-Disposition: inline
In-Reply-To: <1502152045-150457-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--vgcv3t4zz55elkbi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

really sorry for the delay! But now, here are my thoughts:

> +	/*
> +	 * Per the SD specification(physical layer version 4.10),
> +	 * section 4.3.3, it explicitly states that "When the last
> +	 * block of user area is read using CMD18, the host should
> +	 * ignore OUT_OF_RANGE error that may occur even the sequence

missing "if"? ..."even if the sequence"... Yeah, it is missing in the
specs, too, but still.

> +	 * is correct". And JESD84-B51 for eMMC also has a similar
> +	 * statement on section 6.8.3. As CMD23 is optional for either
> +	 * cards or hosts, so we need to check the MMC_BLK_CMD23 flag
> +	 * to prevent the OUT_OF_RANGE error for open-ending multiple
> +	 * block operations as it's normal behaviour.
> +	 */

I really like adding this comment. Yet, I don't really get why you check
for CMD23, though, since the SD specs say CMD18? As I understand it,
this is true for all multiblock accesses, so we could also do something
like this (only build tested)?

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f1bbfd389367ff..e83d8291ad4f99 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1362,6 +1362,14 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_r=
equest *brq,
 	}
 }
=20
+#define STOP_ERRORS							\
+	 (R1_ADDRESS_ERROR |	/* Misaligned address */		\
+	 R1_BLOCK_LEN_ERROR |	/* Transferred block length incorrect */\
+	 R1_WP_VIOLATION |	/* Tried to write to protected block */	\
+	 R1_CARD_ECC_FAILED |	/* Card ECC failed */			\
+	 R1_CC_ERROR |		/* Card controller error */		\
+	 R1_ERROR)		/* General/unknown error */
+
 #define CMD_ERRORS							\
 	(R1_OUT_OF_RANGE |	/* Command argument out of range */	\
 	 R1_ADDRESS_ERROR |	/* Misaligned address */		\
@@ -1371,9 +1379,9 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_re=
quest *brq,
 	 R1_CC_ERROR |		/* Card controller error */		\
 	 R1_ERROR)		/* General/unknown error */
=20
-static bool mmc_blk_has_cmd_err(struct mmc_command *cmd)
+static bool mmc_blk_has_cmd_err(struct mmc_command *cmd, u32 err_mask)
 {
-	if (!cmd->error && cmd->resp[0] & CMD_ERRORS)
+	if (!cmd->error && cmd->resp[0] & err_mask)
 		cmd->error =3D -EIO;
=20
 	return cmd->error;
@@ -1400,7 +1408,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct m=
mc_card *card,
 	 * stop.error indicates a problem with the stop command.  Data
 	 * may have been transferred, or may still be transferring.
 	 */
-	if (brq->sbc.error || brq->cmd.error || mmc_blk_has_cmd_err(&brq->stop) ||
+	if (brq->sbc.error || brq->cmd.error || mmc_blk_has_cmd_err(&brq->stop, S=
TOP_ERRORS) ||
 	    brq->data.error) {
 		switch (mmc_blk_cmd_recovery(card, req, brq, &ecc_err, &gen_err)) {
 		case ERR_RETRY:

Note that I decided to not couple STOP_ERRORS and CMD_ERRORS in case we
need more adjustments in the future. And your comment needs to be added
somewhere, too. It is just to show what I mean.

Do you think this could work, too? Or am I missing something?

Thanks and kind regards,

   Wolfram


--vgcv3t4zz55elkbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmR5MMACgkQFA3kzBSg
KbY6yg//clC1LKSUaLkrmgT3k9YkBI79JbxnNauGdR+1iUOvRkt7cVWlhtSLAnEV
qepwoERWCTk8ioV4mDyfaWPjTrVx67aq2MWZu+x3QUmsRwL+YTAOzBNmXQRi6h6r
60+p7/MT7bI3CqYXpvj8riUTdruW1ZfeGU7qzBq+oQQj7E+rt941Wy8WfK7zYBOn
o6tpDbgrF5WLt8SntBSPfeOkdhuKifcFwUdrRVi2YdddDO/Fc6/fpwOR4wk23z7r
6QsBzRrqxxoRBi/doMEAggKZOVFrACSQidj9G+XyXfCp/7cAFK+GutS64bGgFbSF
7Mr8zE5KiZ5X45xSUf6jtL28s/ODtN63ce6u/PBebLqv2oYpcDyEW/I3ZgF+fPvT
kqFYyzMiLZ9bGSgY/NFU9/KamjA9JBtUPlb5QJEHPbUB5xb2gX2cXF5TZ2Xcvim3
rKX/T/gMSTVxnW3TNwLQ3CDK6TVD3/wS1uuZ2CRddGKcq1jS+rxGuQvuxOxxirTn
yQgDwuLgNuo9dKqb5wBukSyIR49aQpObkx3oKUuvbBRsdsif6vVAWZQzzf4Kdi4q
++uZdzvTHl0gkkO3fkP2IJM6/VQLJqe++k2zMBzSVtwCN8Dyezurq/f8FoEJ1jcl
sOgs0Jo9KN/GxiDDWkN9W/iZomEy5WHzG48vgmj23r0x5osCCik=
=qwNW
-----END PGP SIGNATURE-----

--vgcv3t4zz55elkbi--

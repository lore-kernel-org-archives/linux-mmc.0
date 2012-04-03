From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: card: move variable initialization earlier
Date: Tue, 03 Apr 2012 11:40:08 +0300
Message-ID: <4F7AB768.8020702@intel.com>
References: <1332495146-16312-1-git-send-email-linus.walleij@linaro.org> <8762dkm6wc.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33271 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653Ab2DCIj5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Apr 2012 04:39:57 -0400
In-Reply-To: <8762dkm6wc.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, Rabin Vincent <rabin@rab.in>, Kyungmin Park <kyungmin.park@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 01/04/12 07:07, Chris Ball wrote:
> Hi Adrian,
>=20
> On Fri, Mar 23 2012, Linus Walleij wrote:
>> I was pretty tired of seeing these in my kernel compiles:
>>
>> drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_issue_secdisc=
ard_rq=E2=80=99:
>> drivers/mmc/card/block.c:911:18: warning: =E2=80=98arg=E2=80=99 may =
be used uninitialized in this function [-Wuninitialized]
>> drivers/mmc/card/block.c:910:6: warning: =E2=80=98nr=E2=80=99 may be=
 used uninitialized in this function [-Wuninitialized]
>> drivers/mmc/card/block.c:910:6: warning: =E2=80=98from=E2=80=99 may =
be used uninitialized in this function [-Wuninitialized]
>>
>> The problem stems from the code path in
>> mmc_blk_issue_secdiscard_rq() where mmc_switch()
>> with EXT_CSD_SANITIZE_START may return -EIO and fall back
>> to using the default trim operations instead. At this point
>> the variables needed for the fallback will be uninitialized.
>>
>> Cc: Ulf Hansson <ulf.hansson@stericsson.com>
>> Cc: Rabin Vincent <rabin@rab.in>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> I don't know if this is the actual intention - maybe we
>> should just fail the call entirely if the sanitize command
>> fails?
>=20
> I think you (Adrian) introduced this "goto out->goto retry" logic in
> upstream commit 67716327eec7e9 -- please could you take a look here?
>=20

The sanitize logic looks wrong to me.  I would expect it to look
like this:


diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index b180965..f5e0534 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -881,17 +881,12 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc=
_queue *mq,
 		goto out;
 	}

-	/* The sanitize operation is supported at v4.5 only */
-	if (mmc_can_sanitize(card)) {
-		err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_SANITIZE_START, 1, 0);
-		goto out;
-	}
-
 	from =3D blk_rq_pos(req);
 	nr =3D blk_rq_sectors(req);

-	if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
+	if (mmc_can_sanitize(card))
+		arg =3D MMC_DISCARD_ARG;
+	else if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, n=
r))
 		arg =3D MMC_SECURE_TRIM1_ARG;
 	else
 		arg =3D MMC_SECURE_ERASE_ARG;
@@ -918,6 +913,12 @@ retry:
 		}
 		err =3D mmc_erase(card, from, nr, MMC_SECURE_TRIM2_ARG);
 	}
+
+	/* The sanitize operation is supported at v4.5 only */
+	if (!err && mmc_can_sanitize(card)) {
+		err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_SANITIZE_START, 1, 0);
+	}
 out:
 	if (err =3D=3D -EIO && !mmc_blk_reset(md, card->host, type))
 		goto retry;



Also the timeout for eMMC v4.5 DISCARD looks wrong.  It should be
the same as TRIM:


diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 14f262e..00fd7db 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1407,7 +1407,7 @@ static unsigned int mmc_mmc_erase_timeout(struct =
mmc_card *card,

 	if (card->ext_csd.erase_group_def & 1) {
 		/* High Capacity Erase Group Size uses HC timeouts */
-		if (arg =3D=3D MMC_TRIM_ARG)
+		if (arg =3D=3D MMC_TRIM_ARG || arg =3D=3D MMC_DISCARD_ARG)
 			erase_timeout =3D card->ext_csd.trim_timeout;
 		else
 			erase_timeout =3D card->ext_csd.hc_erase_timeout;



In addition eMMC v4.5 seems to indicate the use of the trim timeout
irrespective of the setting of erase_group_def, so maybe it should be
like this:



diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 14f262e..4691a23 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1405,7 +1405,10 @@ static unsigned int mmc_mmc_erase_timeout(struct=
 mmc_card *card,
 {
 	unsigned int erase_timeout;

-	if (card->ext_csd.erase_group_def & 1) {
+	if (arg =3D=3D MMC_DISCARD_ARG ||
+	    (arg =3D=3D MMC_TRIM_ARG && card->ext_csd.rev >=3D 6)) {
+		erase_timeout =3D card->ext_csd.trim_timeout;
+	} else if (card->ext_csd.erase_group_def & 1) {
 		/* High Capacity Erase Group Size uses HC timeouts */
 		if (arg =3D=3D MMC_TRIM_ARG)
 			erase_timeout =3D card->ext_csd.trim_timeout;




Alternatively, maybe it would be better to switch to HC erase size for =
all
eMMC v4.5 cards?

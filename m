From: "Linus Walleij" <linus.walleij@linaro.org>
Subject: [PATCH] mmc: card: move variable initialization earlier
Date: Fri, 23 Mar 2012 10:32:26 +0100
Message-ID: <1332495146-16312-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:58932 "EHLO mail.df.lth.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755413Ab2CWJcf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Mar 2012 05:32:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Rabin Vincent <rabin@rab.in>

I was pretty tired of seeing these in my kernel compiles:

drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_issue_secdiscard=
_rq=E2=80=99:
drivers/mmc/card/block.c:911:18: warning: =E2=80=98arg=E2=80=99 may be =
used uninitialized in this function [-Wuninitialized]
drivers/mmc/card/block.c:910:6: warning: =E2=80=98nr=E2=80=99 may be us=
ed uninitialized in this function [-Wuninitialized]
drivers/mmc/card/block.c:910:6: warning: =E2=80=98from=E2=80=99 may be =
used uninitialized in this function [-Wuninitialized]

The problem stems from the code path in
mmc_blk_issue_secdiscard_rq() where mmc_switch()
with EXT_CSD_SANITIZE_START may return -EIO and fall back
to using the default trim operations instead. At this point
the variables needed for the fallback will be uninitialized.

Cc: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I don't know if this is the actual intention - maybe we
should just fail the call entirely if the sanitize command
fails?
---
 drivers/mmc/card/block.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c6a383d..2741d93 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -877,6 +877,14 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_=
queue *mq,
 	unsigned int from, nr, arg;
 	int err =3D 0, type =3D MMC_BLK_SECDISCARD;
=20
+	from =3D blk_rq_pos(req);
+	nr =3D blk_rq_sectors(req);
+
+	if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
+		arg =3D MMC_SECURE_TRIM1_ARG;
+	else
+		arg =3D MMC_SECURE_ERASE_ARG;
+
 	if (!(mmc_can_secure_erase_trim(card) || mmc_can_sanitize(card))) {
 		err =3D -EOPNOTSUPP;
 		goto out;
@@ -889,13 +897,6 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_=
queue *mq,
 		goto out;
 	}
=20
-	from =3D blk_rq_pos(req);
-	nr =3D blk_rq_sectors(req);
-
-	if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
-		arg =3D MMC_SECURE_TRIM1_ARG;
-	else
-		arg =3D MMC_SECURE_ERASE_ARG;
 retry:
 	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
 		err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
--=20
1.7.7.6


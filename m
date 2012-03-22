From: "Linus Walleij" <linus.walleij@linaro.org>
Subject: [PATCH] mmc: fix card block compile warnings
Date: Thu, 22 Mar 2012 08:35:09 +0100
Message-ID: <1332401709-25513-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53353 "EHLO mail.df.lth.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab2CVHlT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Mar 2012 03:41:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>

I'm pretty tired of seeing these in my kernel compiles:
drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_issue_secdiscard=
_rq=E2=80=99:
drivers/mmc/card/block.c:911:18: warning: =E2=80=98arg=E2=80=99 may be =
used uninitialized in this function [-Wuninitialized]
drivers/mmc/card/block.c:910:6: warning: =E2=80=98nr=E2=80=99 may be us=
ed uninitialized in this function [-Wuninitialized]
drivers/mmc/card/block.c:910:6: warning: =E2=80=98from=E2=80=99 may be =
used uninitialized in this function [-Wuninitialized]

This patch marks the variables explicitly uninitialized as
seems to be the intention, I can assure myself they are not
actually uninitialized at use time by just reading the code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/card/block.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c6a383d..214ae68 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -874,7 +874,9 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_q=
ueue *mq,
 {
 	struct mmc_blk_data *md =3D mq->data;
 	struct mmc_card *card =3D md->queue.card;
-	unsigned int from, nr, arg;
+	unsigned int uninitialized_var(from);
+	unsigned int uninitialized_var(nr);
+	unsigned int uninitialized_var(arg);
 	int err =3D 0, type =3D MMC_BLK_SECDISCARD;
=20
 	if (!(mmc_can_secure_erase_trim(card) || mmc_can_sanitize(card))) {
--=20
1.7.7.6


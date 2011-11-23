From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH] mmc: block: Fix compile time warning for uninitalized variables
Date: Wed, 23 Nov 2011 15:41:42 +0530
Message-ID: <1322043102-28050-1-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50914 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab1KWKN2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2011 05:13:28 -0500
Received: by iage36 with SMTP id e36so1383438iag.19
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2011 02:13:28 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org

This patch fixes following compile time warnings.

drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_issue_rq=E2=80=99=
:
drivers/mmc/card/block.c:828:18: warning: =E2=80=98arg=E2=80=99 may be =
used uninitialized in this function [-Wun    initialized]
drivers/mmc/card/block.c:794:25: note: =E2=80=98arg=E2=80=99 was declar=
ed here
drivers/mmc/card/block.c:827:6: warning: =E2=80=98nr=E2=80=99 may be us=
ed uninitialized in this function [-Wunin    itialized]
drivers/mmc/card/block.c:794:21: note: =E2=80=98nr=E2=80=99 was declare=
d here
drivers/mmc/card/block.c:827:6: warning: =E2=80=98from=E2=80=99 may be =
used uninitialized in this function [-Wun    initialized]
drivers/mmc/card/block.c:794:15: note: =E2=80=98from=E2=80=99 was decla=
red here

If the code follows the labels 'out' and 'retry', then we get
to situation when these variables are used uninitialized.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---

The patch is rebased on v3.2-rc2.

I don't have much idea on what should be the default value
for these variables. The fixes are provided just to do away
with the compile time warnings.

 drivers/mmc/card/block.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a1cb21f..8e0ffe9 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -791,7 +791,7 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_q=
ueue *mq,
 {
 	struct mmc_blk_data *md =3D mq->data;
 	struct mmc_card *card =3D md->queue.card;
-	unsigned int from, nr, arg;
+	unsigned int from =3D 0, nr =3D 0, arg =3D 0;
 	int err =3D 0, type =3D MMC_BLK_SECDISCARD;
=20
 	if (!(mmc_can_secure_erase_trim(card) || mmc_can_sanitize(card))) {
--=20
1.7.4.1


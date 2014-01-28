From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH RESEND] =?UTF-8?q?mmc:=20Allow=20forward=20compatibility?= =?UTF-8?q?=20for=20e=E2=8B=85MMC?=
Date: Tue, 28 Jan 2014 09:40:02 +0100
Message-ID: <1390898402-16174-1-git-send-email-romain.izard.pro@gmail.com>
References: <1385714317-28911-1-git-send-email-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:41362 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbaA1Ik7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 03:40:59 -0500
Received: by mail-wg0-f50.google.com with SMTP id l18so163277wgh.17
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jan 2014 00:40:56 -0800 (PST)
In-Reply-To: <1385714317-28911-1-git-send-email-romain.izard.pro@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Romain Izard <romain.izard.pro@gmail.com>

As stated by the e=E2=8B=85MMC 5.0 specification, a chip should not be =
rejected
only because of the revision stated in the EXT_CSD_REV field of the
EXT_CSD register.

Remove the control on this value, the control of the CSD_STRUCTURE fiel=
d
should be sufficient to reject future incompatible changes.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/mmc/core/mmc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 98e9eb0f6643..81c23e4db704 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -293,13 +293,12 @@ static int mmc_read_ext_csd(struct mmc_card *card=
, u8 *ext_csd)
 		}
 	}
=20
+	/*
+	 * The EXT_CSD format is meant to be forward compatible. As long
+	 * as CSD_STRUCTURE does not change, all values for EXT_CSD_REV
+	 * are authorized, see JEDEC JESD84-B50 section B.8.
+	 */
 	card->ext_csd.rev =3D ext_csd[EXT_CSD_REV];
-	if (card->ext_csd.rev > 7) {
-		pr_err("%s: unrecognised EXT_CSD revision %d\n",
-			mmc_hostname(card->host), card->ext_csd.rev);
-		err =3D -EINVAL;
-		goto out;
-	}
=20
 	card->ext_csd.raw_sectors[0] =3D ext_csd[EXT_CSD_SEC_CNT + 0];
 	card->ext_csd.raw_sectors[1] =3D ext_csd[EXT_CSD_SEC_CNT + 1];
--=20
1.8.3.2


From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH] =?UTF-8?q?mmc:=20Allow=20forward=20compatibility=20for=20?= =?UTF-8?q?e=E2=8B=85MMC?=
Date: Fri, 29 Nov 2013 09:38:37 +0100
Message-ID: <1385714317-28911-1-git-send-email-romain.izard.pro@gmail.com>
References: <867gbsjzmf.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47832 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab3K2IjG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Nov 2013 03:39:06 -0500
Received: by mail-wi0-f178.google.com with SMTP id ca18so1755145wib.5
        for <linux-mmc@vger.kernel.org>; Fri, 29 Nov 2013 00:39:05 -0800 (PST)
In-Reply-To: <867gbsjzmf.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Romain Izard <romain.izard.pro@gmail.com>

As stated by the e=E2=8B=85MMC 5.0 specification, a chip should not be =
rejected
only because of the revision stated in the EXT_CSD_REV field of the
EXT_CSD register.

Remove the control on this value, the control of the CSD_STRUCTURE fiel=
d
should be sufficient to reject future incompatible changes.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/mmc/core/mmc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f631f5a9bf79..73b43574e1b4 100644
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


From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v2] =?UTF-8?q?mmc:=20Allow=20forward=20compatibility=20for?= =?UTF-8?q?=20e=E2=8B=85MMC?=
Date: Fri, 27 Jun 2014 10:51:07 +0200
Message-ID: <1403859067-21142-1-git-send-email-romain.izard.pro@gmail.com>
References: <53AC65FF.1010301@webtuner.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35270 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbaF0Ive (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jun 2014 04:51:34 -0400
Received: by mail-wg0-f51.google.com with SMTP id x12so4721894wgg.34
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jun 2014 01:51:33 -0700 (PDT)
In-Reply-To: <53AC65FF.1010301@webtuner.tv>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Derek Simkowiak <derek@webtuner.tv>
Cc: Romain Izard <romain.izard.pro@gmail.com>

As stated by the e=E2=8B=85MMC 5.0 specification, a chip should not be =
rejected
only because of the revision stated in the EXT_CSD_REV field of the
EXT_CSD register.

Remove the control on this value, the control of the CSD_STRUCTURE fiel=
d
should be sufficient to reject future incompatible changes.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1ab5f3a0af5b..ac9b8232133c 100644
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
1.9.1


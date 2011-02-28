From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: dw_mmc: Remove set-but-unused variable.
Date: Mon, 28 Feb 2011 16:55:37 -0500
Message-ID: <1298930137-15105-1-git-send-email-cjb@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:55621 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab1B1V6D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 16:58:03 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>

count is only ever used by assigning to old_len if count =3D=3D 0, and
then old_len isn't ever used at all.  So, both are redundant.  Fixes:

drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_read_data_pio=E2=
=80=99:
drivers/mmc/host/dw_mmc.c:1034:32: warning: variable =E2=80=98old_len=E2=
=80=99 set but
not used [-Wunused-but-set-variable]

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Will Newton <will.newton@imgtec.com>
---
 drivers/mmc/host/dw_mmc.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 58476c1..299c1d6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1031,13 +1031,10 @@ static void dw_mci_read_data_pio(struct dw_mci =
*host)
 	struct mmc_data	*data =3D host->data;
 	int shift =3D host->data_shift;
 	u32 status;
-	unsigned int nbytes =3D 0, len, old_len, count =3D 0;
+	unsigned int nbytes =3D 0, len;
=20
 	do {
 		len =3D SDMMC_GET_FCNT(mci_readl(host, STATUS)) << shift;
-		if (count =3D=3D 0)
-			old_len =3D len;
-
 		if (offset + len <=3D sg->length) {
 			host->pull_data(host, (void *)(buf + offset), len);
=20
@@ -1082,7 +1079,6 @@ static void dw_mci_read_data_pio(struct dw_mci *h=
ost)
 			tasklet_schedule(&host->tasklet);
 			return;
 		}
-		count++;
 	} while (status & SDMMC_INT_RXDR); /*if the RXDR is ready read again*=
/
 	len =3D SDMMC_GET_FCNT(mci_readl(host, STATUS));
 	host->pio_offset =3D offset;
--=20
1.7.0.1


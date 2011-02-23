From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 3/3] mmc: via-sdmmc: Remove set-but-unused variable.
Date: Wed, 23 Feb 2011 17:29:13 -0500
Message-ID: <1298500153-28081-3-git-send-email-cjb@laptop.org>
References: <1298500153-28081-1-git-send-email-cjb@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:44153 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab1BWWhi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Feb 2011 17:37:38 -0500
In-Reply-To: <1298500153-28081-1-git-send-email-cjb@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Harald Welte <HaraldWelte@viatech.com>

drivers/mmc/host/via-sdmmc.c: In function =E2=80=98via_reset_pcictrl=E2=
=80=99:
drivers/mmc/host/via-sdmmc.c:805:8: warning: variable =E2=80=98addrbase=
=E2=80=99 set but
not used [-Wunused-but-set-variable]

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Harald Welte <HaraldWelte@viatech.com>
---
 drivers/mmc/host/via-sdmmc.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.=
c
index 9ed84dd..8c5b488 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -802,12 +802,9 @@ static const struct mmc_host_ops via_sdc_ops =3D {
=20
 static void via_reset_pcictrl(struct via_crdr_mmc_host *host)
 {
-	void __iomem *addrbase;
 	unsigned long flags;
 	u8 gatt;
=20
-	addrbase =3D host->pcictrl_mmiobase;
-
 	spin_lock_irqsave(&host->lock, flags);
=20
 	via_save_pcictrlreg(host);
--=20
1.7.0.1


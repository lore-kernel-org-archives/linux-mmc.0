From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 2/3] mmc: cb710: Remove set-but-unused variable.
Date: Wed, 23 Feb 2011 17:29:12 -0500
Message-ID: <1298500153-28081-2-git-send-email-cjb@laptop.org>
References: <1298500153-28081-1-git-send-email-cjb@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:44152 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504Ab1BWWhi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Feb 2011 17:37:38 -0500
In-Reply-To: <1298500153-28081-1-git-send-email-cjb@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>

drivers/mmc/host/sdhci-pci.c: In function =E2=80=98sdhci_pci_probe_slot=
=E2=80=99:
drivers/mmc/host/sdhci-pci.c:913:18: warning: variable =E2=80=98addr=E2=
=80=99 set but
not used [-Wunused-but-set-variable]

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/cb710-mmc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.=
c
index 66b4ce5..280c03a 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -179,7 +179,6 @@ static int cb710_wait_for_event(struct cb710_slot *=
slot, u8 what)
 static int cb710_wait_while_busy(struct cb710_slot *slot, uint8_t mask=
)
 {
 	unsigned limit =3D 500000;	/* FIXME: real timeout */
-	int err =3D 0;
=20
 #ifdef CONFIG_CB710_DEBUG
 	u32 e, x;
@@ -190,7 +189,6 @@ static int cb710_wait_while_busy(struct cb710_slot =
*slot, uint8_t mask)
 		if (!--limit) {
 			cb710_dump_regs(cb710_slot_to_chip(slot),
 				CB710_DUMP_REGS_MMC);
-			err =3D -ETIMEDOUT;
 			break;
 		}
 		udelay(1);
--=20
1.7.0.1


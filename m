From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/5] mmc: cb710: partially demystify clock selection
Date: Sun, 21 Mar 2010 07:33:08 +0100
Message-ID: <e20dfff39b7a56f1fd8a294470dbba4dc90a982e.1286922133.git.mirq-linux@rere.qmqm.pl>
References: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:40168 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab0JLWwT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Oct 2010 18:52:19 -0400
In-Reply-To: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Clock divider selection in partially verified, so document known facts
in code.

Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/cb710-mmc.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.=
c
index ca3bdc8..ad61c4c 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -25,7 +25,7 @@ static const u8 cb710_src_freq_mhz[16] =3D {
 	50, 55, 60, 65, 70, 75, 80, 85
 };
=20
-static void cb710_mmc_set_clock(struct mmc_host *mmc, int hz)
+static void cb710_mmc_select_clock_divider(struct mmc_host *mmc, int h=
z)
 {
 	struct cb710_slot *slot =3D cb710_mmc_to_slot(mmc);
 	struct pci_dev *pdev =3D cb710_slot_to_chip(slot)->pdev;
@@ -33,8 +33,11 @@ static void cb710_mmc_set_clock(struct mmc_host *mmc=
, int hz)
 	u32 divider_idx;
 	int src_hz;
=20
-	/* this is magic, unverifiable for me, unless I get
-	 * MMC card with cables connected to bus signals */
+	/* on CB710 in HP nx9500:
+	 *   src_freq_idx =3D=3D 0
+	 *   indexes 1-7 work as written in the table
+	 *   indexes 0,8-15 give no clock output
+	 */
 	pci_read_config_dword(pdev, 0x48, &src_freq_idx);
 	src_freq_idx =3D (src_freq_idx >> 16) & 0xF;
 	src_hz =3D cb710_src_freq_mhz[src_freq_idx] * 1000000;
@@ -46,13 +49,15 @@ static void cb710_mmc_set_clock(struct mmc_host *mm=
c, int hz)
=20
 	if (src_freq_idx)
 		divider_idx |=3D 0x8;
+	else if (divider_idx =3D=3D 0)
+		divider_idx =3D 1;
=20
 	cb710_pci_update_config_reg(pdev, 0x40, ~0xF0000000, divider_idx << 2=
8);
=20
 	dev_dbg(cb710_slot_dev(slot),
-		"clock set to %d Hz, wanted %d Hz; flag =3D %d\n",
+		"clock set to %d Hz, wanted %d Hz; src_freq_idx =3D %d, divider_idx =
=3D %d|%d\n",
 		src_hz >> cb710_clock_divider_log2[divider_idx & 7],
-		hz, (divider_idx & 8) !=3D 0);
+		hz, src_freq_idx, divider_idx & 7, divider_idx & 8);
 }
=20
 static void __cb710_mmc_enable_irq(struct cb710_slot *slot,
@@ -512,7 +517,7 @@ static int cb710_mmc_powerup(struct cb710_slot *slo=
t)
 #endif
 	int err;
=20
-	/* a lot of magic; see comment in cb710_mmc_set_clock() */
+	/* a lot of magic for now */
 	dev_dbg(cb710_slot_dev(slot), "bus powerup\n");
 	cb710_dump_regs(chip, CB710_DUMP_REGS_MMC);
 	err =3D cb710_wait_while_busy(slot, CB710_MMC_S2_BUSY_20);
@@ -572,7 +577,7 @@ static void cb710_mmc_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
 	struct cb710_mmc_reader *reader =3D mmc_priv(mmc);
 	int err;
=20
-	cb710_mmc_set_clock(mmc, ios->clock);
+	cb710_mmc_select_clock_divider(mmc, ios->clock);
=20
 	if (!cb710_mmc_is_card_inserted(slot)) {
 		dev_dbg(cb710_slot_dev(slot),
--=20
1.7.1


From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/5] mmc: cb710: implement get_cd() callback
Date: Sun, 21 Mar 2010 07:39:52 +0100
Message-ID: <27ba2dd366a831fe2f89483bd86d8949f8f42f4a.1286922133.git.mirq-linux@rere.qmqm.pl>
References: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:40165 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab0JLWwS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Oct 2010 18:52:18 -0400
In-Reply-To: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/cb710-mmc.c |   33 +++++++++++++--------------------
 1 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.=
c
index ad61c4c..7a176b4 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -100,12 +100,6 @@ static void cb710_mmc_reset_events(struct cb710_sl=
ot *slot)
 	cb710_write_port_8(slot, CB710_MMC_STATUS2_PORT, 0xFF);
 }
=20
-static int cb710_mmc_is_card_inserted(struct cb710_slot *slot)
-{
-	return cb710_read_port_8(slot, CB710_MMC_STATUS3_PORT)
-		& CB710_MMC_S3_CARD_DETECTED;
-}
-
 static void cb710_mmc_enable_4bit_data(struct cb710_slot *slot, int en=
able)
 {
 	dev_dbg(cb710_slot_dev(slot), "configuring %d-data-line%s mode\n",
@@ -499,13 +493,9 @@ static void cb710_mmc_request(struct mmc_host *mmc=
, struct mmc_request *mrq)
 	reader->mrq =3D mrq;
 	cb710_mmc_enable_irq(slot, CB710_MMC_IE_TEST_MASK, 0);
=20
-	if (cb710_mmc_is_card_inserted(slot)) {
-		if (!cb710_mmc_command(mmc, mrq->cmd) && mrq->stop)
-			cb710_mmc_command(mmc, mrq->stop);
-		mdelay(1);
-	} else {
-		mrq->cmd->error =3D -ENOMEDIUM;
-	}
+	if (!cb710_mmc_command(mmc, mrq->cmd) && mrq->stop)
+		cb710_mmc_command(mmc, mrq->stop);
+	mdelay(1);
=20
 	tasklet_schedule(&reader->finish_req_tasklet);
 }
@@ -579,12 +569,6 @@ static void cb710_mmc_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
=20
 	cb710_mmc_select_clock_divider(mmc, ios->clock);
=20
-	if (!cb710_mmc_is_card_inserted(slot)) {
-		dev_dbg(cb710_slot_dev(slot),
-			"no card inserted - ignoring bus powerup request\n");
-		ios->power_mode =3D MMC_POWER_OFF;
-	}
-
 	if (ios->power_mode !=3D reader->last_power_mode)
 	switch (ios->power_mode) {
 	case MMC_POWER_ON:
@@ -624,6 +608,14 @@ static int cb710_mmc_get_ro(struct mmc_host *mmc)
 		& CB710_MMC_S3_WRITE_PROTECTED;
 }
=20
+static int cb710_mmc_get_cd(struct mmc_host *mmc)
+{
+	struct cb710_slot *slot =3D cb710_mmc_to_slot(mmc);
+
+	return cb710_read_port_8(slot, CB710_MMC_STATUS3_PORT)
+		& CB710_MMC_S3_CARD_DETECTED;
+}
+
 static int cb710_mmc_irq_handler(struct cb710_slot *slot)
 {
 	struct mmc_host *mmc =3D cb710_slot_to_mmc(slot);
@@ -669,7 +661,8 @@ static void cb710_mmc_finish_request_tasklet(unsign=
ed long data)
 static const struct mmc_host_ops cb710_mmc_host =3D {
 	.request =3D cb710_mmc_request,
 	.set_ios =3D cb710_mmc_set_ios,
-	.get_ro =3D cb710_mmc_get_ro
+	.get_ro =3D cb710_mmc_get_ro,
+	.get_cd =3D cb710_mmc_get_cd,
 };
=20
 #ifdef CONFIG_PM
--=20
1.7.1


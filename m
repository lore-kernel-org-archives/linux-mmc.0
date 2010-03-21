From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 5/5] mmc: cb710: remove debugging printk (info duplicated from mmc-core)
Date: Sun, 21 Mar 2010 08:30:19 +0100
Message-ID: <9c566c72e1217c963427c6e7037d885dfd1daaef.1286922133.git.mirq-linux@rere.qmqm.pl>
References: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:40164 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113Ab0JLWwS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Oct 2010 18:52:18 -0400
In-Reply-To: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/cb710-mmc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.=
c
index 2299afc..66b4ce5 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -102,8 +102,6 @@ static void cb710_mmc_reset_events(struct cb710_slo=
t *slot)
=20
 static void cb710_mmc_enable_4bit_data(struct cb710_slot *slot, int en=
able)
 {
-	dev_dbg(cb710_slot_dev(slot), "configuring %d-data-line%s mode\n",
-		enable ? 4 : 1, enable ? "s" : "");
 	if (enable)
 		cb710_modify_port_8(slot, CB710_MMC_CONFIG1_PORT,
 			CB710_MMC_C1_4BIT_DATA_BUS, 0);
--=20
1.7.1

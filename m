From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/5] mmc: cb710: clear irq handler on init() error path
Date: Sun, 21 Mar 2010 07:44:34 +0100
Message-ID: <4c7fa58319080cc0845abd5925d328d0f8ef7d28.1286922133.git.mirq-linux@rere.qmqm.pl>
References: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:40163 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109Ab0JLWwS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Oct 2010 18:52:18 -0400
In-Reply-To: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/cb710-mmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.=
c
index 5374b6b..2299afc 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -743,6 +743,7 @@ static int __devinit cb710_mmc_init(struct platform=
_device *pdev)
 err_free_mmc:
 	dev_dbg(cb710_slot_dev(slot), "mmc_add_host() failed: %d\n", err);
=20
+	cb710_set_irq_handler(slot, NULL);
 	mmc_free_host(mmc);
 	return err;
 }
--=20
1.7.1


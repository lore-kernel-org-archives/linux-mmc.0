From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/5] mmc: cb710: remove unnecessary msleep()
Date: Sun, 21 Mar 2010 07:41:39 +0100
Message-ID: <370c7c02f9721047837ec2716820dc3a2ed20dd7.1286922133.git.mirq-linux@rere.qmqm.pl>
References: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:40166 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab0JLWwS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Oct 2010 18:52:18 -0400
In-Reply-To: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/cb710-mmc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.=
c
index 7a176b4..5374b6b 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -495,7 +495,6 @@ static void cb710_mmc_request(struct mmc_host *mmc,=
 struct mmc_request *mrq)
=20
 	if (!cb710_mmc_command(mmc, mrq->cmd) && mrq->stop)
 		cb710_mmc_command(mmc, mrq->stop);
-	mdelay(1);
=20
 	tasklet_schedule(&reader->finish_req_tasklet);
 }
--=20
1.7.1


Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC71268684
	for <linux-mmc@vger.kernel.org>; Tue,  6 May 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525092; cv=none; b=ZTEAeqdAF3r4/YPXxPh/eLr8W1DzFvj/gafyEgsCu5OFIg6qK5XSb84VjR+FwIsbpoichNI2DzpeXg9Hi+VKH+2aaiGG49BLhGZtv7YPd/WC74jWIQCimKBcaG1ERa8iFohI7nabUhoaTqah6jULhtci/doP6ihswe+q9+UVcYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525092; c=relaxed/simple;
	bh=o5kt/QV+MPk6gBTy1bzmdhHQ87VP4aY+c4VSaP8gPWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYm3vDjIjz23ZkpUqftqSfFF9cQ0EeRKLIzl7VJk9B7Ail8L9hr5bK6aAcZQ4AIE3m4+OkG7GdAqgMk6mMX3axujgt7fzZgU1HqNFB0OVGVybZQ6+oVKvlnfLHhOf+jy6LU/saj+A4bR0w39aOQGOx5bncAZN8N48PwFnk0f9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uCExM-0005A2-Qx; Tue, 06 May 2025 11:51:20 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uCExL-001NB5-2q;
	Tue, 06 May 2025 11:51:19 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uCExL-009Obc-2Y;
	Tue, 06 May 2025 11:51:19 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
	Christian Loehle <christian.loehle@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <Avri.Altman@sandisk.com>
Subject: [PATCH v5 4/4] mmc: block: abort requests and suppress errors after undervoltage shutdown
Date: Tue,  6 May 2025 11:51:18 +0200
Message-Id: <20250506095118.2239459-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506095118.2239459-1-o.rempel@pengutronix.de>
References: <20250506095118.2239459-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

Extend the existing card removal checks in mmc_blk_mq_complete_rq() and
mmc_mq_queue_rq() to also account for the undervoltage state. If the host
has entered undervoltage shutdown, mark requests as quiet and abort them
early to prevent unnecessary retries and error logging. This ensures no
further operations are attempted on the card after an emergency stop.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/mmc/core/block.c | 2 +-
 drivers/mmc/core/queue.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 585c2b274d98..2f07610d3c35 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2129,7 +2129,7 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
 	} else if (mqrq->retries++ < MMC_MAX_RETRIES) {
 		blk_mq_requeue_request(req, true);
 	} else {
-		if (mmc_card_removed(mq->card))
+		if (mmc_card_removed(mq->card) || mq->card->host->undervoltage)
 			req->rq_flags |= RQF_QUIET;
 		blk_mq_end_request(req, BLK_STS_IOERR);
 	}
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 284856c8f655..1dd71ea6927d 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -239,7 +239,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool get_card, cqe_retune_ok;
 	blk_status_t ret;
 
-	if (mmc_card_removed(mq->card)) {
+	if (mmc_card_removed(mq->card) || mq->card->host->undervoltage) {
 		req->rq_flags |= RQF_QUIET;
 		return BLK_STS_IOERR;
 	}
-- 
2.39.5


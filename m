Received: from mail-m49200.qiye.163.com (mail-m49200.qiye.163.com [45.254.49.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D23D6CBF;
	Tue, 31 Mar 2026 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943705; cv=none; b=jrVKbtIXaSAGE3Rc+Hu4/v1ZZuZtNGnmdnW38WibmStal7yhNAyxEQaV+/V/RZDoB/AoC/KUwwO9D/lmcWecuW5yHZtLUPIYny/tpX1KIniijZsIxzjaqcVXl0QNeGvgAROmYlndQtA65bnQ1TIuAvBPXQnh0OywdeGMLwZCf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943705; c=relaxed/simple;
	bh=9scD12CFRY312eRUTJ13BZ6DHwscLo3F2p2r5bbOyrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=C8dNTl5L7PqTioF3/SxU2nL0kDnubAlDzlJcURAohAGNCj0yQvdiVFxehEjnms1I06VAN5Qj1ZFh1W74v4mFNpr2pIhrRVS1JTvqlFBuw2YMKa642UoU3EqoygLYBKVZ56b6g86ay+u21PrnioyrjBBOIUZHbzw5uEXJspLFuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=iS9GhxHD; arc=none smtp.client-ip=45.254.49.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="iS9GhxHD"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 38f5d4bfa;
	Tue, 31 Mar 2026 15:54:56 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] mmc: dw_mmc: Inline dw_mci_queue_request() into dw_mci_request()
Date: Tue, 31 Mar 2026 15:54:49 +0800
Message-Id: <1774943690-219754-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1774943690-219754-1-git-send-email-shawn.lin@rock-chips.com>
References: <1774943690-219754-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d42e3771409cckunmd4b3018ef1389a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk9NQ1YdSxgYSxhPHk1JQ0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iS9GhxHD70d6NA76SEbjsRIOEvRcLBAexMTtLKsbzGBIhrBJbj5jOlMKujxbt8QhyCa8eJhasFLcmhkbddFpV5R6lA7AdnkTSodalaBBYbZaJS+kxggpCkZoUu6wHvq8yN/P4vc03eG69U2itwEzyoPQ41PWrg/mI3xKdzrO6gM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=mCzyNmBFA8aEpEL5CQq8Q5KXnNXE4JGvx3A/egICVf8=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

With the removal of queue support, the function dw_mci_queue_request()
is now just a wrapper with a confusing name that doesn't suggest
anything about queue. Removes the function and moves its body into
dw_mci_request().

No functional changes intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bbdd759..8e78faf 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1293,31 +1293,6 @@ static void dw_mci_start_request(struct dw_mci *host)
 	__dw_mci_start_request(host, cmd);
 }
 
-/* must be called with host->lock held */
-static void dw_mci_queue_request(struct dw_mci *host, struct mmc_request *mrq)
-{
-	dev_vdbg(&host->mmc->class_dev, "queue request: state=%d\n",
-		 host->state);
-
-	host->mrq = mrq;
-
-	if (host->state == STATE_WAITING_CMD11_DONE) {
-		dev_warn(&host->mmc->class_dev,
-			 "Voltage change didn't complete\n");
-		/*
-		 * this case isn't expected to happen, so we can
-		 * either crash here or just try to continue on
-		 * in the closest possible state
-		 */
-		host->state = STATE_IDLE;
-	}
-
-	if (host->state == STATE_IDLE) {
-		host->state = STATE_SENDING_CMD;
-		dw_mci_start_request(host);
-	}
-}
-
 static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct dw_mci *host = mmc_priv(mmc);
@@ -1329,7 +1304,6 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	 * atomic, otherwise the card could be removed in between and the
 	 * request wouldn't fail until another card was inserted.
 	 */
-
 	if (!dw_mci_get_cd(mmc)) {
 		mrq->cmd->error = -ENOMEDIUM;
 		mmc_request_done(mmc, mrq);
@@ -1338,7 +1312,25 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_lock_bh(&host->lock);
 
-	dw_mci_queue_request(host, mrq);
+	dev_vdbg(&host->mmc->class_dev, "request: state=%d\n",
+		 host->state);
+
+	host->mrq = mrq;
+	if (host->state == STATE_WAITING_CMD11_DONE) {
+		dev_warn(&host->mmc->class_dev,
+			 "Voltage change didn't complete\n");
+		/*
+		 * this case isn't expected to happen, so we can
+		 * either crash here or just try to continue on
+		 * in the closest possible state
+		 */
+		host->state = STATE_IDLE;
+	}
+
+	if (host->state == STATE_IDLE) {
+		host->state = STATE_SENDING_CMD;
+		dw_mci_start_request(host);
+	}
 
 	spin_unlock_bh(&host->lock);
 }
-- 
2.7.4


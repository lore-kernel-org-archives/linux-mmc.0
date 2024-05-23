Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523381AC7
	for <linux-mmc@vger.kernel.org>; Thu, 23 May 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462835; cv=none; b=igbp93F52j7XPQQX3mBUREz3+MPsHnNhC2MqDamnTXG6qpRehxqoW5Halr3OAtRR5d8b5OaxllqIVosOJj9X5Y+k6RCbRTIcEoWaCB02RI79gGMUXyWM+KnXkCnGssf1leCT9S9ebUTwFfjjaRNmX/34QrQr0fcmV/cSy2OdyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462835; c=relaxed/simple;
	bh=Y55yFLHdKD1NNJbp+c/hkJiWe2gpT+FuO5g//coJMxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/TsrvcTKtAosr24XmXcgmAvaG+72Ngy0b9qL6K0FhwbK8cJmsFQnYlZYbnFjq2YjnO/esKyR+6YThoaiTtM9fSybdtXbotkGCBzKLeVL/ThHt0SJAELFJLTXdqqQ3u2sIgKoE1GQVYo2weV77zseWPVzOydsxPUTZnjQcegJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from silverhorse.lan (unknown [62.197.239.54])
	by speedy.danman.eu (Postfix) with ESMTPSA id 664D62406F6;
	Thu, 23 May 2024 13:13:43 +0200 (CEST)
From: linux-mmc@danman.eu
To: linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org
Cc: Daniel Kucera <linux-mmc@danman.eu>
Subject: [PATCH v2] mmc: core: allow detection of locked cards
Date: Thu, 23 May 2024 13:13:17 +0200
Message-Id: <20240523111317.594583-1-linux-mmc@danman.eu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Kucera <linux-mmc@danman.eu>

Locked card will not reply to SEND_SCR or SD_STATUS commands
so it was failing to initialize previously. When skipped,
the card will get initialized and CMD42 can be sent using
ioctl to unlock the card or remove password protection.
Until unlocked, all read/write calls will timeout.

Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
---
 drivers/mmc/core/sd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1c8148cdd..0eebfea02 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -928,8 +928,20 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	bool reinit)
 {
 	int err;
+	u32 card_status;
 
-	if (!reinit) {
+	err = mmc_send_status(card, &card_status);
+	if (err){
+		pr_err("%s: unable to get card status\n",
+			mmc_hostname(host));
+			return err;
+	}
+
+	if (card_status & R1_CARD_IS_LOCKED){
+		pr_warn("%s: card is locked\n", mmc_hostname(host));
+	}
+
+	if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
 		/*
 		 * Fetch SCR from card.
 		 */
-- 
2.34.1


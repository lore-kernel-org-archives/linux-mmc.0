Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500514A60C
	for <linux-mmc@vger.kernel.org>; Thu, 23 May 2024 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470428; cv=none; b=IEfrWmC4NNq7r+Y0Ifkf5ovwseJx/X5cPej3HT98TyfoLAwb6z50deRQ3R4HfCTCTTo5Rt/St+V4P5tjnyIjITQcMVmYnHGCnG0HY2+M7FwuVbYrN1S7iB5bameMAcWBLIOqIxXimvpvNPGzLItcLyL7mMxPYFsTQ2xeZigk6FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470428; c=relaxed/simple;
	bh=3VcMLeE7XjRQRqf97quiS+2jp0egRFR+nIvD0nRPIE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=souQVG3K0oswgdCrfk/CeVlT/wc/EvVuSYHkWY6r7E6BllP7uqtJNVZo63QPdOd0q9nhjJbGte4xwkVM192gbV8+Snk7i/O0UW4RtdGb6H0xWZsBGd3cMx4y3omMWKNoiUOjRntgugY+pN8WB6rbR1gg3U5tBv3rPzD5bNungao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from silverhorse.lan (unknown [62.197.239.54])
	by speedy.danman.eu (Postfix) with ESMTPSA id 2AF66240539;
	Thu, 23 May 2024 15:20:22 +0200 (CEST)
From: linux-mmc@danman.eu
To: linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org
Cc: Daniel Kucera <linux-mmc@danman.eu>
Subject: [PATCH v3] mmc: core: allow detection of locked cards
Date: Thu, 23 May 2024 15:20:16 +0200
Message-Id: <20240523132016.599343-1-linux-mmc@danman.eu>
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
 drivers/mmc/core/sd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1c8148cdd..ae821df7d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -928,8 +928,19 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	bool reinit)
 {
 	int err;
+	u32 card_status;
 
-	if (!reinit) {
+	err = mmc_send_status(card, &card_status);
+	if (err){
+		pr_err("%s: unable to get card status\n", mmc_hostname(host));
+		return err;
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


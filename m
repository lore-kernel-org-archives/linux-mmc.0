Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A01EFFAE
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501538; cv=none; b=UePlvVTolQDSg9CVxTwkPnf9vlHDsQXoR05nz0u5UIozdQLbOdkhghHt6VMOQJcMqpt0ier8VzGr+EZ69tEeGG0i25WzJewdQK7jiqZWUThywP1NgAYlbN0tNvXuFWonGxjhyVteAKX9KAYBJvLRfkFixljCacJJVd3BElFns60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501538; c=relaxed/simple;
	bh=n0C8AyKo3KFN9TTI5kEm9Fer4f9eTnrwjK7U2XfyK5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaT2MiJJcFuZMBhWE/fpZXw1noe/sCgaPgPY8rbB5vBvWYn/Fu8T9/zFMe1W7q0MukuKpDbrfkhojy91Ob6OHGx3SAlawlLVHa9FKcDI34gRRR60Byc204QiPe+eTxzDKHbmnBrOWQx8JjrWOH1YuvT9fHxIyqeNTkPIR2PqLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=D7Mrl6M7; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="D7Mrl6M7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=OajYp0iDsNfE5s7SE7buXINIqcruT/MezuYRuFQzqZo=; b=D7Mrl6
	M73ciC9tKexAFqXYvOF50yD7OdIaO2Nlq4GrRLPufI++CdHAbTMf9eTB0XH2Bq1o
	w6QZx+LfD4h9MGHiIFzXfKZGDL+hrFuSM6PnqTsj9Rub8jh4FZnjideBsbYTtHdj
	Or7yfzlBQ3ulBmhiGfermmfu+lMgXI6Tmpge4V6vchu8eEgFAI0J/9q4K3Wojmpu
	yVOpDGRo4iF3+BHJ6wL0NcOxpe+nQjwPrF1QzBuNv3FwcsEmxZT0nS2SbyKywqxf
	S5cyjRPb4hIMNNncsLhbhzIzh08dAiYmhq9Il20RsojzoeTGHWj0J7uSS068xxRr
	3jZCGxB0qMYjDfmw==
Received: (qmail 1558739 invoked from network); 1 Apr 2025 11:58:53 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:53 +0200
X-UD-Smtp-Session: l3s3148p1@r6uJlbQxPoIgAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 04/11] mmc: rename mmc_can_poweroff_notify() to mmc_card_can_poweroff_notify()
Date: Tue,  1 Apr 2025 11:58:40 +0200
Message-ID: <20250401095847.29271-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
References: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_can_* functions sometimes relate to the card and sometimes to the host.
Make it obvious by renaming this function to include 'card'.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2b63eb608489..8911b2206c45 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2013,7 +2013,7 @@ static int mmc_sleep(struct mmc_host *host)
 	return err;
 }
 
-static bool mmc_can_poweroff_notify(const struct mmc_card *card)
+static bool mmc_card_can_poweroff_notify(const struct mmc_card *card)
 {
 	return card &&
 		mmc_card_mmc(card) &&
@@ -2137,7 +2137,7 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 		goto out;
 
 pr_info("%s: reason %d, may_notify %d\n", mmc_hostname(host), pm_type, mmc_may_poweroff_notify(host, pm_type));
-	if (mmc_can_poweroff_notify(host->card) &&
+	if (mmc_card_can_poweroff_notify(host->card) &&
 	    mmc_may_poweroff_notify(host, pm_type))
 		err = mmc_poweroff_notify(host->card, notify_type);
 	else if (mmc_can_sleep(host->card))
@@ -2217,7 +2217,7 @@ static int mmc_shutdown(struct mmc_host *host)
 	 * In a specific case for poweroff notify, we need to resume the card
 	 * before we can shutdown it properly.
 	 */
-	if (mmc_can_poweroff_notify(host->card) &&
+	if (mmc_card_can_poweroff_notify(host->card) &&
 	    !mmc_may_poweroff_notify(host, MMC_POWEROFF_SUSPEND))
 		err = _mmc_resume(host);
 
-- 
2.47.2


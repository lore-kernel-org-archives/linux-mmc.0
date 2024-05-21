Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE750276
	for <linux-mmc@vger.kernel.org>; Tue, 21 May 2024 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325519; cv=none; b=qCT0Y7aZHheIM/85I5Np0F1K62QE9f+IuI98BtLc+RaPCViXUVtHyqa5bQK5IdmoYSoLgucPKIp9VRyE32jP/4ABfUgLlWPlhHkdApAkdAYiky2VkyDxlLsi5z7CLKFIMqn6wLh6o5KpVjwicZ4q7Qvl5lZZEl4ft2DQjfr5YT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325519; c=relaxed/simple;
	bh=GO07VuBpIdhrCt9DGBIYE0AK57t1Uaxod8eXheR7PQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XlDc9bQGZ0vijxVc45YUCWzl6LpcGtKAIUZaaFGthag1MF6p1nGAyWp0O1cNJteIwbuwzIHTg2SXo8EAiQfJ59z7cRMOwKjNfB/Fdr/LoNc996Z/50Hdha8GICHpLaiWOozKphNSoFFbx44VOP4L7b4e/bLj2kSpULen2m9mSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from silverhorse.lan (unknown [62.197.239.54])
	by speedy.danman.eu (Postfix) with ESMTPSA id D9E62240ACA;
	Tue, 21 May 2024 23:05:12 +0200 (CEST)
From: linux-mmc@danman.eu
To: linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org
Cc: Daniel Kucera <linux-mmc@danman.eu>
Subject: [PATCH] mmc: core: allow detection of locked cards
Date: Tue, 21 May 2024 23:04:55 +0200
Message-Id: <20240521210455.543587-1-linux-mmc@danman.eu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Kucera <linux-mmc@danman.eu>

Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
---
 drivers/mmc/core/sd.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1c8148cdd..b22c30348 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1475,9 +1475,22 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
-	err = mmc_sd_setup_card(host, card, oldcard != NULL);
-	if (err)
-		goto free_card;
+        u32 card_status;
+
+        err = mmc_send_status(card, &card_status);
+        if (err){
+                pr_err("%s: unable to get card status\n",
+                        mmc_hostname(host));
+                goto free_card;
+        }
+
+        if (card_status & R1_CARD_IS_LOCKED){
+                pr_warn("%s: card is locked\n", mmc_hostname(host));
+        } else {
+                err = mmc_sd_setup_card(host, card, oldcard != NULL);
+                if (err)
+                        goto free_card;
+        }
 
 	/*
 	 * If the card has not been power cycled, it may still be using 1.8V
-- 
2.34.1


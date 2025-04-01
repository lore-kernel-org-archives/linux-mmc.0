Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B41EFFB3
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501540; cv=none; b=tnB1YloNFBzgEzOipZo8InToknRwa0tasSvFFh1LSe62AAFKj9OSSB+xnpAFBzDF6P1g88eigRpYTcrs6xKvyh99rmbjqre3dzWEzZGDQJzJWWcuHkCVa2hPBjsh9FVvtWLQ2dBzaXt8pytzROCON7p3fKyFGL22EeYQs9AY6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501540; c=relaxed/simple;
	bh=AfOBgpXXlyh+fO3e/6EvM+KIYoZUgmk3i2msn5750PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkF6gAJNXXsOYKnxLhCRlvR+U10V7J0jwTR9wJmH8BkRuqahiG2iJznK4CjTQS92/ePAxCLHkdsLxWdnLFmGnkKQya7nL4BaY79YLoPEOuLjCBEWrtwOO08qLL6+yH8BQfHfn/SZqOCbWfwtR5HUmGdgmNBm4g945mCt2c6Sof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jwQWjceH; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jwQWjceH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=dCX43o3nZTqlv5N0jxis+72e1fW1QqYX1lobgu58ju0=; b=jwQWjc
	eHpDjEgO7WTxaO66cxBIwckLmKu/4Pf6Hxly2jIxYxYE8ANR6s4h5fpqQ5Z+3hzg
	KUNmX/5tC4Xct3XLzZKhd6smGpt8k4KntIvCf9floyhSjvs1Q68ihoczCQ0EnQ6r
	ZoVs0n4YqLdeFXOcBUPFx/J5XJCzJUcE6ZywCmS6YuuZHEQhof1YyWBjJ1mDeFyq
	fUFXfWJOgOeWYbMW+PRV64ccKmrci3K0QlIiyp41rcv9+lji1FGolDXUZc5Eiem3
	UqAWp5GotBFCrYN0OFmuVKCFYxvRy1Oh8leciGs9/jbx742JzTohp3XGjgmrIdX6
	x5cLk5Yd5MinxiFQ==
Received: (qmail 1558808 invoked from network); 1 Apr 2025 11:58:55 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:55 +0200
X-UD-Smtp-Session: l3s3148p1@YR+qlbQxVIIgAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 08/11] mmc: rename mmc_can_sleep() to mmc_card_can_sleep()
Date: Tue,  1 Apr 2025 11:58:44 +0200
Message-ID: <20250401095847.29271-9-wsa+renesas@sang-engineering.com>
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
Make it obvious by renaming this function to include 'card'. Also, convert to
proper bool type while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8fde20ba3d95..80bb0a68b037 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1955,7 +1955,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	return err;
 }
 
-static int mmc_can_sleep(struct mmc_card *card)
+static bool mmc_card_can_sleep(struct mmc_card *card)
 {
 	return card->ext_csd.rev >= 3;
 }
@@ -2140,7 +2140,7 @@ pr_info("%s: reason %d, may_notify %d\n", mmc_hostname(host), pm_type, mmc_may_p
 	if (mmc_card_can_poweroff_notify(host->card) &&
 	    mmc_may_poweroff_notify(host, pm_type))
 		err = mmc_poweroff_notify(host->card, notify_type);
-	else if (mmc_can_sleep(host->card))
+	else if (mmc_card_can_sleep(host->card))
 		err = mmc_sleep(host);
 	else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
-- 
2.47.2


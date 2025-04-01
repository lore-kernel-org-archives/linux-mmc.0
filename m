Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6901EFFB2
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501540; cv=none; b=c62yepwgNfAahog8+kXOLx423/8S/Gv1O/0wj9VucL0dQubPDRiuqS0D7Trk3/ZAX2L6h6H6iclcDwgsPF5KG3HhmAuQ0mu4ish273h3s+RXakjTzaOC2NJX0EgWTzbgmCapnu3hXvZrJSH2Knx61NnUeLt2oXmNPlFBOLvfdJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501540; c=relaxed/simple;
	bh=VMjZ2itBT5079vCh2i1l6OAKcdGdKMtRjw7L8zlN1EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgdp9uDvQZ7Q8SpA4y0VTooDs+31qspKe185u2QYub5ygwL7ahsSGw+aWe9UE2chXmRWUvmt3rgrCn+6FZ19lCvk4usHqnEmObtcIUn6YrdyornCkhHzY3Iz2rmDEy8VjgTqJLq1SzHS8Rd6aqzI9nzIJ3U/bQlshCGChy/SzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BozdZuAh; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BozdZuAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=NlGGF6Ty2KBVMuK6zsEhXv+yBKpBK29ytnYhfAG2CFE=; b=BozdZu
	AhOE61IX+IRcQsaePmGay/SD1Cty4YQGnH0yWPWyDZsQaPMQqGgwaxK8Rqe+CPAS
	AkJTmPeXRDiSTj8k8H+F8aPkN4dWQbmBepZcm+pBZNIH7HbQV2vmR409GkljKZh9
	QHT6S9DBWSTbfKXQKmZl6h+ejn4ZW0309Q5aVdlzJWAxotNQrOi5mTiS3RYENuiC
	su8GZ6+w/kVC+QzBvLsKd5Mg8mFjqq5qqpty3u+QYUCWAkKvAiBFAR9cu6owkJYe
	5CqycKThd3WXmbbYqXXGGbVw1fKFMK2yUaU79ITqlBn9s0bMwaqW2e6rO0gukDPA
	o11+oVwJ9NCw1zUA==
Received: (qmail 1558771 invoked from network); 1 Apr 2025 11:58:54 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:54 +0200
X-UD-Smtp-Session: l3s3148p1@HVGZlbQxSoIgAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 06/11] mmc: rename mmc_can_sanitize() to mmc_card_can_sanitize()
Date: Tue,  1 Apr 2025 11:58:42 +0200
Message-ID: <20250401095847.29271-7-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/core/core.c    | 8 ++++----
 drivers/mmc/core/core.h    | 2 +-
 drivers/mmc/core/mmc_ops.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e7449d03f311..ff75336eb1ae 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1862,13 +1862,13 @@ bool mmc_card_can_discard(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_card_can_discard);
 
-int mmc_can_sanitize(struct mmc_card *card)
+bool mmc_card_can_sanitize(struct mmc_card *card)
 {
 	if (!mmc_can_trim(card) && !mmc_card_can_erase(card))
-		return 0;
+		return false;
 	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_SANITIZE)
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 int mmc_can_secure_erase_trim(struct mmc_card *card)
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 2e66d8321626..1f194665499d 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -121,7 +121,7 @@ int mmc_erase(struct mmc_card *card, sector_t from, unsigned int nr, unsigned in
 bool mmc_card_can_erase(struct mmc_card *card);
 int mmc_can_trim(struct mmc_card *card);
 bool mmc_card_can_discard(struct mmc_card *card);
-int mmc_can_sanitize(struct mmc_card *card);
+bool mmc_card_can_sanitize(struct mmc_card *card);
 int mmc_can_secure_erase_trim(struct mmc_card *card);
 int mmc_erase_group_aligned(struct mmc_card *card, sector_t from, unsigned int nr);
 unsigned int mmc_calc_max_discard(struct mmc_card *card);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 638e87a861bc..66283825513c 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -1046,7 +1046,7 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
 	struct mmc_host *host = card->host;
 	int err;
 
-	if (!mmc_can_sanitize(card)) {
+	if (!mmc_card_can_sanitize(card)) {
 		pr_warn("%s: Sanitize not supported\n", mmc_hostname(host));
 		return -EOPNOTSUPP;
 	}
-- 
2.47.2


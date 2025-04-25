Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C8244685
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579665; cv=none; b=T6drxuDHMBwxy4T85JRxRUmYGNdz0/JkTXXnZXdWAA9DCEo3X3PHGtFaX7Yt6OEnyByxi87bBJ7batryTdNjj8XeUIUUY0sCHjOA6H2uNEABxYgNxdtpGzd9yxjT2jBSP9OAYiPKwuMXAZgBcJfcnYeHLdrOXHv/s6pZ6+dTCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579665; c=relaxed/simple;
	bh=z87LNsYZi3fNdqV6cBynWTcc70A4CLYgzMZ4KHbIYyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WU2D6sdXlhqc4qcgmG8IK0m4/BaQO6/YDDMcjpHl11OUQJ9T4yN7hVDY92UTeBsNkRNKXU7ll6o5zVhQLgz+XcncWBTZ2O0Y0GDQrQXt6DZEvGF60j0OJZL98szFlVwXNfwnRbq8h+v64LP+VjMVyFG4ZfZo0pXQi6LmSD1UVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OC4XCblA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OC4XCblA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=LK3O1YZdFpxihwZ+bfJfdOOvo+X2bYNcL70oK3S25Bw=; b=OC4XCb
	lAjarn4ZSSAY+cQft+VyJiHK7gzEWPEL3GWb5XsL/Z4whh0jXX6dPr7U0p+EOQIU
	UaojVpI1+RH5IjCCTPFt3Fev3IWsi9xpgVh4gW/ek+XYFsqUMnt9WZnDmrqR8xZ/
	gCMXLK3OIKh8TRCVYsRYgNr+hQ4bvJVsSYH5LTA8fr8I6GeNrJ/gj0VJCd9Mz+jY
	6Wecq0NhzowY0sDvRGD4XKDsDtfqGOXqt6kVlgsyVgcsHs16Pg1tnttPtYHG63hq
	6t7Dy3/BSgNR4vcD4aC9MmuYc7O1+tRvvuT/5PN6JN2m3LSvynuwlnTjIIixppQE
	9cf4WcvL6NvMDKdw==
Received: (qmail 3801134 invoked from network); 25 Apr 2025 13:14:18 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Apr 2025 13:14:18 +0200
X-UD-Smtp-Session: l3s3148p1@9eJvb5gzZoYujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 02/11] mmc: rename mmc_retune_disable() to mmc_host_retune_disable()
Date: Fri, 25 Apr 2025 13:13:58 +0200
Message-ID: <20250425111414.2522-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250425111414.2522-1-wsa+renesas@sang-engineering.com>
References: <20250425111414.2522-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_* functions sometimes relate to the card and sometimes to the host.
Make it obvious by renaming this function to include 'host'.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/core.c | 2 +-
 drivers/mmc/core/host.c | 4 ++--
 drivers/mmc/core/host.h | 2 +-
 drivers/mmc/core/mmc.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b0901d3a0f67..faa935ba30f0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -988,7 +988,7 @@ void mmc_set_initial_state(struct mmc_host *host)
 	if (host->cqe_on)
 		host->cqe_ops->cqe_off(host);
 
-	mmc_retune_disable(host);
+	mmc_host_retune_disable(host);
 
 	if (mmc_host_is_spi(host))
 		host->ios.chip_select = MMC_CS_HIGH;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e7bd8d415c6a..b0d261bd54b8 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -138,12 +138,12 @@ void mmc_retune_unpause(struct mmc_host *host)
 EXPORT_SYMBOL(mmc_retune_unpause);
 
 /**
- * mmc_retune_disable() - exit a transfer mode that requires retuning
+ * mmc_host_retune_disable() - exit a transfer mode that requires retuning
  * @host: host which should not retune anymore
  *
  * It is not meant for temporarily preventing retuning!
  */
-void mmc_retune_disable(struct mmc_host *host)
+void mmc_host_retune_disable(struct mmc_host *host)
 {
 	mmc_retune_unpause(host);
 	host->can_retune = 0;
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 8989aa73c2a1..cf3a3894c2c8 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -14,7 +14,7 @@ int mmc_register_host_class(void);
 void mmc_unregister_host_class(void);
 
 void mmc_host_retune_enable(struct mmc_host *host);
-void mmc_retune_disable(struct mmc_host *host);
+void mmc_host_retune_disable(struct mmc_host *host);
 void mmc_retune_hold(struct mmc_host *host);
 void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 621022348f33..413af7cf3143 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1238,7 +1238,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	mmc_set_bus_speed(card);
 
 	if (host->ops->execute_hs400_tuning) {
-		mmc_retune_disable(host);
+		mmc_host_retune_disable(host);
 		err = host->ops->execute_hs400_tuning(host, card);
 		mmc_host_retune_enable(host);
 		if (err)
-- 
2.47.2


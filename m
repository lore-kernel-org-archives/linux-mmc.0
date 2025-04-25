Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49FE2451D7
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579667; cv=none; b=oE06dPGeO95T40qjThMz1TuF6CYFewLZaJ7BsGTVAEDQRo2Ui18xFfNvcmLL5iRlOqvEqyL30bbciOKvua1EVDuvMWPlSQWje8cd1xJWlfaEcuG77Z8M80rpwIIw3W3UR6E8ckhDkHNCeFfAVziJZAo9Ky3pLjA1hUh8+BJxefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579667; c=relaxed/simple;
	bh=Yb9u6zNsILt6J0d1h2j49WT+R0SN4cUlJSQGWciMs5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2iojerpVmKqLYXFRCzBaNGdRH7jRRB3o95BjbF/3OKPT6z6YDwf5EDt9JHmpoqODGZ96BjffGNvcTAGYWWsBW7a+WzcNcKqeGiXORGyZemgMzzEEqSZiXOJQVV4V6GvZnDLvtmQoymUNNuRWFQab5EQdyN4C1desZkeSaMoVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YYF0Dy4B; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YYF0Dy4B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=+RBI1vPta0neq5DNX4gAYXGxAf6p2HH9SJJFXxkjR04=; b=YYF0Dy
	4BgovLkpglu4wh/OG/ZGzAH31Bo+nmgfGzJ9H/QW/j3aR01hugRvzRdXdf8KRNE1
	ZkjcG8R9lCNnlpnfDjx4MQS75vKdcRFQJuinMI2jF9e1A3i8/hUmYUVEbZjv6rPY
	COgpS7o3MsQ95Ip4+afCAV5D5y+S36z6eBJstIgkA22hQ0qyiQpa5SyDmpXSa9Qs
	iJlbB8wlzQDa29Gjzqoq6J37fJUXqtuHoqpF8Rj9YULC5gOzhrRsiBS6scSCeV3R
	T5j23i/JzA14krFM49+8hq0NtucuSAl8kqQTkJ7TGklYmXND0jE0mRq1w4ePmW89
	+qZNFpEkKffbJVbA==
Received: (qmail 3801241 invoked from network); 25 Apr 2025 13:14:22 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Apr 2025 13:14:22 +0200
X-UD-Smtp-Session: l3s3148p1@gruwb5gzEpgujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/11] mmc: rename mmc_retune_pause() to mmc_host_retune_pause()
Date: Fri, 25 Apr 2025 13:14:02 +0200
Message-ID: <20250425111414.2522-7-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/core/block.c | 2 +-
 drivers/mmc/core/host.c  | 4 ++--
 drivers/mmc/core/host.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8d2c6b6fdead..69469239bea4 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -931,7 +931,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 			if (ret)
 				return ret;
 		}
-		mmc_retune_pause(card->host);
+		mmc_host_retune_pause(card->host);
 	}
 
 	return ret;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b0c958f761da..db1f2ad6e7c6 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -119,14 +119,14 @@ void mmc_host_retune_enable(struct mmc_host *host)
  * Pause re-tuning for a small set of operations.  The pause begins after the
  * next command.
  */
-void mmc_retune_pause(struct mmc_host *host)
+void mmc_host_retune_pause(struct mmc_host *host)
 {
 	if (!host->retune_paused) {
 		host->retune_paused = 1;
 		mmc_host_retune_hold(host);
 	}
 }
-EXPORT_SYMBOL(mmc_retune_pause);
+EXPORT_SYMBOL(mmc_host_retune_pause);
 
 void mmc_retune_unpause(struct mmc_host *host)
 {
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 45200070d318..e7757423e0fa 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -18,7 +18,7 @@ void mmc_host_retune_disable(struct mmc_host *host);
 void mmc_host_retune_hold(struct mmc_host *host);
 void mmc_host_retune_release(struct mmc_host *host);
 int mmc_host_retune(struct mmc_host *host);
-void mmc_retune_pause(struct mmc_host *host);
+void mmc_host_retune_pause(struct mmc_host *host);
 void mmc_retune_unpause(struct mmc_host *host);
 
 static inline void mmc_retune_clear(struct mmc_host *host)
-- 
2.47.2


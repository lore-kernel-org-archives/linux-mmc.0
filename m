Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889481EFFAD
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501538; cv=none; b=l0m5PAD6/C48D9frFqPQZ2oH+68og+ghwfhV5WShUO/Yo5W4dy+b9nGrXlHzBdPFaNf+hs1O9YrKOBKQ0miagUPg446nztDeTWgZTVv40g6FH8/54QgmmgW3v5J3vwufxdYrt2HqD4OEQKRl7N7ni57xrX6JXwEJ0nAZaVMV8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501538; c=relaxed/simple;
	bh=6+5NhkHTOcoMGPS2xi4K6NqovhNCM2vGbbFlnV/BG1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdPCCJ7MH0WmtRRvPSrROGQbUm+1GLhveKkY1v28fBibILohh5SOEQhAfioxhGTnHTtTD8xr9cUb8mErmivWUkIwHrSE5buXpW2ohjUfyU1IQ8EJZl+vaMbnyfWpirSOZGliHQ/QfHg+95hWHnQp7YA7se5bQu6YRL4C6m0kgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=awTDnN4M; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="awTDnN4M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=9u0hzGZFnsDZygBVOxAig1nlvDZUfl9BQwidcgufXRI=; b=awTDnN
	4MO6JqyjJtknm9xS3aqOodMZHm0dqXfh+fHtQToLLSF0OqpdMVzqe8RGo8VmTOCo
	Xd0tIZxsibG8HsMWx8XBvrBCSSKVBPoJobOOY+14mJGRyNuNT6/HqrOBln63nxl7
	wD0ODIL0U2yhFhNeQUmFKCyRnoVW+rqr1qEYwlCBSmTZRYopHbURYcSakwUFbNEi
	wh+qjwt/U0bHs2BpHa2vfUjWIhqPtHUPsUPI8Ccc2n0ttzSuYv4MHsIfMHUT7tP5
	j57LU4hMKO/3ae5QciCmlqH35qJd9yY0UUPo6cZZEgz+MEb9zEyo5cNsdIj/yaWu
	09v8LL8d5mtQxGXQ==
Received: (qmail 1558755 invoked from network); 1 Apr 2025 11:58:53 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:53 +0200
X-UD-Smtp-Session: l3s3148p1@LqWRlbQxQoIgAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 05/11] mmc: rename mmc_can_reset() to mmc_card_can_reset()
Date: Tue,  1 Apr 2025 11:58:41 +0200
Message-ID: <20250401095847.29271-6-wsa+renesas@sang-engineering.com>
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
proper bool type while we are here. Conversion was simplified by
inverting the logic.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/mmc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8911b2206c45..8fde20ba3d95 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2269,14 +2269,12 @@ static int mmc_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
-static int mmc_can_reset(struct mmc_card *card)
+static bool mmc_card_can_reset(struct mmc_card *card)
 {
 	u8 rst_n_function;
 
 	rst_n_function = card->ext_csd.rst_n_function;
-	if ((rst_n_function & EXT_CSD_RST_N_EN_MASK) != EXT_CSD_RST_N_ENABLED)
-		return 0;
-	return 1;
+	return ((rst_n_function & EXT_CSD_RST_N_EN_MASK) == EXT_CSD_RST_N_ENABLED);
 }
 
 static int _mmc_hw_reset(struct mmc_host *host)
@@ -2290,7 +2288,7 @@ static int _mmc_hw_reset(struct mmc_host *host)
 	_mmc_flush_cache(host);
 
 	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->card_hw_reset &&
-	     mmc_can_reset(card)) {
+	     mmc_card_can_reset(card)) {
 		/* If the card accept RST_n signal, send it. */
 		mmc_set_clock(host, host->f_init);
 		host->ops->card_hw_reset(host);
-- 
2.47.2


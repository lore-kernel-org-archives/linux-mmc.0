Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC569242D91
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579667; cv=none; b=f8s4tXfN8/UI11rn1Nvjth8KNlmpCzyZ+RKDEimixUPLUqhL0nomfGwAc1lbmK/4T1y1U5OJ6kAmxPm1PVjXeWVtWgjRq/AsLrjQlBN2KVRQmU5HH5JgROTMP+Xmanmx9xHPX/YR0hZCwR0/23d+6t9YDEbm23r2xJtmKIkcwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579667; c=relaxed/simple;
	bh=VSs1ZANAFUhU6l5mzwZq8u2kPjLwcCGO2Ip/Nzjqtgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtBOn8HU2vWkziwACL8E8BLnWC8NukRQwAIVODrAn45rJkL+OdU5yLUUMudr11XrahRUS8VQNO/dx24ptJYjtB1C7yQsXP919/KId42tdyvrvGj6/uhpW3dNH1s8bibM2d6bns5xeux1rjhbgj07WPT3DQtqiG/yeKUvxk033LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=LGuTv9Wx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="LGuTv9Wx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=ceVBVVUMdRLfCSHFeF8WDzT0M+dOm9siBST3UhcyzPg=; b=LGuTv9
	WxrN1klnJXrCa55EkLg8SmdDUzm4/9S/FtviE9rUIn0dpwrj+vFnsEMSVWxQP7Io
	toEkYzxluQw9w9v+e0HQCgdYQv7VL+oHGEc//5tA+Hxuri5H1HTmG9oaWKUnU434
	roKRFEqIR09scpOg7QAB2IqvOy/kqV5JmPwhD0QufjdlUGgZFLfpYyVXF5MBuhMV
	3bPojP7957/q1Sp83WHRCKs1+Zuk/VNOsG7f1hx+mSpZWNMYvOJz7BSgovGZqbw5
	zVCOJLIzZdYNV6IdXpPuGB8XaZbBLCTba/DSrQknI/TkEEn/jSHOdyrpCsTH4oo5
	TZ+McT5Tz3ukYa2g==
Received: (qmail 3801103 invoked from network); 25 Apr 2025 13:14:17 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Apr 2025 13:14:17 +0200
X-UD-Smtp-Session: l3s3148p1@/ntgb5gzYIYujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 01/11] mmc: rename mmc_retune_enable() to mmc_host_retune_enable()
Date: Fri, 25 Apr 2025 13:13:57 +0200
Message-ID: <20250425111414.2522-2-wsa+renesas@sang-engineering.com>
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
index a0e2dce70434..b0901d3a0f67 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -948,7 +948,7 @@ int mmc_execute_tuning(struct mmc_card *card)
 	err = host->ops->execute_tuning(host, opcode);
 	if (!err) {
 		mmc_retune_clear(host);
-		mmc_retune_enable(host);
+		mmc_host_retune_enable(host);
 		return 0;
 	}
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index dacb5bd9bb71..e7bd8d415c6a 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -104,10 +104,10 @@ void mmc_unregister_host_class(void)
 }
 
 /**
- * mmc_retune_enable() - enter a transfer mode that requires retuning
+ * mmc_host_retune_enable() - enter a transfer mode that requires retuning
  * @host: host which should retune now
  */
-void mmc_retune_enable(struct mmc_host *host)
+void mmc_host_retune_enable(struct mmc_host *host)
 {
 	host->can_retune = 1;
 	if (host->retune_period)
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 48c4952512a5..8989aa73c2a1 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -13,7 +13,7 @@
 int mmc_register_host_class(void);
 void mmc_unregister_host_class(void);
 
-void mmc_retune_enable(struct mmc_host *host);
+void mmc_host_retune_enable(struct mmc_host *host);
 void mmc_retune_disable(struct mmc_host *host);
 void mmc_retune_hold(struct mmc_host *host);
 void mmc_retune_release(struct mmc_host *host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e499835b05a9..621022348f33 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1240,7 +1240,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	if (host->ops->execute_hs400_tuning) {
 		mmc_retune_disable(host);
 		err = host->ops->execute_hs400_tuning(host, card);
-		mmc_retune_enable(host);
+		mmc_host_retune_enable(host);
 		if (err)
 			goto out_err;
 	}
-- 
2.47.2


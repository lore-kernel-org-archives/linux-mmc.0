Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05B22DFB8
	for <linux-mmc@vger.kernel.org>; Sun, 24 Aug 2025 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756025408; cv=none; b=I86cNm7Ik8FrkuUHCTy8DAf1naJo/Tv2xaV/R3vaBEQ9zxGve/4VdMe1SyptJcCPtmkz1uNmVqQ2Oru0i5Ltf1f5mRcAWF92cr6j3lnRfiOSn0dfzckrZpwj4Yn4KGGGuH7wuj/QgZJ9c/mxNAKe3p3CIMRX2qK0vuIdUw0gJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756025408; c=relaxed/simple;
	bh=cOU70fy64IsQP6b2y2oAX6mJHsidnf0ev2WnUxt2NHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=akwrb68CJunmOtLMhpCc9k9Jc4MuAlvBB07eVzJkdpiC4UhBAbWGVqrc4KDTQNsPydJAL9POw3ykaLOQejjhceBpwZe6trYK3GZot+FY1mLrbB+EmIkMB/+G67Ydux02boe3EPTUrCN+3luTln24i8ON+tGqvf619kEbHPSBqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rl4Gewph; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl4Gewph"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3252589a4afso1546690a91.0
        for <linux-mmc@vger.kernel.org>; Sun, 24 Aug 2025 01:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756025406; x=1756630206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxIZSS5baIki0N/gAyQ9E49UPlheZtudcdMGnoLU7K4=;
        b=Rl4GewphILo+aIKl1nhFRPcHufcs4FXdGtHAUnpbQJbyaEUbWwWmtiIzKIkPSdERiS
         S6J29tqDWDBDoWwfPyR4x7/bUYnnPr2wncmQpH4q6cy2A8SyNSVq7mUK1HopLL6mMdCs
         JkMWfERhu/Qc6l4l5jQUhPFFd9DFmynDJMdsC9xoUbEaOtxFjFYtzHY7tay1i/wrbcq+
         tZQTYGCMQO+ARXLB3kOar39C6YoLUvn56y1ULNp5hhEyIy88I6RM4LjEj3dDTbG++T12
         hHjgyVufjYDgt+GfnwxV/3avGaBJEjtbtxTVV/XqN8aR3Ui7erL9aDTlOu9Rtyh7vNKd
         S9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756025406; x=1756630206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxIZSS5baIki0N/gAyQ9E49UPlheZtudcdMGnoLU7K4=;
        b=NGaRcM/Y7b/1qG6EwixzqBohjzciMMuBhMMdiPyJL/IbtEK4KAWXM3p2npnVjqna1t
         H+j3ncd+h+ViVJRvjM377TU52ibwYFci4E9UfLKs61IaANAGpzyTKmpqDvyUd/bq57os
         GHllwGeBJeu4H/Ey6DarxEmP7PJVbZ/ENa0W5hyDw7ZDexKi3golrA0O41P9u09RAWut
         DhoN4mIVRST809QEbSkJl1STYiVI+7PKW1PrP3DFOT2mmkeIHrU6LzEt/Bopq6rElEZN
         gYxYpPGYqkZS0TrlVUxFLfwCq5HLuo+xVS/QqhECN8/tij8hEAGZdvIKe4lfBLOW/mAE
         3R5Q==
X-Gm-Message-State: AOJu0Yz8gqgYcnb5wiBIDd7DCDKhF14MRtJW+ajcsT6+NsxtSZNygZ1k
	aYJaqWXiNzM/Ep0hYlfaFZuLG2G10lR5ndLKlyG8lHINnmseaD6/Cbq1e5a1kdcA
X-Gm-Gg: ASbGnctr4EnVLk2+rRJcOCql5dUXIuMxeYZcWs7ONYUSPA8zR2rHMKIdzC6F955jZ0I
	59ZCiqufQfuYCBKeK35P9cSzUk+YnSgp4AGoF3W0sAxzpmXOmuzBgNTa5AtbdjnWjfZ8j8Y8FsG
	B9DAsi0cScIJwyYTfXk9+nIPlVJckrJ7cx89b2z9Xq17cwV7iP+JMGsCVwa52KlPS/6iy+zkcfw
	E+SQIGD4rQhNsIMSdQngw8slmNoZS7CdK5wKm45tfREXopvm8XNchHSsQ1bJyfaa7fvHiyW4a8i
	ClpL2Ahwwc5tkctTEzhwd0Jpg19ONI/ydkk9yor0otld46BAk3cgfSVWk9014pOo2Ucxmc5tqgx
	yJlCvll7cRopu6ZecD9XBGPukZA2+GBSTbg==
X-Google-Smtp-Source: AGHT+IHEE8ysAiWsF0EkOz1gCGZS+ByO90NFg/YVcjDIQCh7bgFHUQnb+TdNdDfjPjlccmy39zMVbA==
X-Received: by 2002:a17:90b:5386:b0:311:ff02:3fcc with SMTP id 98e67ed59e1d1-32515e38405mr11852505a91.14.1756025405870;
        Sun, 24 Aug 2025 01:50:05 -0700 (PDT)
Received: from cpi-X79.lan ([139.180.137.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254b9f3a06sm3965164a91.28.2025.08.24.01.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 01:50:05 -0700 (PDT)
From: cuu <dexterkidd@gmail.com>
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	cuu <dexterkidd@gmail.com>
Subject: [PATCH] mmc_spi: Fix cd-gpios for SPI SD card insertion/removal detection
Date: Sun, 24 Aug 2025 16:47:36 +0800
Message-Id: <20250824084736.172222-1-dexterkidd@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, SD cards using pure SPI protocol with mmc_spi could not
reliably detect card removal via cd-gpios. This patch fixes the issue
by extending the card alive check in _mmc_detect_card_removed() to
include cd-gpios detection.

Additionally, mmc_rescan() now includes a status probing function
specific to SPI SD cards to ensure the card state is correctly updated
on insertion and removal events.

Signed-off-by: cuu <dexterkidd@gmail.com>
---
 drivers/mmc/core/core.c | 15 ++++++++++++---
 drivers/mmc/core/core.h |  1 +
 drivers/mmc/core/mmc.c  |  8 ++++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 874c6fe92855..e028ec8fbf46 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2123,6 +2123,11 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 
 	ret = host->bus_ops->alive(host);
 
+        if(mmc_host_is_spi(host)) {
+        	if(host->ops->get_cd){
+       			ret = !host->ops->get_cd(host);
+                }
+        }
 	/*
 	 * Card detect status and alive check may be out of sync if card is
 	 * removed slowly, when card detect switch changes while card/slot
@@ -2238,9 +2243,13 @@ void mmc_rescan(struct work_struct *work)
 	}
 
 	/* Verify a registered card to be functional, else remove it. */
-	if (host->bus_ops)
-		host->bus_ops->detect(host);
-
+	if (host->bus_ops){
+		if (mmc_host_is_spi(host)){
+			mmc_detect_mmc(host);
+		}else{
+			host->bus_ops->detect(host);
+		}
+	}
 	host->detect_change = 0;
 
 	/* if there still is a card present, stop here */
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 622085cd766f..5b48c50b5bb5 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -78,6 +78,7 @@ void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
 int _mmc_detect_card_removed(struct mmc_host *host);
 int mmc_detect_card_removed(struct mmc_host *host);
 
+int mmc_detect_mmc(struct mmc_host *host);
 int mmc_attach_mmc(struct mmc_host *host);
 int mmc_attach_sd(struct mmc_host *host);
 int mmc_attach_sdio(struct mmc_host *host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5be9b42d5057..e73de34e072b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2316,6 +2316,14 @@ static const struct mmc_bus_ops mmc_ops = {
 	.flush_cache = _mmc_flush_cache,
 };
 
+/*
+ * Export function for mmc detection 
+ */
+int mmc_detect_mmc(struct mmc_host *host){
+	mmc_detect(host);
+	return 0;
+}
+
 /*
  * Starting point for MMC card init.
  */
-- 
2.34.1


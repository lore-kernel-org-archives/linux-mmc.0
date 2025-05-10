Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782DD1428E7
	for <linux-mmc@vger.kernel.org>; Sat, 10 May 2025 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746847199; cv=none; b=dj/ZaoyadEfi1EKAjc2mjN6vSOdWPJGPf8GsEgJ9ZJZr71Z/fABGYO447jJ9GscwO4S/cmsMh1obKKeFsOH9/IMjIl0vT8YvDzttn+ygOaqSFyt8HrDtVTYYD4QbMhX1OLlBqpOK1qx5JT98q9S0iR/LJXGlSlZeK4s4Cpt5Nmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746847199; c=relaxed/simple;
	bh=X4VbS6hxTRUDXi5qymXSbdGbid2iTp6/aO7oAaUZrPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/QUgI3oMGqieGxcAC9cFpbGWbUIZStdf0r3+e4bIeJQ6fSyJIZbs2R2xcKXj65z61xXgUpEKVq9t/0bt27toKVYw9TyRst4XKsVL88cCPq7DTX8QRRfOIYiNgtpP/SlHzUNPZn8yiBoNRt+wlVLzw4bh7eOu6OQ3dTnczyCzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYgQWz4W; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYgQWz4W"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47692b9d059so45068611cf.3
        for <linux-mmc@vger.kernel.org>; Fri, 09 May 2025 20:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746847196; x=1747451996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+w6XKIgi/97++r72eGcu+jW8kdBQp5YATPEndk4ZTLU=;
        b=XYgQWz4W1HQBekwBez6qXZdC1cB4UG5W07zJbEaKypq90m1QjT7upeEI6fiIFZA4bl
         Kt3ev0wCFp6bpLXZJN/OAhq+o4rC2LGlukfq7vmhiyx9kJ6H4hDIwLxYlpHlLFLCH7Nj
         lU1e9anxA5DkJeFP2N7bQNsdxw5En+uZcwTqx81AODv++setPAtQucoH2bXZmq+dBzl4
         8M9JIhGzuXQJ7jMAMTw86xnSG/MoGjLxakNqebynjeOSYSavSDUIarDAYuI25M2N47gQ
         mZrpvS3MLXhEGt79iN+oOGgN6FNf0bQJHVWOfGPKIziAgOMTofgDACxyUAdHDexphlVH
         T4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746847196; x=1747451996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+w6XKIgi/97++r72eGcu+jW8kdBQp5YATPEndk4ZTLU=;
        b=Iq4x7Ms7bQ+rNMJMNWa9DTHRX2kb274OGbppQVoCT5leLjyZPuW4T4hCTFYaF0KHh8
         Wqp0CIfO0fy2TbFRonfdrp8jPSbTArO2OHZJxLkMeXsewuhMoE611bu172TbRHTUY/9x
         cTFOaUJtdy6IWjnPRYfgjmPctAQAhTFiscmRcEyuV7Eq7r8XMNYLJvQQwZghT/7shLGt
         06vu4mOfnjtGQ1C9VuP4UJKo05viwsqzD3FRozeU9wsFjsTAGJzGyCLCRyPC/Xl71xCA
         kWbvgq0uZFU0Wpr6zFtrgbErWsMKukFRDVOImfHRB8Sj/2O+hnJ5v/49Us8QvOCRVGai
         f1Jg==
X-Gm-Message-State: AOJu0Ywfr0iXnPKVcyqCLwoQMCTtsEXjgoPv1fJYapkPDi8pGOC7Wzh+
	SFTN2zaL6wSkZxT9pN5UI0KGj79mt8OKhfEKK3MebthTHzlqAuCR
X-Gm-Gg: ASbGncvfgA7g5sZLoy2jrmyr7t+Hn9uFstnHCKcF2A7BtP4wb9GSrVGkKgNguZRnPrm
	lk3XoFG5w1V+aiyRhYRskcuzAbtFsPwQNIFtE/7DDRmztjmKkOIC2keoGQYi4vpKmfL+PPP0M0w
	WFiCdUZPPuC8SbyYvSK8kkO+eeLusB2/mSr6I/wpN5c5n6J1WcS1xVISNa2rP1IHsK/5f0idIac
	zQx6VF6QnxzykuT7apiE6I3EeqrhOWzkURMZ1mBNFgths+gvCQJyFaJC0PprRwCyV9gC/+B22Ex
	FxyrgVEzzbi8hXvMm0TlnQRbIhvBF/T8XjS8Lt4vU3tJRX2TGKVwPY7Ubp7d0g6r5xpAg8XcdMD
	7WvFQSJTDABQ1c1dwFKVUFti6LxzHCj2KEm5BRg==
X-Google-Smtp-Source: AGHT+IE1h70Ob0cBKayxB9Vaoa0wr/Jh/3l5EUSZnStgTIeAoDZu1y/3ikqYjTkFpDbDVRBfL2a3Cg==
X-Received: by 2002:ac8:5d45:0:b0:474:e75e:fccc with SMTP id d75a77b69052e-494527ba618mr98816561cf.35.1746847196108;
        Fri, 09 May 2025 20:19:56 -0700 (PDT)
Received: from craggy.ristobar.nom.menu (pool-108-50-194-43.nwrknj.fios.verizon.net. [108.50.194.43])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4945259e3a1sm21226911cf.70.2025.05.09.20.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 20:19:55 -0700 (PDT)
From: Gavin Li <gfl3162@gmail.com>
X-Google-Original-From: Gavin Li <git@thegavinli.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Gavin Li <git@thegavinli.com>
Subject: [PATCH v1] mmc: rtsx_usb_sdmmc: add parameter to always poll for card presence
Date: Fri,  9 May 2025 23:19:45 -0400
Message-ID: <20250510031945.1004129-1-git@thegavinli.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some RTS5179 implementations have broken remote wake-up, preventing the
runtime_resume calback from being called and breaking card insertion.
With the current implementation, the card is detected if it is present
when the RTS5179 enumerates. However, card insertions after the initial
enumeration are not detected, and a rtsx_usb_sdmmc module reload is
necessary to detect the card again.

The change to only poll when card inserted was added in commit
4dad599b8b5d ("Re-work card detection/removal support") to save power
when the card is not present. Thus, this change adds a module parameter
to revert to the previous behavior of always polling for card presence.

Signed-off-by: Gavin Li <git@thegavinli.com>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index d229c2b83ea9..246b0da1e908 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -30,6 +30,10 @@
 #define RTSX_USB_USE_LEDS_CLASS
 #endif
 
+static bool always_poll = false;
+module_param(always_poll, bool, 0444);
+MODULE_PARM_DESC(always_poll, "always poll for card presence");
+
 struct rtsx_usb_sdmmc {
 	struct platform_device	*pdev;
 	struct rtsx_ucr	*ucr;
@@ -1306,6 +1310,14 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
 	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
 		MMC_CAP2_NO_SDIO;
 
+	/*
+	 * Some RTS5179 implementations have broken remote wake-up, preventing the
+	 * runtime_resume calback from being called and breaking card insertion.
+	 * In that case, we always need to poll.
+	 */
+	if (always_poll)
+		mmc->caps |= MMC_CAP_NEEDS_POLL;
+
 	mmc->max_current_330 = 400;
 	mmc->max_current_180 = 800;
 	mmc->ops = &rtsx_usb_sdmmc_ops;
@@ -1419,7 +1431,9 @@ static int rtsx_usb_sdmmc_runtime_suspend(struct device *dev)
 {
 	struct rtsx_usb_sdmmc *host = dev_get_drvdata(dev);
 
-	host->mmc->caps &= ~MMC_CAP_NEEDS_POLL;
+	if (!always_poll)
+		host->mmc->caps &= ~MMC_CAP_NEEDS_POLL;
+
 	return 0;
 }
 
@@ -1427,9 +1441,12 @@ static int rtsx_usb_sdmmc_runtime_resume(struct device *dev)
 {
 	struct rtsx_usb_sdmmc *host = dev_get_drvdata(dev);
 
-	host->mmc->caps |= MMC_CAP_NEEDS_POLL;
-	if (sdmmc_get_cd(host->mmc) == 1)
-		mmc_detect_change(host->mmc, 0);
+	if (!always_poll) {
+		host->mmc->caps |= MMC_CAP_NEEDS_POLL;
+		if (sdmmc_get_cd(host->mmc) == 1)
+			mmc_detect_change(host->mmc, 0);
+	}
+
 	return 0;
 }
 #endif
-- 
2.49.0


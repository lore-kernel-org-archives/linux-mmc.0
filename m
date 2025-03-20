Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772FD2253FB
	for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479260; cv=none; b=NHOK+kp62dJP2PDwzgI1szFTjjvZuy2S/eXPExsXpl2gn8VUYJH6415EeJ2sjSB/tJD1Ni0k8hWSsm6RfnjriDqu8FGbgqJvB+HNlITcFIdIB5medeBJVVTDDCFFWDH+LIzmkPCZ2UMGx9gW+GNm9uCc5iGcs18OX3nPGzpQDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479260; c=relaxed/simple;
	bh=5q7KCE9db7ERhm5lr7U4Yg37JmaxdnTD/f+2sXkyzxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZmVfsbfQ0ewgFwEiS2RLwZtcp2VyCnL/foSN81pr6qPqKOCT9zRzBmrwM4byV+wj2sn3YE/vm+2yeA1LIpuhnt4WZ1P5uRIb6m2VgJdDBscO1x0IA6NrVuMtmltWvhPBeWZo5NS9JSSZTXgk8hQB7F5aDzgJWXjaO2poyHGOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xiTQvwwU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiTQvwwU"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so877233e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479256; x=1743084056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXE9dlseC0dhD7d4oX2r9ZUURR/ikgG5O0SCUhzKJLQ=;
        b=xiTQvwwUQMwy2rT+pjfqAWF6BwGiO35f3I4+17xJhhQRNv9pdDy/0/tTguJ2Cpd0c8
         CJ+SBoG56JHPylJmxEX6nXspuwd98YAs2wzXaGSVeuJQ5BVSrymVnYYvVJpbPe0D+IKf
         0lWWwnz0i8IlN5C9Z0umiA5mTxsmr8J0DBphm4fMb43o+DIxFlWp8gG5HbC2ulxzlUdq
         wmAjL5V2BWkJ66WfXdc4H2NSxvyVU+mZLYU68j8kREDg+uUKrGCizsy1JUupUnp+IyId
         qUh5OKBXbA/o0t8XoUKyggFwTtDi4sFzoTm7F+6NgQ+3TCy2Yv3gFT7x+X+djZ1JhIKH
         uA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479256; x=1743084056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXE9dlseC0dhD7d4oX2r9ZUURR/ikgG5O0SCUhzKJLQ=;
        b=Su4y8lvWdgMs6gC7bDN3QqVybYOkJfZmy2p1wRZLUQe72ieF5xKFwlDwUNOoe9C1O2
         jVcIg1aJgiB9Ne6t0eCaa4tPW4hGVdwXq0F1kfjJzb/JyCKkuE+8MohJ1nERn50dWtgc
         fZTziilyKqinNZQSfDSGgk3g0idi3St0SsAxXBJQ/ZDq8CKFZbQAAK96Cc8tU+g0eW2l
         mRstx8Bls6sQBJAaHLi9rLSzOR+UTxoHTarBTHpIRK4HwPkDqskBeQa8VCHNMutH2iEg
         c8JB3Mffkv1pro3dxhKx1itnj3SA3dbMCZn15s6cxMCJYS9UGbRBu2lnDaRUJSi7Db1R
         xpmQ==
X-Gm-Message-State: AOJu0YwSzni0VCVJlM2IRnZcutmoT0n0OeEeuamJsFgJZtG0RCjSsixe
	vkqyhpsHjCqlXfNr957IX57aYe6gxkU+ZQF1RhnyzyqsGqJVS78lJ6w1Gb4r0oxQcIC7lwV/cSI
	d
X-Gm-Gg: ASbGnctv/dPuxljcqLo8pj96USCnUb6m9PiDLw9uKF/gHNobbGeRInCeHPTQ7hwJFxK
	eDmouvADHsGQhfn1VNdiqjJPEamLH6EGsFU6TgyMaIwCTws8B4bbdWEI+E9zvmHQ+QZzuSNXVRV
	IQgCzyhGd71JZIS4QW49e8kQXx+UUrjw8uobXqH5eeNN0GHSSzb+uy8q2GO4i3CTUvl8wrgSPQx
	ls2rxV4vUDuw6yFl+cFK1HW5HSI6WiB33fLqysHI7Vj7YmAQ9WR8wltw3vgC1RxvwmgHw9Wykgq
	Fzmbe8oSlq48x1S+T3nEgBsrbNOHxSvuV+U0nMB+JAi5Y0pTb7ngaPSoFW8183pzvY0HCy2u6wn
	ymh6Q+io5pQZGonU8Ga+JpkU4o90M4A==
X-Google-Smtp-Source: AGHT+IHyRLgkNoCEkf9M1ICxzrsASm6on3//oo9APTxgLDD9aYJ0CrJh/ehpG879EGIFtCHQch+O4A==
X-Received: by 2002:a05:6512:b99:b0:54a:cc04:ea24 with SMTP id 2adb3069b0e04-54ad068688cmr1116238e87.46.1742479254697;
        Thu, 20 Mar 2025 07:00:54 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864dd9sm2295029e87.148.2025.03.20.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:00:54 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mmc: core: Add support for graceful host removal for eMMC
Date: Thu, 20 Mar 2025 15:00:35 +0100
Message-ID: <20250320140040.162416-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140040.162416-1-ulf.hansson@linaro.org>
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An mmc host driver may allow to unbind from its corresponding host device.
If an eMMC card is attached to the host, the mmc core will just try to cut
the power for it, without obeying to the eMMC spec.

Potentially this may damage the card and it may also prevent us from
successfully doing a re-initialization of it, which would typically happen
if/when we try to re-bind the mmc host driver.

To fix these problems, let's implement a graceful power-down of the card at
host removal.

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 60af88ac0213..5a62a3d3df32 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -36,6 +36,7 @@
 enum mmc_poweroff_type {
 	MMC_POWEROFF_SUSPEND,
 	MMC_POWEROFF_SHUTDOWN,
+	MMC_POWEROFF_UNBIND,
 };
 
 static const unsigned int tran_exp[] = {
@@ -2054,15 +2055,6 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 	return err;
 }
 
-/*
- * Host is being removed. Free up the current card.
- */
-static void mmc_remove(struct mmc_host *host)
-{
-	mmc_remove_card(host->card);
-	host->card = NULL;
-}
-
 /*
  * Card detection - card is alive.
  */
@@ -2088,7 +2080,8 @@ static void mmc_detect(struct mmc_host *host)
 	mmc_put_card(host->card, NULL);
 
 	if (err) {
-		mmc_remove(host);
+		mmc_remove_card(host->card);
+		host->card = NULL;
 
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
@@ -2160,6 +2153,20 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 	return err;
 }
 
+/*
+ * Host is being removed. Free up the current card and do a graceful power-off.
+ */
+static void mmc_remove(struct mmc_host *host)
+{
+	get_device(&host->card->dev);
+	mmc_remove_card(host->card);
+
+	_mmc_suspend(host, MMC_POWEROFF_UNBIND);
+
+	put_device(&host->card->dev);
+	host->card = NULL;
+}
+
 /*
  * Suspend callback
  */
-- 
2.43.0


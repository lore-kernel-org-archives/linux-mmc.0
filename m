Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604314;
	b=sLFAYk3XgJTw3E4S6Cwbw8YwdJJrNGYyKIJWTbd3ZTW6jjYQUY7b3guBZlHd5o2qp8Qm
	 JFmezg/H8hKsht7yJjFCnOQdhCGjDI50CvtEB962A/w31PQxDhoiheuagFnXcYSI/ZiPM
	 nRjgnsADCJpQBXfMIdjaweOXLAeoJuH0VdIuPGKzOG3dDONSjaLM1q9vssSazZGg4dJ71
	 vuwG+CWc7PiNd/HRUHAlyMR/9YCWh0IFvh2jM1mqFbZjcso5OV2J+qwfAszNxo5AAcgLu
	 uODd++IFQq85NIDPlpkPDz3wEsBsNtK6vTZvfpiwPqWYfaHh/d+DoRHlX6foKXLJBbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604314;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=fCytLPbTQSjOf7Vpu6o9kchdmZ8p74IaOwZ5U8CL04Q=;
	b=Tmb1Pb0BBLEJVHfpxE6cOE0See0txPB3Vo4MtOue0F8cp4605S1jLB0SaJCkgKRS7Hmf
	 o6ToLvCgS+wHsLxYV8njzeYmsZJ3NMjS6B/SWOpKEoigZXh/3TdA7w6GaAhwvFYojxF4R
	 02WQjppbtl0jJgLFIWTnmYSY0mVRRbkAUJTir6uI2CRe0vCNCNh/g52+qRFtWsN77T3yM
	 2wKYcn0ahZITBpjPdjKZib3FznOGbyFcuT55G9U+S+2+zt7nxOum77s7oiN3vA5eMWIuI
	 WcEfxfZRPVOJiBxpPh5P+ElVf+uBYtU3ML5K0hrwlwTinpzZ9xsCfRDJJG3/09Ji6Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WNi6SEUl;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E674606A338
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 21:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E674606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=WNi6SEUl
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdb628232d2so1647597a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604312; x=1795209112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fCytLPbTQSjOf7Vpu6o9kchdmZ8p74IaOwZ5U8CL04Q=;
        b=wH9K3nKnTtsol1kwxCa5134VfAj1kFUMWaUVKmd9YSBs2F9WIbtlR0LAldAGH5dOaY
         oP/u74Znbai87wIkLp3GXcQvaZXKJclgRxbIqPq6EOCjOCVEfq2pA+2B0eOD1H0CaADo
         Cw2f9AirL5X1qBQrWbNWWLjwAj7rktFombZb8AfaW7Q+0puQ+KEfdO09Sats6zkldEel
         J88hPUjfLe+Jq5z6mXnzslYN9mWF8PrQXwg2LfNb1J05BlZ2UW3L1vwj6exEZUjNBRw1
         yyt6WU9sRyDC6QGzxJAz0kU9/TSth5oNQXOAg0DgPLflSw30N+N2lt54zpCD224BsEsd
         fovA==
X-Gm-Message-State: APuU4Z8h5PiRi1PPJRDJDsvyB+c1+whP2sOiIsh80PL1d1ooFxE1iKVB
	TWjW49W0PUlKRa546/uj30hIfSl8UacyBDV3iyYUeC/BBSvmp9UvGhEoIaRtBXpnxtaoQkjBcLF
	tpx94faDxopErKmuW39/YzpmIlPYTE/u3Y9W4d3Pq98mOyvvSyPKKfvtqW2yH2ROkYWyhtaqKTN
	d2XdtMvBqRWVOcEcsjVZFhr3zN9tz6QFhYiWaeAPJkBBWH4tnQKrygIr0q+VUsXnjLiXkdpIHM/
	5HMjcAhEvlf
X-Gm-Gg: AYBFou3mKY5j5eKW0D0Dao3QHYOt8ikoUzj786Ax61+SUautLGHhssjsnoBKYTlhrlF
	MCsGsZfhdSYzYlwunq6q5mP1fY/3lH3APXvjdO3pd0RKrremwmGJ4Jrt+1EYs73QQoU38lo+Xyw
	6/eeb9MWc+R8zr5wORRRpGjo2Hy0MUNzw5V61sr96c8sOi9CPL5HFYjdDUzlMtIU8cJfbIzey7A
	PXtTSQHSQ9lTmYVCa+xn1x0h/IeojbvzAMcHWIKLfyG4zKv0UK/JLUWj4RIReLnCPue4ySTw1xa
	L+eHuQw/VJYdShOsjitKRwU4kJBAtnYtsxNt+VSh6u6k2M4ZCgr5bdCFnepUCzxmZiDfvM8VcM+
	csKr2YHnw3SrQC9mV9eXZ/AuBzsXSixPMILLsjVYYjiQN5lesXcBWkBCEI4jYvObDuZ62G4tIbT
	+BOG6PnUydpc0zGInPvsAnzko7TNNLu97z
X-Received: by 2002:a05:6a21:610f:b0:3de:456a:6e07 with SMTP id adf61e73a8af0-3f7a84cefd4mr3530724637.46.1794604312555;
        Fri, 13 Nov 2026 13:11:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cddc18d22b1sm133504a12.25.2026.11.13.13.11.52
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:11:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f559420f3so163091285a.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794604311; x=1795209111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fCytLPbTQSjOf7Vpu6o9kchdmZ8p74IaOwZ5U8CL04Q=;
        b=WNi6SEUlzC2n+eaCvHpctxNxs/PPndMgpycG9oYUVNbvDU7P+Ohc1uTcn0ZreG2/gI
         dAU3EcRoefSsMztKl7SMZJJxG7RS9/nr8EYEKw8PkX8NWV2iV83YwQD+XnsYb3V18z+c
         CKqK8hcrYz/vMOnsFkKsoL0eXSZVhsSObfP0Q=
X-Received: by 2002:a05:620a:1d02:b0:949:33a9:8ef6 with SMTP id af79cd13be357-9494b9e3c42mr605779885a.2.1794604311266;
        Fri, 13 Nov 2026 13:11:51 -0800 (PST)
X-Received: by 2002:a05:620a:1d02:b0:949:33a9:8ef6 with SMTP id af79cd13be357-9494b9e3c42mr605774585a.2.1794604310486;
        Fri, 13 Nov 2026 13:11:50 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73206sm29027626d6.25.2026.11.13.13.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:11:49 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v13 5/6] mmc: core: Move and split reset functions for eMMC
Date: Fri, 13 Nov 2026 16:11:42 -0500
Message-Id: <20261113211143.3759154-6-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113211143.3759154-1-kamal.dasu@broadcom.com>
References: <20261113211143.3759154-1-kamal.dasu@broadcom.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>

To prepare for a subsequent change and to simplify review, let's move the
function for resetting the eMMC card a few lines up in the file.

While at it, split the cache flush out of _mmc_hw_reset() into a new
mmc_hw_reset_recovery() function and use that for the ->hw_reset() bus
operation. This keeps the flush for recovery, where it was intended, but
allows the card to be reset without it, by calling _mmc_hw_reset()
directly. That is needed when resetting the card at system resume, as the
cache has already been flushed at suspend and the flush would only fail
with a timeout, after the card has been accessed by firmware.

There are no functional changes.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Co-developed-by: Kamal Dasu <kamal.dasu@broadcom.com>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/mmc.c | 73 ++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 93bd9b44e7d9..122ac9ba0a4b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2273,6 +2273,44 @@ static int mmc_shutdown(struct mmc_host *host)
 	return err;
 }
 
+static bool mmc_card_can_reset(struct mmc_card *card)
+{
+	u8 rst_n_function;
+
+	rst_n_function = card->ext_csd.rst_n_function;
+	return ((rst_n_function & EXT_CSD_RST_N_EN_MASK) == EXT_CSD_RST_N_ENABLED);
+}
+
+static int _mmc_hw_reset(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+
+	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->card_hw_reset &&
+	    mmc_card_can_reset(card)) {
+		/* If the card accept RST_n signal, send it. */
+		mmc_set_clock(host, host->f_init);
+		host->ops->card_hw_reset(host);
+		/* Set initial state and call mmc_set_ios */
+		mmc_set_initial_state(host);
+	} else {
+		/* Do a brute force power cycle */
+		mmc_power_cycle(host, card->ocr);
+		mmc_pwrseq_reset(host);
+	}
+	return mmc_init_card(host, card->ocr, card);
+}
+
+static int mmc_hw_reset_recovery(struct mmc_host *host)
+{
+	/*
+	 * In the case of recovery, we can't expect flushing the cache to work
+	 * always, but we have a go and ignore errors.
+	 */
+	_mmc_flush_cache(host);
+
+	return _mmc_hw_reset(host);
+}
+
 /*
  * Callback for resume.
  */
@@ -2321,39 +2359,6 @@ static int mmc_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
-static bool mmc_card_can_reset(struct mmc_card *card)
-{
-	u8 rst_n_function;
-
-	rst_n_function = card->ext_csd.rst_n_function;
-	return ((rst_n_function & EXT_CSD_RST_N_EN_MASK) == EXT_CSD_RST_N_ENABLED);
-}
-
-static int _mmc_hw_reset(struct mmc_host *host)
-{
-	struct mmc_card *card = host->card;
-
-	/*
-	 * In the case of recovery, we can't expect flushing the cache to work
-	 * always, but we have a go and ignore errors.
-	 */
-	_mmc_flush_cache(host);
-
-	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->card_hw_reset &&
-	     mmc_card_can_reset(card)) {
-		/* If the card accept RST_n signal, send it. */
-		mmc_set_clock(host, host->f_init);
-		host->ops->card_hw_reset(host);
-		/* Set initial state and call mmc_set_ios */
-		mmc_set_initial_state(host);
-	} else {
-		/* Do a brute force power cycle */
-		mmc_power_cycle(host, card->ocr);
-		mmc_pwrseq_reset(host);
-	}
-	return mmc_init_card(host, card->ocr, card);
-}
-
 /**
  * _mmc_handle_undervoltage - Handle an undervoltage event for MMC/eMMC devices
  * @host: MMC host structure
@@ -2412,7 +2417,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.runtime_resume = mmc_runtime_resume,
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
-	.hw_reset = _mmc_hw_reset,
+	.hw_reset = mmc_hw_reset_recovery,
 	.cache_enabled = _mmc_cache_enabled,
 	.flush_cache = _mmc_flush_cache,
 	.handle_undervoltage = _mmc_handle_undervoltage,

Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174F1FFC6E
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039691; cv=none; b=A6Esi/e/qZIGGKnruuSOaC2pdnmslwXjuVJL5VaYDpfJ4pU8lEYraCRvxtbfdr0R9NKOsItH6fO3PPsVOH74HvZuSxh7sbC+lnWTOBbW+N4BJOKD3wUpUei3K3H31DcDghO6bUdJkzL7WvxfgrGzz9/G2ejdaKWAzVFq69HzwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039691; c=relaxed/simple;
	bh=YFGgFVZPO4gvL4I94QxKzw7LMTFbifBp14DoIXK02zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOCPSmuP7IrACFNJ4jIgybwpT2qrRj+8K3fgxuDIqYNEoNrkioay4xIozpMe/8m2hzAC8sZXgFfWD9u8Lx/Ar/SdqrL/BMX5s/qTT8Remm635b8s00fgj+x04Snjv72d630eItMtb/Vsr/Niw1nX24hkTqG/Dh/ix8ZqRZu6s8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZIbtqNSr; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIbtqNSr"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30db3f3c907so41289731fa.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744039687; x=1744644487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+pgF1XCcw3LX396XqHvp0lR6UpYQKe9OvVkFZWMDPQ=;
        b=ZIbtqNSrkldocotfcHSutbxSeNpXPBMPZBKk7I+DW8fPBdOIqtIaijNeWtcBj1sykQ
         7HVBpHtKOJOGwHsL5U6+Pov0eDUCHhMpx4t9iQ/FB2/S3EGR5YUEfCytRTIo2Rh/0NXN
         RaJ3Ai6mQ8RTIT7sKtwOfEX1VJrOdDd4YNuukGsD/60xCQyhk/p9uDeeoiXnY0XguXrm
         Dk0AKjKj7ZUFSW6k43g1yL/daePfXAxM9rgiEbjwny6tIxT3zH3E2uB9n0hMrEqWziZu
         U4mJTSClFK/G832b2/j3MunhJzGwxvyVvZ52PNj8/CxAJlhXwys7bpBhunloFq4nLEg0
         V8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039687; x=1744644487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+pgF1XCcw3LX396XqHvp0lR6UpYQKe9OvVkFZWMDPQ=;
        b=VDoF+28HpuUykuVC2Dszc/iBkALOc5nSZhiXaj8wlfWgxlmte08S9PpYHT+Zlmi/M6
         toILx8yBl8oO5iHro58jelA7CDho9zp3r0N+/aho0MIR7sRkpwPEz6Q6lgyTjoG6CyhB
         w02Q1HWHKGsd5hTJMqswctCdFqCDkk8gFT8nDP+MX8c6/zNTfhu1GFKE9KCO0G8RWTcC
         HgXsqwIrcIUllUzSfzToov0KJAXiW3jfGl5jLsL0jN2zBubDDBgLL8bUgGBmMtVBwuAU
         BDae8jIWICnYP5h3Jv71uDw5BCM9x1/NH/l6MFCfWTQD1TVBz9AGrmo39L1t4dgUAUY4
         qK2w==
X-Gm-Message-State: AOJu0YwK0hYQ9c3ajKk0EQH0QOBFss6V8TcKPJ7Mu0Pi0oytmWXk9RPF
	YyRrkl5m0DmOozK1OyD0x5QuG6oMZkJuimBcraQot8WJ1a5GVFl2DPrDBdom6bnrjotMGruL0dw
	Y
X-Gm-Gg: ASbGnctTrAbGGPqt4ixpZs4QyiHzn1AofIXc3Evqt1CRKNtVNNkkq/a2TNJmF/ogh4E
	D+4RBFlnoKLXlfPOhnC+/ikq+I3T37DvULkO56CYY2itMvsKogNS0rOoFJnn6ygzDX+Lt+AqosB
	Z18nU3KzQYCy2w9Qm8GfFhkCe/bxeEQr5bPWj1z9vMt1wNy69CKF/CJkETrdUZOmBZ/ZUSN6LpE
	NeG6lmOurCSqIjjv1y6NYAGBzAl6CexDlApxxN2K06rFbhfqFn2XuW0xP69Z1MXzaNenR2r5g88
	JJjQ5vlm9ZYZ01/MrfQz5X8LmTlKS2tIrggB3xkZiZSdqvyJCFqD2h3no2FC9MtDBXkvzhztdFC
	Icp1qxB0hxarHYwg6k1E=
X-Google-Smtp-Source: AGHT+IGKFFXXs/zoQFbwjMJSn5/Y2OgqzEvHiVsqN6vOlmAJ+S4/vcsfkBfaBXLhJVMXv7YgnpaLyw==
X-Received: by 2002:a05:651c:982:b0:308:e8d3:7578 with SMTP id 38308e7fff4ca-30f0a1c31edmr43821991fa.35.1744039687449;
        Mon, 07 Apr 2025 08:28:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0314c62bsm16158691fa.61.2025.04.07.08.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:28:07 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Avri Altman <Avri.Altman@sandisk.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] mmc: core: Further avoid re-storing power to the eMMC before a shutdown
Date: Mon,  7 Apr 2025 17:27:52 +0200
Message-ID: <20250407152759.25160-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407152759.25160-1-ulf.hansson@linaro.org>
References: <20250407152759.25160-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To manage a graceful power-off of the eMMC card during platform shutdown,
the prioritized option is to use the poweroff-notification command, if the
eMMC card supports it.

During a suspend request we may decide to fall back to use the sleep
command, instead of the poweroff-notification, unless the mmc host supports
a complete power-cycle of the eMMC. For this reason, we may need to restore
power and re-initialize the card, if it remains suspended when a shutdown
request is received.

However, the current condition to restore power and re-initialize the card
doesn't take into account MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND properly. This
may lead to doing a re-initialization when it really isn't needed, as the
eMMC may already have been powered-off using the poweroff-notification
command. Let's fix the condition to avoid this.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Updated commit message, clarified comment in the code and renamed a
	function, according to Wolfram/Avri's comments.

---
 drivers/mmc/core/mmc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3424bc9e20c5..ee65c5b85f95 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2014,6 +2014,18 @@ static bool mmc_can_poweroff_notify(const struct mmc_card *card)
 		(card->ext_csd.power_off_notification == EXT_CSD_POWER_ON);
 }
 
+static bool mmc_host_can_poweroff_notify(const struct mmc_host *host,
+					 bool is_suspend)
+{
+	if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE)
+		return true;
+
+	if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND && is_suspend)
+		return true;
+
+	return !is_suspend;
+}
+
 static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 {
 	unsigned int timeout = card->ext_csd.generic_cmd6_time;
@@ -2124,8 +2136,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 		goto out;
 
 	if (mmc_can_poweroff_notify(host->card) &&
-	    ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
-	     (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
+	    mmc_host_can_poweroff_notify(host, is_suspend))
 		err = mmc_poweroff_notify(host->card, notify_type);
 	else if (mmc_can_sleep(host->card))
 		err = mmc_sleep(host);
@@ -2187,11 +2198,12 @@ static int mmc_shutdown(struct mmc_host *host)
 	int err = 0;
 
 	/*
-	 * In a specific case for poweroff notify, we need to resume the card
-	 * before we can shutdown it properly.
+	 * If the card remains suspended at this point and it was done by using
+	 * the sleep-cmd (CMD5), we may need to re-initialize it first, to allow
+	 * us to send the preferred poweroff-notification cmd at shutdown.
 	 */
 	if (mmc_can_poweroff_notify(host->card) &&
-		!(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
+	    !mmc_host_can_poweroff_notify(host, true))
 		err = _mmc_resume(host);
 
 	if (!err)
-- 
2.43.0


Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A328DF3E
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554212; cv=none; b=cYStIdj2qyEq9vlSD2bXLNxNPfygpJB3OlR4W/YaER4ALCa6XnCNTiY9UI9S1hEIONxf6OMUx4L/ZuO5Ay5WmSWZixp2DcFEW7Pip6peo1qEN+p2eXAcysIuXF1H4JY0lRNqOeZol5e3sDJLWAxlVCelAKuMrcrKt5gHqbNIXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554212; c=relaxed/simple;
	bh=RUnyAMGtHh+/vEL4sflSpEFAoSQObmIYvyugmKssooo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cufkDmHgxiV3g0ror23gjFZbs/24xdb7oOnGAbc47HSP3szea2bWIWbleW6zme677iE0Z5z7fF425NffVEkUb8tQIwjJUhvYC0+fLNKzaYGxPC5Y7mo1kSAOEidXCIorBcXxp9hhAILk0KtoTByZjDHItrIkXqJ9PVP+qdF3y1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fEj2Gubg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEj2Gubg"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55220699ba8so6676927e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 04:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749554208; x=1750159008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWS6iCfw+rN1nm0C9pkCk8oe46JcwKDDliTDyR8kmr0=;
        b=fEj2Gubg1GXhS1CkD/hOnUPCBm08bI3qFh3o/zUwJROXgMYYo+8o3hi8wYssqdjGLH
         V3bPoW7jN1eymaKUH0rTb3Ev+EY77Sbfcdbx8Iz4S8GvTtMcGsIdj7FvfXRCtg5QYyIm
         PHSpcRtGyH65gnsymHmoZVsNd2nF2TS7YgL5G5/ySbTyrZyyOxSV+7wsDjJPZVuXbMTz
         3HOR6Wm2hkDdvjbJcf4xy20+3Se1Ew1ZQhB9sUwGuuJEKP2gXpMlahYU6F93XVD8kzNS
         J+qrDHigdjuHNxYgO98lpbUqHJLMoYVifCpE9tENjchJwwVZdqFiFEFuEPZMLind3jmv
         ULmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554208; x=1750159008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWS6iCfw+rN1nm0C9pkCk8oe46JcwKDDliTDyR8kmr0=;
        b=o9dk2ePqEeS7nAL2Cqh+iGolGqy/DbUryxFTLMGvNYyLAXDzlb+oSpmX5rHNOovQhD
         3nXoeDKmsd6Y+zAFxw2ggZ+MIuTdh00dTTwyHKlgUfcVR+vEdIlhLOCl03+YIjIupwaC
         uqdlnbIt//JsiKGHlEd7V5wAie8yX+1kwQClclpTRhqZ4KZpq3VBe1mco6Nt3eioeKCp
         karjAPq9AYJpX2qPKsnjONO4PvkJiH0rwwnfiiFMsvDTosXuWUGmB2OLVo8Wjci4A6me
         pGWcqfp5p2OtpEoobRRboMtNlAxVeSueRpAyCN7BswUmbu7qeXpfVvOXN06W5gxJ5pnR
         ZvMA==
X-Gm-Message-State: AOJu0Ywzrr6qxTY/zLPvIRcJRnsvuYnRIF0ayDKkDL2LKCn244Zo3PK3
	GcPkWDSp4tluc9JTJM4w5uOEoadMtaorgoBy9LEDut8/zKUwqR+8Ib17nVCuPpEyXLT2mBNmIno
	a9mnVyn8=
X-Gm-Gg: ASbGncvjpdcGT6hbtuEUwTqWbB3nDhMxTcAqwPwVMqhsWxeNyuDb/L43e5iFSWf5YJ7
	HCl3eHw1P1KcFQfEIeu0PxOWcvOylgikGCfV6qKLpDlq/Om/xUjelv+Q4olgytx7/9z83wEqrPC
	az1UAUOaqTdumrP+DWx3zepe0IaMlp4fA04TT51d93qcLKC1hJc6G4ddU+6JdBAWwpPNjdXr887
	sbswfwHXT4XbgSfdLU3LTpcR8GnOH5nZBp/BaqRHedmqvFnDcEaD+Q6cQ1GB17odUTQKkJoNIor
	MhSxKohSfT8P0EdWSjStkl8CFsfUOEtyvH3NSwsswhD+qG6ozVDFW3p7boG8iTmv1ri/Abx4J1D
	ujwm8CYhlWiazioUg8MXtFR/aFdbReVype0pi
X-Google-Smtp-Source: AGHT+IHE+pv8n7aP2OaZM/clNWkmC54/7jafLxvDCyYVgdGlQISWH7wYhIrRa9Iq6Ak/oNlfAese7A==
X-Received: by 2002:a05:6512:3e06:b0:553:291f:92d with SMTP id 2adb3069b0e04-55366c38ec2mr4260599e87.57.1749554208364;
        Tue, 10 Jun 2025 04:16:48 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367722481sm1500146e87.126.2025.06.10.04.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:16:47 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mmc: rtsx_usb_sdmmc: Re-work the code in sd_set_power_mode()
Date: Tue, 10 Jun 2025 13:16:26 +0200
Message-ID: <20250610111633.504366-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610111633.504366-1-ulf.hansson@linaro.org>
References: <20250610111633.504366-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's only at MMC_POWER_OFF and at MMC_POWER_UP when some operations must be
carried out in sd_set_power_mode(). The code is a bit obfuscated in this
regards. Let's convert it into a switch-case-clause to make this clear.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index af45bac019d2..c1fdcc334c8f 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1015,22 +1015,30 @@ static void sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 {
 	int err;
 
-	if (power_mode != MMC_POWER_OFF)
-		power_mode = MMC_POWER_ON;
-
 	if (power_mode == host->power_mode)
 		return;
 
-	if (power_mode == MMC_POWER_OFF) {
+	switch (power_mode) {
+	case MMC_POWER_OFF:
 		err = sd_power_off(host);
 		if (err)
 			dev_dbg(sdmmc_dev(host), "power-off (err = %d)\n", err);
 		pm_runtime_put_noidle(sdmmc_dev(host));
-	} else {
+		break;
+
+	case MMC_POWER_UP:
 		pm_runtime_get_noresume(sdmmc_dev(host));
 		err = sd_power_on(host);
 		if (err)
 			dev_dbg(sdmmc_dev(host), "power-on (err = %d)\n", err);
+		break;
+
+	case MMC_POWER_ON:
+	case MMC_POWER_UNDEFINED:
+		break;
+
+	default:
+		break;
 	}
 
 	host->power_mode = power_mode;
-- 
2.43.0


Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD128C879
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554211; cv=none; b=j4Q9+p4ovU3DomV9a8Uajvy7N4x3wMmoKUuhgboLvIQzoKtq8IHdEvLXPxmCOld3PKBdv+Vp8nep64CplrDW1IkkIyMMMOMUYPndRFgdHHK2COoxsbyYcZleAeH310zQWVjNazRcB5H/EL7JpWzWIUaDfDUHMKkH44Wj6hNGX0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554211; c=relaxed/simple;
	bh=Q2G+6qC4eXTH3lTxHkq3eblVciHhR4sMPJfXSbMcZXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+QK06TXBPyBlBLCx+1sMztAMHF4bMlJ3wRgfPhwvf/QpRrpLemyvyqjsyCg8yLJpM8PU+gLxQconDqjGGowazSpAVzzBn35c/iPMPCeae9Ft3+gv8eoUZgiysquEkahotjkOwtwXNrA3Vs2V1cUQdbGZSti8KRjurSRbn2SB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K3Sbiz9/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3Sbiz9/"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-552206ac67aso6449931e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749554207; x=1750159007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb7O/WfyRrI7BVa8uAeHS7SpLGTdVUHqO49VpFjc3ic=;
        b=K3Sbiz9/ydJUT61nEBgHGRWgUAxRmf2A5lbQhaTtJ3lH25p2Xg+ObsJrhs0To3KtXj
         LVH5bQKcs0XdZ5Uv/2yE+lM8DT7qE8ExHJzFFpJ4qc1DiadOb1JPwlTjKv7Hem7Bgl5S
         Gxl7C6u0GMjYnrbEg3vTSNkJPKyt4yMP+lNYXSqtK1nCLKHbXkqWEP7Szp4EBPGCd/sB
         y8CMhov3xxpLh56a2mnbsu2DJ58eI9ORnvICrjxiT1bhR7FuuGgrK9DqjDxhMkM6PjIf
         dMTZJGForgji1gWABYdiNET59PUnn+XkzLlP/F/SRmNZqHKzhCnOvQp+SOdMj0cN8+cq
         LV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554207; x=1750159007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wb7O/WfyRrI7BVa8uAeHS7SpLGTdVUHqO49VpFjc3ic=;
        b=ZBES4+BrPgNQAbSHq1Ghd+0Kc9fvUJuyhJRI+56FQuyhFgTgMYI+Qbv8Wiw0S0l6d6
         H1u8T1bj7FbaEuXwoylOBpPrbVqsv85zshfbuNjp3997DVMjkxUwwFFeok/9knjNFnWe
         dCHFM7oPPcnLrBYH0L0UWbCH041aAb6gWWEC0x0tEp5YeDG/3erW7dy/xc+NdRbHstGy
         SJrM25sKz+KVFPaQVU71fBSVdLtHJT+S4grMGpgrxAEmk1Chn+zTm2EYuRdn9LYJA3qP
         I3qQm22xwNuT+PQP/gH1S+AJ+JAWAQ7uhdIytSwYy/iAg6DXTa92f3v0DCpG6ux8APYj
         zvyQ==
X-Gm-Message-State: AOJu0Yx7Kfx9PQ6ODjv44HAG6mo7pOtD/mA7F3MM0VkY5O5L1mQCKYAv
	c81sdDnhLA7i/kdCVzDA7XOTf2AsYyB1Z2uyxec8LNa+OiG4mH/cJ7qbHoB4DA7RtONWGHvVG3J
	peAe8u6k=
X-Gm-Gg: ASbGncu0KaXc10hvFY5rDcp6uuG9zhUG/Uy7cfbvJY4iFDmpqdP8lP4Q+SROYkmHoSn
	A3PXeCCTOK7JsczltP1efS+ahlCUcLhd6tXMiSonqjhGPPATON6djSCNlyZCaJQXJuEMD/Ul2UB
	h9bC7TnbbadCL1xJ3WnPNpP7z/7mOG380IChrs9VqzCQJiWPb4FCY3GZKoOyahHdj4mDtYm4Tin
	0DLU3djJ5NXt/9selsLUaT2NpPGcM87USGXpBRlMbM4lylIBp2HALa0rLToTvP3dLspYVsbbHet
	EVizFHv2hVXV99YQrTvU+T96+6u0TfDT5IUxwiDpbRZiRtcO0ilHqcgrDAOToDA84H7KOgnRv9t
	LpbgSL38t8c+qmOe341KnTgD6knZttUG6C1DP
X-Google-Smtp-Source: AGHT+IGcJjeSLPZhPYZFF9acT9CaBa+tleHeWD/nvlbTe8RESEGmC/LAyYSFCjwYD71GvdSbOrVrtw==
X-Received: by 2002:a05:6512:3b82:b0:553:5e35:b250 with SMTP id 2adb3069b0e04-55366c0262bmr4758736e87.32.1749554207032;
        Tue, 10 Jun 2025 04:16:47 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367722481sm1500146e87.126.2025.06.10.04.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:16:45 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mmc: rtsx_usb_sdmmc: Convert sd_set_power_mode() into void
Date: Tue, 10 Jun 2025 13:16:25 +0200
Message-ID: <20250610111633.504366-4-ulf.hansson@linaro.org>
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

The sdmmc_set_ios() is the only caller of sd_set_power_mode() and it
ignores the return code. Let's therefore convert sd_set_power_mode() into a
void function instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index c204cdeaee3e..af45bac019d2 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1010,7 +1010,7 @@ static int sd_power_off(struct rtsx_usb_sdmmc *host)
 	return sd_pull_ctl_disable_qfn24(ucr);
 }
 
-static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
+static void sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 		unsigned char power_mode)
 {
 	int err;
@@ -1019,7 +1019,7 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 		power_mode = MMC_POWER_ON;
 
 	if (power_mode == host->power_mode)
-		return 0;
+		return;
 
 	if (power_mode == MMC_POWER_OFF) {
 		err = sd_power_off(host);
@@ -1034,7 +1034,6 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 	}
 
 	host->power_mode = power_mode;
-	return err;
 }
 
 static int sd_set_timing(struct rtsx_usb_sdmmc *host,
-- 
2.43.0


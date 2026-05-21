Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788D43612F3
	for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352527; cv=none; b=FJ7QPruIcH8MEXJiPTIqJbmEyOtdscAsqs82jh2MNUeGAj1QsI/SAFGYtJw9Y9rYb9L8Qpr9NTI7MlkwQ6UDny8QsDg/4MxeTrX9hDYAawzI2vq+rnSlpo4KlzTfjaW5+GTCthPcIwoKTr3D8xxtVmS4A1VQ5VRwKO37e64+i5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352527; c=relaxed/simple;
	bh=Q+haSKFB1SdpIbkH4xTiI2J7bQfg7b5S9UPBCsuRI/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0dVtFl93JWPLiRPiC+W8XspVXxvg2rqe3SAB3srmTzTaXreVbrWVZyf2K+mvdUi86eUYK9KeNHqcQZji7etAas1eWJVpWewOewhQI6eVDWSIVgbSJUiLchcPVZnTBEfoJUbnTZeXRk2VJ5znaiqeVMepZgbPUzThYFfjutKqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR9Bqo4q; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR9Bqo4q"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39556b00a85so49025461fa.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779352523; x=1779957323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCn2qEYWfhjJsuia41fA60ypMxY8rzylIJyZCEZboB4=;
        b=OR9Bqo4qnnsjb+aAe9c91SGtyL/10tIWalPgiWRe3BfhiDGSAtvH+JqIKSHcBVHjwi
         PfYcvb4qqF/lms26EhlpxyryR/QvFhmvLpXAK3M5vNbM2CTDRPk8hVeYZr59NbhzQRFk
         QI+AJaNADGtTzOhd16lDXSAIMEto+cXJQ5Gy7e+gmb7r3oWGh/WQaHHtl9VQvtJluPgG
         kHiZfVH48zFu3NrouAbOwcs+UIkuJ5bkTL7ZgLcnkfXoNIcrZkbJWznpVM7mfM69ldFD
         cdvI3orJgIBzzZMn1GA9RdHH6NYw0+tKdxb8hQ7WNyrRjGihBPU1qzj02fcosid8/rZd
         yiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352523; x=1779957323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCn2qEYWfhjJsuia41fA60ypMxY8rzylIJyZCEZboB4=;
        b=LAE1GA9kXtlcSLwgbciugmbN/6PrS2MGT7VOnrJZJoSUbV6ykqVsFHd5gTrul2LQXx
         MTjO3iqGjxGLr5i85PVccei/cRgAM1uqdLsJyy322//HhXYfLW5HnjA1U6oqllZvrV0K
         WGx3FsdGbgfAzD7Lo61Z4GnvEAcbyn4IKrRH18i6R4AU+XLM3Ab6gNWbgYJG758i+sqi
         +nH81TtqHK1aDtA4obqAO3fBJWxWd0PiZn3JZ7IqphVP9YUNMB+CSS/de06YxzjhfA57
         aIwgXZQcWDz9yiNGqPQA3H5MQUQr1ppxn7BvUeksiRid2SWOzYe9qnxZOnm1TBmK14yI
         3g6g==
X-Forwarded-Encrypted: i=1; AFNElJ+6RPTL63gcJnJsF4w44w36gOept250O/n8thYf2XZbRAFRLcMlhSiF6XePjMBn73m4/b2KXEzySmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPKJVoPSM5770Uq06VCJgC8RrJFP0z5d3sCiQwmgoPJXxjRVE6
	SpKL4V16Nq2B/+n759Tdzxliflr57fsS3+w4pa8Z2/QLnstqztsSXsPi
X-Gm-Gg: Acq92OEeCiBXjfHwqNY+Igx4ZZTOC60d5bNaX6EutCUQUJA3PRDB6FZUfyQ7yZ3IpEC
	gYx2fUsRdCiPr85/AgmOGBV/TdeoGJetqnq5869HB+VxLFUIJ9VM8xH+ZxgSOjLLM874aEnBc6b
	nDTWR/phhXcG81/YRjP5sqUKL5pSrxNITeAeDuXR3DfDcjhiqDTdpKGdApjhdrtgOJbysQ/oTAw
	zZteAo6e2x8LFHIYOn1bjzyhxiD6I7EIMoxVTDQaIy/MZzer/4tYCtwGF6dDutz4OZPaAoxlDTi
	lpTW4au+x7qwAYZuUEKmRWFwXP5h22oLzh6QKZJeyFsc1DqaemYwf1MxgjhFsF1DBl0jAnbGwjU
	a1/QuMj/P3t3NVL7uIGoygEzsKPo6IQ4XUEXcqr8UzsveoIJPd3KWelv4RcP/Rx/9iIKwU2sDg7
	F1EIoO0okYAbLHPy68fzLl6PzBWhM/3+/jmayfZ3ed
X-Received: by 2002:a2e:a582:0:b0:395:b668:44b6 with SMTP id 38308e7fff4ca-395ca24eeb4mr7281861fa.4.1779352519360;
        Thu, 21 May 2026 01:35:19 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([91.132.132.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395d0b68afcsm917611fa.32.2026.05.21.01.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:35:17 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mmc: sdhci-of-dwcmshc: improve delay and sleep handling with fsleep()
Date: Thu, 21 May 2026 11:35:02 +0300
Message-ID: <20260521083506.356422-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521083506.356422-1-a.shimko.dev@gmail.com>
References: <20260521083506.356422-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace usleep_range() and udelay(1) (for consistency) with fsleep()
in several places to follow kernel documentation recommendation [1]
of using fsleep() for delays in non-atomic contexts.

The fsleep() function automatically selects the optimal delay mechanism:
udelay() for delays <= 10 us, usleep_range() for 10-20000 us, and msleep()
for longer delays. This makes the code more consistent and simplifies
future adjustments if delay durations ever change.

[1] https://docs.kernel.org/timers/delay_sleep_functions.html

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 0b2158a7e409..4cccd6e42e60 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -816,7 +816,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 
 	/* Reset DLL */
 	sdhci_writel(host, BIT(1), DWCMSHC_EMMC_DLL_CTRL);
-	udelay(1);
+	fsleep(1);
 	sdhci_writel(host, 0x0, DWCMSHC_EMMC_DLL_CTRL);
 
 	/*
@@ -895,7 +895,7 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	if (mask & SDHCI_RESET_ALL && priv->reset) {
 		reset_control_assert(priv->reset);
-		udelay(1);
+		fsleep(1);
 		reset_control_deassert(priv->reset);
 	}
 
@@ -1136,7 +1136,7 @@ static void cv18xx_sdhci_set_tap(struct sdhci_host *host, int tap)
 
 	clk |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-	usleep_range(1000, 2000);
+	fsleep(1500);
 }
 
 static int cv18xx_retry_tuning(struct mmc_host *mmc, u32 opcode, int *cmd_error)
@@ -1490,7 +1490,7 @@ static void sdhci_eic7700_config_phy(struct sdhci_host *host)
 		val |= PHY_PAD_RXSEL_1V8;
 		sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
 	}
-	usleep_range(2000, 3000);
+	fsleep(2500);
 	sdhci_writel(host, drv | PHY_CNFG_RSTN_DEASSERT, PHY_CNFG_R);
 	sdhci_eic7700_config_phy_delay(host, dwc_priv->delay_line);
 }
@@ -1520,7 +1520,7 @@ static int sdhci_eic7700_reset_init(struct device *dev, struct eic7700_priv *pri
 		dev_err(dev, "Failed to assert reset signals: %d\n", ret);
 		return ret;
 	}
-	usleep_range(2000, 2100);
+	fsleep(2050);
 	ret = reset_control_deassert(priv->reset);
 	if (ret) {
 		dev_err(dev, "Failed to deassert reset signals: %d\n", ret);
@@ -1565,7 +1565,7 @@ static int sdhci_eic7700_delay_tuning(struct sdhci_host *host, u32 opcode)
 		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
 		if (ret) {
 			host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
-			usleep_range(200, 210);
+			fsleep(205);
 			if (delay_min != -1 && delay_max != -1)
 				break;
 		} else {
@@ -1736,7 +1736,7 @@ static void sdhci_eic7700_set_uhs_signaling(struct sdhci_host *host, unsigned in
 		 */
 		sdhci_writew(host, 0xffff, PHY_DLLBT_CNFG_R);
 		sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
-		usleep_range(100, 110);
+		fsleep(105);
 
 		ret = read_poll_timeout(sdhci_readb, status, status & DLL_LOCK_STS, 100, 1000000,
 					false, host, PHY_DLL_STATUS_R);
-- 
2.43.0


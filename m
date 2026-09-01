Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BA15E5DC
	for <linux-mmc@vger.kernel.org>; Tue,  1 Sep 2026 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223100; cv=none; b=XyKHDb7cK+d2Zeq1e/0asVsixE+i2AjaY+koMfH4607VpUfxanznDMpPVoh9RI2rgGf4rGEXXfiyZUT30xKjbZAEldvZOCYCU9ZA/bR3N1ZZ/9C6CBlckR3iVXodbyEUtCeQWJSrACjkUfBPbp7ylQkkyidy9WSwQRAiqNCd0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223100; c=relaxed/simple;
	bh=gPjNpDBNZpS4nNBac1YecZcI16rt+NY/MB+mg/m7tv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V72y59KqZkWg+ikfol6/a3pXR66kE3Az8N0ANky7V8E9n2gNk3AjuoAx34lBGRAdpmgYDEvEBIwan4JGbCie070It8lDPpsVcDfDGm2Dl6+Qq5+eT3T++PPBiprGAmD7Qw82HMxOrLyJQnyTp+yPbWt2H85wTAysOtbSDCwdNFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI4YtpdT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI4YtpdT"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1ceadbd16so4509300a12.2
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2026 17:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788223098; x=1788827898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k30Rohc+2WDZFezLd1Hggkn12iWJGk2wvx7B05pG0n4=;
        b=WI4YtpdTHz9XTX8tGV40K2VLXO39pCGDqTGmk1snASWNCBsTySQeprbrorBpq3EGGC
         +VUFaaW9OfjQI0X9YpSAUT4E6BoDIaHfwy//kuUILLA4iLoFyWUbkBIHOLAiR62bHR+M
         hxv6SlHBFYF3YzCczPqz4L2UxXsF0Wie56LUGcV3MFNoLgVnjp/8AFbDg7amXVqzm8jo
         QyNcWjGvo8Z/u8SMiPxH77x023FC7bCBR5B+hlMYkZ8OR23dMbl1677c/4LzkmW/Ce6/
         3m0aGl4hM4xrG0TLPsp/PZ9wvyMvrKzW5eTQVoBlqFcB5nXphRFh1NwVFmzIsr0Er2ZJ
         WEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788223098; x=1788827898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k30Rohc+2WDZFezLd1Hggkn12iWJGk2wvx7B05pG0n4=;
        b=dHL06v6JSLa1Sm1A2Frvc96bYxkpjVgVulc3veAhfX3mo2IcZFxuGntm3YXOH8mXW6
         jOLvVpImWeZLzLlA8dlfZCg9FhjV9So0KLlF4UfqdtTekdBH5lbaroQT+8CYvgggaJXL
         dBKW5PcEjE7BzJb5hmGeClWHqZ6FJM2CvgTrxxneyHOBwm8qJ6v3SctL4iaV1bHUImKR
         JP6TaGL7xPCHZ/k3I3h1MPFuWLw9bQKezuvrEAi1AQiF7XZbnsxv5a/QJWgBNsrrqRYp
         +Yq/uhJOpKNJ6xq9qIPRLiKE99C3/PA7My7X8jQVaPVeorN3VaQXJLiGhFMo26QOB6uy
         9m5A==
X-Gm-Message-State: AFuF++mMM8qbtFJHlpA9PJ6/8wcTOQqEdZZbCy6pgBklfy2reUR5vs1X
	oIStYMcgj8+cHWpvkYWnm9B9/lt2T3761qS+36DtZoaIKyHEP6in4oYyW3VTQA==
X-Gm-Gg: AR+sD109O9GkI63SHlZY2iiu59wu3Ok5K8RnlGa9WrTcNTbhwHNMW8HKscoKuMUnQ7L
	jns37B1ISetUvqsBvmBAql8EJTzeyTguAMim8N7vH4ERXstbhDHovx508T66ASS7B9CYzJf1pR8
	JKkvPDD4ATiWY6F5tfrQQj+ockqQ5aoQail3kvge4wBq8qkZccT2R/MpwhGvwl7kkWOLx0305tB
	/Kl2XXiRjiAHEYOmMeQ6qFVibFJLfg8GfzipfSWoHEH+aXmbDQkHSmTsTF205gMllNs7b8MxN/g
	Cmq9zdebHqK2Yfa+jKU/jowWLLPWno9gWjLFYFHvXajVaBZDBFjyWb/dkeLDNVSHBTt/ySZUlol
	An2OXZxVr8cFx6e+XJ+9Ui7t5qTKbaIwftlT9tQ693kzVQVu7QyRzxUMH8uP57L/HNmVAmDsDjn
	fzG/N7cjKaJKripIxrHSBX41VMNmlQd7p+4rYrRmmb32Z9+W5QNuT7axmT2J0aALd7S9hzJwAPf
	xqn6gZT8kbHhCvBy8LxQhPF99G5eMJSbw85p01bn08pch+P9ftqwE59hqPjP4R+rOVU15NnBllf
	tvZWMe4YmiP63yQNR7dHRV6aLjVjpS0QGj4RPg==
X-Received: by 2002:a05:6a21:b8f:b0:3d1:54ef:e8e4 with SMTP id adf61e73a8af0-3d2688bd7cemr48699834637.17.1788223098169;
        Mon, 31 Aug 2026 17:38:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36aff95sm5000067a12.20.2026.08.31.17.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:38:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mmc: sdhci-pxav3: disable clock inversion for SD HS cards
Date: Mon, 31 Aug 2026 17:38:16 -0700
Message-ID: <20260901003816.48460-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SDIO3 Configuration register branch of pxav3_set_uhs_signaling()
only clears the clock-inversion and feedback-clock bits for
MMC_TIMING_MMC_HS.  As a result, MMC_TIMING_SD_HS (ordinary SD High
Speed) falls through to the default case, which sets SDIO3_CONF_CLK_INV
and leaves the feedback clock cleared.

According to erratum FE-2946959, clock inversion is only needed for
slow frequencies when the card hold-time requirement is high and is not
required nor desirable for high-speed modes.  SD High Speed runs at 50
MHz, so the same timing argument that applies to MMC High Speed holds.
Treat MMC_TIMING_SD_HS the same as MMC_TIMING_MMC_HS and clear the
clock-inversion and feedback-clock bits for both.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index db9dfa92cb57..9e6703e005e2 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -284,7 +284,8 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		    uhs == MMC_TIMING_UHS_DDR50) {
 			reg_val &= ~SDIO3_CONF_CLK_INV;
 			reg_val |= SDIO3_CONF_SD_FB_CLK;
-		} else if (uhs == MMC_TIMING_MMC_HS) {
+		} else if (uhs == MMC_TIMING_MMC_HS ||
+			   uhs == MMC_TIMING_SD_HS) {
 			reg_val &= ~SDIO3_CONF_CLK_INV;
 			reg_val &= ~SDIO3_CONF_SD_FB_CLK;
 		} else {
-- 
2.55.0


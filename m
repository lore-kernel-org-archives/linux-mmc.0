Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6284314D13
	for <linux-mmc@vger.kernel.org>; Tue,  5 May 2026 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988263; cv=none; b=s+Ulnvw724omNw1yVG1i+I99BnYEZ/cipfFg44EPHhm+rj8XqFxqu43A/rYwmJvMK+GD7ewQoC8EKmiOOG24DjdTihuxBdBHNvSz0cf5Ns9za3syKtAdWsPCcY6CjSrjHA+7dd0V8FkZaS+TJvu9ayCDDEoRH6DZzOUQozpKiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988263; c=relaxed/simple;
	bh=9w4dkmpnUTPgPef44NQpN+loUArr+6ep1thmIbJGQtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aN6+2a60fN2xecPo753hx0tAZjLMm5u2/IxMb6Vxj0o6sBS330obG9YQZ4PgRfiwN/RBds43wZF5IESwXbpPESnU6Kw4TJHXPq5lAZMpDnrMsNj2l4ckzYvtFwLx8nEtvWPSJPbaWXab0qzTpo2UB6HLf3atOwoplwRX2+BJ7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYVIUGMJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYVIUGMJ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso28001535e9.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2026 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777988259; x=1778593059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UOXS6al4LhNZR5XdmgsqkE6gRGeNvrPx5pbBclC1clU=;
        b=XYVIUGMJu/prLPHL22/gjadrq9k4BDypwfFuqpBNmt/4qM4xBXOJ7qlWA1SjTEddci
         wtBnBBNLppZdeMvhVGAY10rrPqeOJKkEfYn/b9URQHvNdQAjwRUOQ873TKZ0WEZIzVmn
         2cwKuxRpmfI4VobTONNptYPSrQwMv2IN4GxIXXe/M637ykRMyuRa/dnGhps0mDKTv97t
         vcVU1u6kMAUdueSXbzl0EcUWxeevuZMMMG4qB4LvQ6xSIIRIO/0Om2FdMywpdMZt+Xcx
         Sgq0RcoZh6TS21gjHX3bQkerlv0W8xgMK0UgHorrRZhxcCk7CWMladJqLrAkzu51M5Ih
         rUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988259; x=1778593059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOXS6al4LhNZR5XdmgsqkE6gRGeNvrPx5pbBclC1clU=;
        b=avauogqDUjsOvPsPrT9DtpOx5yrFu3OfS2G3Q53+ogsZV5sKLiZ9+tyUXiE8aYuubv
         KIKSekC6YCSLG8dkiiYNLgVRtCueRV/px6qF2SASR8v2JsZYZDki2txoAqY4xlNcxxZ5
         Pn7xjR8wfQYHT0mJZxoIedjwQ5zc8zOIErldExVfm3opO0KT4CVqSyCSm4RveEYYuaq6
         /Np470KuqZ1+hC/XK0lnjZmgljaNw2MJ/bk6KQcBBXIihpNYvDwiz8B1v6Ey04vuTC/U
         J9Nfutw6LkU5VwPEVLZR4k/MZ0QpOrhpO7/4edUjA/fI74DFZ2yUaMK6FABscmWu9f3D
         SD/g==
X-Forwarded-Encrypted: i=1; AFNElJ9o6vs66siUL8Y5atD4hd0KTM+qDYegSs3gubAfUqdMCAAheg/dalrlpv0T3/Ki83poYbYdsyoTLIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVNJX9MlI0f6i/FE9LOJSp9i6e/vRyvo610ANCYDOUm+MZXjcZ
	q22vDFHm15ZhV0AfzeenrqB69ywhMulY8AVzEV/cRYYNh8F+ppxTwao8
X-Gm-Gg: AeBDietIO4nzISuJNXOKNd3mClFWz+YYsG7qO8KRVHBuQmZMcfb/BNaXVY4NeL4ZvdW
	+sy7jH4gTd82h7zDtOW64J2uHRtPEFNZlVyuT5/hP6L33xeuEgAsXedtjyV0AE6UUxcPdou1NPB
	94SD1RLreHnbP3MKukyD0W9ilODf39038bRLC3c7lvytKor8ic4SWRL+IwzGBQyoR6mgxxhI8ik
	L5uemTs2jBnhA5e96lfIHFYdT/V94/xNrCvNrWgetEzh5R13RutOYFdZOhhI97Los37OuyXyd3g
	uyiFtyL0WGsrykh6BgVFOr2O6ZKFljhWR5cFAdQwvO9PxJBV5bb2jvY2QM2i04AcmGIVs9cy1GR
	Vu/pa81XU4a4jawQq/pvTyZ3fBpJScC8Z16Ila6mHYYuUz0HzBOjadvKwugs7CDvhQLuROq/2dv
	X47uJQ1pPSkeBi6OJDRBOaqOTpMyvp3GBANA==
X-Received: by 2002:a05:600c:a412:b0:48a:7965:b92a with SMTP id 5b1f17b1804b1-48a988ccc9fmr179745355e9.26.1777988259098;
        Tue, 05 May 2026 06:37:39 -0700 (PDT)
Received: from NB-6746.. ([91.132.132.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm316281635e9.10.2026.05.05.06.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:37:38 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Jisheng.Zhang@synaptics.com,
	hehuan1@eswincomputing.com,
	andriy.shevchenko@intel.com,
	yifeng.zhao@rock-chips.com,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-of-dwcmshc: add reset control support in suspend/resume
Date: Tue,  5 May 2026 16:37:29 +0300
Message-ID: <20260505133731.383544-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver currently handles reset control only during initializations,
but does not manage the controller reset signal during system
suspend/resume. This can leave the hardware in an undefined state
after resume. Additionally, the reset control is stored in vendor
structs making it inaccessible for power management operations.

Move the reset control to dwcmshc_priv structure and add proper
assertion during suspend and deassertion during resume. The
needs_reset_on_pm flag to control whether reset operations are
performed during power management transitions, as not all platforms
require or support reset handling in suspend/resume path. This ensures the
controller is properly reset before entering low power state and correctly
reinitialized upon wake.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---

Hi,

Move reset control from vendor-specific private structures to the
common dwcmshc_priv. Introduce a needs_reset_on_pm flag — platforms
that require reset during suspend/resume set it to true. When the
flag is false (the default for all existing platforms), the PM path
behaves exactly as before, preserving full backward compatibility.

Rockchip RK35xx and EIC7700 do not set the flag; their suspend/resume
behaviour is unchanged.

--
Regards,
Artem

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20260415123411.437450-1-a.shimko.dev@gmail.com/T/#u
  v2:
    * Added needs_reset_on_pm flag. The flag defaults to false,
      guaranteeing no functional change for existing platforms.

 drivers/mmc/host/sdhci-of-dwcmshc.c | 47 ++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 0b2158a7e409..cf9be59f79c5 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -279,12 +279,10 @@
 #define PHY_DELAY_CODE_SD		0x55
 
 struct rk35xx_priv {
-	struct reset_control *reset;
 	u8 txclk_tapnum;
 };
 
 struct eic7700_priv {
-	struct reset_control *reset;
 	unsigned int drive_impedance;
 };
 
@@ -297,6 +295,8 @@ struct k230_priv  {
 
 struct dwcmshc_priv {
 	struct clk	*bus_clk;
+	struct reset_control *reset;
+	bool needs_reset_on_pm;
 	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
 	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
 
@@ -887,16 +887,15 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *priv = dwc_priv->priv;
 	u32 extra = sdhci_readl(host, DECMSHC_EMMC_MISC_CON);
 
 	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL))
 		cqhci_deactivate(host->mmc);
 
-	if (mask & SDHCI_RESET_ALL && priv->reset) {
-		reset_control_assert(priv->reset);
+	if (mask & SDHCI_RESET_ALL && dwc_priv->reset) {
+		reset_control_assert(dwc_priv->reset);
 		udelay(1);
-		reset_control_deassert(priv->reset);
+		reset_control_deassert(dwc_priv->reset);
 	}
 
 	sdhci_reset(host, mask);
@@ -916,9 +915,9 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
 	if (!priv)
 		return -ENOMEM;
 
-	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
-	if (IS_ERR(priv->reset)) {
-		err = PTR_ERR(priv->reset);
+	dwc_priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
+	if (IS_ERR(dwc_priv->reset)) {
+		err = PTR_ERR(dwc_priv->reset);
 		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
 		return err;
 	}
@@ -1504,24 +1503,24 @@ static void sdhci_eic7700_reset(struct sdhci_host *host, u8 mask)
 		sdhci_eic7700_config_phy(host);
 }
 
-static int sdhci_eic7700_reset_init(struct device *dev, struct eic7700_priv *priv)
+static int sdhci_eic7700_reset_init(struct device *dev, struct dwcmshc_priv *dwc_priv)
 {
 	int ret;
 
-	priv->reset = devm_reset_control_array_get_optional_exclusive(dev);
-	if (IS_ERR(priv->reset)) {
-		ret = PTR_ERR(priv->reset);
+	dwc_priv->reset = devm_reset_control_array_get_optional_exclusive(dev);
+	if (IS_ERR(dwc_priv->reset)) {
+		ret = PTR_ERR(dwc_priv->reset);
 		dev_err(dev, "failed to get reset control %d\n", ret);
 		return ret;
 	}
 
-	ret = reset_control_assert(priv->reset);
+	ret = reset_control_assert(dwc_priv->reset);
 	if (ret) {
 		dev_err(dev, "Failed to assert reset signals: %d\n", ret);
 		return ret;
 	}
 	usleep_range(2000, 2100);
-	ret = reset_control_deassert(priv->reset);
+	ret = reset_control_deassert(dwc_priv->reset);
 	if (ret) {
 		dev_err(dev, "Failed to deassert reset signals: %d\n", ret);
 		return ret;
@@ -1780,7 +1779,7 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
 
 	dwc_priv->priv = priv;
 
-	ret = sdhci_eic7700_reset_init(dev, dwc_priv->priv);
+	ret = sdhci_eic7700_reset_init(dev, dwc_priv);
 	if (ret) {
 		dev_err(dev, "failed to reset\n");
 		return ret;
@@ -2563,6 +2562,9 @@ static int dwcmshc_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (priv->needs_reset_on_pm)
+		reset_control_assert(priv->reset);
+
 	clk_disable_unprepare(pltfm_host->clk);
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
@@ -2593,18 +2595,27 @@ static int dwcmshc_resume(struct device *dev)
 	if (ret)
 		goto disable_bus_clk;
 
+	if (priv->needs_reset_on_pm) {
+		ret = reset_control_deassert(priv->reset);
+		if (ret)
+			goto disable_other_clks;
+	}
+
 	ret = sdhci_resume_host(host);
 	if (ret)
-		goto disable_other_clks;
+		goto assert_reset;
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_resume(host->mmc);
 		if (ret)
-			goto disable_other_clks;
+			goto assert_reset;
 	}
 
 	return 0;
 
+assert_reset:
+	if (priv->needs_reset_on_pm)
+		reset_control_assert(priv->reset);
 disable_other_clks:
 	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 disable_bus_clk:
-- 
2.43.0


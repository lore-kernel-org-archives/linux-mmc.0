Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B160E19F137
	for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256459; cv=none; b=CPgdEPI3BBdSQFJ+XlDaV966UonEJBNXjoAq1rBfzfG/SDiVxMb26YFH7MhP075ne4P3KOjfSuq5Hjt1QtLGdDewyaAdeIQukrmWXcz8oyc365xw1xXByEM8M05XJ6Guo51cemuAn7PTK22o/EDr36FFNymTli2jbYL/inATaMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256459; c=relaxed/simple;
	bh=Ls9GAreIYzYNfQFK7hdolvY4/Wi1nFjCA/U8eDkQGtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsqPXa2l5Nu8HpQp7YPv6f5ugvig5EQ2qlvkU6obB9KMmwlpvXs0QYZmrfI4PLsrhUJvbBB/4w7jzlJcvUs/YKmXS8xVGho48d/x7uyjxFNpVT+FWQZNSNkt+riZ3ZsGE2Pg0bHT0DBDOaeHMviGaJoEzAhlbDMwoIpl9jyWhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQMzSUwU; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQMzSUwU"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d880e6fbbso62754671cf.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 05:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776256456; x=1776861256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EzcnPzwC7M4/PB4hXWEUeSQFZO8O4+DKyxgVBJ78iek=;
        b=SQMzSUwUSV4PbleH8i3/yiYHpGkFVi/wC8YQRi8Ivu7jQmcp1nEiO/nMmyiae22ijB
         +b6DMOp/hUo4oB7246fCoaKLCCL4c3TWV7U+B9vON3eNUorXgZO2XNFctkM5h/1ocYou
         v0aRKcl5IjqiYbQn6vCVsGT1BPXKb5++wWVQMCdTY0WJ/H1seH12XCnHmzIe03xFKDfI
         lcw+X4QlyFojCJVLWHDBoOfQ3BFrn4Ro6osHntHLQOPgvxMw8MBtBB+EXz3yOWcAoCha
         75R5aMQbLsRmT+DEmEaOP26+UQlWOvVdBxNERHaU6Ss9hTgHpGKB/2gKDK1gv52g931q
         Y+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776256456; x=1776861256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzcnPzwC7M4/PB4hXWEUeSQFZO8O4+DKyxgVBJ78iek=;
        b=bx6O56G4YfSZ3fcdqgf+ZdUaflPQH2n4QZUGOlhr5Y0HMB1hUxPQbV6pVZlGNg0JGr
         aJklcCy0Bw6lh1yQlopn2bxUVmnlp58Rz+WlQs+lG1PxVYqYqioeyMu6vV/wXGaUBYkC
         sINEYitCf610naMSQL12/qUgpLTW+IVJQ4kWfHaV4flWuJQCZ+RpmyM45MzTrLjA+k5g
         PFG9StBdCmX4MqUl1zMKYhf8Pe/BzO6vKU4VHnKdjCWMpGKwSbPeyyRSw0z5ZBE3sfGT
         ZHxfcqjPg2cT9nrnWiVwLXL9nZMBD67N+kRCnsz6RAXEJ2/bJAkOiWKVOaKF0sytJWZN
         A2Ow==
X-Forwarded-Encrypted: i=1; AFNElJ+VqVEb8/RY8z81SPmPhr4MEtpbyClDe+c4bU9+5Bq/k2ZZkxakkvkfKPJ2fDEHsf6XZZUX2O5Yk8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzup/y1Xj614Br7u1jlitDzQBsWHFfVJAyYa9nUTdpTeaJZXrbD
	vyPLMIsdA8g4r8QqTNLsZ5HMPO2Ar7cCJw2usB70Yi6yk4P0QQZx2h3f
X-Gm-Gg: AeBDieutLjroWbJmsvt1l0F1CUWUkcgWfrFwrNQlheYzqXri/6eNIxRR4z5KJ66wgyF
	1V3UPteAfcyO2rW+vujXDluOR09xVoRm2RcwICEm/QTT04rySMglUnu+AqddHHngisvmV94NgYl
	8E5xYrQfqNlC/kDRGF3fdtWbDCtaI5N39xanG0oPWz4/aigBCC8eG/f8NiR6fLUGaTVu6tfmh/2
	F4MPOrF1UtFfRJlm1l1UCzzON6BH2vmgOyJgHfC4ovetkOORWUJ1bXzfrP+ooe165SEWNuq45Dv
	AonQe1BOPGzZ4FLCprBvZUXmqXkDZgoHoehHP9ZnqToGoLDpWLkZU9dJc2E0IJ9BNtDcx04Y/ZP
	OQi8gRhbN2IgAg8BS5h8gOp7Tkrp9pkcv/h8f2MYhc1py84xQs7AfdfQSAWzIMZsx8dfPBSZkGK
	tNHGwtwVsV1d+sUSfkv/8M/4cf8Q==
X-Received: by 2002:a05:622a:60b:b0:50b:29da:ec58 with SMTP id d75a77b69052e-50dd6aa7341mr280997571cf.8.1776256456452;
        Wed, 15 Apr 2026 05:34:16 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e21f8eb5csm2481421cf.8.2026.04.15.05.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 05:34:16 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	Jisheng.Zhang@synaptics.com,
	hehuan1@eswincomputing.com,
	yifeng.zhao@rock-chips.com,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-dwcmshc: add reset control support in suspend/resume
Date: Wed, 15 Apr 2026 15:34:10 +0300
Message-ID: <20260415123411.437450-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently handles reset control only during initializations,
but does not manage the controller reset signal during system
suspend/resume. This can leave the hardware in an undefined state
after resume. Additionally, the reset control is stored in vendor
structs making it inaccessible for power management operations.

Move the reset control to dwcmshc_priv structure and add proper
assertion during suspend and deassertion during resume. This ensures the
controller is properly reset before entering low power state and correctly
reinitialized upon wake.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---

Hello maintainers and reviewers,

This patch adds reset control support for the MMC controller
during system suspend/resume.

Currently, the reset control is only handled during initialization and
is stored in vendor-specific private structures. This makes it
inaccessible to the common power management code and leaves the
controller in an undefined state after resume.

The changes move the reset control to the generic dwcmshc_priv structure,
update all platform-specific users (Rockchip, EIC7700), and add proper
reset assertion/deassertion in dwcmshc_suspend/resume.

Kindly, please review.

Many thanks.

--
Regards,
Artem

 drivers/mmc/host/sdhci-of-dwcmshc.c | 43 +++++++++++++++++------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 2b75a36c096b..aca176d2c809 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -258,13 +258,11 @@ enum dwcmshc_rk_type {
 };
 
 struct rk35xx_priv {
-	struct reset_control *reset;
 	enum dwcmshc_rk_type devtype;
 	u8 txclk_tapnum;
 };
 
 struct eic7700_priv {
-	struct reset_control *reset;
 	unsigned int drive_impedance;
 };
 
@@ -272,6 +270,7 @@ struct eic7700_priv {
 
 struct dwcmshc_priv {
 	struct clk	*bus_clk;
+	struct reset_control *reset;
 	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
 	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
 
@@ -829,16 +828,15 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
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
@@ -863,9 +861,9 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
 	else
 		priv->devtype = DWCMSHC_RK3568;
 
-	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
-	if (IS_ERR(priv->reset)) {
-		err = PTR_ERR(priv->reset);
+	dwc_priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
+	if (IS_ERR(dwc_priv->reset)) {
+		err = PTR_ERR(dwc_priv->reset);
 		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
 		return err;
 	}
@@ -1331,24 +1329,24 @@ static void sdhci_eic7700_reset(struct sdhci_host *host, u8 mask)
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
@@ -1607,7 +1605,7 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
 
 	dwc_priv->priv = priv;
 
-	ret = sdhci_eic7700_reset_init(dev, dwc_priv->priv);
+	ret = sdhci_eic7700_reset_init(dev, dwc_priv);
 	if (ret) {
 		dev_err(dev, "failed to reset\n");
 		return ret;
@@ -2122,6 +2120,8 @@ static int dwcmshc_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	reset_control_assert(priv->reset);
+
 	clk_disable_unprepare(pltfm_host->clk);
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
@@ -2152,18 +2152,25 @@ static int dwcmshc_resume(struct device *dev)
 	if (ret)
 		goto disable_bus_clk;
 
-	ret = sdhci_resume_host(host);
+	ret = reset_control_deassert(priv->reset);
 	if (ret)
 		goto disable_other_clks;
 
+
+	ret = sdhci_resume_host(host);
+	if (ret)
+		goto assert_reset;
+
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_resume(host->mmc);
 		if (ret)
-			goto disable_other_clks;
+			goto assert_reset;
 	}
 
 	return 0;
 
+assert_reset:
+	reset_control_assert(priv->reset);
 disable_other_clks:
 	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 disable_bus_clk:
-- 
2.43.0


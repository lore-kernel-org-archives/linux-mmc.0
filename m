Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F66FBF;
	Fri, 19 Jul 2024 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378750; cv=none; b=Hi1TOI91WtsCdsOJcQ3Jwt8k4qByjBreZFGuFH8mwPBo9qlmR3wtszzpqAhb9PHP0RCgEFAdsgH2O9jPvZzg0/TgQFTYmDEzPjVBQSdJOyV3iTcGPqtGsXW3Zs7Y443A0Fdq7PAPbe/IscWbG6kcHh8pLle3HbyNx/l2BCAqbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378750; c=relaxed/simple;
	bh=nNoc3/cP1tijMwGy0aKfr+zIHNN+M8a3TCPwlGft7sI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bt6dHEPNpyxuShsSZGjcgBKIWleoV1rwf+O+KWVhTXLQgi2Jx0Lnwrk4F6x+ZYtVNJD3dD5tfk1AFuZgzm6ZWDOGoRlamGP/tAkvwmno5y81NlmtrKnaodIP/WF4IQjkYicHEL82/0nhC7S+8ZgyCWoBXCsjVIhQJR1zOF9pepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3XgR0CO; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3XgR0CO"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5cebd3bd468so847771eaf.1;
        Fri, 19 Jul 2024 01:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721378748; x=1721983548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uqvBP32xV6qRefoyJcm+diCLzvCyHwlNjo5p8QbsSQ=;
        b=F3XgR0CO3yMg3TX0BGz7BicCip1/1V+lMDkClMACCOClRQYWB+BskMyZNm4jZ3N2Rq
         amq8NO1XU+SHrpgEpbAN2HQGct2B0pWgVeyLdUM9Xtw1b6e5M5piiqFVR+pt9ynMbjYs
         KP//nvZ8hwtDWQPvg924xka16gLAOC4Uv9NRMg3Iv522529WM1G+m4EWa6C5u6mzpnLs
         y7fwsqReVPKbWN6JZt+RJbeqZdDgXo48JZisHmWk6ZZlc0iP/INTJ/wSVnjDwsfV2hph
         8ibdrHK5PxvNeE+/22nPeRi2pHxLsgIRCcqp0mCqQtcca2z8PUeKeAD1lYQL7M/5qh0q
         SJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721378748; x=1721983548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uqvBP32xV6qRefoyJcm+diCLzvCyHwlNjo5p8QbsSQ=;
        b=C3dMGGzmBCPo3kOll31iMW5Ro0urjUzdqGoD9ESKwERobSbkEO3hu9c/JeqUt6b5zB
         uXcRBehiIIQ9JGc4XsaqqouV0v2ps9jFfEl6Blda12ZEfGYzzQCtnXKlGQkLWVYN8jF/
         ZEmBfZKNpcqBoluNLQJi791jJQNzCGePXG0/0FrpAa+BNVk494Ggb0fK/6z4d9eVtPd6
         x/1ThfgU/60+V/YsPntNk8XI2Amz0U6D7hbguy0AjC9ORd4ZkhCa7y4cweJAUIHRtD/e
         nxKcmgT8xI9HnQfLCRWWIY2dXM+ezy+Jiy0oh+vK0Fgck3aqp5aiwG/Fpvt+GA7jXGip
         hVVA==
X-Forwarded-Encrypted: i=1; AJvYcCXwxBKj6pF8joKmOgLqNi7iYWTitqAJWEdVipUYnk5nAkUO5m9QyHg/+J7rZYI7MEog6gfIw2z+Rtza33U0LUJ0RmbHe3bgn79VjOFx/sXK2ELL1cNBRsUCNf6rVkXxfg/fZ92qNzDIsA9swEViBh4WnkrBVSfDqmwylzwb+LJB0BjmXg==
X-Gm-Message-State: AOJu0YxbMQi8caosx5PZUiis4xoj5oGBWzdsYJvQsiguG4MMLODYy4u7
	R10ZG1tSIXmNePkX/FfjUl1ciH0ofW4/zv+Pt9OqGWCr0q90lfd1
X-Google-Smtp-Source: AGHT+IHXTA/zgkdr+H1RuzNCjWddediAA0SHwbiJ+VeYitWvUf/Oywvo4d5FAaFRIYS1Lp9cmPpbZA==
X-Received: by 2002:a05:6820:270f:b0:5cd:2e7:cc6 with SMTP id 006d021491bc7-5d41cade049mr8811826eaf.8.1721378748386;
        Fri, 19 Jul 2024 01:45:48 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d55a7fa65esm179536eaf.5.2024.07.19.01.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:45:48 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v5 2/8] mmc: sdhci-of-dwcmshc: move two rk35xx functions
Date: Fri, 19 Jul 2024 16:45:41 +0800
Message-Id: <ebfe6fb90fb85a0f203d9816211eccd23d5a5330.1721377374.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721377374.git.unicorn_wang@outlook.com>
References: <cover.1721377374.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

This patch just move dwcmshc_rk35xx_init() and
dwcmshc_rk35xx_postinit() to put the functions
of rk35xx together as much as possible.

This change is an intermediate process before
further modification.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 90 ++++++++++++++---------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index fb4076c19ed5..903fe06050e4 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -711,6 +711,51 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
+static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	static const char * const clk_ids[] = {"axi", "block", "timer"};
+	struct rk35xx_priv *priv = dwc_priv->priv;
+	int err;
+
+	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
+	if (IS_ERR(priv->reset)) {
+		err = PTR_ERR(priv->reset);
+		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
+		return err;
+	}
+
+	err = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
+					    ARRAY_SIZE(clk_ids), clk_ids);
+	if (err)
+		return err;
+
+	if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
+				&priv->txclk_tapnum))
+		priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
+
+	/* Disable cmd conflict check */
+	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
+	/* Reset previous settings */
+	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
+	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
+
+	return 0;
+}
+
+static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	/*
+	 * Don't support highspeed bus mode with low clk speed as we
+	 * cannot use DLL for this condition.
+	 */
+	if (host->mmc->f_max <= 52000000) {
+		dev_info(mmc_dev(host->mmc), "Disabling HS200/HS400, frequency too low (%d)\n",
+			 host->mmc->f_max);
+		host->mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
+		host->mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR);
+	}
+}
+
 static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1064,51 +1109,6 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
 	host->mmc->caps2 &= ~(MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
 }
 
-static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
-{
-	static const char * const clk_ids[] = {"axi", "block", "timer"};
-	struct rk35xx_priv *priv = dwc_priv->priv;
-	int err;
-
-	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
-	if (IS_ERR(priv->reset)) {
-		err = PTR_ERR(priv->reset);
-		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
-		return err;
-	}
-
-	err = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
-					    ARRAY_SIZE(clk_ids), clk_ids);
-	if (err)
-		return err;
-
-	if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
-				&priv->txclk_tapnum))
-		priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
-
-	/* Disable cmd conflict check */
-	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
-	/* Reset previous settings */
-	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
-	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
-
-	return 0;
-}
-
-static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
-{
-	/*
-	 * Don't support highspeed bus mode with low clk speed as we
-	 * cannot use DLL for this condition.
-	 */
-	if (host->mmc->f_max <= 52000000) {
-		dev_info(mmc_dev(host->mmc), "Disabling HS200/HS400, frequency too low (%d)\n",
-			 host->mmc->f_max);
-		host->mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
-		host->mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR);
-	}
-}
-
 static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 	{
 		.compatible = "rockchip,rk3588-dwcmshc",
-- 
2.34.1


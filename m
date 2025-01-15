Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8FC1DB13C;
	Wed, 15 Jan 2025 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736926257; cv=none; b=NotdGiCIi83R01bpG+jWeoAfKFbb+6A1VvEuHxF+vOjxdcrJkZRs4PyC/LF4ub7jPlG+O3xRVxCyH9vgapgPe3DbFHvnOZVm7H0DvEBjGqwq7kRv2rNvqyOnET7N2VaEo7oRcSDb/L3NiRW9MbeAO9dL6SfYtb98HHgAkUWt49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736926257; c=relaxed/simple;
	bh=diLtFnyDNcOyjKb5X1KbzPgDz8KY0pspKsa/HJVKHsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlePzklrO2a/ykAszpU5Qbwcm7d+XsbYpv/umNl73Q4Nv2zSSL/Wtmf1k27b3khdfp8myOVhQp6zISBWiYHrULD7hVhkLtQqoiSZyo8uLTXJ8WZX8+7VUdmEYHRi6hHHgSEoG8z5nJ6NFGmIw3RqoPfcftLBTCzzSV6Ao8ikVt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkeJWfRR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkeJWfRR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso45160235e9.1;
        Tue, 14 Jan 2025 23:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736926254; x=1737531054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfc7yHRU9A77/4BsuDwrRLLhbG0qYCnEUsOYkaHwtVM=;
        b=lkeJWfRRfjJTnxbnpS86qmz1i6LwtS6GPteS139sMiUU9ItKRVWc9/NgiqvopK5I1g
         TTaHDXN1R3vHVNLhxRAI14Gb+Nag224b3hGS3Xj+VOnF8ycQy16Ip70z3zZtUDFRanXV
         TcVFMsT0nyqMrDV/5CUruKybB0Qxzke6ZAQ2KtcNKEichW+S6VNuizvc2pawM2lZbCZ8
         mrvKpdKHKCN64M6S5T9PyWWdf7vqL6hv6X3o175RE+MlYJ3OysDCNo39B26ijp1XUVJ4
         wrY1+zZWmQ5s3boN99ZWX6U6l1xBTNNZEbUZQU0EDl/zDA3u9sBDv2EiBFdZNSE06dZQ
         PoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736926254; x=1737531054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfc7yHRU9A77/4BsuDwrRLLhbG0qYCnEUsOYkaHwtVM=;
        b=xBp4+OirqBsqnvAthaSC9aBS7pPronZiIivmQAGMrvFP7020MvprDmkq6puxbz9Ipd
         hEqhlZTxmbQI5f2P9ls6eQ1YQYlW4pORBPRFg8CZuzVYoCKQYg0lFzbA5TngOHCJqPXe
         Ej5y0rU5fb2BarZcaH4i9KBbwRDn6jV1VwPoMUbek/+N1k+JOsS87ovWbPqGkaZfuAFg
         J2OS9Ka3mwN9Lfe+X2L6c3VTEanEqvLxqf45MdgE73zRuJ8e1Y7tIia0lI7KqSJlySsi
         qdO3uYidcP3WNaq4fa3SnEMGktjqF2E5kwbj23A+v/X+3uRE1aoc4fvDvJ93IXaN4bPk
         njjg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4viyYFnXTj/8dxgqgP8axMTBHS94NLoKO2vzPGCLDEW20ziHMZXBEjrpQzuJRO/ZUZyUF9b0GJ0ipDA3@vger.kernel.org, AJvYcCWlDTBwKEfJiZgh1F9V5K3r84IVmL9/bnY27/YxnvpQDUvuT/os1eZElhoJOYuNH2WqANIMuunAVu5Z@vger.kernel.org, AJvYcCXEb0KXfVO+e7ugXo7z6jyfzfZlhjWJimsZmiRjedTmWxWZyUvCDJQDdwm5Q+qsPdql0XkFoo0APhXk@vger.kernel.org
X-Gm-Message-State: AOJu0YwQFY6IpLFOmlpZUTQFCMDAoxFzQo3cw1AQkQVB/i/mTpFZ2XrH
	87easS7sYTjKgJmGT45dJRtCDKMHYq56JuFenMgQI3dk1lm5Th/H
X-Gm-Gg: ASbGnctxQhR1qVdg/PzAhGRjjvPkSwto5OpbfW/jiDyP9t69aVfDnmAJi288JdnphEb
	zMZjIj63310xEopuwzsL1hXviNEzvfEMfdSU/QLhzxOI0HX8mIp7Ifiw/TyMMt/xupMAlDZqoQ3
	RW0dzIlkpL49aRay0xSzdbrW+s3xe4Tt5lLYiNzj9z5XZV8wln8Jbw0Y02++4q6ULTU8R4UV0Y5
	PDDgUhuj+wm9YG185g/erUDkDZOZQNGRY2zPdpH4DJArSEzIgXbozziRliDAp4r9oN+18c+nhlg
	uSyucJLwoRXEbGzLShC69regCg==
X-Google-Smtp-Source: AGHT+IGfNQA9MdWtZcu0lFIOOfKNshqX7g+GdY8i9HXPqYU4BO9lxCOaxNz5u34Tmlm4uc6Zmf8FEQ==
X-Received: by 2002:a05:600c:510a:b0:434:faa9:5266 with SMTP id 5b1f17b1804b1-436e26adfc9mr244453335e9.13.1736926254141;
        Tue, 14 Jan 2025 23:30:54 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c7499932sm13313065e9.7.2025.01.14.23.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:30:53 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
Date: Wed, 15 Jan 2025 08:29:51 +0100
Message-ID: <20250115073026.31552-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115073026.31552-1-ansuelsmth@gmail.com>
References: <20250115073026.31552-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for AN7581 MMC Host. The MMC Host controller is based on
mt7622 with the difference of not having regulator supply and state_uhs
pins and hclk clock.

Some minor fixes are applied to check if the state_uhs pins are defined
and make hclk optional for the new airoha compatible.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mmc/host/mtk-sd.c | 55 ++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index efb0d2d5716b..9d6868883c91 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -666,6 +666,20 @@ static const struct mtk_mmc_compatible mt8196_compat = {
 	.support_new_rx = true,
 };
 
+static const struct mtk_mmc_compatible an7581_compat = {
+	.clk_div_bits = 12,
+	.recheck_sdio_irq = true,
+	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE0,
+	.async_fifo = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+	.stop_dly_sel = 3,
+	.enhance_rx = true,
+	.support_64g = false,
+};
+
 static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
 	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
@@ -680,7 +694,7 @@ static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
 	{ .compatible = "mediatek,mt8196-mmc", .data = &mt8196_compat},
 	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
-
+	{ .compatible = "airoha,an7581-mmc", .data = &an7581_compat},
 	{}
 };
 MODULE_DEVICE_TABLE(of, msdc_of_ids);
@@ -1600,6 +1614,10 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct msdc_host *host = mmc_priv(mmc);
 	int ret;
 
+	/* Skip setting supply if not supported */
+	if (!mmc->supply.vqmmc)
+		return 0;
+
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		if (ios->signal_voltage != MMC_SIGNAL_VOLTAGE_330 &&
 		    ios->signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
@@ -1699,7 +1717,9 @@ static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
 				dev_dbg(host->dev, "SDIO eint irq: %d!\n", host->eint_irq);
 			}
 
-			pinctrl_select_state(host->pinctrl, host->pins_uhs);
+			/* Skip setting uhs pins if not supported */
+			if (host->pins_uhs)
+				pinctrl_select_state(host->pinctrl, host->pins_uhs);
 		} else {
 			dev_pm_clear_wake_irq(host->dev);
 		}
@@ -2036,6 +2056,10 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	msdc_set_buswidth(host, ios->bus_width);
 
+	/* Skip regulator if not supported */
+	if (!mmc->supply.vmmc)
+		goto skip_regulator;
+
 	/* Suspend/Resume will do power off/on */
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
@@ -2071,6 +2095,7 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
+skip_regulator:
 	if (host->mclk != ios->clock || host->timing != ios->timing)
 		msdc_set_mclk(host, ios->timing, ios->clock);
 }
@@ -2816,9 +2841,12 @@ static int msdc_of_clock_parse(struct platform_device *pdev,
 	if (IS_ERR(host->src_clk))
 		return PTR_ERR(host->src_clk);
 
-	host->h_clk = devm_clk_get(&pdev->dev, "hclk");
-	if (IS_ERR(host->h_clk))
-		return PTR_ERR(host->h_clk);
+	/* AN7581 SoC doesn't have hclk */
+	if (!device_is_compatible(&pdev->dev, "airoha,an7581-mmc")) {
+		host->h_clk = devm_clk_get(&pdev->dev, "hclk");
+		if (IS_ERR(host->h_clk))
+			return PTR_ERR(host->h_clk);
+	}
 
 	host->bus_clk = devm_clk_get_optional(&pdev->dev, "bus_clk");
 	if (IS_ERR(host->bus_clk))
@@ -2926,10 +2954,13 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		return PTR_ERR(host->pins_default);
 	}
 
-	host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
-	if (IS_ERR(host->pins_uhs)) {
-		dev_err(&pdev->dev, "Cannot find pinctrl uhs!\n");
-		return PTR_ERR(host->pins_uhs);
+	/* AN7581 doesn't have state_uhs pins */
+	if (!device_is_compatible(&pdev->dev, "airoha,an7581-mmc")) {
+		host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
+		if (IS_ERR(host->pins_uhs)) {
+			dev_err(&pdev->dev, "Cannot find pinctrl uhs!\n");
+			return PTR_ERR(host->pins_uhs);
+		}
 	}
 
 	/* Support for SDIO eint irq ? */
@@ -3010,6 +3041,12 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Cannot ungate clocks!\n");
 		goto release_clk;
 	}
+
+	/* AN7581 without regulator require tune to OCR values */
+	if (device_is_compatible(&pdev->dev, "airoha,an7581-mmc") &&
+	    !mmc->ocr_avail)
+		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+
 	msdc_init_hw(host);
 
 	if (mmc->caps2 & MMC_CAP2_CQE) {
-- 
2.45.2


Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8416130C;
	Mon, 20 Jan 2025 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737398899; cv=none; b=OSKqNnNpCIyJSxq1/KJoJHee94i0zymVjblYxyKbR6pCGH2K/PIWnuwrjJX8s0lJhrXi1yMhatX7/yI36gh/nwoeLHiYYB6HoKLmE14cSQPDsliyPPaqHImS2eRvKI+bLqHVoqXjFXluLJln3svuaM3Wnus6x0I0vKf6Xf6N28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737398899; c=relaxed/simple;
	bh=CmSCIagW08VnZ4CU/uxmB1qIbYYaSiSUpO3PfTPBVqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3L6oKPRPz+WPTYNp84j5WzqDyWVMuyFtEJOAoGoRQWOq3dowYhvl6DW0Ic3zUyLxmuUx8LlfOQTKHiGJ6iKeTuWeLH17xXWEl2JrsbeiOOUKErVPBeEnCT2KnnQ3lvNpbeRgn27EhxvaTPqArto7TygMAEZP9EdqbhHhI0088o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKVn2taf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKVn2taf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso33446975e9.3;
        Mon, 20 Jan 2025 10:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737398896; x=1738003696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqV/FjhJj9DUjcirvqGcRVZyK8YP06tY6pUQMoRMhuw=;
        b=jKVn2tafc1yMOBKbBHBSWReBihoRfYNKfZB5TpeH5otPaK3LeXvUeqMUKXyb7jEx5y
         ohK63r6EpAbj2k9yoB2TIg7tBORW8m1NmObkCVtSLgeXHmHMe54l2yTI99/F7hcvjoxk
         gtrkje4FLMimhioxPPZuvGnCv43TOLO/o9Go3VqNTWw4PGWraYZSDisu8ZOjEsADNfvz
         Zco2AWyuTftbp9Gb3vFPOLjjsOTwWdo7WSE+kxboGipWvgVGVN2en117OlUHaQnullpO
         EIlP0pkof6fsO71wXFBNQnpIE/IE7h0763Tn4EsEqJdauLVdb9BeRFTQ+4nEgGhQP6FA
         VjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737398896; x=1738003696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqV/FjhJj9DUjcirvqGcRVZyK8YP06tY6pUQMoRMhuw=;
        b=ZCah7N16FHsbYp12OkxuC58QP9QxkjvgYnObXwzCazhmW4JxzCsb6NmoX5rZxbN32S
         JymkNrCMaDauBv5ESVsPzOin2m0QrMPVT2s5IA3SipWrmN2RKEsnw8VqUgwPkh/y5C2P
         CZpKF7Oveuo3PcocSE3gG7Kzph03hBXFATkLI/mOvGF2kLjLP8gAt5yeXwqboVUNQuaD
         FqByUwugJKWKxvls4jbC9lu7bBJ8KrCIhilufQ8eKouXfNsRwK4MWf3tCrKIwxXAsU1p
         9czv/5cF4tKzLrAOmGe7uyakqJRGaLkbTMiKAllX1CFdd0h6TZ58mzNttDWETwiLREuB
         CVaA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ+jNu9C7mbLVlBPGOrOxQ8kkZU7tZ0yCcRSOa8lAMJmy1WVBd+sJ7nNgEpXKKnykpqy+hUhE5ppR5@vger.kernel.org, AJvYcCWCOX07lUm3Ah7D6iMGUW0VP63rK66pb15s/Zqs26OUL4HbrBJi5rzL1bfHAEK1Uos/gtM41qXaLtBI@vger.kernel.org, AJvYcCWdHvlnVZlwsVyV0A4sQdYCtd5Wt6kOXifpbIEzdq2EtYDa3XHsXN3QQFHQhAQCEUfUCXDoacOTPzFi46bV@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNwmcYma6ZXXjWJ1Jp36zyF+1bEVEUX1cKHsosxbXh0ddRdKk
	d4MifRnKHsCARhRdhHWtRx++w+/0wp5m22jTZNGHjt3WemaevOuO
X-Gm-Gg: ASbGncuMvv+vmioFNDzHPve9IphkVZN045OczUb73NNNq9zutUFKb70pBqvZpIhOjEa
	yrNkcJOST3jBcNd58ySYXNb8u3z5LlbbTqmx5tI2AATyOhieSI4yp2mj0QK9zJR8UGLwiPpSUgE
	mVaoUFSSSaoPd/Z+9rQ5CKLQrpHbOJNbEecPfgnKBfGrMQLu+ihpSQE/Hyd4o1AtgkWT5ZXcCwL
	r7zQIman53ReQZyRggZ8zHTFDvoB+cKsddo8eqaLBpBwUMvSAy9S3exDSAKTGqCRLdWMBvS5v7K
	KaSVu2LdqK+TZNL7dA5z00AmUDXOIm46R2l2CZ8=
X-Google-Smtp-Source: AGHT+IH9PM2GibsFcQmyWQQGrxcXpJ+kncPmt3vY8dQwqwdzD60YCwZnKsd2BQmHXXaTAhz6p7SP5A==
X-Received: by 2002:a05:6000:1f85:b0:38b:e32a:109d with SMTP id ffacd0b85a97d-38bf59e1d83mr11668430f8f.34.1737398896238;
        Mon, 20 Jan 2025 10:48:16 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38bf3215023sm11095390f8f.9.2025.01.20.10.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 10:48:15 -0800 (PST)
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
Subject: [PATCH v2 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
Date: Mon, 20 Jan 2025 19:47:02 +0100
Message-ID: <20250120184728.18325-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250120184728.18325-1-ansuelsmth@gmail.com>
References: <20250120184728.18325-1-ansuelsmth@gmail.com>
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
Changes v2:
- Drop redundant if condition where regulator is not supported
- Correctly set pin in msdc_ops_switch_volt

 drivers/mmc/host/mtk-sd.c | 59 +++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index efb0d2d5716b..f76f20502409 100644
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
@@ -1614,12 +1628,15 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 			return ret;
 		}
 
-		/* Apply different pinctrl settings for different signal voltage */
-		if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
-			pinctrl_select_state(host->pinctrl, host->pins_uhs);
-		else
-			pinctrl_select_state(host->pinctrl, host->pins_default);
 	}
+
+	/* Apply different pinctrl settings for different signal voltage */
+	if (!IS_ERR(mmc->supply.vqmmc) &&
+	    ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
+		pinctrl_select_state(host->pinctrl, host->pins_uhs);
+	else
+		pinctrl_select_state(host->pinctrl, host->pins_default);
+
 	return 0;
 }
 
@@ -1699,7 +1716,9 @@ static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
 				dev_dbg(host->dev, "SDIO eint irq: %d!\n", host->eint_irq);
 			}
 
-			pinctrl_select_state(host->pinctrl, host->pins_uhs);
+			/* Skip setting uhs pins if not supported */
+			if (host->pins_uhs)
+				pinctrl_select_state(host->pinctrl, host->pins_uhs);
 		} else {
 			dev_pm_clear_wake_irq(host->dev);
 		}
@@ -2816,9 +2835,12 @@ static int msdc_of_clock_parse(struct platform_device *pdev,
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
@@ -2926,10 +2948,13 @@ static int msdc_drv_probe(struct platform_device *pdev)
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
@@ -3010,6 +3035,12 @@ static int msdc_drv_probe(struct platform_device *pdev)
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
2.47.1


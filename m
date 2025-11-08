Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FD2853FD
	for <linux-mmc@vger.kernel.org>; Sat,  8 Nov 2025 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643611; cv=none; b=ccn+3ra3czsmhwcyyVBEhNTCAUr2RPoyXl4DHKgxHkKQlHQUxHknbH9f0fA2iiWnEXbr7bNGzFIQTsHCi4YxTJQuLeDx5bgRLoaB2hIsO6Vv5TvOW/JdGoVHzNOGKR2WwwVuNA5+LGvhEUd7B2lDYo8ieNzaCGJjBWWmOTI/dHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643611; c=relaxed/simple;
	bh=MXwD98+QiCRKWpbu3tuuKlm8W3tPdoRbgTcv4H6yNxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkp78qaJPd0cgL7vWuMjwoWHv4EIdYKzOVmzzSmOz34AVlP70PfHJAPzgFLEuU5cdv9OiVkA8iaooOMFdX2wq0nCDpP9UG63PBv8KtAs8KSeZyWppXHnJPM8VvtZfxLyP0M97YyV7qwnD+I1wtq1A0gtxRRgO2Q5rqoZb6J7apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lcARcs8p; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lcARcs8p"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so2948132a12.0
        for <linux-mmc@vger.kernel.org>; Sat, 08 Nov 2025 15:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643608; x=1763248408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cijZ+09YTsl3uHzpkuOiO4+DMdT2cKq32KSIaXuX+bQ=;
        b=lcARcs8pc6IYkG/VjQQqpJEWODaaz+Q6v4rMlVxi/IjvToEPCWsigNmSARD42S1U1+
         x9LHuMtbntSnTyK02NP9lGiTofuAMpYBCHidrElP/LgYQ43R3CMYXeWksojECSyvjxY1
         n874ZFELWwo4hECURFn4rxtmyBbAs7oodClMvb4qI4Zs0I0gZinAZpgxrrXUCq6XtgvD
         x4LcDejCpD7CIVkqOozXE/Tyel6JBPfJ6bD96o3vzSukZ3amdDAZHNCNAX/tIq3jCUI0
         FzL98KHUmwlac1dK0f90OFK9WhP/5oxCwPffQL2LZTFMfDMKHYX27hq0i9te1DPmbkGr
         yj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643608; x=1763248408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cijZ+09YTsl3uHzpkuOiO4+DMdT2cKq32KSIaXuX+bQ=;
        b=QTrshsA8Oh3dxWTNL/cQHGEZJ7wGL043MVgrW4qn8q7ixvOs8GIcp0qz+Mw45bssN3
         zY5PnWu6rF1NxwmmVgC+Ur7iT0F+hznH4a8eEPp17YqCI5K78LyYXFrNZiAWOM2MOjSL
         nbKaHuufa9Sz8hRzW8a3SvQygY+LEeu4bMo6Y10RcDqak2NMsfAnG1fvZbqqy+GjE5fp
         sT49EA/+1Y/dA1mdnF2zRVtyLJyjxDUHtWM/1disn1YNTiDSE8w2+JelF9RBqPSH2jZQ
         02kW6xVTCSlhQ/rBH4o19KtKA6VEeY8Iv+ZCqU0TLWpt5Dg84kyArvaeREQmTTrVhX2z
         VMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgK4aunLdbpC74+aRiXCF3uK+Q/oHc5m4I0aSHpdU43MRGIyUhTm31WFmxmxDHy6asJc7CEbMXGtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpyYyHaEgZFHMWFAWF/a0iSH3XPX3mK6XRHVlTjZ9tKz6fkAD
	BrRERrh58L2yITU8qJQZy9y/llVOs+bTAOq9/XuyQ6pGT4asl/sr96IC
X-Gm-Gg: ASbGncvr1sFXi4CyTmuQJoqJBm7BLQB8/fEGhFlW/bnrfxFXHaBY/lYkVzR6sEYOZXX
	WTfKUxZYiTV0Kz9E9yveXYzYbrI4YTV5nwnwxfNaMW8WqKfVDxSl0j3B0pulrBkUKffoXfN5seQ
	my1FkLkUV8oYRF8fV/9XlD1ie0Y24TMqS5iZZsxVejNMDkIdbHy52yqRytSQKbsYWta5FziM/JD
	1aA5lhJXNxpTqBMBzcOXCzJhARisfxDj2aaWXOEeGIKBIngme0Y05PQwkjUaeX8pMAE3p9Go9uQ
	fwXD4R+ujq09aHLigWNTjVym/DcZOlzkGQkDJOdLSMCSJGESa9vVD9p+UKL+MaNWnJTD/RG/y58
	8h37x5DZKB8glWG2GeQ6yMG4IAJQUkKjebuGJt2Q2XFeUrH3OXWRBrKnNQhS+JdJSnzl23Sv2kt
	yYv6Noo1ucQTtAYSOce0XtCuZYdP/I2pA72Z9hp90uFN0za4GOpKJ+//yyBGE0USHGvEaVBmvPi
	+N82vmn6mobmOZsB1XCn93IeR+iuozZAkttL8XW2eo=
X-Google-Smtp-Source: AGHT+IGhMEgUC8oM2+pqlrfLLlvVoY4z7bHF+SAAYNYxAbvCQcc6jUd5lgOvOXrATxrEZssO/EG4/Q==
X-Received: by 2002:a05:6402:4310:b0:63b:dc3e:f01c with SMTP id 4fb4d7f45d1cf-6415e6cc622mr2587683a12.12.1762643608311;
        Sat, 08 Nov 2025 15:13:28 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:26 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 5/7] mmc: meson-mx-sdio: Use dev_err_probe() where appropriate
Date: Sun,  9 Nov 2025 00:12:51 +0100
Message-ID: <20251108231253.1641927-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This streamlines probe error handling / logging with other drivers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 214ce84f1ddd..052bcf8f32df 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -520,16 +520,14 @@ static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
 	struct device *slot_dev = mmc_dev(mmc);
 	int ret;
 
-	if (of_property_read_u32(slot_dev->of_node, "reg", &host->slot_id)) {
-		dev_err(slot_dev, "missing 'reg' property\n");
-		return -EINVAL;
-	}
+	if (of_property_read_u32(slot_dev->of_node, "reg", &host->slot_id))
+		return dev_err_probe(slot_dev, -EINVAL,
+				     "missing 'reg' property\n");
 
-	if (host->slot_id >= MESON_MX_SDIO_MAX_SLOTS) {
-		dev_err(slot_dev, "invalid 'reg' property value %d\n",
-			host->slot_id);
-		return -EINVAL;
-	}
+	if (host->slot_id >= MESON_MX_SDIO_MAX_SLOTS)
+		return dev_err_probe(slot_dev, -EINVAL,
+				     "invalid 'reg' property value %d\n",
+				     host->slot_id);
 
 	/* Get regulators and the supported OCR mask */
 	ret = mmc_regulator_get_supply(mmc);
@@ -666,7 +664,8 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					     &meson_mx_sdio_regmap_config);
 	if (IS_ERR(host->regmap)) {
-		ret = PTR_ERR(host->regmap);
+		ret = dev_err_probe(host->controller_dev, PTR_ERR(host->regmap),
+				    "Failed to initialize regmap\n");
 		goto error_unregister_slot_pdev;
 	}
 
@@ -680,12 +679,16 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 					meson_mx_mmc_irq,
 					meson_mx_mmc_irq_thread, IRQF_ONESHOT,
 					NULL, host);
-	if (ret)
+	if (ret) {
+		dev_err_probe(host->controller_dev, ret,
+			      "Failed to request IRQ\n");
 		goto error_unregister_slot_pdev;
+	}
 
 	core_clk = devm_clk_get_enabled(host->controller_dev, "core");
 	if (IS_ERR(core_clk)) {
-		ret = PTR_ERR(core_clk);
+		ret = dev_err_probe(host->controller_dev, PTR_ERR(core_clk),
+				    "Failed to get and enable 'core' clock\n");
 		goto error_unregister_slot_pdev;
 	}
 
@@ -697,7 +700,8 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(host->cfg_div_clk);
 	if (ret) {
-		dev_err(host->controller_dev, "Failed to enable MMC clock\n");
+		dev_err_probe(host->controller_dev, ret,
+			      "Failed to enable MMC (cfg div) clock\n");
 		goto error_unregister_slot_pdev;
 	}
 
-- 
2.51.2


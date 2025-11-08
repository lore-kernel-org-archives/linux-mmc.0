Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3328CF6F
	for <linux-mmc@vger.kernel.org>; Sat,  8 Nov 2025 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643609; cv=none; b=H6DTYAQFGY311WEMyTzBXKVYaAzSUDdj1AaXLD83Qrsr5xecgBCpnC8cE6daYyoEJ8GbNKP4HiND2e2hbKH2o2E6TUhGotr/JRIG7i8Vd9idcYTZRWckZtsfPQIBwSTqFm76ywL1l7Hq+tvcXNsnqiMLZPFrctAh5C0M0+OPuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643609; c=relaxed/simple;
	bh=LRgQG8dmzk1BLZPP62AH0NDL2Twf5lOn1hcY4/I8VFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzkSiWhnhl8imoM10eVLUTQiaqEKnbWdJPjEcuUJW7bYvTr0k4ktVgqCH9zAqao0+0t1uSZjSmbuNUuOueyzOpb6YUvFAAvBmFaMX6Isxj2m+lzQSJelMegPdemOjOlK/3gy4Dor3ChZbpFIdbd9I4SleV8iumB0nBLUWipU1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=O1WWlgvV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="O1WWlgvV"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso3435603a12.2
        for <linux-mmc@vger.kernel.org>; Sat, 08 Nov 2025 15:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643605; x=1763248405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MEwQ3w0WXL0SbyJSEK5ayMTVI87i1RH9nRchsrOxNc=;
        b=O1WWlgvVv2vgkkklyh4x+dbs882JcoL7raHaLMEOs853JRSoJkjlqoE+E4grv66jWH
         Ux5h38G4VaEmzPjHcRoZIBMw4Mkp6KBmLzSBu6Kbl+mn7ZJ8DbbLbzy86h5/5yatDKac
         fsDECl8qZCSrtOcBj4nwBIRRM9iYRBSM0cAY/9Q9xVbWrTZdBhmy9/OeP68SKAdND/JW
         Y9bdfTlcjgGCvopdhu4i/tGA9R9Kh3HFlsbQrJXhKFsAqCMsYlOvD8pg+NMxnoqTO/mM
         MpncH72amL5T2qGsVi5l0R1zOdUqzk3rRD+iqHRnJzxPEIX9hLAZEZLJZtsBkl0FPZt+
         tv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643605; x=1763248405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1MEwQ3w0WXL0SbyJSEK5ayMTVI87i1RH9nRchsrOxNc=;
        b=SOfEO4W1/i/5LTcOBxzVNKLXHfS7/ttHzyhceihLuDwWvwfoNq4EBIi3U/bX66Kri6
         CpV5fFfXwVQWD550dDRstKgrVVB83Cos1oIa0BXvNKc+mQA6pnhpQH+SI5Kf6jqhK1Xg
         VfDTbvz0RQWALDQ32QbMIRuKblSLzDqCgGYxFsRGmt5oSU2cwBAK72X9mSgG6pcE2liu
         ClV3JEaKdc4yYrNWswaRtKNPmUqzyP39ZtYs6JeNFDTrrb4t68YbOJT3hX0zSZaxsNmq
         PC9sRNYpiohvvAZwYo9PYp6DnYraYS0Vs8GLyODHdt9bJXFVbPb7X28lbbC7TxrUMQZC
         t+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqLHwdA2zEVEiOsvkoyggRbU7DqZYCCeGQpmI1U8VBlweVLz0/5wBA2zGxNZbYVBFo19XroxhfE5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPdqO5i2Pukh9gkalwPHBY4Q6KeaabILfA3Dx6S4K2GGLrJNC6
	fgWXCctnI8a3YFVROFX1GiawarPzwIWXakKLPwMrCrsfIBvqvIyQAQWc
X-Gm-Gg: ASbGncsDDFTTl2GghpP6wm++AeoKW0GT+0YMyvCP7C9z2+yHQh8TXWKsiKwNPXu9VvC
	iTOGk/622dL4qW8etMCYcdKd4fT1TAU5qQtJCaSaMUIS1ElzwpYxcevqA4wITvTY+EGQIGBHFgc
	hv/nv74tHilgwsVCwOuwT+4QM2HaNdivHvuUdq3DiHgFBCE9fzJCijsU3xBwDeI5WLJKfVT9+nG
	+N4uYNVQwq36XA/d0jXrUBsbfTqmBsD6nOgxq9fOEnv7uhtzpK/MXcul/EK1Ou4DBmCAjr7gd8G
	YlX//vplgwp7J1NxzECy3BAFSmUnia4rdKtAiGP/m+LAE+oAMZfUfcCuuPCPZu1VMWv8eI3Dzzs
	+J5YpeejIiK4U6im7qpZPFvjaWnupO2jcbqh0HiCHlVuD5z/kItVqzG3T/uAGRZmT/z4IimSQTe
	Ps0VmxNZn/c4gBEkbz5l4swfseClpO+oxbjA5X7sZM964R0VFgldYHVXB/4gPCvnlzOU6kRC8/D
	uOpPlg7Ib6pRLSWoI7NgYDcccRkbzhpZhiSxJ3lbv4=
X-Google-Smtp-Source: AGHT+IEsR1rp3/X0FtnDGE5wBY+8APLUTqmqxSkpd5bpl/RawvNHr6XzcekK44kWFCslKuF52z+IjQ==
X-Received: by 2002:a05:6402:305c:10b0:640:ebca:e680 with SMTP id 4fb4d7f45d1cf-6415e80f7fdmr2452169a12.37.1762643605472;
        Sat, 08 Nov 2025 15:13:25 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:24 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 4/7] mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper
Date: Sun,  9 Nov 2025 00:12:50 +0100
Message-ID: <20251108231253.1641927-5-martin.blumenstingl@googlemail.com>
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

From: Binbin Zhou <zhoubinbin@loongson.cn>

Use new function devm_mmc_alloc_host() to simplify the code.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index ce1828d915da..214ce84f1ddd 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -648,7 +648,7 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	else if (IS_ERR(slot_pdev))
 		return PTR_ERR(slot_pdev);
 
-	mmc = mmc_alloc_host(sizeof(*host), &slot_pdev->dev);
+	mmc = devm_mmc_alloc_host(&slot_pdev->dev, sizeof(*host));
 	if (!mmc) {
 		ret = -ENOMEM;
 		goto error_unregister_slot_pdev;
@@ -667,13 +667,13 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 					     &meson_mx_sdio_regmap_config);
 	if (IS_ERR(host->regmap)) {
 		ret = PTR_ERR(host->regmap);
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 	}
 
 	ret = devm_request_threaded_irq(host->controller_dev, irq,
@@ -681,24 +681,24 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 					meson_mx_mmc_irq_thread, IRQF_ONESHOT,
 					NULL, host);
 	if (ret)
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 
 	core_clk = devm_clk_get_enabled(host->controller_dev, "core");
 	if (IS_ERR(core_clk)) {
 		ret = PTR_ERR(core_clk);
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 	}
 
 	host->cfg_div_clk = meson_mx_mmc_register_clk(&pdev->dev, base);
 	if (IS_ERR(host->cfg_div_clk)) {
 		ret = PTR_ERR(host->cfg_div_clk);
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 	}
 
 	ret = clk_prepare_enable(host->cfg_div_clk);
 	if (ret) {
 		dev_err(host->controller_dev, "Failed to enable MMC clock\n");
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 	}
 
 	conf = 0;
@@ -718,8 +718,6 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 
 error_disable_div_clk:
 	clk_disable_unprepare(host->cfg_div_clk);
-error_free_mmc:
-	mmc_free_host(mmc);
 error_unregister_slot_pdev:
 	of_platform_device_destroy(&slot_pdev->dev, NULL);
 	return ret;
@@ -737,8 +735,6 @@ static void meson_mx_mmc_remove(struct platform_device *pdev)
 	of_platform_device_destroy(slot_dev, NULL);
 
 	clk_disable_unprepare(host->cfg_div_clk);
-
-	mmc_free_host(host->mmc);
 }
 
 static const struct of_device_id meson_mx_mmc_of_match[] = {
-- 
2.51.2


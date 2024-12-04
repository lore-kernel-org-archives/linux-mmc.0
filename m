Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABFB1AA7A5
	for <linux-mmc@vger.kernel.org>; Wed,  4 Dec 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304549; cv=none; b=QOr8Hr06B8Y/TnEPDRgM97OgkrwBU3WjsQuauvxJ/M17umi52+Ipg4CoBYqb1S9TtB9M+CFi56ZXR9PtmBA2kSSuKMF+EXPPaZWg8Ay+8kVjtwc6bBWzw0hzotct1JzknoxH2QdlgpehjGwcu7XZr5t7VyP27INm9uAFjan9jDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304549; c=relaxed/simple;
	bh=ZF846tfxXQR1bjFKcFdA9ieHcqIFK6FjHRuAwd9+d9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLl7LkJx7NZ2r5gdi3ki8AYz2WLlG7kHpsyWHR0G4HcTAG/++IzRUIBLsO7CKlwmzy3GZPqGBx50hV78gYY4GaLHYC2y5lpvvFc9icJ25/t7zjVFOiREwgCDmSLXQGmM7oxZYoiFi7FwimfHDl91NcVL7NA2qlZ9uU50USnnfSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ar8kYtfz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ar8kYtfz"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fc22a88bcbso5016709a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Dec 2024 01:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733304547; x=1733909347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lmhyTT2gnZ9bY0N8ST8GSpbytof12mEhpjxb7D+L9U=;
        b=Ar8kYtfzscK8eQvziDDm5C8HUKZVLZbINqRj/8zmMnMCiCb0QDgALrhDm2NFPRn/VG
         stUKrgrjnA689u3jjl7kurolByZm0cJWEdk1pn/pC+CToGLevuNfWK4DHz7bBL10WQDN
         U3Cg/RmBurDghyoszvT5ZGlnlIC8D4JjR7uro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733304547; x=1733909347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lmhyTT2gnZ9bY0N8ST8GSpbytof12mEhpjxb7D+L9U=;
        b=CdmrdH9e+UbxopQa0DQB3v7VUs7iHSbK9fqUOhALdFv7uFPZgoIl1Nabpo7+wGFqOH
         L5QxE0PmJ26ZzcMVVAIzzWdE7hkZAOAQH2ThEFLvnbd81x+kOR2PKszMLN3qjhsbI3Kn
         nQM8sv/Hah2b/KwsFtySTOzqMIUKaFxoiGONgY+HQW7ZFjjmv7YQzppfpCGW8qMRyPsG
         TzQU6I0OYoSRPpJac/1YOLuG7/ZILe5zPTwC0W346NB19d5IwMJ+1qg9ojort3xCNK/U
         54/8HWkazsoDcm5zVXyDHYqVLQrrz1yh4zJB1v+p78ubcnMLyBBbuNeOGgFWewvm8zXn
         ZSvw==
X-Forwarded-Encrypted: i=1; AJvYcCWp7j5CdcjEkp5AaLB1c3n8srPOO1OKcSJSqfsMz9bjNTo11SyH7Zo/d529C5VQ8sFJFnIbBki/dY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1GNsiapHcFGy07mfnJE0g/LAmaH6c7pEFjzJKd3AoKxVgq52q
	5CFAftRqpaegPWJLebLGPqj7Muru0JcUYprB1AHbvAsgq45Ls+GbOb5lCjLFVA==
X-Gm-Gg: ASbGncs7FvJegZurGKqfR8V5XENftfqv8zwIsb48S/LFC3LweoVO6sKikFXkmOA3W7X
	78pwPs65vbnEphvwaFoJ67aJlYYynqsODXd2wflGjHtImg0sv0wXA4X9vpHs4915RXjfzBZy4FP
	wQAZ2KFBiOwemk1iWBmayGTaFLuPKK2Zj1E/xdFS8o6hUfnwDDru895wQ1um7SKE9Kc+lLANTGf
	NSJjuOQCkdNlnVhYrqeBCWVfJ6eFpbmcAPsMZBoHY86poE2JI7JSDhd6R+N7ojRUO+s
X-Google-Smtp-Source: AGHT+IF/J9a4qflcZHiUbg+VHivDCNAN5kL5imj4FjGYpM9OWcUYV3cXUXaClbk0sydJ7WHWfxLZ0A==
X-Received: by 2002:a05:6a20:8407:b0:1db:c20f:2c4d with SMTP id adf61e73a8af0-1e1653a6515mr8672949637.2.1733304547503;
        Wed, 04 Dec 2024 01:29:07 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2eb1:a68a:2625:b944])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d38dbsm11049024a12.15.2024.12.04.01.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:29:07 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH 2/2] mmc: mtk-sd: Limit getting top_base to SoCs that require it
Date: Wed,  4 Dec 2024 17:28:53 +0800
Message-ID: <20241204092855.1365638-3-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241204092855.1365638-1-wenst@chromium.org>
References: <20241204092855.1365638-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the mtk-sd driver tries to get and map the second register
base, named top_base in the code, regardless of whether the SoC model
actually has it or not. This produces confusing big error messages on
the platforms that don't need it:

    mtk-msdc 11260000.mmc: error -EINVAL: invalid resource (null)

Limit it to the platforms that actually require it, based on their
device tree entries, and properly fail if it is missing. There is
no MMC node in the MT6779 dts, so it's currently unknown if that
platform needs it or not.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/mmc/host/mtk-sd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index e2c385853eef..1bb7044f4ca1 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -414,6 +414,7 @@ struct mtk_mmc_compatible {
 	u8 clk_div_bits;
 	bool recheck_sdio_irq;
 	bool hs400_tune; /* only used for MT8173 */
+	bool needs_top_base;
 	u32 pad_tune_reg;
 	bool async_fifo;
 	bool data_tune;
@@ -587,6 +588,7 @@ static const struct mtk_mmc_compatible mt7986_compat = {
 	.clk_div_bits = 12,
 	.recheck_sdio_irq = true,
 	.hs400_tune = false,
+	.needs_top_base = true,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
 	.data_tune = true,
@@ -627,6 +629,7 @@ static const struct mtk_mmc_compatible mt8183_compat = {
 	.clk_div_bits = 12,
 	.recheck_sdio_irq = false,
 	.hs400_tune = false,
+	.needs_top_base = true,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
 	.data_tune = true,
@@ -653,6 +656,7 @@ static const struct mtk_mmc_compatible mt8196_compat = {
 	.clk_div_bits = 12,
 	.recheck_sdio_irq = false,
 	.hs400_tune = false,
+	.needs_top_base = true,
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
 	.data_tune = true,
@@ -2887,9 +2891,13 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(host->base))
 		return PTR_ERR(host->base);
 
-	host->top_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(host->top_base))
-		host->top_base = NULL;
+	host->dev_comp = of_device_get_match_data(&pdev->dev);
+
+	if (host->dev_comp->needs_top_base) {
+		host->top_base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(host->top_base))
+			return PTR_ERR(host->top_base);
+	}
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
@@ -2951,7 +2959,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	msdc_of_property_parse(pdev, host);
 
 	host->dev = &pdev->dev;
-	host->dev_comp = of_device_get_match_data(&pdev->dev);
 	host->src_clk_freq = clk_get_rate(host->src_clk);
 	/* Set host parameters to mmc */
 	mmc->ops = &mt_msdc_ops;
-- 
2.47.0.338.g60cca15819-goog


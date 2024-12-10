Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2922E402
	for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815946; cv=none; b=ZUExEZgMsKHSpuW9fsvTCfPAyw8YIar/Y4K+DU4nrjPLmq9ppxYuNI7A1wBD0VQB6Zysrpa6xp600d3LAtENVRxwNYoaLnecRcKQb4clXol9SZXhK/NdbrZhPtZwJ+XtL61m6z+9sNz51U8vd2w96p5aSW1kidTu0xbL9RyNQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815946; c=relaxed/simple;
	bh=NOfDh6XWMXA3bQDZgyXinaVUDZBBis7f4DQlXXXEj18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPybOntjzjZ7UnmQzjfPp7EOw028vjM4Yr5gCynLHjyOcAt939jKzZt/cNs51bu6IxQcAAMB9yWq7d3f747qRFiF+C+rDO0jqk5BGoF0zZpDmrbnsk7oKV/jrn3Pypcz2EcAUJ7ihJ2tAUgIDvf7KXYsmpsQ7kPNelrLnDQcWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nNRq3IaS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nNRq3IaS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21636268e43so28165075ad.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 Dec 2024 23:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733815944; x=1734420744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIYaaljMW1uOvyE52JKpg1mRNjsi/3D4cn4UsNQnmlk=;
        b=nNRq3IaSCDLph7zpnboRZ1+zFRDvhhk7V0FKhrFDr39iKyHno9vLzL+r4PWE15tXP5
         IS+2L49n+YGoPTZVK8axS49mFkGdK4HKUHbn5e0/Kv6RRj3DtKUH2L1Aq6Svrn8djXkf
         D4W7pHiLAxgjJMivWGHR9LiwWR5ZrgazL7Ar4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733815944; x=1734420744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIYaaljMW1uOvyE52JKpg1mRNjsi/3D4cn4UsNQnmlk=;
        b=oiAMlI28mBy0RkB2Ww6pl1fqhgc+YBRiyR0NQ5CLEjL7MIiIWjIQ4tUDGa/zTu6/V8
         K0MzWC+Ze2aeaAG4QyIKq+UBlc5OKcirG+elfqeFqWiADgvprj08t5rt8BfLAYIh/gKl
         DU20MhQeJkZMVA7Xahdl1qceooDReX6mtRRmgl+YK4f06k7AhZO9sWjpwAsv3qQ/YzXh
         M27ecUtB4OW66hjxKHDhKtKFUUZUrwgcK5P7J8UQIdjcI4oQmj2gxQsP84lSncEZhLR2
         tsrQAF7N2/S8pyUhDedymEsUtlcVygM/EojdRUx8Ul9uMGgOL+BUdKytnQVglOl7Rgua
         J/jA==
X-Forwarded-Encrypted: i=1; AJvYcCW80UVejtZUFjwQSLbYkSTnVsJnWu5U0QpfeD06p5Ah5jCqMCtM9sJX7xnty8xvAEWnr4mEeIuCPGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSOoTBF25s1hOMttO4JCxMOTNBmjgEwQVzShxIssyFdpFkH/s
	zpiVjqezavYcJeyv1G8QxMzSrhcQMOrLMIfetbtPB2o9hc3CkrhpK8L84h8NQse11nAU79JmYtg
	=
X-Gm-Gg: ASbGnctGWiqoJyTUvyTiPG19DF/N4AmU+s9bhmS8wEN56NUXB7WyRzD+0GJayK1wA2i
	4ajXruHhHtfgGUCIyFpyma3MMzXyxVO+yK2yGcQZd/fHU+3B0DiGUc5xgBk4WOQ0gaOoXIuNX4o
	ndpAB/3qeavfAtK8zTf+0X1OyBqLTkG6Me3socP6tRNsZS6CvR6VlM5yJedFsO7aEdY11IS4o+6
	zb2ijI2zxP2/fXoDbVWAAOiinSITOl44mMHRxxj5ypLaLhBh5/nKjxwtFp3+fk2Kf235KBK
X-Google-Smtp-Source: AGHT+IEljjpPjIkRAq9lZ+wjZ9Q+4usk5mFRZZW08ysh+jkDMPJ/btZlL9SUPYyzmbG9svkENmEq7A==
X-Received: by 2002:a17:902:ce88:b0:216:55a1:35a with SMTP id d9443c01a7336-2166a0097c0mr55964065ad.30.1733815943958;
        Mon, 09 Dec 2024 23:32:23 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:89ce:2db9:f7d5:156d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09146sm83693295ad.199.2024.12.09.23.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 23:32:23 -0800 (PST)
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
Subject: [PATCH v2 2/2] mmc: mtk-sd: Limit getting top_base to SoCs that require it
Date: Tue, 10 Dec 2024 15:32:11 +0800
Message-ID: <20241210073212.3917912-3-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241210073212.3917912-1-wenst@chromium.org>
References: <20241210073212.3917912-1-wenst@chromium.org>
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
device tree entries, and properly fail if it is missing.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


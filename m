Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B62F39DE;
	Wed,  3 Dec 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762350; cv=none; b=cv3VoxlXWqBvHX58EIO2+N38K/mxvKcoV3ziieTzP20spn9KsXucrLJ/VhzLE4DkV0Ez5m1YlQaYkwyhJnwBjVIQDKiarob3MIREQv0RLIQiUVliVS/CsdcK3arorwMLMsf1MlRgZ5XpMubtHUcCckoKV8kLIePoUGRv/9/KtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762350; c=relaxed/simple;
	bh=7rOHPZhf4PD5pAFldbx7LxIk29O+cfxEaxF+eBGZ1tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D54KJ4/uTGXuAqX9lsAk74ZAxLgmmBZNMfNWZzUBUP4PJLib4/BlbjumwLSuCVNqG1wK1ALEIheY5rLyJTf0PymY/UC9Scb+xBdfTwEAXR+geCL6U3U011uywusPS5cjBYHs+WnUNa6S4784Fbr+Bpf7MkXiIgnpjmY2eRcw0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GmhYL6v+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GmhYL6v+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764762347;
	bh=7rOHPZhf4PD5pAFldbx7LxIk29O+cfxEaxF+eBGZ1tw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GmhYL6v+QMpo5rIY30ipper51Gu0HdFzgGWsuDUak1EROzNGEHC9tiF7Ca4IajGDf
	 MzytSZJTCwgTg2J4BKB7g9DR/k6qrsa3Ex2H5XhBaVNqz6tAJedY/GsTFjk60uGhLt
	 EDaI7R325yEFT9cMqFksaRz1g5hew9T4AivNW2YvHOnn4ZHNzuU1oPoVTNtfohMEOJ
	 k4CQ76udrfPEyUOrCC8EynbGf6WMtsKMjjgNLbDiEfH5h5hKFlcwOBOHGtM7FmZxkF
	 RYAP2n+7F3C+mS5aBGOUqBUe8N6NULtqergAmG6/tc5+fcKs77EfPJUxeEjf1A71Yq
	 9eLxvnHmCaLRg==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 769A617E13F2;
	Wed,  3 Dec 2025 12:45:46 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 03 Dec 2025 12:45:36 +0100
Subject: [PATCH 3/3] mmc: mtk-sd: add support for MT8189 SoC
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-mt8189-add-mmc-support-v1-3-f5ce43212fe9@collabora.com>
References: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
In-Reply-To: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: kernel@collabora.com, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764762344; l=1893;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=7rOHPZhf4PD5pAFldbx7LxIk29O+cfxEaxF+eBGZ1tw=;
 b=SLgz3INqPxcoBYI65advm9kShlkIf/WYvat1ohh0WEg1Xbz3muok1O8f7wjV0GWKXmcr+rjgw
 vpfwQNz49lGDcW3y7gPbtg+vco6PO887setn29kDXGgjrU/pYQGoN50
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Even though MMC IP in MT8189 SoC is partially compatible with the one
found in MT8196 SoC, its register layout has some slight differences
and additional features such as the system power management release
resource control support.
Thus, add new compatible and platform data to support this SoC.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4ce596d616409646613748086476c58d8b7b8de9..302ac8529c4f093a541db2d37dcc8709c3775557 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -675,6 +675,25 @@ static const struct mtk_mmc_compatible mt8516_compat = {
 	.stop_dly_sel = 3,
 };
 
+static const struct mtk_mmc_compatible mt8189_compat = {
+	.clk_div_bits = 12,
+	.recheck_sdio_irq = false,
+	.hs400_tune = false,
+	.needs_top_base = true,
+	.pad_tune_reg = MSDC_PAD_TUNE0,
+	.async_fifo = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+	.stop_dly_sel = 1,
+	.pop_en_cnt = 2,
+	.enhance_rx = true,
+	.support_64g = true,
+	.support_new_tx = true,
+	.support_new_rx = true,
+	.support_spm_res_release = true,
+};
+
 static const struct mtk_mmc_compatible mt8196_compat = {
 	.clk_div_bits = 12,
 	.recheck_sdio_irq = false,
@@ -705,6 +724,7 @@ static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
 	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
 	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
+	{ .compatible = "mediatek,mt8189-mmc", .data = &mt8189_compat},
 	{ .compatible = "mediatek,mt8196-mmc", .data = &mt8196_compat},
 	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
 

-- 
2.52.0


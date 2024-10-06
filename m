Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F33184555;
	Sun,  6 Oct 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728228899; cv=none; b=g+a/cAiequ/IyL62+2Tnjt+B+rUNYSNrtVgKjfmAaDUBNNDFMLb+i51v+lBl1qqnq/2VAiH/V5/7CnyD6ybDrUgmxKDyLXqwpE7KXpM0eA6NDQtzmpKcoeYGyT6LxBwnhtP41YS+Q2nbXLiZCwdivHQTolZzvufcPxnweQtM06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728228899; c=relaxed/simple;
	bh=i0VDLMwDuMOVDGFP0bfNMFug3qcxk/uI24ZwMKQ5QrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyy7o/9+JqlCAm7XPOp1pwPb56Xgow/bjZgjrl49q+jggVz1151+xWhg/3J7CzUmFSYLNO9m5oGQLPUAOrNECIUyxon8ITJFaRTqnTg2k4kpsAiIChfDWGFJdHuENbuBAAroTH1OAYIunZYhPB4n+fHbdSyoFbipe3rYA5DUWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=HKUABLJH; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="HKUABLJH"
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id 52737100686;
	Sun,  6 Oct 2024 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1728228895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWad4mvVdtgpAklA0NUqnK9RzmPaXG2g9lgsXi99zSI=;
	b=HKUABLJHoAz5SRjgY0pRJu8+RYC3KnH9d7e0cf8Xz6Cgx6HotlM2ML925NxsOGNpGFJ1Q8
	/Ehrk0kLzCpHTApBUTCH1IHvFY4QRt+qgFVu315+92/6gF3XQ9rEjk6drO/2zNdVcE+rtm
	RySndsd8V9B05mH8nS7ElRgFdg5W8Vo=
Received: from frank-u24.. (fttx-pool-217.61.153.101.bambit.de [217.61.153.101])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 7FC4E100546;
	Sun,  6 Oct 2024 15:34:54 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	daniel@makrotopia.org,
	john@phrozen.org,
	eladwf@gmail.com,
	ansuelsmth@gmail.com
Subject: [PATCH v2 2/2] mmc: mtk-sd: add support for mt7988
Date: Sun,  6 Oct 2024 17:34:46 +0200
Message-ID: <20241006153447.41377-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241006153447.41377-1-linux@fw-web.de>
References: <20241006153447.41377-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 90dd9763-464e-42af-a560-77d9e9212177

From: Frank Wunderlich <frank-w@public-files.de>

Add support for mmc on MT7988 SoC.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/mmc/host/mtk-sd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 89018b6c97b9..6d5afe51a61d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -571,6 +571,19 @@ static const struct mtk_mmc_compatible mt7986_compat = {
 	.support_64g = true,
 };
 
+static const struct mtk_mmc_compatible mt7988_compat = {
+	.clk_div_bits = 12,
+	.recheck_sdio_irq = true,
+	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE0,
+	.async_fifo = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+	.enhance_rx = true,
+	.support_64g = true,
+};
+
 static const struct mtk_mmc_compatible mt8135_compat = {
 	.clk_div_bits = 8,
 	.recheck_sdio_irq = true,
@@ -629,6 +642,7 @@ static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt7620-mmc", .data = &mt7620_compat},
 	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
 	{ .compatible = "mediatek,mt7986-mmc", .data = &mt7986_compat},
+	{ .compatible = "mediatek,mt7988-mmc", .data = &mt7988_compat},
 	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
 	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
 	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
-- 
2.43.0


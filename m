Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E5255E55;
	Tue, 25 Mar 2025 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900836; cv=none; b=smeNy/r2KCaaJWYUGQJOrTZxBptMVbAI2XtTKy/7QRftT9t4JjJWroxF4NYMjKfVrKMkbuc3uUnSxsPA4vPCxZQyokdPoQLGOBv1L/vRNKZIleses01fSl5nMwQKafLfI7ryKjTxmZQkSyE8MJWkJSBHNhJQmWtJPax+mfkxws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900836; c=relaxed/simple;
	bh=6gfZwf9ykxKwOa5PaJOpeqSIrrjjR+YFkwmIKu4UMTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAOCVrDkznkTOxU+hzv2kOjllqkMHQndQLdqjkKVgOoGJGOdni/UrI/v/OYnJB5/hZ/68nzUTvj0EvQkCxlJi/bj8VYRj9e2UtN26hgBtc0SrfX3T5h3mQaGev/EUDEg/k+xrKaO/D8euyI7b8fJanFoGYGuLiOYYj9c5hbBNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i8+hY6E8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i8+hY6E8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742900832;
	bh=6gfZwf9ykxKwOa5PaJOpeqSIrrjjR+YFkwmIKu4UMTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8+hY6E892an2brH4W+uQ5V7R/JmO8lW8mZpQPragEGDMJuPM3Bxbbxhw0d//6wrF
	 gRqHRnYwMGEeVWWu+ACn/hxRBblbn+BgHLptbgrvhygYgepZHIXF1THWiqE8iqg5bA
	 ayzkTuTK+TDKdgGHZpuC1qfAurEv/4opxVXHtXXgq8LTlEJ2m/UV9+rG85+NwYt9xg
	 6a98Hbp+J2IxW4Lt/O+ZyGNz2gh/iZzvRqQkiwUFJ3nJLYeQ02fHDw/InSuoa6hWTw
	 Ypjx164S0Ve096ZVhmnSD+bA0XW6pH1HNl8jqiLATzAoQl4Uie2npsyeAt3hs6vpJE
	 +I82wcNruk8Mw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D1FA917E0FCE;
	Tue, 25 Mar 2025 12:07:11 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chaotian.jing@mediatek.com
Cc: ulf.hansson@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	axe.yang@mediatek.com
Subject: [PATCH 3/4] mmc: mtk-sd: Do single write in function msdc_new_tx_setting
Date: Tue, 25 Mar 2025 12:07:00 +0100
Message-ID: <20250325110701.52623-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325110701.52623-1-angelogioacchino.delregno@collabora.com>
References: <20250325110701.52623-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of reading and writing the LOOP_TEST_CONTROL register for
each set or cleared bit, read it once, modify the contents in a
local variable, and then write once.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index dd3f7468d32c..e9e84b9a65f0 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -942,15 +942,15 @@ static int msdc_ungate_clock(struct msdc_host *host)
 
 static void msdc_new_tx_setting(struct msdc_host *host)
 {
+	u32 val;
+
 	if (!host->top_base)
 		return;
 
-	sdr_set_bits(host->top_base + LOOP_TEST_CONTROL,
-		     TEST_LOOP_DSCLK_MUX_SEL);
-	sdr_set_bits(host->top_base + LOOP_TEST_CONTROL,
-		     TEST_LOOP_LATCH_MUX_SEL);
-	sdr_clr_bits(host->top_base + LOOP_TEST_CONTROL,
-		     TEST_HS400_CMD_LOOP_MUX_SEL);
+	val = readl(host->top_base + LOOP_TEST_CONTROL);
+	val |= TEST_LOOP_DSCLK_MUX_SEL;
+	val |= TEST_LOOP_LATCH_MUX_SEL;
+	val &= ~TEST_HS400_CMD_LOOP_MUX_SEL;
 
 	switch (host->timing) {
 	case MMC_TIMING_LEGACY:
@@ -960,19 +960,18 @@ static void msdc_new_tx_setting(struct msdc_host *host)
 	case MMC_TIMING_UHS_SDR25:
 	case MMC_TIMING_UHS_DDR50:
 	case MMC_TIMING_MMC_DDR52:
-		sdr_clr_bits(host->top_base + LOOP_TEST_CONTROL,
-			     LOOP_EN_SEL_CLK);
+		val &= ~LOOP_EN_SEL_CLK;
 		break;
 	case MMC_TIMING_UHS_SDR50:
 	case MMC_TIMING_UHS_SDR104:
 	case MMC_TIMING_MMC_HS200:
 	case MMC_TIMING_MMC_HS400:
-		sdr_set_bits(host->top_base + LOOP_TEST_CONTROL,
-			     LOOP_EN_SEL_CLK);
+		val |= LOOP_EN_SEL_CLK;
 		break;
 	default:
 		break;
 	}
+	writel(val, host->top_base + LOOP_TEST_CONTROL);
 }
 
 static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
-- 
2.48.1


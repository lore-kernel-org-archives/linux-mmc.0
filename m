Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7381255E51;
	Tue, 25 Mar 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900836; cv=none; b=Fucq6nK/vPcWBsFvkkLtUqzlH4e5SMQuNYDXqQlWByXbYdO4XsDEHIq9OeuXqNLC/PiIVnSqDCGE6AqnAViVXXDwEL4k4YJZ/rM70pyYbSIgxGUQ5Pr5jUxp1vq/gb+KdaqLsrMYkmaV7Y9e52BcHoW0dhwOY/2gg2xK30ZeFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900836; c=relaxed/simple;
	bh=tQdqC3X/w6Ew7CJsG7Mg8Rjon894mVM5eCrZJ+b+ETk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYcSOa08R3CJQpGDipafCFCdHNdZVY3eEGuvfL2dc+af6r8ITGvSuB+CwOzaLYP/79YrsGonuMn+FDJwEV7557VvYkqV6judtKQ0duclniy+X9aKJumU/YVkwqZFuuKQhLmgUeoySlmcJ7WRvdt4ii/jYOYei84oxgEt0I4TvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QmByxQk8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QmByxQk8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742900833;
	bh=tQdqC3X/w6Ew7CJsG7Mg8Rjon894mVM5eCrZJ+b+ETk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QmByxQk8kS9IT0dTWY5RsURyRDWudypZFoLsYt8y4lxb09ejm44kEWdATNUdb27x7
	 rGaZCQje0IBK2monEAqbMgpmVpFkZW3Ip6VUnE2aQUiLud/KHH9TPv2fP4s4WHOQfQ
	 cRDng2Spse7Xm0uwigQPOuIfxtLvrg8curOxeY+ETMZEJb5ahA9jH4kuBrugSeAEMR
	 N94MoFIlyfzGmmbOhu0BXIql/+6SBuoGbzu+W0see4aIuQOWOJKL7PIUQ4DmKaq6k+
	 qliaRRU340r0Dolvh+/1m8uTLLXUJQZG/096I8+q4V7JwYx0jWp5KWTRe5FMdeQeEU
	 PczIurXzbt+7w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8F25C17E0FD1;
	Tue, 25 Mar 2025 12:07:12 +0100 (CET)
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
Subject: [PATCH 4/4] mmc: mtk-sd: Aggregate R/W for top_base iospace case where possible
Date: Tue, 25 Mar 2025 12:07:01 +0100
Message-ID: <20250325110701.52623-5-angelogioacchino.delregno@collabora.com>
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

In case the controller uses the top_base iospace, most register
read/writes can be changed from multiple RWs to a single read
and a single write.

Where possible, and where it makes sense, aggregate the multiple
reads and writes to just one.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 52 +++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index e9e84b9a65f0..ceeae1aeac94 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1975,18 +1975,19 @@ static void msdc_init_hw(struct msdc_host *host)
 
 	if (host->dev_comp->data_tune) {
 		if (host->top_base) {
-			sdr_set_bits(host->top_base + EMMC_TOP_CONTROL,
-				     PAD_DAT_RD_RXDLY_SEL);
-			sdr_clr_bits(host->top_base + EMMC_TOP_CONTROL,
-				     DATA_K_VALUE_SEL);
-			sdr_set_bits(host->top_base + EMMC_TOP_CMD,
-				     PAD_CMD_RD_RXDLY_SEL);
+			u32 top_ctl_val = readl(host->top_base + EMMC_TOP_CONTROL);
+			u32 top_cmd_val = readl(host->top_base + EMMC_TOP_CMD);
+
+			top_cmd_val |= PAD_CMD_RD_RXDLY_SEL;
+			top_ctl_val |= PAD_DAT_RD_RXDLY_SEL;
+			top_ctl_val &= ~DATA_K_VALUE_SEL;
 			if (host->tuning_step > PAD_DELAY_HALF) {
-				sdr_set_bits(host->top_base + EMMC_TOP_CONTROL,
-					     PAD_DAT_RD_RXDLY2_SEL);
-				sdr_set_bits(host->top_base + EMMC_TOP_CMD,
-					     PAD_CMD_RD_RXDLY2_SEL);
+				top_cmd_val |= PAD_CMD_RD_RXDLY2_SEL;
+				top_ctl_val |= PAD_DAT_RD_RXDLY2_SEL;
 			}
+
+			writel(top_ctl_val, host->top_base + EMMC_TOP_CONTROL);
+			writel(top_cmd_val, host->top_base + EMMC_TOP_CMD);
 		} else {
 			sdr_set_bits(host->base + tune_reg,
 				     MSDC_PAD_TUNE_RD_SEL |
@@ -2196,15 +2197,17 @@ static inline void msdc_set_cmd_delay(struct msdc_host *host, u32 value)
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
 
 	if (host->top_base) {
+		u32 regval = readl(host->top_base + EMMC_TOP_CMD);
+
+		regval &= ~(PAD_CMD_RXDLY | PAD_CMD_RXDLY2);
+
 		if (value < PAD_DELAY_HALF) {
-			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY, value);
-			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY2, 0);
+			regval |= FIELD_PREP(PAD_CMD_RXDLY, value);
 		} else {
-			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
-				      PAD_DELAY_HALF - 1);
-			sdr_set_field(host->top_base + EMMC_TOP_CMD, PAD_CMD_RXDLY2,
-				      value - PAD_DELAY_HALF);
+			regval |= FIELD_PREP(PAD_CMD_RXDLY, PAD_DELAY_HALF - 1);
+			regval |= FIELD_PREP(PAD_CMD_RXDLY2, value - PAD_DELAY_HALF);
 		}
+		writel(regval, host->top_base + EMMC_TOP_CMD);
 	} else {
 		if (value < PAD_DELAY_HALF) {
 			sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY, value);
@@ -2224,17 +2227,18 @@ static inline void msdc_set_data_delay(struct msdc_host *host, u32 value)
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
 
 	if (host->top_base) {
+		u32 regval = readl(host->top_base + EMMC_TOP_CONTROL);
+
+		regval &= ~(PAD_DAT_RD_RXDLY | PAD_DAT_RD_RXDLY2);
+
 		if (value < PAD_DELAY_HALF) {
-			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-				      PAD_DAT_RD_RXDLY, value);
-			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-				      PAD_DAT_RD_RXDLY2, 0);
+			regval |= FIELD_PREP(PAD_DAT_RD_RXDLY, value);
+			regval |= FIELD_PREP(PAD_DAT_RD_RXDLY2, value);
 		} else {
-			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-				      PAD_DAT_RD_RXDLY, PAD_DELAY_HALF - 1);
-			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
-				      PAD_DAT_RD_RXDLY2, value - PAD_DELAY_HALF);
+			regval |= FIELD_PREP(PAD_DAT_RD_RXDLY, PAD_DELAY_HALF - 1);
+			regval |= FIELD_PREP(PAD_DAT_RD_RXDLY2, value - PAD_DELAY_HALF);
 		}
+		writel(regval, host->top_base + EMMC_TOP_CONTROL);
 	} else {
 		if (value < PAD_DELAY_HALF) {
 			sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_DATRRDLY, value);
-- 
2.48.1


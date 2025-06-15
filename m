Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DE264608;
	Sun, 15 Jun 2025 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749959913; cv=none; b=e3vj0luoGXvReqYKlk9fq/eGI2VHnNNa+qbHckdykp5oDH3tCwUsS601YqoSxrRDXJifwXcvhIy8m8hu64spS7L47oln3Sfc5yOanHeXcIcwRlGky63KSj5tSXSSaqDfyqfPcDX+ourdeWpHJqJVnuspFARDpLStSXuIra1mPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749959913; c=relaxed/simple;
	bh=bHUS/Tk9LMBg9lQIuPHoyB6SeTAcyZ0KY8ozl+YM+RE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo+8XUk3vvwwKnOft3OdPE98YIq0UjBMPLLpXpvldzmtCTrV7njTWerEbNijRWMvKAgFjHOZoZE4HDnqaGfXw3wqcn9hCvLSyCSKcCpRc03vKKk2DHaGK6EoIVS5ofMNci/Ba1t8r+w8lnQebaPsnEjJFl6bzVT+MTt7tfiBQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 15 Jun
 2025 11:58:04 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 15 Jun 2025 11:58:04 +0800
From: Cool Lee <cool_lee@aspeedtech.com>
To: <andrew@codeconstruct.com.au>, <adrian.hunter@intel.com>,
	<ulf.hansson@linaro.org>, <joel@jms.id.au>, <p.zabel@pengutronix.de>,
	<linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] mmc: sdhci-of-aspeed: Add output timing phase tuning
Date: Sun, 15 Jun 2025 11:58:01 +0800
Message-ID: <20250615035803.3752235-7-cool_lee@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enhance auto tuning with input and output calibration.

Signed-off-by: Cool Lee <cool_lee@aspeedtech.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 48 ++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 22dde915e51b..92687fc30d1d 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -25,6 +25,7 @@
 #define   ASPEED_SDC_S1_PHASE_IN	GENMASK(25, 21)
 #define   ASPEED_SDC_S0_PHASE_IN	GENMASK(20, 16)
 #define   ASPEED_SDC_S0_PHASE_IN_SHIFT  16
+#define   ASPEED_SDC_S0_PHASE_OUT_SHIFT 3
 #define   ASPEED_SDC_S1_PHASE_OUT	GENMASK(15, 11)
 #define   ASPEED_SDC_S1_PHASE_IN_EN	BIT(10)
 #define   ASPEED_SDC_S1_PHASE_OUT_EN	GENMASK(9, 8)
@@ -422,7 +423,7 @@ static int aspeed_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 		}
 
 		window = right - left;
-		dev_info(dev, "tuning window = %d\n", window);
+		dev_dbg(dev, "tuning window[%d][%d~%d] = %d\n", edge, left, right, window);
 
 		if (window > oldwindow) {
 			oldwindow = window;
@@ -433,7 +434,50 @@ static int aspeed_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 	val = (out_phase | enable_mask | (center << ASPEED_SDC_S0_PHASE_IN_SHIFT));
 	writel(val, sdc->regs + ASPEED_SDC_PHASE);
 
-	dev_info(dev, "tuning result=%x\n", val);
+	dev_dbg(dev, "input tuning result=%x\n", val);
+
+	inverted = 0;
+	out_phase = val & ~ASPEED_SDC_S0_PHASE_OUT;
+	in_phase = out_phase;
+	oldwindow = 0;
+
+	for (edge = 0; edge < 2; edge++) {
+		if (edge == 1)
+			inverted = ASPEED_SDHCI_TAP_PARAM_INVERT_CLK;
+
+		val = (in_phase | enable_mask | (inverted << ASPEED_SDC_S0_PHASE_OUT_SHIFT));
+
+		/* find the left boundary */
+		for (left = 0; left < ASPEED_SDHCI_NR_TAPS + 1; left++) {
+			out_phase = val | (left << ASPEED_SDC_S0_PHASE_OUT_SHIFT);
+			writel(out_phase, sdc->regs + ASPEED_SDC_PHASE);
+
+			if (!mmc_send_tuning(host->mmc, opcode, NULL))
+				break;
+		}
+
+		/* find the right boundary */
+		for (right = left + 1; right < ASPEED_SDHCI_NR_TAPS + 1; right++) {
+			out_phase = val | (right << ASPEED_SDC_S0_PHASE_OUT_SHIFT);
+			writel(out_phase, sdc->regs + ASPEED_SDC_PHASE);
+
+			if (mmc_send_tuning(host->mmc, opcode, NULL))
+				break;
+		}
+
+		window = right - left;
+		dev_info(dev, "tuning window[%d][%d~%d] = %d\n", edge, left, right, window);
+
+		if (window > oldwindow) {
+			oldwindow = window;
+			center = (((right - 1) + left) / 2) | inverted;
+		}
+	}
+
+	val = (in_phase | enable_mask | (center << ASPEED_SDC_S0_PHASE_OUT_SHIFT));
+	writel(val, sdc->regs + ASPEED_SDC_PHASE);
+
+	dev_dbg(dev, "output tuning result=%x\n", val);
 
 	return mmc_send_tuning(host->mmc, opcode, NULL);
 }
-- 
2.34.1


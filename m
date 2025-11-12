Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C23155C97;
	Wed, 12 Nov 2025 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762907534; cv=none; b=GQujTM/9iE9DaYhneW23sW+o6K4tS453kAwEvpRFWtIle4ah3jLqxyf/QcSngq0zdpmagunjAnwwpsF2RdLT4HPvYrg/c6BZZJF1oamouZNWfy3ipT7JasoFpc8lyM6OVJyC8qd8iD2HbzadUDjSywWxZttNCI/OARSeclDF5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762907534; c=relaxed/simple;
	bh=EKQB2ioNu47riqAdcpw9niW4VnYXoNetzqx4WN7e1II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bp3kGpx9UCSzI5GoIRd9ws+0xlJDixan8bF/CYfoBibODQj8PqVp/k2zoGm39fqDA2WLcrFZ0ATaQO67GCN+4Q9mXQLO5P4UEjMqTtabPnsH2E57933jlkRmQUMs3yWTRKX3Hmp0RzLWST+3X8gfuibgL/0R6r4nj34PyZvllTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/h2+19x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/h2+19x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63479C4AF09;
	Wed, 12 Nov 2025 00:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762907533;
	bh=EKQB2ioNu47riqAdcpw9niW4VnYXoNetzqx4WN7e1II=;
	h=From:To:Cc:Subject:Date:From;
	b=C/h2+19xISoHknJ4bm1dQpALU3kL9x7AstdRma/pnKIFMsSduI6zXJkfF+UwE7qxr
	 EKFmxvyzQwsZ/mf70DuDd8Yyq2OSwt9uk5VnwLNwvJRKiibNvbkYKuDBB60bhL8DkI
	 TTlDj5NVPtRiyNn/Fmqw+jT8DTi4XkNIyAYFqRXuHKKtDW2xZvkFlHogqVTPxYMceH
	 tp8J9gCGbjbkImy0p7a3Qe9OzF+s3Z/uc4Ocqh0mJTG6B9eMX7qjIJ+m44Qtq/RKW9
	 c5thc60VFBr8yboSZHxA6uKeOMTivDk1gAX9iff0YwaQ6JwUp84HcrkJXbqrnpTp6B
	 nErJhLQSS1u1Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Promote the th1520 reset handling to ip level
Date: Wed, 12 Nov 2025 08:14:26 +0800
Message-ID: <20251112001426.17252-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 27e8fe0da3b7 ("mmc: sdhci-of-dwcmshc: Prevent stale command
interrupt handling") clears pending interrupts when resetting
host->pending_reset to ensure no pending stale interrupts after
sdhci_threaded_irq restores interrupts. But this fix is only added for
th1520 platforms, in fact per my test, this issue exists on all
dwcmshc users, such as cv1800b, sg2002, and synaptics platforms.

So promote the above reset handling from th1520 to ip level.

Fixes: 017199c2849c ("mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 35 ++++++++++++++++-------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index eebd45389956..c17168edc9fd 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -289,6 +289,19 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
 	sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
+static void dwcmshc_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_reset(host, mask);
+
+	/* The dwcmshc does not comply with the SDHCI specification
+	 * regarding the "Software Reset for CMD line should clear 'Command
+	 * Complete' in the Normal Interrupt Status Register." Clear the bit
+	 * here to compensate for this quirk.
+	 */
+	if (mask & SDHCI_RESET_CMD)
+		sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
+}
+
 static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -686,7 +699,7 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 		reset_control_deassert(priv->reset);
 	}
 
-	sdhci_reset(host, mask);
+	dwcmshc_reset(host, mask);
 }
 
 static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
@@ -832,15 +845,7 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	u16 ctrl_2;
 
-	sdhci_reset(host, mask);
-
-	/* The T-Head 1520 SoC does not comply with the SDHCI specification
-	 * regarding the "Software Reset for CMD line should clear 'Command
-	 * Complete' in the Normal Interrupt Status Register." Clear the bit
-	 * here to compensate for this quirk.
-	 */
-	if (mask & SDHCI_RESET_CMD)
-		sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
+	dwcmshc_reset(host, mask);
 
 	if (priv->flags & FLAG_IO_FIXED_1V8) {
 		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
@@ -886,7 +891,7 @@ static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	u32 val, emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
 
-	sdhci_reset(host, mask);
+	dwcmshc_reset(host, mask);
 
 	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
 		val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
@@ -958,7 +963,7 @@ static void cv18xx_sdhci_post_tuning(struct sdhci_host *host)
 	val |= SDHCI_INT_DATA_AVAIL;
 	sdhci_writel(host, val, SDHCI_INT_STATUS);
 
-	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	dwcmshc_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 }
 
 static int cv18xx_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
@@ -1080,7 +1085,7 @@ static inline void sg2042_sdhci_phy_init(struct sdhci_host *host)
 
 static void sg2042_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
-	sdhci_reset(host, mask);
+	dwcmshc_reset(host, mask);
 
 	if (mask & SDHCI_RESET_ALL)
 		sg2042_sdhci_phy_init(host);
@@ -1100,7 +1105,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
 	.get_max_clock		= dwcmshc_get_max_clock,
-	.reset			= sdhci_reset,
+	.reset			= dwcmshc_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 	.irq			= dwcmshc_cqe_irq_handler,
 };
@@ -1121,7 +1126,7 @@ static const struct sdhci_ops sdhci_dwcmshc_bf3_ops = {
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
 	.get_max_clock		= dwcmshc_get_max_clock,
-	.reset			= sdhci_reset,
+	.reset			= dwcmshc_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 	.irq			= dwcmshc_cqe_irq_handler,
 	.hw_reset		= dwcmshc_bf3_hw_reset,
-- 
2.50.0


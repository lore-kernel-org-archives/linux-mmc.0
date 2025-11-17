Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672BE36B;
	Mon, 17 Nov 2025 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763338762; cv=none; b=rjmy53Gf5TyiVVNI9Pbd+/rasqo2sNUB5IAs1IbhEYJ8LhI5bPhW4+1GYEPfCW8FXmNvdL+9ELYV2g5WewBnwnozA29QKq3EkEtPFLmkgxzBgUQ4aHMPC9wqnJm0WVb0BU+sUM0HIuWzuWYqZ94sw5BRSzrLVWqBDn7Rg9kwA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763338762; c=relaxed/simple;
	bh=ioh45gwWAMsIBAuBW5n+SDcbuFnEqg8xH7CdINw5IKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8/c5UyJ4ypnJs6P6auC7VfTe+3rgWLD2noc3+9mYRDt5GWkvWfe9Pk9arQ8MLQI/1SJXBxxdEoEwEe0Kq7k27T41d+TfBvxfyrybDbG9WcDNdoxvBxRhVNfmqEByujgR9gtDS0zUYYZkB99qbdB2/fFqCK2QkQHoWftEOq2mHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nogTCqiH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nogTCqiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB680C116D0;
	Mon, 17 Nov 2025 00:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763338761;
	bh=ioh45gwWAMsIBAuBW5n+SDcbuFnEqg8xH7CdINw5IKY=;
	h=From:To:Cc:Subject:Date:From;
	b=nogTCqiHookAKqfS9WxjC/SI8plw/7vINCPqVxNjZJaY+RSiT3hDgqxDYv5lTb6UZ
	 u+vboxnMBjGTGtbrc5Crj1d9yH+bjpFYpg8qj78SFcumGdZktKpin/nHu9HxzxSKGm
	 dYwXM2519BIQOayFEb1QtlMvRlhroW6D8pzYzI6GusqMTRSpQt7mQRfU7r4DcQPETD
	 k5NdQwRQF8WZwnqMPHSNZqgy5BRQ78LsODM0U41TYxcJNDwNxocWMkQhzq2KyuBNN0
	 7lFCGL2cS+Mmq8lImoxddrumjfDrZRcpUrQtSitjYR2t4DdGgPBpr87g+I9Bd7IL+I
	 eodOu/ee/av6A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawn.lin@rock-chips.com
Subject: [PATCH v2] mmc: sdhci-of-dwcmshc: Promote the th1520 reset handling to ip level
Date: Mon, 17 Nov 2025 08:01:32 +0800
Message-ID: <20251117000132.12131-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
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

So promote the above reset handling from th1520 to ip level. And keep
reset handling on rk, sg2042 and bf3 as is, until it's confirmed that
the same issue exists on these platforms too.

Fixes: 017199c2849c ("mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
since v1:
 - limit the promotion to only cv1800b, sg2002 and generic dwcmshc

 drivers/mmc/host/sdhci-of-dwcmshc.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index eebd45389956..07e5df0f8beb 100644
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
@@ -1100,7 +1105,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
 	.get_max_clock		= dwcmshc_get_max_clock,
-	.reset			= sdhci_reset,
+	.reset			= dwcmshc_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 	.irq			= dwcmshc_cqe_irq_handler,
 };
-- 
2.51.0


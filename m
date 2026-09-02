Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93C3CB2DB;
	Wed,  2 Sep 2026 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332626; cv=none; b=cxY2dYSRMK3t/Szde1C3Vx+CXXdq+jWSOgBAgCJHCcWlOOvOFRDSzREyDTUM3fxDjnpvlyLQCDaNY22NykeHG+1xixm9I+BzKm9NgWEtQMtKzbBbh+XpPhwzO+gLXtoPsJOg7BOOm44gEHkBJnGTJkkjPGxWxKP9are2j7/gqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332626; c=relaxed/simple;
	bh=N+onsIpN7i1t2Coa7S6kLlV/TfAA5dYVZFHJST7H/6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ASum2RSNvROjz+GIzzRAYSIMUfLjUs2gxEnPIOqupipq+Xd/63284ujy2ZLWrGrFLIHS8mLmQE13SymgKmJjSjFyuTABZ5k5kLJ0Ay4qHbIogaDN3Ul6/ckxGFgWobbfMXwK3xzGXLToMrGvLVddl+bgrB3K2BsEOQ/Jeyn/ecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5xrr/1y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5xrr/1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F771F00A3A;
	Wed,  2 Sep 2026 07:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788332624;
	bh=ECyP0docozOqo+POubZUdu/wkpSW+1NuQQaSDOlyVC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C5xrr/1ytXtYzOmQDkgsxEFgVBO+EWwU9xcwkIINV7+NLq1Xg47oKjjSGhS4JCym7
	 omNmZdEE2Pbof35cuFbQrZhddQceCJsvO0oNx/gp1Y5L77sZYDPw3fVQ49Bo45cKrw
	 ETGVENA7PG+B6Wh8jQtP1b7IpRdHECG4sYNQ1rDZ9lVHEU6RRQ4mTFfdFnfMOHu1jI
	 TetpSEelH97jEo0fMMT0aj4DK4gu3bNL8b0IrydnTQeMvB2Ib8YOk0RYnA0+IjnfZT
	 2ZDZbLpLQb3Odr8eOG0xr+8OynLbi2bAcENvtB1cIXAjVXLfsWn4Lu4l3kOGyoR/Xm
	 BTb31PpUhObSQ==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 02 Sep 2026 07:03:15 +0000
Subject: [PATCH 4/4] mmc: sdhci-of-k1: Add TX tuning parameter
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-07-k3-sdhci-dts-v1-4-4e7909cf4233@kernel.org>
References: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
In-Reply-To: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2977; i=dlan@kernel.org;
 h=from:subject:message-id; bh=3uz4FJ0LT6upjBL2hQH3AOnAQaSXZgnr5H5kakl7pJA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBql8pA1dlln4e0W6rHtxupS1J3C+SpP1K97YWff
 YcOa8a104yJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCapfKQBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2Qyw/+P1hdoqOlwCmm3uJT+I5lCO8Bt/fEREJT4Rdm37SMw2fikHVs3ykU2
 zULPpfPbm2pKJak2kUVTGsakdZjEMPOuoZzU4p/ce7j4o0claO/JUp6pqOlTtqGI9qCjwKDhdTK
 rZjXl/aIEYXiBWr1wT48J4CoZz0gniWbbYihkNFk9Bd8iS2pQkUvqSXQK25uagF9kwmO13ZC/Kz
 6M62CAq1bnw0lovsov7sKAz3eAH1ZXLgjnu6aqXmqgeWKnflBmv4nbnDVGlbd0WkSLjkgE8sp+t
 25x763BDANXUPZP4JdcdSVjIIElVSTF1PMJldG57BXUc73NbMc2XvOIMittkgeUo7rFacwX/wd/
 OQbcoJxrUAHSnrYqjCf3+3BcsNVpqaGVCc6dozgNuMjdhsG6pVJ+wj1UNKvqlwj55yRkD4Jdk49
 BtRcAUt2Fzg1hbWPgRW/16n4iwHhx7oHAmR8ymQ34KxeoxHLWuK2ViQXpMIcQJR9eyyvaCz360O
 zEg+zeSpaSbjxIPi4DGnTiJmfuVHxv7aKy1RYj5kkUidd5exYF0r6sNPWuhVIZvzHabc6VcX35O
 fG485+YjnM4nvPWMQliHOLUEWarqeRU9A/qOLthC+KI1OuMUZOuAw0F5i6Q2MispEg1d3vzeshY
 OzJ2/6eAwKnc/Zimv4deW6kRitcPDM=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Long Wan <long.wan@linux.spacemit.com>

Instead of setting the TX delay code via hardcoded parameter, configuring
it via device tree property, which make it able to adapt according to
board specific tuning requirement.

Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index e6ab40c9a555..6cab06332747 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -97,6 +97,7 @@ struct spacemit_sdhci_host {
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pinctrl_default;
 	struct pinctrl_state *pinctrl_uhs;
+	u8 tx_delaycode;
 };
 
 /* All helper functions will update clr/set while preserve rest bits */
@@ -263,6 +264,7 @@ static int spacemit_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 	int max_pass_len = 0, max_pass_start = 0;
 	struct mmc_host *mmc = host->mmc;
 	struct mmc_ios ios = mmc->ios;
+	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(sdhci_priv(host));
 	u8 final_delay;
 	int ret = 0;
 	int i;
@@ -279,11 +281,11 @@ static int spacemit_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 
 	if (mmc->caps2 & MMC_CAP2_NO_MMC) {
 		spacemit_sdhci_set_tx_dline_reg(host, SPACEMIT_TX_TUNING_DLINE_REG);
-		spacemit_sdhci_set_tx_delay(host, SPACEMIT_TX_TUNING_DELAYCODE);
+		spacemit_sdhci_set_tx_delay(host, sdhst->tx_delaycode);
 		spacemit_sdhci_tx_tuning_prepare(host);
 
 		dev_dbg(mmc_dev(host->mmc), "TX tuning: dline_reg=%d, delaycode=%d\n",
-			SPACEMIT_TX_TUNING_DLINE_REG, SPACEMIT_TX_TUNING_DELAYCODE);
+			SPACEMIT_TX_TUNING_DLINE_REG, sdhst->tx_delaycode);
 	}
 
 	spacemit_sdhci_prepare_tuning(host);
@@ -496,6 +498,23 @@ static inline void spacemit_sdhci_get_pins(struct device *dev,
 		sdhst->pinctrl_default, sdhst->pinctrl_uhs);
 }
 
+static void spacemit_sdhci_get_tuning_params(struct device *dev,
+					     struct sdhci_pltfm_host *pltfm_host)
+{
+	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
+	u32 val;
+
+	sdhst->tx_delaycode = SPACEMIT_TX_TUNING_DELAYCODE;
+
+	/* Override from DT property */
+	if (!device_property_read_u32(dev, "spacemit,tx-delay", &val)) {
+		if (val <= U8_MAX)
+			sdhst->tx_delaycode = val;
+		else
+			dev_warn(dev, "ignoring invalid tx delay: %u\n", val);
+	}
+}
+
 static const struct sdhci_ops spacemit_sdhci_ops = {
 	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
 	.reset			= spacemit_sdhci_reset,
@@ -571,6 +590,8 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
 
 	spacemit_sdhci_get_pins(dev, pltfm_host);
 
+	spacemit_sdhci_get_tuning_params(dev, pltfm_host);
+
 	host->mmc_host_ops.start_signal_voltage_switch = spacemit_sdhci_start_signal_voltage_switch;
 
 	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);

-- 
2.55.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B95382380;
	Wed,  2 Sep 2026 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336316; cv=none; b=iBrDL9napf3se1ddJ67QEMJpXIpq7Am0bGMJ79s32VGeIRAevX5qpGp0HBYQ1BP8NdkxmXlWqhxNn8bpgiCREw1HX4Vy/7PnHpTH+NZQ8nkzepJnoA8oNA5DouoRK9u3vYsnQxL5qfWu0X6JzsOraLwwXxLwDgJIx/mqIUsTZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336316; c=relaxed/simple;
	bh=/ZIvAw8yqWGKaG2zienrjgmA7aWZeUru02p2TWxLLvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSU+NYBetPjht1ZSfwwwtDqIm2ZFCFkqDqUCTPOQP2Qr4NxFbuGk4KissZ/fLXuSsHKVgTbY8dsnn0MczsuasGCQjaIdFeoTsrcOi5ePY7MHwSpc8fFzWW1FvLhkMgs/gJLwlkJXvp6+7VyP1kZEx6F+TGuIqWxjQ9gnpzaCdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMt18JAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMt18JAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4374C1F000E9;
	Wed,  2 Sep 2026 08:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788336314;
	bh=F0wV2qcV3xxb/dUlan84uLPgJlsVQkSyunOuVaREOOk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cMt18JAki31A4EN00Hj94bVx5jLZjMn81AvQT6ategSfVUWLtHV28QeyfgmIHrLOp
	 z8WsuZ3doV68VHvWpkdWW9nMwVoooDSVSbKXYZ014kOOuXwRFNsz8DHc0RW1HcvrNw
	 TvEsDJeaNqG3J1ExxywiExlhDJ3tEdGBhbSEbg9uzP0K+UB3tWHWxA0V4ajRZT1qSD
	 fZkL48EdM5sNaUOmBRc0vmX0PWKUOYqhQmM4mTQ5Tn0MHfSa86Z//anF2ZyC8IQW/L
	 IUNVNwJzOKyg2SZDfzmiqkXd33VKpNCViH0xlwGl4nJuEp4HxAGH5kTAhJi0jf/+vD
	 BIwCrLlNXB7Zg==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 02 Sep 2026 08:04:28 +0000
Subject: [PATCH 7/7] mmc: sdhci-of-k1: Implement SD clock gating for
 voltage switch
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-07-k3-sdhci-fix-v1-7-b15c5d0f64fd@kernel.org>
References: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
In-Reply-To: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4567; i=dlan@kernel.org;
 h=from:subject:message-id; bh=JcwwxWmRjUMzK+qEox84Kkiw71OgSbs3W3gBg84tHxE=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBql9in4tLIbAiMHmRZnoPmzJf6TJCSeFaRAdVbc
 HIQPm/4pM2JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCapfYpxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2IBg/5ARLXlb2b/ww0rz6+6x4Vgw8EkL2ssItSyrO9UKUd6GkvgUJDcsXwJ
 si4YF/6F+cAN7X2IlXZg+EVlRExtSkJFpm5FT/it9bvL0TIt1z2IhtTa91oytciO+NlH+p3+uod
 /3x9h+gMBYuIc//crPH8G+xynvfXmDWEX8Pqs+c2uWSXnkfD0gclJMUyRHwo3ftyPMqJd5rjepS
 Swx120eceepZF0txIsZXUVQNlemy4HX/zor7dkdAHTC1iVPxEJwcCGDYwm+tYli1wR7r79YLu05
 CRfP6VvD/JqtFjn/Es3W7Kty1MFrg1kOLBLe4vLvKihjY5Um7n0pzxPWv2RwZdkJmcmHEZVpTaG
 6VR0zGwGKsik/theLcLG3Ev+AQjq9+GGRfrpQwIhs6cPUcypyacnNQtKhhs3m+SZ9TYY+M7dzcn
 YCB4BIq1OaDabieOoYrFkB56fOBjutw+Lry99vASpf05A7/JjTXbq+Bz1W4EYYvlPVBZM6dbelS
 sq7K9EzVV96srxi8TghxV2ZOVgxXHOSyvCjeUiO2F+Yp+RCpjd4m1lzUIaOA/Wff/n4FwnTaoAv
 S3XzyYiP6yVlYLPrKi6QI+jnAkBHBzL9nwu7/IkL9Je0OxhKujYGTol2F6/wKJY1qz2FnLrT6DY
 mHFZjn5W5pv/ZUKnFtIYDEJu1Twy40=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Long Wan <long.wan@linux.spacemit.com>

reset() permanently set OVRRD_CLK_OEN and FORCE_CLK_ON for SD/SDIO hosts
and never cleared them, so the SD clock was forced on for the lifetime of
the controller and hardware auto gating never took effect.

These bits are only needed during the CMD11 1.8V voltage switch, where
the clock has to keep running so DAT[3:0] can be sampled after the
switch. Add a set_clk_gate() helper, force the clock on from set_clock()
when CMD11 is in flight, and restore auto gating from card_busy() once
the switch completes.

card_busy() is registered for all card types since the CMD11 sequence is
an SD/SDIO path and the DAT[0] level check is generic.

Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 49 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index a07e7db0853e..5260421d394c 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -12,6 +12,7 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -162,6 +163,16 @@ static void spacemit_sdhci_prepare_tuning(struct sdhci_host *host)
 		spacemit_sdhci_setbits(host, SDHC_HS200_USE_RFIFO, SPACEMIT_SDHC_PHY_FUNC_REG);
 }
 
+static void spacemit_sdhci_set_clk_gate(struct sdhci_host *host, unsigned int auto_gate)
+{
+	if (auto_gate)
+		spacemit_sdhci_clrbits(host, SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON,
+				       SPACEMIT_SDHC_OP_EXT_REG);
+	else
+		spacemit_sdhci_setbits(host, SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON,
+				       SPACEMIT_SDHC_OP_EXT_REG);
+}
+
 static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	sdhci_reset(host, mask);
@@ -172,9 +183,6 @@ static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
 	if (host->mmc->caps2 & MMC_CAP2_NO_MMC) {
 		/* SD/SDIO: bypass PHY, use TX internal clock */
 		spacemit_sdhci_setbits(host, SDHC_TX_INT_CLK_SEL, SPACEMIT_SDHC_TX_CFG_REG);
-
-		spacemit_sdhci_setbits(host, SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON,
-				       SPACEMIT_SDHC_OP_EXT_REG);
 	} else {
 		/* eMMC: use PHY function mode */
 		spacemit_sdhci_setbits(host, SDHC_PHY_FUNC_EN | SDHC_PHY_PLL_LOCK,
@@ -209,6 +217,20 @@ static void spacemit_sdhci_set_clock(struct sdhci_host *host, unsigned int clock
 		spacemit_sdhci_clrbits(host, SDHC_TX_INT_CLK_SEL, SPACEMIT_SDHC_TX_CFG_REG);
 
 	sdhci_set_clock(host, clock);
+
+	if (host->mmc->caps2 & MMC_CAP2_NO_MMC) {
+		/*
+		 * During CMD11 voltage switch to 1.8V, temporarily force the
+		 * clock on to ensure DAT[3:0] can be sampled correctly after
+		 * the switch. Auto gating is restored in card_busy() once the
+		 * switch completes.
+		 */
+		if ((SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND)) == SD_SWITCH_VOLTAGE) &&
+		    host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+			if (clock)
+				spacemit_sdhci_set_clk_gate(host, 0);
+		}
+	}
 };
 
 static void spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
@@ -491,6 +513,23 @@ static inline void spacemit_sdhci_get_pins(struct device *dev,
 		sdhst->pinctrl_default, sdhst->pinctrl_uhs);
 }
 
+static int spacemit_sdhci_card_busy(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 present_state;
+
+	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
+
+	if (host->mmc->caps2 & MMC_CAP2_NO_MMC) {
+		if ((SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND)) == SD_SWITCH_VOLTAGE) &&
+		    host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_180)
+			/* Recover auto clock after voltage switch */
+			spacemit_sdhci_set_clk_gate(host, 1);
+	}
+
+	return !(present_state & SDHCI_DATA_0_LVL_MASK);
+}
+
 static const struct sdhci_ops spacemit_sdhci_ops = {
 	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
 	.reset			= spacemit_sdhci_reset,
@@ -555,8 +594,10 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	mops = &host->mmc_host_ops;
+	mops->card_busy = spacemit_sdhci_card_busy;
+
 	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC)) {
-		mops = &host->mmc_host_ops;
 		mops->hs400_prepare_ddr	= spacemit_sdhci_pre_select_hs400;
 		mops->hs400_complete	= spacemit_sdhci_post_select_hs400;
 		mops->hs400_downgrade	= spacemit_sdhci_pre_hs400_to_hs200;

-- 
2.55.0


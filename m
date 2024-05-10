Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149D170891
	for <linux-mmc@vger.kernel.org>; Fri, 10 May 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351731; cv=none; b=HKOCRR28ITabfbQpPX4bzSz9wkinaQhR0y7mwoAK0q7YjCsAWEi+kRjFZkcdRGhnD9lL6e8rC18BYRkavF3zEl99ITZlE8s0u5xFLQ99k6coHNG4B+42PoirbafQrk8w1iY2pDNeLQMYjDiEC42Mdt6ObxCEvjrLWZggeXuwxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351731; c=relaxed/simple;
	bh=E7NUkbQ1yYPYk13T3ngej5HA0PiOQTLH4ED/QrY2NS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2NE/sRZenxR7QUeICqjueclDSZLQ0kzwOFSp0VFJ8pfCG+EeMF1u1kX0Rd5YNezbXbyDWXZ9pAAmel1dMOkHf0zDHsXGH3+s6+eJ/DB6xYZaEZzDMUHGg2ibb021QPwyEWz2l6GKOyqa8traAC1jCZ4pgtVGBYBXOhjW45QeAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GdEhHa1c; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GdEhHa1c"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a0168c75so557289166b.1
        for <linux-mmc@vger.kernel.org>; Fri, 10 May 2024 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715351728; x=1715956528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSzJbe+WTx3YozI8N8SsrWCbxRZkF3THuwWmguwkPbs=;
        b=GdEhHa1cv6nrOXV8JYxxp53rDF6H/yktwVp2/QCqoPaI2enKBovbKGoUpkeq8QtKyM
         nqBa1UNy8Ga0t5Ff2C60HZHT3RAJ+EJj+MdLawe0sx56R+5K6VQXwnGRz4wrhQiSSo5k
         jQkU9aWiQh5gkXby4nq0Pgwu5O3/y6Ij6ilaVSLm7RlR1ADNOqCP3Ytqv2BTPkO8gqpD
         6b9q/p5UtBRFmAp6irxWs8MceByrfqJ1hrws5/gXeCFKW0TXrL5ybC/eConPDvK/Q5iD
         V429b9CUNljPT/8QPJkX+YM1MYeIghVvAKeNCHWoA1NiZLJzXYRQIFHvz4mHMCPzsJlx
         zOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715351728; x=1715956528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSzJbe+WTx3YozI8N8SsrWCbxRZkF3THuwWmguwkPbs=;
        b=mhe4zSAYDzoFVffq8bHZi6KVxplUGoHqyvKjZ/1+IU/qVbhUqN//u8fpcs8jcQlWRY
         aDLZyiVD4q1GlYK2yP2dFs8bO1Qlx1FXaEr2evk0stcQfN8ykoerIy9BJuFvYW2Vyin+
         4/eelG4uL7kQyQsTTHDpDUqOZYlDWPouDcHU7M7zFYgn3vXN9jWiE4nqhDYMIcvQZnUW
         qLvWXZ2QUZ6wFc0OZL1YWQAFoEm5WZZPMIKxlDgWtY8oaX/GrtpVCKA0zCfRcdt/tCdq
         HVps3LLpReir1vRrds6WDbc1yO+qlFmYbXBvmn/v3F5TuD/QcR6LfyJSKj9HjWu4MIzX
         E+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUaQHInBA7bWp1AoPpnZrkuldgoG7rTr4N48X9+QBHXUilkUi/wzF495MP9+XbkVBfEyPh6SaL/yKaEQJY3hrg6DR7uH7d+MfRX
X-Gm-Message-State: AOJu0YyKYs7/lFN47S6iiHbvpOmKg76P4y+tgseQ0b1tDdxsRkC14977
	dV95NfXEfeaI7PUVaUKqKcx6BiFyDNibgoGupjJG8ZdLQRyVB8BkdGF1C7lfSsk=
X-Google-Smtp-Source: AGHT+IHvNWn+a/E+B1THbrDUUwvq+JSMNDMNjIXDVlIPLuJo/eF+Pd3MYBa8HUbGY5Yt7plZIaokhg==
X-Received: by 2002:a50:d710:0:b0:572:1589:eb98 with SMTP id 4fb4d7f45d1cf-5734d5b9098mr2123594a12.12.1715351727997;
        Fri, 10 May 2024 07:35:27 -0700 (PDT)
Received: from localhost (host-95-235-217-160.retail.telecomitalia.it. [95.235.217.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65e2sm1878884a12.19.2024.05.10.07.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:35:27 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 3/4] mmc: sdhci-brcmstb: Add BCM2712 support
Date: Fri, 10 May 2024 16:35:29 +0200
Message-ID: <c2f8d42a5bd8e1b6acc38d6c24eee4dcb9948bfd.1715332922.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715332922.git.andrea.porta@suse.com>
References: <cover.1715332922.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
register block present on other STB chips. Add support for BCM2712
SD capabilities of this chipset.
The silicon is SD Express capable but this driver port does not currently
include that feature yet.
Based on downstream driver by raspberry foundation maintained kernel.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 81 ++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 9053526fa212..13a1017d53c5 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -30,6 +30,24 @@
 
 #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
 
+#define SDIO_CFG_CQ_CAPABILITY			0x4c
+#define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
+
+#define SDIO_CFG_CTRL				0x0
+#define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
+#define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
+
+#define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
+#define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
+#define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
+
+#define MMC_CAP_HSE_MASK	(MMC_CAP2_HS200_1_8V_SDR | \
+				 MMC_CAP2_HS200_1_2V_SDR | \
+				 MMC_CAP2_HS400_1_8V     | \
+				 MMC_CAP2_HS400_1_2V)
+
+#define MMC_CAP_UHS_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
+
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
 	unsigned int flags;
@@ -38,6 +56,7 @@ struct sdhci_brcmstb_priv {
 };
 
 struct brcmstb_match_priv {
+	void (*cfginit)(struct sdhci_host *host);
 	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
 	struct sdhci_ops *ops;
 	const unsigned int flags;
@@ -139,6 +158,17 @@ static void sdhci_brcmstb_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_enable_clk(host, clk);
 }
 
+static void sdhci_brcmstb_set_power(struct sdhci_host *host, unsigned char mode,
+				    unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	if (!IS_ERR(mmc->supply.vmmc))
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+
+	sdhci_set_power_noreg(host, mode, vdd);
+}
+
 static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
 					    unsigned int timing)
 {
@@ -168,6 +198,40 @@ static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 
+static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 hsemmc_mask = MMC_CAP_HSE_MASK;
+	u32 uhs_mask = MMC_CAP_UHS_MASK;
+	u32 reg, base_clk_mhz;
+
+	/*
+	 * If we support a speed that requires tuning,
+	 * then select the delay line PHY as the clock source.
+	 */
+	if ((host->mmc->caps & uhs_mask) || (host->mmc->caps2 & hsemmc_mask)) {
+		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
+		reg &= ~SDIO_CFG_MAX_50MHZ_MODE_ENABLE;
+		reg |= SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE;
+		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_MAX_50MHZ_MODE);
+	}
+
+	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
+	    (host->mmc->caps & MMC_CAP_NEEDS_POLL)) {
+		/* Force presence */
+		reg = readl(brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
+		reg &= ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
+		reg |= SDIO_CFG_CTRL_SDCD_N_TEST_EN;
+		writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CTRL);
+	}
+
+	/* Guesstimate the timer frequency (controller base clock) */
+	base_clk_mhz = max_t(u32, clk_get_rate(pltfm_host->clk) / (1000 * 1000), 1);
+	reg = SDIO_CFG_CQ_CAPABILITY_FMUL | base_clk_mhz;
+	writel(reg, brcmstb_priv->cfg_regs + SDIO_CFG_CQ_CAPABILITY);
+}
+
 static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
 {
 	sdhci_dumpregs(mmc_priv(mmc));
@@ -200,6 +264,14 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
+	.set_clock = sdhci_set_clock,
+	.set_power = sdhci_brcmstb_set_power,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
 static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
 	.set_clock = sdhci_brcmstb_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -214,6 +286,11 @@ static struct sdhci_ops sdhci_brcmstb_ops_74165b0 = {
 	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
 };
 
+static const struct brcmstb_match_priv match_priv_2712 = {
+	.cfginit = sdhci_brcmstb_cfginit_2712,
+	.ops = &sdhci_brcmstb_ops_2712,
+};
+
 static struct brcmstb_match_priv match_priv_7425 = {
 	.flags = BRCMSTB_MATCH_FLAGS_NO_64BIT |
 	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
@@ -238,6 +315,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
 };
 
 static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
+	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
@@ -370,6 +448,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
 		host->mmc_host_ops.hs400_enhanced_strobe = match_priv->hs400es;
 
+	if (match_priv->cfginit)
+		match_priv->cfginit(host);
+
 	/*
 	 * Supply the existing CAPS, but clear the UHS modes. This
 	 * will allow these modes to be specified by device tree
-- 
2.35.3


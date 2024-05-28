Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E35D16F8FA
	for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903184; cv=none; b=nTuoLqnef2TfnoPfzvPUll1DZxWsuOMUm2zQBq6Ar9n9Re9wdTiISEmxRgFxfO6vMy8WNBCyRDBsiQ0pLRjDvC5wTLXo/vGkI7IL8AHZwN6ada23/9aiQtfxFktIvvcRws/I6l4XfJ4hDhkIZABx21FnvLt45JUoBTYHSQkL+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903184; c=relaxed/simple;
	bh=xCeqwsoTmryqe4S0XXkbxSFO9YkPJ05veZ6sTcrEhzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZmVPQoexLoI6DEgnuJqFGM1UQvaLeRYUhk7N8X7vmQiSMru945rQavfSoukW/GRdoT7xOLiiHDozcL8ob3KLm7efeqIRvBwb4T26jhFx8x8d8YIGczbcui+Z2USW7gQpuH/BSNDR1X63q6XAADqjfwPngApDmnaOzHlPZcpnOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WvY0qC+M; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WvY0qC+M"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a620a28e95cso92401766b.3
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716903181; x=1717507981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAttVQb286WgzeBs4n1LQU/SvEUwJV3m31Mwzag2RvE=;
        b=WvY0qC+MEModBkBo5Lp0r0MvZ7GM5P2lHYDm9Iaq131lPP8+ED6gIi7Ffkkyy7wDzN
         oVuqqESQotIAZpg7/WQhgODO4/SJ/WCVhIfP/1KjdVCsuuSMD4Ndy57nVY/TA/96jTas
         kUiY/B4J4xjb2Jym+5M4VIlyKkdF8KtyMceM9U5tNDSlqGV6fML9Wg9SlYUXoa2tVfPA
         /RqHy95I6i3KvzwRUVETdHKd1UGRRD8751QYMIYUBjtcvfDIWq8A2jp7RmbbKqKvLwaP
         UyjzOMkan7cvUNoDPUuvULin45mxbFk3yhIam9KBka1Ci5j7EMiEcJ3RlJXlvewFY/PF
         wudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716903181; x=1717507981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAttVQb286WgzeBs4n1LQU/SvEUwJV3m31Mwzag2RvE=;
        b=X4sYsmgg8mCi2BjqYym0XzmxR50pn6EtOZfVa1FaRidryzOJwcVVonojvKma/pA6e6
         m/WVfhgJgGXD3NysZYgt9C5UwGUPOH4rKhOMplsdaY12O9nD+WZnXbDjbYT+1Oksu8AY
         GUMDaAfhTaAk9ey7bxRMyuNfFAUlCbnAQjag5tIt3jbPzlrlbBnHq16p0YRrB//ZF2V9
         XjAiwQkYTjJbVFt5e9LOwzUjhk+ILgYP4Ay12RBNNsLx0fZFdF3Rw55SEOEYfPEgHOZd
         MMi+iEkiHN92aU4Ej9rWFjtV7PcH9xmaurZ4B+Kvk9XvuIahy+XjpAGrk+UwK+jTOVjQ
         3ulQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdgHxUC3LUACPbguG30a/79DQOWrlR6EuHZxMIbIoQ/u95k/Tj1swKAUbAIK0hYHXuUwn0itWaYjPBTAMXJCEEm39pT/wq4LPk
X-Gm-Message-State: AOJu0Yw20infVDBXGPPDO67PLJcZxq16V+RwHZ4eTRDI7TQ4t+sS47Ec
	+BUQWfDdirzzSP0Jw2cC3ETtbVnJdmbBGtx9xKx1K6MbdoBr3ZTgITHt3a5IhRg=
X-Google-Smtp-Source: AGHT+IGM94/l7QnF+H/+9xD5yqLVDdx1tOWfh2zBVOOVaQvsHCnpoeegLHgLc4A1XrQmSWUj79Za8w==
X-Received: by 2002:a17:906:5a47:b0:a62:2c5f:5a64 with SMTP id a640c23a62f3a-a626407bfacmr890996866b.15.1716903180761;
        Tue, 28 May 2024 06:33:00 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a634b0ec497sm57631166b.116.2024.05.28.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:33:00 -0700 (PDT)
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
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v4 3/4] mmc: sdhci-brcmstb: Add BCM2712 support
Date: Tue, 28 May 2024 15:32:40 +0200
Message-ID: <4e8fc54e87447bae7db58636a1c87e5d8baeb012.1716899600.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716899600.git.andrea.porta@suse.com>
References: <cover.1716899600.git.andrea.porta@suse.com>
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
 drivers/mmc/host/sdhci-brcmstb.c | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 9053526fa212..0d9c42d41376 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -30,6 +30,21 @@
 
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
+#define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
+/* Select all SD UHS type I SDR speed above 50MB/s */
+#define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
+
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
 	unsigned int flags;
@@ -38,6 +53,7 @@ struct sdhci_brcmstb_priv {
 };
 
 struct brcmstb_match_priv {
+	void (*cfginit)(struct sdhci_host *host);
 	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
 	struct sdhci_ops *ops;
 	const unsigned int flags;
@@ -168,6 +184,33 @@ static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 
+static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *brcmstb_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 reg, base_clk_mhz;
+
+	/*
+	 * If we support a speed that requires tuning,
+	 * then select the delay line PHY as the clock source.
+	 */
+	if ((host->mmc->caps & MMC_CAP_UHS_I_SDR_MASK) || (host->mmc->caps2 & MMC_CAP_HSE_MASK)) {
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
+}
+
 static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
 {
 	sdhci_dumpregs(mmc_priv(mmc));
@@ -200,6 +243,14 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
+	.set_clock = sdhci_set_clock,
+	.set_power = sdhci_set_power_and_bus_voltage,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
 static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
 	.set_clock = sdhci_brcmstb_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -214,6 +265,11 @@ static struct sdhci_ops sdhci_brcmstb_ops_74165b0 = {
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
@@ -238,6 +294,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
 };
 
 static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
+	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
@@ -370,6 +427,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
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


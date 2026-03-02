Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA78241B351
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464443; cv=none; b=l8uG7ERJt9vSpK6U80KS4wAsRo3taIXX5BNrxewzovYKIM7tslSVNVsNXFq9/xLXkR52/09HKNGtSlb9eFa4SwXTAdJH7GGllx9tR7tbmosp4v3RvKWwBFJgzWKdku4PAtUvXnGROcRkZIh/YbtmMcLhegm2W2g6YMNirY0oF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464443; c=relaxed/simple;
	bh=oROrpMpGRFTyu9YVgnx3q3a5mnQL/8tXkXG+ZsNoOvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RvvwNr3Ok+ebMdFcEIsO70Oo4w+6PzkuYB7fNsjzwzCbXUot1u4o1kNAXqs/MX54rPCpE9T0uvE7BeOXH6tYUabZTAh2LLzfzQcmX4bDP6qkTMYeTp9Q2TBqlar05PS8F+7Wft8EKcPHBCy1XM9GZLJrcbI2+dpiJGjYquJ8wKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+rEQAO/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+rEQAO/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48379a42f76so37621915e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 07:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464437; x=1773069237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vMnihDprCpz00E0mqvOLaz+xzD900tygzUTesRDljg=;
        b=l+rEQAO/ZtZ5a3ll0kTsA+nD+oMAJfL2okPyrhhRV6LTCS/e/TYb4o9MTORAW0BXpw
         MeHb0aVXUrMwouA2f9riftkYIhrw3T/fJRqqf6WFgdRRrdcPbGwYHMKHy7sSbaKmmsPQ
         Yj4I5m9RGEqhQvVATuKo3ay5iNppbT3KKIls78bEu7IcCoBIZzFICVWYyEPfDs8d5U7L
         aW64vNu2iZyFuyE+/YgeUODWQ5qCo9cEy4/s47D9TnSkau7ccbtmChvEVw/lGz8c6WmP
         cMJDiFCtEqhWoe+sRa5fKd3rXM9/c5dH2w4VJMr2HY9UVS0wyKQZblPitgA8xK4cjQ1J
         BIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464437; x=1773069237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1vMnihDprCpz00E0mqvOLaz+xzD900tygzUTesRDljg=;
        b=OpAwqeWQAH6kddLcZRWZd4IfNAp9I/O0vZInbsPPQyDvn2LTQqonjlr3VbkxzAJ9Cr
         rZK53LogSVWEDPJvQf+TDiCH2PckKuR9lVnYb3oo1akhcMGAXESOBbkt2CeO4PACnvcN
         YpAzJuFkcdKfaY6xh9HoWZdLBPmL92oS5RHD8SfFrtaMSJFBTnzQEwRf6D2y7mwiAePk
         0TGYqVeIGdaVd2HVRdR9Hi6A+iN948nBOgrdpHOX+LklLFbxSfqvaGF5V/zqHdP9vsdQ
         9RdlC95OKse2zEfN7qiYc3wSXm7hml5R/uSLkZ8jbfJGixZLYY1cgRCqRLrupC/7W/wq
         Hqbw==
X-Forwarded-Encrypted: i=1; AJvYcCVZR1TWOzXe8dQrjKl0iGoDddCJDHyc9v+WOegf0ZGsddOP70nHeUt8h8dMsB92XvON5LGaIkawkNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2u9b0pyEPAtsrwMpatlvqAs5qmgRkNo+pGfpd+3TNftGL9Pb
	8NsFs/Z3wTumyalsYdZcPNZN6SuBvySuFzqFnupbEnmtXp8vktfYeoRy
X-Gm-Gg: ATEYQzyyC07n4pHZZf5cPgi4ZjFI4qmBxnqHtIEbols78Ypc6b2bLQAZi28pms2cx2X
	1/hjIbouPjo/Nd1UlFVPdfYIqiQZGwQiUZhXJrae21891BXXAzFiDDTKzqZt/ZsP1njkwBqL0Yi
	5/Nj50uNlrPs2I8C3KcWB/+/TU75KmLl/7MMS58Vi1TNxnp2cKu6l3YbspWte+22U41QvyDXnAm
	s2AmjHisqy3gf1hLj1Bt+y9nvbZH3nSsWt/sYrvZ9aTlCw3GV1bRGahH3O/SdIR1zrGGKnfZDHu
	GO0XsJRcMfXzf/qWnQ6h5fEgyNNpd55xvSIB8k7RrfsGz6VIvneOC4t1sqg+4AJWd01x9gnFk/5
	5HhS5qeK8EqOwh+XcPHHucZ5S2fuflmMV243+xQArzgC/o3D3tNujtOOwcqOsBLXcZOZNGTQQbX
	EK1pKRbOkNyNioQM0YtbEEAJv57S+3m92irFlpOXBueIFhDaGKCSl8gtVB6senz2Aywg==
X-Received: by 2002:a05:600c:c16e:b0:482:e5d4:b7ca with SMTP id 5b1f17b1804b1-483c9bbb8d3mr200785895e9.8.1772464437211;
        Mon, 02 Mar 2026 07:13:57 -0800 (PST)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm437240265e9.7.2026.03.02.07.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:13:56 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 02 Mar 2026 16:13:26 +0100
Subject: [PATCH 05/10] mmc: sdhci-of-k1: add AIB register support for
 voltage switching
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-orangepi-sd-card-uhs-v1-5-89c219973c0c@gmail.com>
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
In-Reply-To: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

Add support for SpacemiT K1 Analog Interface Block (AIB) register
programming required for proper UHS voltage switching. The AIB register
controls SoC-level voltage domain coordination between the SDHCI
controller and I/O pins.

- Add AIB register address parsing from device tree
- Implement authentication sequence for secure register access
- Add voltage domain switching for 3.3V/1.8V operation

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 2a982bca2a50ca96f43af7b4de5bc4fb4b5b195b..9425bde6a72541bd628997e91f957072a6266c25 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -68,12 +68,19 @@
 #define  SDHC_PHY_DRIVE_SEL		GENMASK(2, 0)
 #define  SDHC_RX_BIAS_CTRL		BIT(5)
 
+#define  MMC1_IO_V18EN			BIT(2)
+#define  AKEY_ASFAR			0xBABA
+#define  AKEY_ASSAR			0xEB10
+
 struct spacemit_sdhci_host {
 	struct clk *clk_core;
 	struct clk *clk_io;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pinctrl_default;
 	struct pinctrl_state *pinctrl_uhs;
+	u32 aib_mmc1_io_reg;
+	u32 apbc_asfar_reg;
+	u32 apbc_assar_reg;
 };
 
 /* All helper functions will update clr/set while preserve rest bits */
@@ -220,6 +227,47 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
 			       SPACEMIT_SDHC_PHY_CTRL_REG);
 }
 
+static void spacemit_sdhci_set_aib_mmc1_io(struct sdhci_host *host, int signal_voltage)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
+	void __iomem *aib_reg, *asfar_reg, *assar_reg;
+	u32 reg_value;
+
+	if (!sdhst->aib_mmc1_io_reg || !sdhst->apbc_asfar_reg || !sdhst->apbc_assar_reg)
+		return;
+
+	asfar_reg = ioremap(sdhst->apbc_asfar_reg, 4);
+	assar_reg = ioremap(sdhst->apbc_assar_reg, 4);
+	aib_reg = ioremap(sdhst->aib_mmc1_io_reg, 4);
+
+	if (!asfar_reg || !assar_reg || !aib_reg) {
+		dev_err(mmc_dev(host->mmc), "Failed to map AIB registers\n");
+		goto cleanup;
+	}
+
+	writel(AKEY_ASFAR, asfar_reg);
+	writel(AKEY_ASSAR, assar_reg);
+	reg_value = readl(aib_reg);
+
+	if (signal_voltage == MMC_SIGNAL_VOLTAGE_180)
+		reg_value |= MMC1_IO_V18EN;
+	else
+		reg_value &= ~MMC1_IO_V18EN;
+
+	writel(AKEY_ASFAR, asfar_reg);
+	writel(AKEY_ASSAR, assar_reg);
+	writel(reg_value, aib_reg);
+
+cleanup:
+	if (aib_reg)
+		iounmap(aib_reg);
+	if (asfar_reg)
+		iounmap(asfar_reg);
+	if (assar_reg)
+		iounmap(assar_reg);
+}
+
 static int spacemit_sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 						      struct mmc_ios *ios)
 {
@@ -233,6 +281,8 @@ static int spacemit_sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	if (ret)
 		return ret;
 
+	spacemit_sdhci_set_aib_mmc1_io(host, ios->signal_voltage);
+
 	/* Select appropriate pinctrl state based on signal voltage */
 	if (sdhst->pinctrl) {
 		switch (ios->signal_voltage) {
@@ -341,6 +391,16 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
 		dev_warn(dev, "Failed to get regulators: %d\n", ret);
 
 	sdhst = sdhci_pltfm_priv(pltfm_host);
+
+	if (of_property_read_u32(dev->of_node, "spacemit,aib-mmc1-io-reg", &sdhst->aib_mmc1_io_reg))
+		sdhst->aib_mmc1_io_reg = 0;
+
+	if (of_property_read_u32(dev->of_node, "spacemit,apbc-asfar-reg", &sdhst->apbc_asfar_reg))
+		sdhst->apbc_asfar_reg = 0;
+
+	if (of_property_read_u32(dev->of_node, "spacemit,apbc-assar-reg", &sdhst->apbc_assar_reg))
+		sdhst->apbc_assar_reg = 0;
+
 	sdhst->pinctrl = devm_pinctrl_get(dev);
 	if (!IS_ERR(sdhst->pinctrl)) {
 		sdhst->pinctrl_default = pinctrl_lookup_state(sdhst->pinctrl, "default");

-- 
2.53.0


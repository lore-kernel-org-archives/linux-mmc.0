Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7841323D
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464445; cv=none; b=eo2MxykNzgwr1cN/HhjJoBklbRTT8cfuhzG5HThKcSHjq68JmRvcL64+bAQTl+UdX4KOvzUlQX0Ks3W18GHcSYApwIhpXAtBgoFJlzPrVyCCPMCGc4IkD9CLPjHK+hQYJ7/HhDNHrv3TelLPVzFeHfbVPW8oSOwp0mMBjAOBo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464445; c=relaxed/simple;
	bh=GcZr61TwOvUtUfWMRCxXjJRa5feWxGnGJ1rS2AAyvgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJXjHV6Q+Z9BghWThrES/1i0AtsT6HSxRvohnTSx7ulxexTVp1dI6Bsb01VfDGZ7EQ1/Ns8wUCA2ah4u6aFyiP5ViEhwBV3X2O3u66M9DnKI+Gdg1db99aCT7UcXiOOayupVNQ6EWb9+G8SDqHHzylrTLYrzFC4YGaLNPRBCWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INDXboOY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INDXboOY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso41207255e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 07:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464439; x=1773069239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sI0ZXWmHjNvtD6IpJHMeOdxd2SjR4noe2NBQlRy+ENQ=;
        b=INDXboOYioJXolxrreFaV52fmM4iqoD0lk6Pwlx3bt+UeLg14GZOhxbQf3X9907AY4
         MonQk9crJxNYC/3qlrNsxFmqOluYwgcZrLpOmCy51Jx5Dx7osYcM3t1+QM+uX/os3Sas
         eSizHUyVo9q93Cg6UIxis01g0NTn1TI3mFVvnqIkUB1EMu/1pR7a7VyyVGZquDysh2E5
         o7u5WzCJiS1rQyD8d78w7dQAtn14aF36T7Ia61ayjYz707h/1fTHyBdgbF+AP/hk0Cvf
         8uKAvFrq3h6htsX9FBUzYkRhHo1linFuYDaMWannWkN873vgLp250fd/90NQ3P+TNUHc
         Cc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464439; x=1773069239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sI0ZXWmHjNvtD6IpJHMeOdxd2SjR4noe2NBQlRy+ENQ=;
        b=u8MLjTlHXfesWjmLOtuGvI87O5+pE9RzHdwylWEMq7KDmVLupKZiCWhPjQ1blEK1xn
         HSb1+ELcjk7Cle2K7GgxfdN1DdWFsK7ySVuvaHyjh1Ku9XKukCPN7O2/vxbpqdH3zGeb
         GStBB+Mdgfn2ICQ7g/IxbZR2riFKHtD+StXiO867Go4hGYMog0f1KCetfAFU7fL4KcwN
         afWYjtC//m2lFVmUaAwT32CgQ+XY2VYz2+N3VqqpDoI4M/zTbnXqrvV/uB7QPZSYZZ6n
         +zY78pbIXsMhrh3Oy/1Ho07yfa+WTkHy7mapI8HRv+aRfrkIdsByXl8H8+iZwMsU6VLa
         SbDw==
X-Forwarded-Encrypted: i=1; AJvYcCXx9RydHlS7SwmKfQiuIGP79M3ZXNx7xtrNPyYIgb6YkhtrspDh4A4dV3ij4etuuIqBQ5Vk9MpEKAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMX7BWQynrHBW54lM3JWsJtTXVMunNAFCa9vQ7UsyCXWtk8uxl
	/7ei/xmH9OjiyStSAiGHfAJzYxd4kzo4y35siaK/ZKGI6/L8mL8sYb93
X-Gm-Gg: ATEYQzwVDpeSUD3KlaTy+foKfbUCIuXP9zE/dPWlCDNDv6HtsciZd5dBM6+I6M83W0f
	w37P+S5haCIqSuTgFIWIkZY/pFS/2rPpQGPweTAGm229/DgB+1RQL3Gn0N//Ksmn696wLQwDJmQ
	6TUoWvSfiK8WL+JkHeaxq4b1xPtXWkpCFoxceWzJ36SodFC2LOkGsyYOd7ol2P3O008/y7ryxR+
	ZZbg1U+8SZWfO5uip3XVp7NWLu6sz18pTI05Bg4XBQIueyWe/+kOg1G/4pS6cPXUN9Fw9tL7WzF
	kS3MZypCcunWFidJeByTxZEDMXbQtOoPFsjZmVaateLUQTMwI1gLRmh17Y69Wy39K4qNdIsGCPR
	TSHYCv3Ekc4/jVkt8fhAET8sNNWdelBr0nY+7in+k6rEoHQAcIlvHiVqF7R6JPQNQaD5wfiGiFY
	M3Y9rGpKt8SMV8LLUdxh4TgHfkWXYKIQlVdffvuZKZMt3wZaORTqu/OorjGbNLPtNPow==
X-Received: by 2002:a05:600c:5395:b0:483:709e:f22d with SMTP id 5b1f17b1804b1-483c9c24797mr190414855e9.27.1772464439170;
        Mon, 02 Mar 2026 07:13:59 -0800 (PST)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm437240265e9.7.2026.03.02.07.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:13:58 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 02 Mar 2026 16:13:27 +0100
Subject: [PATCH 06/10] mmc: sdhci-of-k1: add SDR tuning infrastructure
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-orangepi-sd-card-uhs-v1-6-89c219973c0c@gmail.com>
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

Add register definitions and delay line control functions to prepare for
SDR50/SDR104 tuning support:

- Add tuning register definitions (RX_CFG, DLINE_CTRL, DLINE_CFG)
- Add delay line control helper functions
- Add tuning preparation function

This infrastructure prepares for implementing the SDR tuning algorithm
while maintaining all existing functionality.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 9425bde6a72541bd628997e91f957072a6266c25..34a1b9c359193be7dd5f07d1f3d6565b5f40e7ff 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -72,6 +72,23 @@
 #define  AKEY_ASFAR			0xBABA
 #define  AKEY_ASSAR			0xEB10
 
+#define SPACEMIT_SDHC_RX_CFG_REG        0x118
+#define  SDHC_RX_SDCLK_SEL0_MASK        GENMASK(1, 0)
+#define  SDHC_RX_SDCLK_SEL1_MASK        GENMASK(3, 2)
+#define  SDHC_RX_SDCLK_SEL1             FIELD_PREP(SDHC_RX_SDCLK_SEL1_MASK, 1)
+
+#define SPACEMIT_SDHC_DLINE_CTRL_REG    0x130
+#define  SDHC_DLINE_PU                  BIT(0)
+#define  SDHC_RX_DLINE_CODE_MASK        GENMASK(23, 16)
+#define  SDHC_TX_DLINE_CODE_MASK        GENMASK(31, 24)
+
+#define SPACEMIT_SDHC_DLINE_CFG_REG     0x134
+#define  SDHC_RX_DLINE_REG_MASK         GENMASK(7, 0)
+#define  SDHC_RX_DLINE_GAIN             BIT(8)
+#define  SDHC_TX_DLINE_REG_MASK         GENMASK(23, 16)
+
+#define SPACEMIT_RX_DLINE_REG		9
+
 struct spacemit_sdhci_host {
 	struct clk *clk_core;
 	struct clk *clk_io;
@@ -102,6 +119,50 @@ static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr, u
 	sdhci_writel(host, val, reg);
 }
 
+static void spacemit_sdhci_set_rx_delay(struct sdhci_host *host, u8 delay)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_CODE_MASK,
+				  FIELD_PREP(SDHC_RX_DLINE_CODE_MASK, delay),
+				  SPACEMIT_SDHC_DLINE_CTRL_REG);
+}
+
+static void spacemit_sdhci_set_tx_delay(struct sdhci_host *host, u8 delay)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_CODE_MASK,
+				  FIELD_PREP(SDHC_TX_DLINE_CODE_MASK, delay),
+				  SPACEMIT_SDHC_DLINE_CTRL_REG);
+}
+
+static void spacemit_sdhci_set_tx_dline_reg(struct sdhci_host *host, u8 dline_reg)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_TX_DLINE_REG_MASK,
+				  FIELD_PREP(SDHC_TX_DLINE_REG_MASK, dline_reg),
+				  SPACEMIT_SDHC_DLINE_CFG_REG);
+}
+
+static void spacemit_sdhci_tx_tuning_prepare(struct sdhci_host *host)
+{
+	spacemit_sdhci_setbits(host, SDHC_TX_MUX_SEL, SPACEMIT_SDHC_TX_CFG_REG);
+	spacemit_sdhci_setbits(host, SDHC_DLINE_PU, SPACEMIT_SDHC_DLINE_CTRL_REG);
+	udelay(5);
+}
+
+static void spacemit_sdhci_prepare_tuning(struct sdhci_host *host)
+{
+	spacemit_sdhci_clrsetbits(host, SDHC_RX_DLINE_REG_MASK,
+				  FIELD_PREP(SDHC_RX_DLINE_REG_MASK, SPACEMIT_RX_DLINE_REG),
+				  SPACEMIT_SDHC_DLINE_CFG_REG);
+
+	spacemit_sdhci_setbits(host, SDHC_DLINE_PU, SPACEMIT_SDHC_DLINE_CTRL_REG);
+	udelay(5);
+
+	spacemit_sdhci_clrsetbits(host, SDHC_RX_SDCLK_SEL1_MASK, SDHC_RX_SDCLK_SEL1,
+				  SPACEMIT_SDHC_RX_CFG_REG);
+
+	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200)
+		spacemit_sdhci_setbits(host, SDHC_HS200_USE_RFIFO, SPACEMIT_SDHC_PHY_FUNC_REG);
+}
+
 static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	sdhci_reset(host, mask);
@@ -335,6 +396,7 @@ static const struct sdhci_ops spacemit_sdhci_ops = {
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_clock		= spacemit_sdhci_set_clock,
 	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
+	.platform_execute_tuning = spacemit_sdhci_execute_tuning,
 };
 
 static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {

-- 
2.53.0


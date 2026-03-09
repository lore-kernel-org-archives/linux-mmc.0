Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B93A6407
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056436; cv=none; b=Xyx+7CvORxlOQ5SeqZpmwjWtuAfGOAhpPtCOjMVe7YAMpk41R74L9B6C8jCRMYCibkm0Z8QBcCCrVastoWOfUFBQaVhB3XxA5uAIEBq7pWJ7PZ9T4d7IdoJqCjQrgOnQGZwfFbfUCxIwD+hIBVAXezs5gr7pol3DeJN2hue0O7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056436; c=relaxed/simple;
	bh=zh+ggJ1R5qBO3E8+3w58NjmsHpAAdOtGm81LBUggVYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OVn/NWWV3fOc3vP318M8jU1LjxAR2ma4JU7wKrbI6/BYt30cf2yJtlrrvuMd3cBDGlc4F4dfK7mPuU9O6mPbCCkGQM2Gv+Q++RjPJsQ19JKK4sDh8lXE6mdMjnfPtqQnrJmwmjR86EDfAzudITrqAbVPe8KdbNwlTS3d/3YFp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbOxcgVe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbOxcgVe"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b7c2788dso5773679f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 04:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773056433; x=1773661233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YpjhzcIYcSxtAdjQVzNzPM/tyjIJ5Q1jULtAL2eLJs=;
        b=YbOxcgVeSdqmBtTnmfzA1Er0rtb81Hq1MfmkM043cXL7+VlrsAYETbSRb4lOvMtGKO
         5c8Ct6CgijeT0qDpn9alCgz/wq+esAO0W0vNFV+MRwHyIcmDxT4SB3Z1861/WMHbkz7I
         PlZ2AnM/u48FVaWV3x8OjDtwbrqgb+dv9VUsHBPeVuLI7e/Bo7c5wz7XJGtsqfPtqnGF
         sEzWMfiWsxgm2oo0J5nl/lNIKaCsr8/FaTN5BGIG+hd0NmBHsE/GZ9guNM12nkY0T2x9
         U496Bw9iMHhl7YBc4WSa9pPRUgS6ZjvOar9oayFDadCm0fFMQWqrySsBla9sI57RrsNY
         TZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056433; x=1773661233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0YpjhzcIYcSxtAdjQVzNzPM/tyjIJ5Q1jULtAL2eLJs=;
        b=cyRW6KeFcKAVvPtrqliQcTpu4yY7Hot6PM/EUGOz5d5LuLGcR2Ii3b6hnZnq77VhRD
         diRds6OKr+yV97M5YqYfBapV1b0HRRPWf7U0po/HugpLJmy97ozuIA1Z9cro3O60VDhH
         tb8rG2xWTac/hQrsUBmapYwRmNxGGOaBK3GRUweKexq1M1FkOJbT+tPJhBmJWzgd0Nlz
         +cKaIo7rL3TtsyEDuiDmsqgkI1tmNcBYPlygybAZwdiM2/cgVG4AaxU8t1tdlu6oxstD
         LffE4T5Bn5Jbzx4BzBLHLwp5pvvL7csV/A6TmDXpE8eTyGPIc97G2DyyogH+R1GGwuPZ
         7Eag==
X-Forwarded-Encrypted: i=1; AJvYcCVxhL+7vG2LBS6sK8wkrlChrxYVQVYsvqtViXsDNvZUEMixpYtaa3xA348ATNJtPd9YnzfrLFaOWbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWOivFemsea1hohD1aN/mqZAptqUleOVSkJMrgPiVarz5Ufyn
	UmPPYkQ4lI5r6EvTFIpM96MYgJE1Ue77L7gHRz+K5/ynG9WBBD65Z5id
X-Gm-Gg: ATEYQzzOz4MTPg0E0sSS2Zb9ntYTkkayyYRSLHYLukZAb2pKhrmbK8Q9dqDwYqK3yYK
	Ngf/u/oUtizpj940BTfUHMudfMTxj9FpMtsGU4vN7A7QuJifoKPcCv99GtYYOJT9s/TuH3VW6uY
	GHiNZxlV9syRFTakt0QWg7oebrQP9aEcDHF+HE/uaIWSSegBM4iNCHDmfDTiIuMkXiGv461lqhw
	peHuw1nIUlyuDUfBYai12zpUjkepAtV7W2fqqB+dczgPmKtErBDJ5GoouHgoMyozNOq0Wo4rRXS
	Wsmx9IOblcqvz6tYK1R1ZYZGFkQJ6GNqp0GgntIJGBfsNwTc5LGiCZaV+1iVnuvRs8QBqbrHeK7
	6lDs0/LWO/F1Ntans+cQE8Grdx/ddHii5KuppEu+gV6enjfIKein8oZACZYonihZ+Wem755OzE1
	BdtgW19SA34lk0PefNLmL2cdcI4Q3RrToe1d0ZtJcKpjxp5a2EANJiSw6MBc3n0bG5
X-Received: by 2002:a05:6000:3112:b0:439:d242:e8fe with SMTP id ffacd0b85a97d-439da348327mr18838818f8f.11.1773056433101;
        Mon, 09 Mar 2026 04:40:33 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.236.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8ec97sm28471699f8f.5.2026.03.09.04.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:40:32 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 09 Mar 2026 12:40:13 +0100
Subject: [PATCH v2 3/7] mmc: sdhci-of-k1: add SDR tuning infrastructure
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-orangepi-sd-card-uhs-v2-3-5bb2b574df5d@gmail.com>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
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
 drivers/mmc/host/sdhci-of-k1.c | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 8af117a8e271c04a80d8dc7bb5ce12075652dd7a..79cb7c8d0b6d9c4206bf01721651c8efe8a173c9 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -68,6 +68,23 @@
 #define  SDHC_PHY_DRIVE_SEL		GENMASK(2, 0)
 #define  SDHC_RX_BIAS_CTRL		BIT(5)
 
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
@@ -95,6 +112,50 @@ static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr, u
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

-- 
2.53.0


Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2F2E1F06
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845907; cv=none; b=LIJ0trUIzO5XN0QP8J6ZlgMsJ/Y504yyau2sVOMy2C6ZPkL0VJHTCQOUfVGADYu/W8cZnjsJaXudlaD+LFjWUHDSmHluBO7fL6MBSznYSaF2qGtJOifIkGTlUR3/blH8vj6Q6j4KoOaYeooQsVIG0hPxvsfabIk3LXlCMAv/8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845907; c=relaxed/simple;
	bh=1i3B2dKT5sbTWo1nJf5tI4NTlUOkK2mEIdt9GtsoDag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvX5mY1ZHoJXX2NhQA2NUj6VK5K2SyMa4kQfFvX1NYO0SAX6m39DZbKOABi+HlekHj7REuAn3ejiFkaIu/S+uj3/fo9IwiP0dfrCGDEyHuMFkaGNjKkXjyVb/9JEgLjuVhU4i4T6Cy9ybYDVHELa0E7iGNnjrs8/JcgQA8Issio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GUvzSFsz; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GUvzSFsz"
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-42f3acb1744so22671885ab.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 07:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845905; x=1760450705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEmNG5dHeCrJHUC2bFy2N+BBQV+BhaaczeWYkzApDTU=;
        b=B38LyMzz1A7sOhqsEdzYabi9ihFgbNhlBr22M9kYJd2bi9FGtnJSJpEdDelm55upfv
         mszLh0sfpNB4F1vi/30CMaeWimqKtF+EHaa91ecpwr2waIYEVULevMeGCf6v2nm66GaJ
         Kw2H+4bN/o/IZ64VGI3Cdo5oYZfiS5iG98TXmw0MYrIB5tmNaXWZPHTA63BK2XxkRzRD
         xB7L1wEf6nV6bJahYTqGm9tpMexZDuQDJaPHhaeim6+pqt/9jsBbZuoeeLIo3Gj1htJL
         pkNZDh96OEUTfNTKP/T5f+4bGaseGjfS42147fXZ2fpCGNPiVruQxvaVSujqciPCeRkq
         lOlg==
X-Forwarded-Encrypted: i=1; AJvYcCV8eKEYG3yf8tVTMqNH5+BVLNtc8+X4isMQAu+z/j4LpVuMJ11aL8Lip44Adna9f3qSBE941yBEUj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmO+5WtIIFkEU8MB0RjM8dDlz0j6E0esx/hcqs5Plf44lGRwy
	giN5VK4JfrNonOtZP7/1PrEueZxRP+W3wcbdovXaowKwuvikAfv9rspaxAdPpt7mf7HKuQXhb9f
	38bm9knfADHYMQea6yg55lSZZigPLMlKkz+fLeDfGfIWLoM+0HWKe3BzHVz30QuOzp1yfcpE4I/
	M80n4HqDAQYzfjPU+n3sSM4UOr0M0aVoz0lQOzQ1ZQsscFAamSGqLMajQZ+UU/VnEIfwzVTxNqc
	bmq8p/7nkCx
X-Gm-Gg: ASbGncvD4SIcL6uWhvsAk0E7wRYW/ToEQMCpk7ilpDfxbHTxy+clGvjkV8jTz6H4TSw
	Kjf37LpHAcBfJHIpezMdi2F9skBKGHjwEJ66TubK4d4bZ3fcvm7VGigBqeJKC3GtrUQP9Jznzwu
	PpQv7BF6kAegWWoTbNd6uCJSWPnbCgT9L1d9Dv6kXstzA6o6iseytYhOpIcCPZOmnklCke8IZwl
	Q22t++N+T+jLwYF+pEB4fLk07C3X3vvHXJQ2y98ZY4i4GKZSuUzScgBk9fRTJNALVBZKfNXhN4Q
	s7rci5Mc+S+OMwPw4eVN90Rtz3ueynO52MIV1qkuP9v8pawPrYDss9TVkvekyyEv2TDnT3Wqzte
	S9uj9W1DCwGJbYb1xGjsXgZFFROCRwKA2kj0gbOBCA1mLdHjUszmO//xzI/YUI45t9G0qCdVrRW
	FSaw==
X-Google-Smtp-Source: AGHT+IGuKXCUuimZqjGreUVY0vMV96OMF6r5qRW92jKb4KfHbmO06PndJ5nbHIZyNQ2HcNtcWzvTn2PvW/wd
X-Received: by 2002:a92:c26e:0:b0:424:7ef5:aeb with SMTP id e9e14a558f8ab-42e7ad84737mr216202095ab.17.1759845904489;
        Tue, 07 Oct 2025 07:05:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-42d8b28fac2sm12453185ab.32.2025.10.07.07.05.03
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:05:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-818bf399f8aso166557836d6.2
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759845903; x=1760450703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEmNG5dHeCrJHUC2bFy2N+BBQV+BhaaczeWYkzApDTU=;
        b=GUvzSFsz3t7AFWVp10npn4zrQGybHAYgVQVwGHdChjeDs6I/3Ex+i/iW+M+BZLnHmn
         DiAulHzbq7gj/FYSHJKD2QTCs3Q4T10wNIL+nX8YIXR1BgRDs0iO3L+Emk6T15svIwmn
         9nySPWIWAkOONec6Gf5YStrksf9AY5++zLZyE=
X-Forwarded-Encrypted: i=1; AJvYcCWaLIlUZOSVjYgVeFeblFeNFu0Fd4arcal8Zp3VV/+UhYGUIoWfx+i0wVYW1cd4JTJkjmOl4jzjQKM=@vger.kernel.org
X-Received: by 2002:a05:6214:4113:b0:818:f4ef:daab with SMTP id 6a1803df08f44-879dc7c243bmr192631946d6.26.1759845902105;
        Tue, 07 Oct 2025 07:05:02 -0700 (PDT)
X-Received: by 2002:a05:6214:4113:b0:818:f4ef:daab with SMTP id 6a1803df08f44-879dc7c243bmr192630956d6.26.1759845901002;
        Tue, 07 Oct 2025 07:05:01 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm142718956d6.9.2025.10.07.07.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:05:00 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v2 3/5] mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200
Date: Tue,  7 Oct 2025 10:04:31 -0400
Message-Id: <20251007140434.606051-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007140434.606051-1-kamal.dasu@broadcom.com>
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Clear SDIO_1_CFG_OP_DLY register when using HS200 mode to be
compliant with timing spec.  We only need this for on BCM72116
SoCs.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index f81cc1889ac9..d25bf71d79f4 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -34,6 +34,8 @@
 #define SDIO_CFG_CTRL				0x0
 #define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
 #define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
+#define SDIO_CFG_OP_DLY				0x34
+#define SDIO_CFG_OP_DLY_DEFAULT			0x80000003
 #define SDIO_CFG_CQ_CAPABILITY			0x4c
 #define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
 #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
@@ -210,6 +212,21 @@ static void sdhci_brcmstb_cfginit_2712(struct sdhci_host *host)
 	}
 }
 
+static void sdhci_brcmstb_set_72116_uhs_signaling(struct sdhci_host *host, unsigned int timing)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	/* no change to SDIO_CFG_OP_DLY_DEFAULT when using preset clk rate */
+	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
+		return;
+
+	reg = (timing == MMC_TIMING_MMC_HS200) ? 0 : SDIO_CFG_OP_DLY_DEFAULT;
+	writel(reg, priv->cfg_regs + SDIO_CFG_OP_DLY);
+	sdhci_set_uhs_signaling(host, timing);
+}
+
 static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
 {
 	sdhci_dumpregs(mmc_priv(mmc));
@@ -250,6 +267,13 @@ static struct sdhci_ops sdhci_brcmstb_ops_2712 = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static struct sdhci_ops sdhci_brcmstb_ops_72116 = {
+	.set_clock = sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_brcmstb_set_72116_uhs_signaling,
+};
+
 static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
 	.set_clock = sdhci_brcmstb_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -280,6 +304,11 @@ static struct brcmstb_match_priv match_priv_7445 = {
 	.ops = &sdhci_brcmstb_ops,
 };
 
+static struct brcmstb_match_priv match_priv_72116 = {
+	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
+	.ops = &sdhci_brcmstb_ops_72116,
+};
+
 static const struct brcmstb_match_priv match_priv_7216 = {
 	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
 	.hs400es = sdhci_brcmstb_hs400es,
@@ -296,6 +325,7 @@ static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
+	{ .compatible = "brcm,bcm72116-sdhci", .data = &match_priv_72116 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
 	{ .compatible = "brcm,bcm74165b0-sdhci", .data = &match_priv_74165b0 },
 	{},
-- 
2.34.1


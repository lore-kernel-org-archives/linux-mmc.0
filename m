Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790B386572
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476372; cv=none; b=SIqHx65d7RpLZj4CxgwuyD7S01Id8efhy0IAR4N4N1jkAN2lR/Ekgi0AhUhYpbaFudDYz51GdMXi6kVk41kokroTfkSLPkAvZkhNcxoBdWOn6zcB8zbJoGHVEnrM+vz0rayiui6oDKGVUjUyalzJRULVgzXiqcs5GIob3+9wENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476372; c=relaxed/simple;
	bh=C6Ad2AD0siK4x4/GE1JAh5GTw84tgnx8SmNQ9vLx5Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wy4NP35fSDDs8jvngzE61iToW+tESzDt8m9FQeJvg9EBlabSSg+1ZmFMEWl9ANmEbTCzpql/o1t3vSKin+oyMXDNPRRH76An0V7UoTW7KEAdvN+mlz40aqYKHy4M7cDJYbAyMn0rCeAFtBzN5ikbxE++RqycVo9yiO0prz00TxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48441fa5c37so245241f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2026 15:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788476367; x=1789081167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/s6nvcJwx7Ifs5qcA8T+nQv2xmeJ2s33utca3H2YozM=;
        b=YJ8MWPmf6rWJLCbkJUuw7fapzqJU4cMVdNZBdDdb4vf64SNXnZ5F2Ir1OEZJcXUPIR
         iPIQrxYliKXCnzrb89WcagSOpbHmqEY7iTyJboJ71MzRzdCpnUJdIE3Ru8T4inAb4ELM
         NIaTlnwmlbBUGZ797c200BboeYlWrhby0hKph3AU3Zjul5GfOsElBKuIkPwKedhkQScF
         ou29itwJodSHMYdhPLnnXih+c3M8npk/4cjm+YoIUpxbFqV7colfq/DxtLmhZ052bdB4
         2CDb7zlanu3dYY8BXBOPsaNX9Ca6iNgTZtcedkyfcfDIg0Qi5R3i+Aimfa25X7hl6e1y
         LPeQ==
X-Forwarded-Encrypted: i=1; AKwUvByTnASDGC7Nux1Vsnyt6LehKOvBlGGJvS7Bw/LxG/VWCVAi4GoWYYH2Ad5wFke79VqiKwjJjCe6+EM=@vger.kernel.org
X-Gm-Message-State: AFuF++mOiBScOzHQpCv+EXv6NrVEMmU7FbFpsGG+9vwm75bXNOKmVi+6
	N/xbBWz+pVWWoFhVosiPcsFKGm63dRgY2I/lk7aDYdWnzk6ZzAZWNuQb
X-Gm-Gg: AYBFou3QvGGflLQKJHxzovhzO3zM6q03gdXueQV+Zxevv9t2Quj96pB/HwlV0ITUCAK
	NC/DFyvez+gv008W8I965mCwPqg4EfRNzzqTlFKpsjK3THAswj55K5UXkaMwQNEqodgMhh8GZGT
	CUMTGxPSKfUMoYDhgeBJ8Pwv4+5dPc0o5si/xQ5LDh9N5jVOs1Gz9oUqNjoxstNYF3tK9wrpRoE
	gogHxAGH7aGlZabYiW7qDKNubd9JwU+9tGa3o0tZcP2dagCedDxZPOm74T2P0+W7JWY+toTtLvY
	bRTJ8LgksIDSVrf8ayhuCcA0QFGUonJY8+NFTwAouGiSoflkq1C99sDRNt6LwBK7SegVm2K85E9
	WLiLCU9SRGSR6HoXUzOqlBVCXWwM3HfC5vBZauxol2z9GLpb16ese/iZJpusd3FAF1lFeMeFuHq
	ABWdYJNxr59dWhgrVKLi7GH7CAXK85yi2CJX1uVWzm1e0ZwAyxXyPX0K27C3XZrZOc+2qJZdOHw
	37LET40RALCL1XTrNfDuvkQ/uCJxOkKfq/OADY=
X-Received: by 2002:a05:6000:2505:b0:485:8ad5:f965 with SMTP id ffacd0b85a97d-4858ad5ff97mr104210f8f.2.1788476366934;
        Thu, 03 Sep 2026 15:59:26 -0700 (PDT)
Received: from threads.localdomain ([84.68.179.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885c5bbdsm1686142f8f.36.2026.09.03.15.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 15:59:26 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney+clk@redhat.com>,
	Chuan Liu <chuan.liu@amlogic.com>,
	Jian Hu <jian.hu@amlogic.com>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claude Fable 5 <noreply@anthropic.com>
Subject: [PATCH 2/4] mmc: meson-gx: enable the bus pipeline clock on T7
Date: Thu,  3 Sep 2026 23:59:19 +0100
Message-ID: <20260903225921.2290441-3-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903225921.2290441-1-tanure@linux.com>
References: <20260903225921.2290441-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the T7 SoC, the bus path between the SD/eMMC controllers and the
NIC_MATRIX fabric goes through a pipeline stage inserted by the hardware
design to help timing closure. The stage has its own gate clock and,
when that clock is disabled, a controller that starts a DMA transfer can
never complete it, hanging the storage devices and, from there, the
whole system.

Add a dedicated match data for the amlogic,t7-mmc compatible that makes
the driver claim and enable the "pipeline" clock for as long as the
device is bound.

The clock is deliberately not optional: the hardware cannot do DMA
without it, and failing the probe with a clear error is preferable to
booting and hitting an undiagnosable DMA hang later.

Assisted-by: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 694bb443d5f3..68566d7eccc7 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -52,6 +52,7 @@
 #define   CLK_RX_DELAY_MASK(h)		(h->data->rx_delay_mask)
 #define   CLK_ALWAYS_ON(h)		(h->data->always_on)
 #define   CLK_IRQ_SDIO_SLEEP(h)		(h->data->irq_sdio_sleep)
+#define   CLK_PIPELINE(h)		(h->data->has_pipeline_clk)
 
 #define SD_EMMC_DELAY 0x4
 #define SD_EMMC_ADJUST 0x8
@@ -139,6 +140,7 @@ struct meson_mmc_data {
 	unsigned int always_on;
 	unsigned int adjust;
 	unsigned int irq_sdio_sleep;
+	bool has_pipeline_clk;
 };
 
 struct sd_emmc_desc {
@@ -1204,6 +1206,15 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (IS_ERR(core_clk))
 		return PTR_ERR(core_clk);
 
+	if (CLK_PIPELINE(host)) {
+		struct clk *pipe_clk;
+
+		pipe_clk = devm_clk_get_enabled(&pdev->dev, "pipeline");
+		if (IS_ERR(pipe_clk))
+                      return dev_err_probe(&pdev->dev, PTR_ERR(pipe_clk),
+					   "missing pipeline clock\n");
+	}
+
 	ret = meson_mmc_clk_init(host);
 	if (ret)
 		return ret;
@@ -1322,12 +1333,22 @@ static const struct meson_mmc_data meson_axg_data = {
 	.irq_sdio_sleep	= CLK_V3_IRQ_SDIO_SLEEP,
 };
 
+static const struct meson_mmc_data meson_t7_data = {
+	.tx_delay_mask	= CLK_V3_TX_DELAY_MASK,
+	.rx_delay_mask	= CLK_V3_RX_DELAY_MASK,
+	.always_on	= CLK_V3_ALWAYS_ON,
+	.adjust		= SD_EMMC_V3_ADJUST,
+	.irq_sdio_sleep	= CLK_V3_IRQ_SDIO_SLEEP,
+	.has_pipeline_clk = true,
+};
+
 static const struct of_device_id meson_mmc_of_match[] = {
 	{ .compatible = "amlogic,meson-gx-mmc",		.data = &meson_gx_data },
 	{ .compatible = "amlogic,meson-gxbb-mmc", 	.data = &meson_gx_data },
 	{ .compatible = "amlogic,meson-gxl-mmc",	.data = &meson_gx_data },
 	{ .compatible = "amlogic,meson-gxm-mmc",	.data = &meson_gx_data },
 	{ .compatible = "amlogic,meson-axg-mmc",	.data = &meson_axg_data },
+	{ .compatible = "amlogic,t7-mmc",		.data = &meson_t7_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, meson_mmc_of_match);
-- 
2.55.0


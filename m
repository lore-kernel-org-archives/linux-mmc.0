Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD64AF9F2
	for <linux-mmc@vger.kernel.org>; Sat,  5 Sep 2026 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788622363; cv=none; b=YFsaZx9JC9k6AHxN12d0g3sP1mwfSIP05CbUSvadNglInHxeAvHnwMSjxRJQZSIJM1in+nNt8GyeTy4VpbJuzj3fDc4yJS1Cfrb0Y7+eoFTjPTrMaZgHSEHuPV0C72bFcLMOrYErY/qXcvijm/j9eA8yktBwA9e9rLzhKiQjky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788622363; c=relaxed/simple;
	bh=oLDcY6kImT6VejPH+8oQ5pUx6Jmf88kTwnGUpUh8fuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLa42PrqH2EAmOp7wE1+QGDAEP1MCxSSd0PBKd47h6qUzldt9SQPsUEKklrsm5OXdpfOLpLPyvmSrN1Aq4+rP4QvBQEtI3e9HkBtVpdRDw7o4J8eFq6FA3qZHnPBCEpP6oOLJYIij+rH+VDYkZXlds6Cfo0athgptEv6k/aI9Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48584dc164fso1951607f8f.0
        for <linux-mmc@vger.kernel.org>; Sat, 05 Sep 2026 08:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788622358; x=1789227158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6cvLPMe39R/AaBDs2Mh5u5mXzrtCLtGEuv4B7IhLgiQ=;
        b=ryZYthBNnVoA2Ub5PeI9l6cE1Z0NsAU7nM4AyU4tzhZRqgDivkFPEQR+iqrhjUQ6eN
         T5M9YmYstilXlmSSAqJBRm/7eLlPJi8f64Kp2335EpBi1YHflATtZleOUlLpc7kOflt3
         EhGR2Zr7AliWGf32FLQEbJPdjJYAIqbgXpW0x/m7NLpp/AReAH4HTU2jB+KK9z/274jr
         JUFJB1ht6t01AtAvW2JOky/E6OYKooo1abXGcjc14fLxT2rj6LSLz3lRgh5fxqFVmCoJ
         r64ZW+jaqfNjqQrRsWQaeqgaXslS2X8DvkrpVRUbCmfVCqLCfzVYZpT/OS+9FJwkBmGc
         ej6g==
X-Forwarded-Encrypted: i=1; AKwUvBw91cIWD78Qy0vMVbFZYFpvHVpzC05HgqGuxOaCg0Wt6Ps1WtsJe+VjEqzBuz+MCnxRrdzV3WYlS68=@vger.kernel.org
X-Gm-Message-State: AFuF++k7On7ftC5SOJ0HabMJAq1sru2emCepoAnOCb077CFyl6+xbpy1
	XU1oM1sJ4q9PJQPEM9sP7vkj82134erYJR23sPyYyeg73yj8UAK0SSLV
X-Gm-Gg: AYBFou17s+IcZJlaTqjHkQjXJOGq7tP6m5u/GxBaXr7ug/ecQtwB4DFPzzqOS/K2t1y
	4GXRplVCicQ1fiOd1HRFIBbT4BWKQAvQBOByZRKTKXpL66xYPn5R8ikGTnqDlZpCaVOqslAYeJW
	/ntSjatcepwIYjw3A/W6iH85oaDhhHFSzKyxIm1+VxDyk84I8QBj4MRjV4MMUz4Ve+yUFGGtTPN
	Hj9suelDljdTx+k/5sQzq8j4xYJwCy0Phsl4wKFa1K8cABJZozrDHg4VMyw2uLf4RgS4CiHAdcy
	rSPLVi3yCseLT9jyU8YVPV1hVz7Cu3EOlHtGI+MLLwrdHPJi/F/A1BdFVH6cmnhTA+CTz2ZtODn
	Yy2rElhzEkE1/OAz9c23tCLiH1ENxFWPfS9wldu0Bhvzo9bb4EZGvPpmAt1vOyY05opBFyzwz4m
	rnawQ4x+Trj3OYFfb93FlkxMjTKoKSW+nGLgw1nF43kdEiSdz2mywcfnCaJLsxfHE7dQSBKutbu
	QnRt94AfXN2GZXVwXG+k1NaJeFgNiSvx3bF
X-Received: by 2002:a05:6000:470c:b0:485:8a46:705c with SMTP id ffacd0b85a97d-4858a4671b8mr11204628f8f.46.1788622357649;
        Sat, 05 Sep 2026 08:32:37 -0700 (PDT)
Received: from threads.localdomain ([84.68.179.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm16691913f8f.25.2026.09.05.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:32:37 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] mmc: meson-gx: enable the bus pipeline clock on T7
Date: Sat,  5 Sep 2026 16:32:32 +0100
Message-ID: <20260905153234.133217-3-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905153234.133217-1-tanure@linux.com>
References: <20260905153234.133217-1-tanure@linux.com>
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

Assisted-by: Claude:claude-fable-5
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 694bb443d5f3..c0f1e929fc13 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -139,6 +139,7 @@ struct meson_mmc_data {
 	unsigned int always_on;
 	unsigned int adjust;
 	unsigned int irq_sdio_sleep;
+	bool has_pipeline_clk;
 };
 
 struct sd_emmc_desc {
@@ -1204,6 +1205,15 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (IS_ERR(core_clk))
 		return PTR_ERR(core_clk);
 
+	if (host->data->has_pipeline_clk) {
+		struct clk *pipe_clk;
+
+		pipe_clk = devm_clk_get_enabled(&pdev->dev, "pipeline");
+		if (IS_ERR(pipe_clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(pipe_clk),
+					     "missing pipeline clock\n");
+	}
+
 	ret = meson_mmc_clk_init(host);
 	if (ret)
 		return ret;
@@ -1322,12 +1332,22 @@ static const struct meson_mmc_data meson_axg_data = {
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


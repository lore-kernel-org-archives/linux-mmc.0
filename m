Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8313932E4
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669873; cv=none; b=guwqXfUgwlMFZQFU5qaPklk7Odx6TnKNzhKmdQXd9T8/l067nhtHKjm72BepTuld5/7Dr4/pPxLo0Y4P0cuTjaG/3zdY2ukIUb1L+Y2bBrc7v0icJEp/l1O1QdM1yRxjwoYkjJ2hrmm182a/43tfWc6yr2ZQKqVp4r4KPI3UTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669873; c=relaxed/simple;
	bh=EIbrLuhe1ooGthxEgQtJO7e+J6yAKFsxYGpGpHEbBow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SikvD39U88F3OUawCvSTUxs0aSKzEiF8LhX47FK5rJKI8o09MUriCZ+zotx+nC1laQv+O0WCLeIYkhRsLyjqP4YestURexlUQipjkgNNGkIWOUDbbyaiH4EQBIEQewksk4qoOem4uDoIoGkNT62ueTrMAW5Q6Ix81eHdEqeFlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaDgUCxy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaDgUCxy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso3290600f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669871; x=1774274671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9V4OY+Uejyw2avNrbAtAaf1qtY8TrzCMiBRo5m6knWA=;
        b=GaDgUCxydsqiBf5Cey9KAqo2GzIm1m6RH7HMMhpQ5/RHFqzKD9WjRWJuRh58VZC0rB
         ZBz6ZzQYrsJsB48mFdlOxe59Igj3iTG4yd9KuzuYXMERRT80AJEz/OxjbdCo7xeGxGXB
         mNO5Qhx1naafHWa12EJ3qrVKntnduUs0RO5nL+5qRUliGw6GBV77UDUCeyFRtCALKcsk
         SAzHDReBR24ABHWQ5OlsxK/kAuyoNtUAjGAYfaRfi14JFGerwgWO07S5NU2Gtj6dt4nz
         Y7rALaOEU67FkK0HelhYS8R2MggyuwRSJnDHRODfwCXCOyGrGkibTmcGzcbBZe6fYKIw
         Yjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669871; x=1774274671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9V4OY+Uejyw2avNrbAtAaf1qtY8TrzCMiBRo5m6knWA=;
        b=rNIKyppiZGvOQdhY9kllhizlwAUHWYTvlhl1nEtRYUnGzLNof4VTo4euEx97SCqRCX
         AJfdXPSqi9MfL/q1cExABaPaglTZ5D3NtbIC6pV5FW6L28ZU9DtbnV3uXnEcxfN9dNMP
         GZcYMBFe/d4oN0ImmKkbvJbXoAx2Jwy1ke/XEfxG5/ImiI4uZ+yYPOUqi9UtejuMS+RZ
         hrRqDT5xBgoMDb8wPW4luretxmSA1TdPYOWQ9Ohrf60U1TfLJ6IeVMjBx4PvXi5w2GWw
         OEuoMvX5h9yFsno6jSzzCLQYeiJpoPygK5MA141+2RcL1nLPxXb7uAZmLTQr7rbnoRKF
         D3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBfTY0b1OabV+h/UlHqbAuJ+rvQC0kIlgH0R29bruY5W9As2nRpl/KOkA/yPQ1f6XtCl+IyLLiqIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1iTPmIuHqUEJm3Dbdch61keW7hzbjhEsMd4YG5WPh4U8AbeJ2
	zmykzX1UyeNejqrmVhOFt4idJuuOVBVO3aeGnggr5E/uo1S9cx1MoVSJ
X-Gm-Gg: ATEYQzygMySyofX8VLYaGQeeSnJ0Ad7wcb2uvaXzIjKkQmS/5YQsgKk/6QztLFvpEua
	JfEgvKMp4qYRr7JMWDwKZCjElYq3Uo+jA7CHmjUJU/FvwzsLt0CAI0ClobX+Y8d6xu4G8dotULx
	gpd1rXuLl/g8KyHggZRGZX5y+Z0BGcudlZCtIIuvHQbKiP5wVUWpjjRmsx/ipnXpx7Hl/E17ngh
	0SAkGeKfxRlPim0k5W9ojmyA88nfofNED8Ut8sqXxIXmyrWirZfvELVn6sAB07MEKPiY6PuTjDG
	3DhNZ1AhTcI0Cm1dj6DA7F7DUSyzbWy9bQ7xgH2ttdFCeqVRLDG8aruiTwzRm+/c2jR7kxgIzVT
	lTX+xvfpBpQiukLwBtZQyNl6qi4LvUqUFAMX/2s7A2YhqqMQpLfHjVpcqehDfmOIMJx9X9VBtNd
	emqbzezwxpID5ncdwZNrMN4WCtv7xJRnwM5OqF4DLzc/uXnF18ZDzmmMImN61GL9vD
X-Received: by 2002:a05:6000:4012:b0:43b:44e1:f661 with SMTP id ffacd0b85a97d-43b44e1f791mr5650973f8f.36.1773669870494;
        Mon, 16 Mar 2026 07:04:30 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.234.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm20698725f8f.0.2026.03.16.07.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:04:29 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 16 Mar 2026 15:03:31 +0100
Subject: [PATCH v3 3/7] mmc: sdhci-of-k1: add comprehensive SDR tuning
 support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260316-orangepi-sd-card-uhs-v3-3-aefd3b7832df@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>
X-Mailer: b4 0.14.2

Implement software tuning algorithm to enable UHS-I SDR modes for SD
card operation and HS200 mode for eMMC. This adds both TX and RX delay
line tuning based on the SpacemiT K1 controller capabilities.

Algorithm features:
- Add tuning register definitions (RX_CFG, DLINE_CTRL, DLINE_CFG)
- Conditional tuning: only for high-speed modes (≥100MHz)
- TX tuning: configure transmit delay line with optimal values
  (dline_reg=0, delaycode=127) to ensure optimal signal output timing
- RX tuning: single-pass window detection algorithm testing full
  delay range (0-255) to find optimal receive timing window
- Retry mechanism: multiple fallback delays within optimal window
  for improved reliability

Tested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 172 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 01afdadcf70796704b272ee5a31543afd5e01188..83d7f9fad5c1fba2f07624ee657cd979a1c7e25d 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -69,6 +69,28 @@
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
+#define SPACEMIT_RX_TUNE_DELAY_MIN	0x0
+#define SPACEMIT_RX_TUNE_DELAY_MAX	0xFF
+
+#define SPACEMIT_TX_TUNING_DLINE_REG	0x00
+#define SPACEMIT_TX_TUNING_DELAYCODE	127
+
 struct spacemit_sdhci_host {
 	struct clk *clk_core;
 	struct clk *clk_io;
@@ -96,6 +118,50 @@ static inline void spacemit_sdhci_clrsetbits(struct sdhci_host *host, u32 clr, u
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
@@ -191,6 +257,111 @@ static unsigned int spacemit_sdhci_clk_get_max_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk);
 }
 
+static int spacemit_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	int current_len = 0, current_start = 0;
+	int max_pass_len = 0, max_pass_start = 0;
+	struct mmc_host *mmc = host->mmc;
+	struct mmc_ios ios = mmc->ios;
+	u8 final_delay;
+	int ret = 0;
+	int i;
+
+	/*
+	 * Tuning is required for SDR50/SDR104, HS200/HS400 cards and
+	 * if clock frequency is greater than 100MHz in these modes.
+	 */
+	if (host->clock < 100 * 1000 * 1000 ||
+	    !(ios.timing == MMC_TIMING_MMC_HS200 ||
+	      ios.timing == MMC_TIMING_UHS_SDR50 ||
+	      ios.timing == MMC_TIMING_UHS_SDR104))
+		return 0;
+
+	if (mmc->caps2 & MMC_CAP2_NO_MMC) {
+		spacemit_sdhci_set_tx_dline_reg(host, SPACEMIT_TX_TUNING_DLINE_REG);
+		spacemit_sdhci_set_tx_delay(host, SPACEMIT_TX_TUNING_DELAYCODE);
+		spacemit_sdhci_tx_tuning_prepare(host);
+
+		dev_dbg(mmc_dev(host->mmc), "TX tuning: dline_reg=%d, delaycode=%d\n",
+			SPACEMIT_TX_TUNING_DLINE_REG, SPACEMIT_TX_TUNING_DELAYCODE);
+	}
+
+	spacemit_sdhci_prepare_tuning(host);
+
+	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i <= SPACEMIT_RX_TUNE_DELAY_MAX; i++) {
+		spacemit_sdhci_set_rx_delay(host, i);
+		ret = mmc_send_tuning(host->mmc, opcode, NULL);
+
+		dev_dbg(mmc_dev(host->mmc), "RX delay %d: %s\n",
+			i, ret == 0 ? "pass" : "fail");
+
+		if (ret == 0) {
+			/* Test passed - extend current window */
+			if (current_len == 0)
+				current_start = i;
+			current_len++;
+		} else {
+			/* Test failed - check if current window is best so far */
+			if (current_len > max_pass_len) {
+				max_pass_len = current_len;
+				max_pass_start = current_start;
+			}
+			current_len = 0;
+		}
+	}
+
+	if (current_len > max_pass_len) {
+		max_pass_len = current_len;
+		max_pass_start = current_start;
+	}
+
+	if (max_pass_len < 3) {
+		dev_err(mmc_dev(host->mmc), "Tuning failed: no stable window found\n");
+		return -EIO;
+	}
+
+	final_delay = max_pass_start + max_pass_len / 2;
+	spacemit_sdhci_set_rx_delay(host, final_delay);
+	ret = mmc_send_tuning(host->mmc, opcode, NULL);
+	if (ret) {
+		u8 retry_delays[] = {
+			max_pass_start + max_pass_len / 4,
+			max_pass_start + (3 * max_pass_len) / 4,
+			max_pass_start,
+			max_pass_start + max_pass_len - 1
+		};
+		int retry_count = ARRAY_SIZE(retry_delays);
+
+		dev_warn(mmc_dev(mmc), "Primary delay %d failed, trying alternatives\n",
+			 final_delay);
+
+		for (i = 0; i < retry_count; i++) {
+			if (retry_delays[i] >= SPACEMIT_RX_TUNE_DELAY_MIN &&
+			    retry_delays[i] <= SPACEMIT_RX_TUNE_DELAY_MAX) {
+				spacemit_sdhci_set_rx_delay(host, retry_delays[i]);
+				ret = mmc_send_tuning(host->mmc, opcode, NULL);
+				if (!ret) {
+					final_delay = retry_delays[i];
+					dev_info(mmc_dev(mmc), "Retry successful with delay %d\n",
+						 final_delay);
+					break;
+				}
+			}
+		}
+
+		if (ret) {
+			dev_err(mmc_dev(mmc), "All retry attempts failed\n");
+			return -EIO;
+		}
+	}
+
+	dev_dbg(mmc_dev(host->mmc),
+		"Tuning successful: window %d-%d, using delay %d\n",
+		max_pass_start, max_pass_start + max_pass_len - 1, final_delay);
+
+	return 0;
+}
+
 static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -314,6 +485,7 @@ static const struct sdhci_ops spacemit_sdhci_ops = {
 	.set_clock		= spacemit_sdhci_set_clock,
 	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
 	.voltage_switch         = spacemit_sdhci_voltage_switch,
+	.platform_execute_tuning = spacemit_sdhci_execute_tuning,
 };
 
 static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {

-- 
2.53.0


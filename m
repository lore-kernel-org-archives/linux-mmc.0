Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158083A0E85
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056438; cv=none; b=MxjDLGdkGewaPWHmSb8V1qJFQBA3l15bxrz3PsjAv6iw7lxtV/z77vYqfuli31qCXnVJ2JqE0aaO5zftrxaar5leelDBXLagEH+i4bvpZ4HYH+4RR0LSmfqNZPl0U1qPgk+3guqUAs0uYz2Sq+PICxSNu3EzMnl5VA1aXtOYoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056438; c=relaxed/simple;
	bh=iawZxXCHV/teSW9TbByTZ0aCl2jCak1q3AZVPQS3+5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AV3utJPWjKpsMx5UrWvA+7h5bYLvl0yqxqArXJBjXz1pvEUvXNfBQEUutVif1VxWkMZ0UjP/rPtLiqRPcXkrdjfKnq/DjvILJJwY5FcBQdTc3iSa3D5ElRNBUsjv6Vhpk3ARQaJ5dHG7jtd8UFy56ZLo2TxO9abi4A040CWLhjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrgWMTOn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrgWMTOn"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b611274bso5193331f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773056435; x=1773661235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQ9F92hXIJmt/OqV8+0Y8qWB6C+g5fuewMC6KiuhW88=;
        b=KrgWMTOnsO8lwwizqhdDWJnLDXQpcAOenotW3cn2jOgnEozvbH9RJXGfwfAqWa3QTb
         pn5rxFO8y9KZwweEVkn9gdpfImgL2j01bwpsiggntdHMHXSs+RRorjigdz5N4XB/pZSz
         kjfWD4Zy1W6ovBcUW0eviSDjUO5xTIM+09HYdZtcTuN+OtHXXc+s+nJVNTXFymrekFhh
         6RnRTQowA4YFgkb1nGtyD4iFukeYZysYlAwR24OIkSt4i2NTeCutHnfTW/UvEM1StOwg
         fC1XAUG40qTDWdaVt5DqzqvVlVD98jQ9bu46SeMIXBsygfInwkm1EiKApe0LdCtHs+Y/
         tILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056435; x=1773661235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SQ9F92hXIJmt/OqV8+0Y8qWB6C+g5fuewMC6KiuhW88=;
        b=EFNdK9+3ap56KwymtxKWDz4tosCcGbKbUfUDYEl2OMjplWVdIly2vJ+xf8e77XYC4n
         dFaCUUfMTg8UdxOh4xJTycufgORg0sujkIqKGAEWkKB9VbXcuA6k8FtUg1InxpnpkK4W
         28u6UF0ZMpeqb2dXZh2V8rUbDqgdXWBeDJUpBJC7jP6K+icUjVniZ/gGRH1wr5KMVcge
         LIePPo2CmMFF1JCbsNu1S8qMtXocfyIwGJGZI6GrILLAcjy0uieBJrC2vafknfP7Oku6
         TwKg8dAqx8/fUJiwo9reA8SHqUHQIj7hE9eTLsY/ZdpabEYww4VRJSYQdz1PtzwK4R3q
         YtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw6ngKkTiEoxW9t2gOvfCtrn6zpth3mYKafXCz7paGxnCT0K9TS9JISaImMbaSYYuM9zP6f17VSSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLkwjNP55ROvaPL//EJ4rHYZ+qVvu/IuJAvONswcSAnVz/B7bs
	10yMBdm6uBaV4gNXThPfbHturgQCplGMhHr6GI+7fbfnGnDHfrg4IB/P
X-Gm-Gg: ATEYQzyTiV/5Dwp+4zS5xhHrJ5WHeqt3RwOUDJ61m1+ZqeJmzAR5LYyQH3ZKdDXmq3/
	g8trPMVEsrHYyhefGf6WJ+NYhD1CcbVQNECHSg+zzkADRQv8BJDMc3xXYN5+/40OV8VwPT06eD0
	s+4VgN78rak7uibpzSFqaMxCiBf3mUG5yoPAmP8gW3u0OcdS1UcfH2y07V7Tg74T5ndCF2NR+NB
	qc/NeOeRPIgl9aLDAozifIdHD4xqPtbh7xuvbx/u5oM1oe4t80S7ikbltYXh6HIAVveCdYkzII+
	Mio0Iz0Se8vGK2WQOQTfraPi4ZSp0evZxSOt3bukmU/3vRR+pK35PkRUSngXXyv1LNLbIybGq37
	+huLcxJUFUIixEouLnN3xd7lGeuW7YGU24HrLpG2vYwP9gDgz8cUwQ/Y3b5zwK9JjDpoxNaCCrP
	WhrVizttOS/8dqwDbgVpQdd8t1D0WjxFfrahEP80FjG/Zb5sg3XIbNFOqCgGWB2q9O
X-Received: by 2002:a05:6000:1886:b0:439:b541:a091 with SMTP id ffacd0b85a97d-439da8a2cd8mr18675754f8f.56.1773056435052;
        Mon, 09 Mar 2026 04:40:35 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.236.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8ec97sm28471699f8f.5.2026.03.09.04.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:40:34 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 09 Mar 2026 12:40:14 +0100
Subject: [PATCH v2 4/7] mmc: sdhci-of-k1: add comprehensive SDR tuning
 support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260309-orangepi-sd-card-uhs-v2-4-5bb2b574df5d@gmail.com>
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

Implement software tuning algorithm to enable UHS-I SDR modes for SD
card operation. This adds both TX and RX delay line tuning based on the
SpacemiT K1 controller capabilities.

Key features:
- Conditional tuning: only tune when SD card is present and for
  high-speed modes (≥100MHz)
- TX tuning: configure transmit delay line with default values
  (dline_reg=0, delaycode=127) to ensure optimal signal output timing
- RX tuning: test full delay range (0-255) with window detection
  algorithm to find optimal receive timing
- Retry mechanism: multiple fallback delays within optimal window for
  improved reliability
- Complete register support: add delay line control and configuration
  register definitions for fine-grained timing control

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 119 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 79cb7c8d0b6d9c4206bf01721651c8efe8a173c9..d903851b9be0e1d21a2b30636f5e63a52cad0dc2 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -84,6 +84,12 @@
 #define  SDHC_TX_DLINE_REG_MASK         GENMASK(23, 16)
 
 #define SPACEMIT_RX_DLINE_REG		9
+#define SPACEMIT_RX_TUNE_DELAY_MIN	0x0
+#define SPACEMIT_RX_TUNE_DELAY_MAX	0xFF
+#define SPACEMIT_RX_TUNE_DELAY_STEP	0x1
+
+#define SPACEMIT_TX_TUNING_DLINE_REG	0x00
+#define SPACEMIT_TX_TUNING_DELAYCODE	127
 
 struct spacemit_sdhci_host {
 	struct clk *clk_core;
@@ -251,6 +257,118 @@ static unsigned int spacemit_sdhci_clk_get_max_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk);
 }
 
+static int spacemit_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	int ret = 0;
+	int i;
+	bool pass_window[SPACEMIT_RX_TUNE_DELAY_MAX + 1] = {false};
+	int pass_len = 0, pass_start = 0, max_pass_len = 0, max_pass_start = 0;
+	u8 final_delay;
+	struct mmc_host *mmc = host->mmc;
+	struct mmc_ios ios = mmc->ios;
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
+	if (!(mmc->caps2 & MMC_CAP2_NO_SD) && !mmc->ops->get_cd(mmc))
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
+	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i <= SPACEMIT_RX_TUNE_DELAY_MAX;
+	     i += SPACEMIT_RX_TUNE_DELAY_STEP) {
+		spacemit_sdhci_set_rx_delay(host, i);
+
+		ret = mmc_send_tuning(host->mmc, opcode, NULL);
+		pass_window[i] = (ret == 0);
+
+		dev_dbg(mmc_dev(host->mmc), "RX delay %d: %s\n",
+			i, pass_window[i] ? "pass" : "fail");
+	}
+
+	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i <= SPACEMIT_RX_TUNE_DELAY_MAX;
+	     i += SPACEMIT_RX_TUNE_DELAY_STEP) {
+		if (pass_window[i]) {
+			if (pass_len == 0)
+				pass_start = i;
+			pass_len++;
+		} else {
+			if (pass_len > max_pass_len) {
+				max_pass_len = pass_len;
+				max_pass_start = pass_start;
+			}
+			pass_len = 0;
+		}
+	}
+
+	if (pass_len > max_pass_len) {
+		max_pass_len = pass_len;
+		max_pass_start = pass_start;
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
@@ -344,6 +462,7 @@ static const struct sdhci_ops spacemit_sdhci_ops = {
 	.set_clock		= spacemit_sdhci_set_clock,
 	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
 	.voltage_switch         = spacemit_sdhci_voltage_switch,
+	.platform_execute_tuning = spacemit_sdhci_execute_tuning,
 };
 
 static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {

-- 
2.53.0


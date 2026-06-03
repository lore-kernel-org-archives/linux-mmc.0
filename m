Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56C33FC5B4
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469868; cv=none; b=bPd1yQofYhy0kDkEUVgu5h+JPo7/raJoJCQiqg6baSbB8GSRYxIf7Vd81LBthbVWffCs9TG9NuF/apDeR+jrzTv0Dt1Fy4TMz1YpUtbDLUIvNdtg0STZJI/oncwinpndaoongl7HXUMTASuYpahqrPPGZ6DdTT8z6jdvP0D216U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469868; c=relaxed/simple;
	bh=qR2v2X5KmKY1aOmqZhoUA64DfOH2jrnAkTyGU5BQy/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quSC0bd4Vt7xshdnHyzLH2iMjQq+aTuyvrFzxpZjQdyJDei/zZAUIBiUT1hcH87SyNEPFsSAsgb2qHfNVkMxYBbyWqCFuv7Xp3+xyCi+0x34bbfJOcgIybL5afdhGm7q485Yf4el+FV8YVqhtWs3sOxhVeFBYMLBhRoWeqeyLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGlQvCFt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGlQvCFt"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so15023935e9.3
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469864; x=1781074664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98XchVxz6Y7TKT8XXQBfVOUPIBeQByRw1PfGZS6iWGk=;
        b=eGlQvCFtUJBTxSLjeJmF9N+O3KpT6sH6Uq3tbFdwqvrCq/AKT2sxwjutQ6Yk5Lt+sH
         D0kAaBqpPmiWxoszEV83NvbnjK4YpzQh3B7GewLhO10UhQ0+zVq4pBx59WvWdT2jG3Go
         6TqUtLgqnkjbNJzy+NoOLQPnKyd09d4idNO+LBNmEXbuIn/9Ojij9gHWO2IN+yLfukVy
         nXM4tdTM7/31r4vDZFnfHDZE7RcSCAsVY4u2kT7SK9sHPUeftOEHYmsv/aushQ3eK8pW
         eux8mwS8NDRp5QZeZy1MM/uQybvM+0qmM3ZHpGuZHJbV4Vop+m6FzKbVkMLTE1jwAXl7
         lquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469864; x=1781074664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=98XchVxz6Y7TKT8XXQBfVOUPIBeQByRw1PfGZS6iWGk=;
        b=qGdalqblXuTjSP15b0ISKoZzTUD5W6fghHz/idHCmTKYIujftw9m8EIC1naA1AvxbC
         bEajUolztIcwycgxQzIjVbdhfTravqNrcf/2vhw4OXwFlxFh+xkI5xGMOL6OYAPsArh2
         El04HgiNIw8nHONO1Ib+tWjrSORrRsK0q5i8pO6Qrq+9PFsGR9S4cnPi1qyBv2+cRooN
         tHpoVqTKzTBlJUGrrLHw21o9sD59bCkeXb2eZOoMbC3XCmIkGz/SAhox3upWufJ7dMmt
         AkPAxoXE2mD7kn8wU/HkesdQvWNkbPwAi48hJzYGs9Jw1UCGitQxiKUHes9BXcGP+qzq
         SvgA==
X-Forwarded-Encrypted: i=1; AFNElJ8evsx9tlsXel4F4/P/4WKdwig+j3kKHc1Yj4zUCr/eF1gUQ0XWq6kXqlgE5g4PvAXkvVIciDVN5II=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLrQ18lZHqEdn+JWI0IRC9nQGxYASdLi0Mj/bFzQGNaeQC8Vt
	yXdYvfZjKSZP4sx7LN4v5KPrXcFJhoc+ZPwqEJfPOtfSM4QDcKtxGkCU
X-Gm-Gg: Acq92OHMe+LdenP0JeTMs/7yT9fqUdcCnZtvP5Lz7abKGM6d158u9WvdAP3YC1E40hb
	OAPIa6IosX+lAjuXY7wy8xIFwgaDNaOB0ZObUdiz+hfsUHm/KZ4KHYIYF8Gy9vltDHNvIHt98qz
	zvfEGtjkyh+J790uPZfpl3O+Em2/+ZqDp7Un0c7GA/wDVDYGQmQsAc3gJ4F0rps9xVCy+FGtKWz
	W5242UhtvdPmZh9Lbecyg5qzP9oqONjeA6fmwl8oWYUMlZGOLTsyGzDkD8wtow1Ol0N0GNWTn/t
	ZY0XpLMrdbfaUHLsizkxHa6hZwvu3NA4DANkWG07/3loqY0zBWZ1gXRmIh2FGNCLYrmsPmHNWAt
	XoraFQwXv4GHYL2m/Qd+mWRiHexHMXEqCJjqEbxsRZccZObuDDP4Lu9KasDdiIEb4FTW+6ejph4
	oHe5DV74ZGZ7XIsnACjqltw9zK4Pj5aTurFAt7e56r4XpYAkma9Q5zhJ4+GJg=
X-Received: by 2002:a05:600c:1d09:b0:490:3f7a:108b with SMTP id 5b1f17b1804b1-490b5e51a49mr32472725e9.16.1780469863954;
        Tue, 02 Jun 2026 23:57:43 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:179c:89ab:19f6:9ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d90bdsm9001855e9.0.2026.06.02.23.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:57:43 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v17 08/17] mmc: renesas_sdhi: Add tuning_delay hw_info flag
Date: Wed,  3 Jun 2026 07:57:08 +0100
Message-ID: <20260603065731.93243-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

As per the RZ/G2L hardware manual, the TMPOUT bit field in the SCC_TMPPORT
register needs to be set to 0 when transferring at 3.3V, and to 1 when
transferring at 1.8V.

Add a tuning_delay bitfield to renesas_sdhi_hw_info to indicate hardware
that requires an adjustment when the signal voltage changes.

Add sdhi_hw_info_rzg2l with tuning_delay = 1 and assign it to
of_rzg2l_compatible, enabling the adjustment for RZ/G2L. All other
platforms retain sdhi_hw_info_generic with tuning_delay = 0 and
are unaffected.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h               |  2 +
 drivers/mmc/host/renesas_sdhi_core.c          | 83 +++++++++++--------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  8 +-
 3 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index a42934e6d49d..a3c5fa368242 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -44,6 +44,8 @@ struct renesas_sdhi_of_data {
 struct renesas_sdhi_hw_info {
 	u64 clk_mask;
 	unsigned int max_divider;
+	/* hardware features */
+	unsigned tuning_delay:1;	/* Has tuning delay */
 };
 
 struct renesas_sdhi_of_data_with_info {
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 16ed6fd8470d..868ba6a6919e 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -257,40 +257,6 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 		 TMIO_STAT_DAT0);
 }
 
-static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
-						    struct mmc_ios *ios)
-{
-	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct renesas_sdhi *priv = host_to_priv(host);
-	struct pinctrl_state *pin_state;
-	int ret;
-
-	switch (ios->signal_voltage) {
-	case MMC_SIGNAL_VOLTAGE_330:
-		pin_state = priv->pins_default;
-		break;
-	case MMC_SIGNAL_VOLTAGE_180:
-		pin_state = priv->pins_uhs;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/*
-	 * If anything is missing, assume signal voltage is fixed at
-	 * 3.3V and succeed/fail accordingly.
-	 */
-	if (IS_ERR(priv->pinctrl) || IS_ERR(pin_state))
-		return ios->signal_voltage ==
-			MMC_SIGNAL_VOLTAGE_330 ? 0 : -EINVAL;
-
-	ret = mmc_regulator_set_vqmmc(host->mmc, ios);
-	if (ret < 0)
-		return ret;
-
-	return pinctrl_select_state(priv->pinctrl, pin_state);
-}
-
 /* SCC registers */
 #define SH_MOBILE_SDHI_SCC_DTCNTL	0x000
 #define SH_MOBILE_SDHI_SCC_TAPSET	0x002
@@ -351,6 +317,55 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
 	writel(val, priv->scc_ctl + (addr << host->bus_shift));
 }
 
+static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host)
+{
+	struct renesas_sdhi *priv = host_to_priv(host);
+
+	if (!priv->info->tuning_delay)
+		return;
+
+	if (host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
+	else
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
+}
+
+static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
+						    struct mmc_ios *ios)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	struct pinctrl_state *pin_state;
+	int ret;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		pin_state = priv->pins_default;
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		pin_state = priv->pins_uhs;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * If anything is missing, assume signal voltage is fixed at
+	 * 3.3V and succeed/fail accordingly.
+	 */
+	if (IS_ERR(priv->pinctrl) || IS_ERR(pin_state))
+		return ios->signal_voltage ==
+			MMC_SIGNAL_VOLTAGE_330 ? 0 : -EINVAL;
+
+	ret = mmc_regulator_set_vqmmc(host->mmc, ios);
+	if (ret < 0)
+		return ret;
+
+	renesas_sdhi_set_hw_adjustment_delay(host);
+
+	return pinctrl_select_state(priv->pinctrl, pin_state);
+}
+
 static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv;
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 84b1b38ca465..d056c3586e6f 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -237,6 +237,12 @@ static const struct renesas_sdhi_hw_info sdhi_hw_info_generic = {
 	.max_divider = 512,
 };
 
+static const struct renesas_sdhi_hw_info sdhi_hw_info_rzg2l = {
+	.clk_mask = 0x80000080,
+	.max_divider = 512,
+	.tuning_delay = 1,
+};
+
 static const struct renesas_sdhi_of_data_with_quirks of_r8a7795_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_bad_taps2367,
@@ -270,7 +276,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
 static const struct renesas_sdhi_of_data_with_quirks of_rzg2l_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_rzg2l,
-	.info = &sdhi_hw_info_generic,
+	.info = &sdhi_hw_info_rzg2l,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compatible = {
-- 
2.43.0


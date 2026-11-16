Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830542;
	b=ZbI8COk0TUstIHeh4i6yYikLUv9HRGAnDWtsT2LI4kVaB5LEFnKUElHXk+FJ1GHk1iVq
	 syuxpznEMALAdDjmbZD30HTjr1jwCY0Soccc9evvomejhpS3ODqXsmLRhq6JiqH2fJwR7
	 1qRvo8Xk+jLqp+Ga6HrFkpGTQ8aPc2SNJ9PPtR/wvggF8zHYJfdJ49GUbk/skcjUFQ1zI
	 QlvoXvx2cCNopNkctUbMBqu8vD6f1RmhDDzIVMvVNvhB2kdA/kERi69KFXyRXmG1MxGYB
	 12CMT1kAjMo9YPE2TVon3JbWMKnYzo88J6k7tpmeMiNxUEESQmdTwcFcudRKqSo9PiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=0LcVzoQKL0bsokOHWsWsVAJ1s1LCZ3P+TDaOc2v7pus=;
	b=UfbjquEScEPhLkbFzt12YZ1DZVippRFPybNGVznTvibJ4ZPptRbv6h6zv6QXAo45j+f6
	 5NZy2wp9FO8zzGbaPyTzmGmb1j85lyLWeeD1EDpLRq9rHWt3DqxnZwjhzJMynhGcVzgZI
	 toctb37vUBmHgi7q5W2r6juMrQMZJ6oaJHVP+8uE0+n8lp7I2mesJcYcqAmjKTZjRWTiQ
	 zWMZGIpCCLDrqLVM5cBbXpk6V2LcoR3VGL6In7m2yn+o0KDM21vZj/SqYMLsnfF0RQ9c/
	 8IvQ4m4hw/jXOZ/Lnc/XrB/Y99taPF6DR1I8Ikk0I3zQd9ydf4DAGpRbJQ9J3Rmox4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nsYTPBFn;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4DB606A337
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 12:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B4DB606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nsYTPBFn
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49d05d51553so18504875e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 04:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794830540; x=1795435340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0LcVzoQKL0bsokOHWsWsVAJ1s1LCZ3P+TDaOc2v7pus=;
        b=nsYTPBFnByBvont31Bz/qtogyCLMB4xedKGIjxFDZj62qtJqvpqgL6Zx1PKwfIa5q7
         h5Y/O8duQjNutXxjb1+pyJPwpUDpy+pHcG681AQN9IpAFg4F7j0lH1fFpf0MX9mbsj06
         08T8t8weOGxNUjAvZfU+E5hBqxU28SHocKUr/hAP2U8e2afOh4qHpwqnYf4v5LdtFZaY
         99LURbf+nmkrJhTlNwT/QPiLywJ/y6/yHakTEPyEzyHNhp9ByCDDhvAFF5DX/G0kmDRl
         fBdIrw8bcXpcUpvSUctc8AU+6i+bMqe/fX8tf854Srk0rv90wv1gUg0wARmV7sgk6zF2
         gE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830540; x=1795435340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0LcVzoQKL0bsokOHWsWsVAJ1s1LCZ3P+TDaOc2v7pus=;
        b=WYkw639agH7AEePDDkkl0TanPaWLqo9aEA5z+l33Ys3DqVsDes3IY98OfhAGohhykS
         +WLgpZBY9jF13lfX8W/G42xEYolq5Y+0XFxLjFBfljQtL/Z/J0S5cf5bQGkRMoDys72U
         oyZ8tmg1uSADcuJ+Emizk/ycP7khpGG0MO+y0gAFFGqm1AcQG0ClDB2soVpp8ARJ78x4
         tePdti/KR7+tRMVroLVLbd0ObwsVLp9/JM/pvHOkl9YG7M8xB2390v2n8ASXGxxBJljh
         IwQrPjNN5/rc0YsfsMPrwEbNMWxlgQntyjbgyQJV1gSvcIN5Tx+JM6Z3kty3B7S4X6YO
         kn7Q==
X-Gm-Message-State: APuU4Z/pG8KJMyTOesp5ksD3GqaXsgnA4EByEpWdv9AXi1TrnAeN0Bsn
	AObdhMW+x5CRhAhJAhvUn+Hf/kNLnhWlUHvTJsKXFdMoUvDhMpN8S2+YiaIgmw==
X-Gm-Gg: AYBFou21rJUema9KQndjp0ZlsxUfRuEHTMXFqtoBS5EHXqhrzLQ7ApV86YRX41Sdwi3
	pEHBsXHGmrn6dd63lEU9ysrPEn0bLijElIiBxTa2VsIO2VFAu5mK3KqDR1fWebUNiexQpJ0oEMe
	Zd8jGgAqzvwVKA9g2JCx76jd+0oYhRQJkxA+Ai2IIARzSaIOfpFhn9mgm7pRuXI6zdUdJvT406V
	Al8WL0gLLKlCoSTFNyOmtBPWURJsaZ2atOn1UwN42s7TgZ36autBsk5TDpczxhmmbbPxFejIBhY
	EWAztDZ5/V5rRSfyD4pzud0jaFv3PSZy3sOVw0ttR22g0P7M8RpoGHvWl1Y1vdqs/oyI3iVCD/q
	6tZ0VerL88t9JriNKowzBsM76DXSizNgnZWJS6U491W05fx7JVM3giy7QQqCinrZ+xi16Z0XBVF
	BW6c2KLMBcA+3OPuPRwSCxXdOF/R9f+edXTn3I2J6TeH0HTcRgU6n1RfiOeO8hP2UF8OZHSTrMR
	meY7/48iFyeT9a3rvFXWVl7S3kngw/OpunScymhRvhEj6Khu0f8Yn8BFUvEhNIrljXEz61dv4o6
	UOF+Ma0pDpbeUGnRXPuCM/+3IwhqdZmg3bbOwEAjKlhL7pOjHeotlcVz/w/Sj5n1zg==
X-Received: by 2002:a05:600c:524d:b0:4bb:68b9:f615 with SMTP id 5b1f17b1804b1-4bb68b9f88bmr120047345e9.17.1794830540041;
        Mon, 16 Nov 2026 04:02:20 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6889:eb24:5e57:83b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm395562805e9.15.2026.11.16.04.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 04:02:19 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Date: Mon, 16 Nov 2026 12:02:17 +0000
Subject: [PATCH 3/3] mmc: renesas_sdhi: Add RZ/G3L HS400 support
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-sdhi_hs400-v1-3-c5bedd312408@bp.renesas.com>
References: <20261116-sdhi_hs400-v1-0-c5bedd312408@bp.renesas.com>
In-Reply-To: <20261116-sdhi_hs400-v1-0-c5bedd312408@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794830537; l=6088;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=oC8XI52dgMrks2U7cRSaACFaiml902PICrgQDRba1+M=;
 b=GK+gmQd3LyUWIDHhs3v3iW73j6qFhTUXBLJUZm5L2mmn2c79h0cFompgotfMRnTN0v5M8BwPE
 SwczoxErMSCC6cDGd2WDXbv+rIfvMNJFnvYy+hYI5krGOlFT9TFIf8j
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Add HS400 support for the RZ/G3L SoC.

RZ/G3L needs a second HS400 enable register, SDm_SCC_HS400MODE2
(offset 0x020), alongside the existing TMPPORT2 path. Add a
TMIO_MMC_HS400MODE2 flag (bit 16) for controllers that need it.

RZ/G3L HS400 mode does not use internal divider and supports
only one divider value "0" in the SD_CLK_CTRL register.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c          | 38 ++++++++++++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 ++-
 include/linux/platform_data/tmio.h            |  3 +++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 7dfcf7f970aa..f15f766b7666 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -135,7 +135,8 @@ static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *host,
 {
 	unsigned int freq = clk_get_rate(clk);
 
-	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+	if ((host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) &&
+	    host->mmc->ios.timing != MMC_TIMING_MMC_HS400)
 		freq /= 2;
 
 	return freq;
@@ -259,6 +260,14 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 			clk &= ~SDHI_SD_CLK_CTL_DIV1;
 	}
 
+	/*
+	 * RZ/G3L SoC HS400 mode has only 1 divider value.
+	 * Other divider values are prohibited
+	 */
+	if ((host->pdata->flags & TMIO_MMC_HS400MODE2) &&
+	    host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
+		clk = 0;
+
 	clock = clk & host->pdata->clk_div_mask;
 	if (clock != SDHI_SD_CLK_CTL_DIV1)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
@@ -315,6 +324,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HS400MODE2	0x020
 #define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
@@ -350,6 +360,9 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT_DISABLE_WP_CODE	0xa5000000
 #define SH_MOBILE_SDHI_SCC_TMPPORT_CALIB_CODE_MASK	0x1f
 #define SH_MOBILE_SDHI_SCC_TMPPORT_MANUAL_MODE		BIT(7)
+#define RZG3L_SDHI_SCC_HS400MODE2_HS400EN2		BIT(0)
+
+#define RZG2L_SDHI_SCC_TMPPORT2_TMPOUT		GENMASK(15, 0)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
@@ -364,6 +377,18 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
 	writel(val, priv->scc_ctl + (addr << host->bus_shift));
 }
 
+static void renesas_sdhi_set_tmpport(struct tmio_mmc_host *host, u32 tmpport)
+{
+	struct renesas_sdhi *priv = host_to_priv(host);
+	u32 val = tmpport;
+
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		val |= sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2) &
+		       ~RZG2L_SDHI_SCC_TMPPORT2_TMPOUT;
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, val);
+}
+
 static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host,
 						 bool force_clear)
 {
@@ -374,12 +399,12 @@ static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host,
 		return;
 
 	if (host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330 || force_clear) {
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
+		renesas_sdhi_set_tmpport(host, 0x0);
 		if (hwadj2)
 			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2,
 				       RZG3L_SDHI_SCC_HWADJ2_3_3V);
 	} else {
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
+		renesas_sdhi_set_tmpport(host, 0x1);
 		if (hwadj2)
 			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2,
 				       RZG3L_SDHI_SCC_HWADJ2_1_8V);
@@ -486,6 +511,10 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2,
+			       RZG3L_SDHI_SCC_HS400MODE2_HS400EN2);
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
 		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
 		       sd_scc_read32(host, priv,
@@ -623,6 +652,9 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
+
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
 		renesas_sdhi_adjust_hs400_mode_disable(host);
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 37eeaa52f011..d9b9f9663386 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -165,7 +165,8 @@ static const struct renesas_sdhi_of_data of_data_rzg3l = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
 			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
-			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ,
+			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ |
+			  TMIO_MMC_HS400MODE2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 501ca4355c34..81a37d6baefc 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -59,6 +59,9 @@
 /* Some controllers have hw adjustment delay */
 #define TMIO_MMC_HWADJ			BIT(15)
 
+/* Some controllers have HS400MODE2 */
+#define TMIO_MMC_HS400MODE2		BIT(16)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;

-- 
2.43.0


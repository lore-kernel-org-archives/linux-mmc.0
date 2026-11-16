Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855168;
	b=xuWSWAtKV9ftxOtQEuIs0WaUq7mUnnX8jMuIsGx+dKWnXUQRfD84HlZWthJkpVrj8sjU
	 aW0opp3M/CZ/8o9GBovq+26NhpF71C4TBcxqMva6z/pJjiPFBh/1bOIGGryvE7wEIUsgA
	 HkZLEOQ9N7p15zIj8O8Sxy2pNO30PYZWUhX1VYaQ8Kn7xWC+6gkzsbXHE/liNnx4wzzH9
	 J14tPL1W/GYfcDcFidA5JLWJgZLHfBc3b0iwDpyhkgrOQjQKTxk4OSED4278jOrbs3VEq
	 eWzlz0g0LWHv5P/Y2BFgKqkNfvZ00AtSWN3swmMt78oY+CDEbMRhZPqg3FjlkJxsCOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=dnESQZB66ZqtLu8qDe7KJpPX20rrkH6E5cL34m1eAjk=;
	b=eGH0fJ8+NBVlWv3SWOgKufY9k9Uo4SK5vanzL1LvfrmiyKTAogcPl1zTr9zO6DZEhRlD
	 4py1iGibcoqJOIlxBpT3pwmByxuUye3umv3muIePTE8yoyNBCHqQktOizA7jTDlrLg/0/
	 +6ZjSUz6aO7mnIgz9JFW7D4B98mmkb+K1BGmIjYF4lbNkJU+uRRUnj37yvTy/nZaD/OtS
	 QF3j5dT9pbtmnH/UBLMGzWJgjpLNMr26nxccHpMJd93iRZC55KK646wBnJnnjrEnSS+Mn
	 dtBt8YjWfJSYJpjB0u+QXwE4L8fc559z53i1rOBmizjqHaJiDH8HXDG0dRWTz8fTxyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MeEs0rAb;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917E0606A8A2
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 18:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 917E0606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MeEs0rAb
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so38287465e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 10:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794855163; x=1795459963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dnESQZB66ZqtLu8qDe7KJpPX20rrkH6E5cL34m1eAjk=;
        b=MeEs0rAbBqdpQTtPaZAUaHzwQuaajnsJkfMmed7vGCCuK/Np4aDjJYaG19/5LCBnHO
         3iwFlZ5Tk8R9RG2XTkmUHFzyqlee5C4ica3JcNBjOsnd6SKxbz9Cd4cyJoHYmnQ2xQ1A
         P1UD/nhaUOpm8/zaMPqO0cqwsHOdNHCUP/uH+eJZ9xsiXIYBvccN3NdbPBH1j9Ouz7Yl
         A1USMd0RjstTye73wY2QuCR2DQSlPE4z254LM0rZzvOFauoMCkKXqzOMpO4RU146lkWw
         HReMe3YhBPi2bYDa3g5w0WpfDBeff3QBgJvXkFzbzJhK3oAksaFpVx7EGMWZyldpOlgM
         TLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855163; x=1795459963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dnESQZB66ZqtLu8qDe7KJpPX20rrkH6E5cL34m1eAjk=;
        b=wADWmZYaYQ+LdzZbGydHmvwpLvrpdQiEMbZnI521Ad5rTXufkvCNHncoHmDCuMeVhh
         Nym6gXzyjI4htZ8d6BwAfbDM5ylmUCh8y8dXcWIa6TWUuoTIBacAVigCq2W9uPuWli1U
         7CbRRhK2yPbGfdUn8NEjtWy7TJGJ0fcT6ihBpyDVQfZUpwyuWJ3tc1Cna1yl1U2/sAGi
         DriRyawRr7hySTZEXo5O1jb8E7W9QoPyUnsIwUGDIdKCQIRoGZVo85Khp1mXm5Jzn708
         RzKRKW5rvOx19ZeyTOZSBL6Fe0XiZcdTWBzOdXxzgRrZ/dWgzXsZf1AgeMV1Ac93leIO
         P+VA==
X-Gm-Message-State: APuU4Z/qNE261OfnhH3ufh0mggC2F/gbocwevM0K4FDfFynDTZB7xRAO
	K62VOVh9y4O8t4i6m9ccbgTLJAxnGX+PMtIZFBBG8S+ke2ySERJSrjEE
X-Gm-Gg: AYBFou1Ia6lSKLR+P3p0iOZs7k4IyTgzG1/dgaloy11K4icroaw1e49qIhBzdcJU9Mz
	HVjVj+uxbY90DPMtnJzdFyO5k+HNnbonpEwebLLnxntzXG0s0LSDoauKY/tIJZTWOX51DC1WIje
	i6dlyUycFHfoFqkVj9QTe4mbGgVmQJpOc1Jy2Kpt5i3CXDmNV8w+iccPqvwe3KB4Qm9lErjRGQT
	lHZSknXgDz2URoQ0slZLO6fG/oOwEXFSncPVVy59Om3EyCXFGT9PLn2Jwv3EWAqT1LlVuKIG2Gk
	ZeDtSxp2mkTR89lf5cpV5DJ7hasAccArOC+YVI2vlWQpVUzGBw+TLsdZ0Ws0kKhQbp9f0D3ipP7
	oB3hbUYG2ZJRSxEIvE2q2jB/ohgUIqGh1Sg/Ly5uADvPNTRSJKMNGZe9Fx/CH3MGcSFK++DYazJ
	B2Uj+lpd3dTx9RYKJO/clh0Nfr0WCslIKKtc1svUmjxsrxF4F5SBinfHE+4JgmrWBlFJvNhreAj
	jkbKG4Ggzg/gU1/oVMB9N62Ps/4ORWXxKY9y4l2ZvVbs1MQ8/h/OfqqcmxXDsfdgO5JtKhxNBTC
	7i3NMxfG2AiZSQOT4hGEZ+WOLdUFeogceRUk4g5AG7aIbcSxr7F8bqnHq0z3de58c2C1o68TqHO
	9FFV522ml6RY=
X-Received: by 2002:a05:600c:81c9:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4bb55a65b31mr234258215e9.18.1794855162899;
        Mon, 16 Nov 2026 10:52:42 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6889:eb24:5e57:83b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5720f6basm157961345e9.4.2026.11.16.10.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:52:42 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Date: Mon, 16 Nov 2026 18:52:41 +0000
Subject: [PATCH v2 3/3] mmc: renesas_sdhi: Add RZ/G3L HS400 support
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
Message-Id: <20261116-sdhi_hs400-v2-3-de41f7a7f330@bp.renesas.com>
References: <20261116-sdhi_hs400-v2-0-de41f7a7f330@bp.renesas.com>
In-Reply-To: <20261116-sdhi_hs400-v2-0-de41f7a7f330@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794855160; l=8502;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=zSh1witOWgk70aQXdLbB1vUXnJMNBizQ3rQrfFp6sRo=;
 b=zU21SwipWnY3BNuItVFANLBfF6cJhVhygSBvpXQMHKuOYeWD9fL0yDFg8sNF+WCaIZaXLR981
 cMOQT618E9+ApeBBeXIb7ggAFzPgi5OSIBNcXuqH1CM3wUeGAUpiCXT
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
v1->v2:
 * Using ios.timing to decide whether the HS400 divider restriction applies
   is wrong: mmc_hs400_to_hs200() lowers the clock while ios.timing is still
   HS400 and then walks through DDR52/HS/HS200 before prepare_hs400_tuning()
   clears the HS400 bits, so the divider could stay at 200 MHz or prohibited
   non-zero dividers could be programmed while HS400 is still enabled. So
   tracking HS400 hardware state for RZ/G3L clock programming using 2
   variables hs400_active and hs400_clk in struct renesas_sdhi.
---
 drivers/mmc/host/renesas_sdhi.h               |  2 +
 drivers/mmc/host/renesas_sdhi_core.c          | 63 +++++++++++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 include/linux/platform_data/tmio.h            |  3 ++
 4 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 8ae2ec04bd1f..d14cfd873bb9 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -94,6 +94,8 @@ struct renesas_sdhi {
 	const u8 *adjust_hs400_calib_table;
 	bool needs_adjust_hs400;
 	bool card_is_sdio;
+	bool hs400_active;	/* HS400 enabled in hardware */
+	bool hs400_clk;		/* divider bypassed for HS400 clock */
 
 	/* Tuning values: 1 for success, 0 for failure */
 	DECLARE_BITMAP(taps, BITS_PER_LONG);
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 7dfcf7f970aa..66da2d1e9370 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -133,9 +133,10 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 static unsigned int renesas_sdhi_clk_get_rate(struct tmio_mmc_host *host,
 					      struct clk *clk)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int freq = clk_get_rate(clk);
 
-	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+	if ((host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) && !priv->hs400_clk)
 		freq /= 2;
 
 	return freq;
@@ -226,12 +227,33 @@ static void renesas_sdhi_sclken(struct tmio_mmc_host *host, bool enable)
 	}
 }
 
+static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
+					  struct renesas_sdhi *priv);
+
 static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 				   unsigned int new_clock)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int clk_margin;
 	u64 clk = 0, clock;
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2) {
+		/*
+		 * While HS400 is enabled in hardware only divider 0 is allowed.
+		 * Leaving HS400 (e.g. mmc_hs400_to_hs200()) lowers the clock
+		 * before the core calls prepare_hs400_tuning(), so disable
+		 * HS400 here once a non-HS400 clock is requested.
+		 */
+		if (priv->hs400_active && new_clock &&
+		    new_clock <= MMC_HIGH_52_MAX_DTR)
+			renesas_sdhi_reset_hs400_mode(host, priv);
+
+		if (new_clock)
+			priv->hs400_clk = priv->hs400_active ||
+				(host->mmc->ios.timing == MMC_TIMING_MMC_HS400 &&
+				 new_clock > MMC_HIGH_52_MAX_DTR);
+	}
+
 	renesas_sdhi_sclken(host, false);
 
 	if (new_clock == 0) {
@@ -259,6 +281,13 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 			clk &= ~SDHI_SD_CLK_CTL_DIV1;
 	}
 
+	/*
+	 * RZ/G3L SoC HS400 mode has only 1 divider value.
+	 * Other divider values are prohibited
+	 */
+	if ((host->pdata->flags & TMIO_MMC_HS400MODE2) && priv->hs400_clk)
+		clk = 0;
+
 	clock = clk & host->pdata->clk_div_mask;
 	if (clock != SDHI_SD_CLK_CTL_DIV1)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
@@ -315,6 +344,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HS400MODE2	0x020
 #define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
@@ -350,6 +380,9 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT_DISABLE_WP_CODE	0xa5000000
 #define SH_MOBILE_SDHI_SCC_TMPPORT_CALIB_CODE_MASK	0x1f
 #define SH_MOBILE_SDHI_SCC_TMPPORT_MANUAL_MODE		BIT(7)
+#define RZG3L_SDHI_SCC_HS400MODE2_HS400EN2		BIT(0)
+
+#define RZG2L_SDHI_SCC_TMPPORT2_TMPOUT		GENMASK(15, 0)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
@@ -364,6 +397,18 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
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
@@ -374,12 +419,12 @@ static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host,
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
@@ -486,6 +531,12 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2,
+			       RZG3L_SDHI_SCC_HS400MODE2_HS400EN2);
+
+	priv->hs400_active = true;
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
 		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
 		       sd_scc_read32(host, priv,
@@ -623,6 +674,12 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
+
+	priv->hs400_active = false;
+	priv->hs400_clk = false;
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


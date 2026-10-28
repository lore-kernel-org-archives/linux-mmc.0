Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191896;
	b=JFigMeHYyz+3tzcS97zeYdlqOaNDpZ5jXGJC48aQs9bDl5nIuR97oDjgeM768y8/0Exg
	 +p5zjGgkEPuImWpOalK1egmnQS4ZMppI2WMD4Ly76n+Y3sDNqJVMI/94Wrtj5Xhn/fCSh
	 8e41EiQdPxuEppuK8ql/BBz5Igek88FZaCQTWfLBIfymIi8M7rXOC2CXGjzz+ZS528de9
	 DYo9zLna2DDb+3PLQPqRYfKm/tFpNvXwfN5pCkzNutcfP0go+gaqa7kZqhPrXXN4bbXqt
	 Z+/DhlW8nCnTE7n1XiaioQ5tAki8WG3ZOse4oH6IyUPboLRvP+5pkQZicZ9Y7o4FlCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=+9gEFsebZgLIr1Qs7Kt62BKf8J/dbl0EPo1Fb2D9wrs=;
	b=R/GUdsOgrEd3IDjlRO5cFTNmLXyVBNPCfI7T5Zw5NVKYA/gQjuZzF+kvm1FMqxAm1/s7
	 To8EHvW7rCnVLonRIWfYT2h98WxqM4L+ZcnX5XyYLqZcn0hThft5Sne4UCj1YO5RsQ8Ff
	 ymA6UOEJnbYFJWsO+Sp5idwlsQiyPZIdX+HvYnJA4TRsY1sIjAhQZlDQdqFOXe2RFDW5A
	 UTys/fbYXqa43bSrPwgtk9RU56vvXhblfmdC+Rx4oYLwXKSXgw/gSjYbDXlweHKoTwyc+
	 KX+IfwDnGMqFJHbDatXQTbEx4oSwNpPJlfy643pqGg4NrYsZcfk2Ryupi/8wm/OOukw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NDPM2nlJ;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E060A5BEB
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 12:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A6E060A5BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NDPM2nlJ
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e09aa5264so468561f8f.2
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793191894; x=1793796694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9gEFsebZgLIr1Qs7Kt62BKf8J/dbl0EPo1Fb2D9wrs=;
        b=NDPM2nlJTZPpMsFQ2IhFxFyuoUGdHlZvNEYlvFaqGheM+xWcg4eETZ1DGsdA1MIVzA
         UkDuGgIwL7xN3J70FabPDr+VrHO8jScAd9ZtxgmgQnYxOH5JVrDIlvfMwWdN0AmXJSOA
         sIq/KxS/elou3xMyTpXwwSXUBiOVdgFRtw+eZmkA4aRVsQJb6RsuXIb7IZxlkhZIovTP
         fFk6oKPuhvh49LqqTMCv4Or9WoEkL5T4h0Um6KA4UNBQTmz/BoZUHiOE4vi0n7/FI4Or
         a9sCoB/nvxZ4l3yiig8PuoqgVuHrswg3IGKgfnPJeDFW+glSUQ5RzQDHgwtrgvEgWWSz
         Qn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191894; x=1793796694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9gEFsebZgLIr1Qs7Kt62BKf8J/dbl0EPo1Fb2D9wrs=;
        b=bIernb4fCU67LGVWQh0j0CFOXieSonaW7Yrr80+DmKWUFlQBDBAfdmvlRwIl55cidk
         iDS0IJvJWN+R7g1ohb8CHn0/mErbJs9kEq81/w9c0Ez1ql+mbYdt5DyggyAaRsfAHE/t
         XolZEOAs425LiZrwqZcfcp8in9Ernu9xXJ/uFjYM+y5XzMNtv7ce27aMrernrWQ9jVWN
         cNdwqHENmEHaUDBIJo8vOe+m3wRO5gQrf0HzIlDagVPQ1LMD2CvUFwa9UrmrpmlZN3qf
         Wh8zeEj6RFl72jad2oPijp9+wQf/bd9jWjlWaWXgneqFqWWnRLKpSx/l61CX8KjZqTed
         f1Iw==
X-Gm-Message-State: AFq9FYLBitoiCbIn7XQ2EWh5jKV/GM+iP+G+xv6DvwLAW2dNza276FIG
	xOH7sahXtk2A9HhjvEd1V49SWAqVrL9MhQH/IM3yr2JUCV4e9NC0YgRx1DuxEw==
X-Gm-Gg: AYBFou3VZ2bVQQ4G0IybT34x2s8z+cZ4pMpXCL+DxOBvbp3Gehvkiz9SEPC2FYgm6tc
	O6OOZp36OXqv3gMXdHa65uDI3928CLKQJ+MnLosaCtE7Vvkjp4xgxWNzeFDt/rIhCfMTWhaVgdk
	mlJqGro3Z29iCWv+l4cB5NVnVZaIlFof7VX8XRtxtCnnI20N7FvJL1bbpKuEiIuP9R49nM3+q1l
	oNOH9A8Ea9DD8uvJFxh0I4Sfn6p6mjTD3ONbnCGrgTs2331KqR7CeDV5uLNiAIWJwe5P/hGzaR4
	D8mIO8gaJ/+TXgusfL+fSnedl4xz25+BX+j4T4wOPpRlfOnjJw8psTqydJnP4V5Z810LhMTx7bG
	prrb3JHjO+WqTRdMRnPfPp+lo5YfTLrhaP0/Kw9R4vFoV8NN3DK0lFBTutDhPoAfDocLzQRYhGQ
	8Z+Lrvz93tw5vO38PZ5WzNRWN+dtVoNIYRk10E7r2D+kWIj+XEZeNmZjG6Z61a1LIzXqqQ01Df9
	7TVg+D2jTXog4QKMUN0+o/YgR+x+mAo4qwEFaKa8YVnV7kB/vF+YeOY//Tfy47CDGoTseVeKdIp
	0XK1zVRpl7A5IocZsraX6lBIDNVHWyRmGdUBb+Wo3Z81b7qp1RCMhhqZb9NK+DhG984=
X-Received: by 2002:a5d:452f:0:b0:487:40d:af29 with SMTP id ffacd0b85a97d-48e5d5c42bemr4021533f8f.36.1793191893408;
        Wed, 28 Oct 2026 05:51:33 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6bf5:6c0a:cf99:c9f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm29275016f8f.10.2026.10.28.05.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:51:33 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 28 Oct 2026 12:51:28 +0000
Subject: [PATCH v25 11/11] mmc: renesas_sdhi: Add RZ/G3L SDHI support
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
Message-Id: <20261028-rzg3l_sdhi-v25-11-57f16691c2ed@bp.renesas.com>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
In-Reply-To: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793191879; l=15656;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=mUfywRPPsPBaEhPP7/YwCSkci7+86rydfvk3F/1/0Gs=;
 b=TbSkHK+mMd6XpXNTzpvK9izd3Y3AHk+fM6ZZ4B9UO1qaUIf6LMki+fyq/buCL/VYXU29eGvSA
 BYw8j9bth7BBbHyfBitNQaoJpOMFrpBZH6ZvTZWspKvsb5FbR7mhPgl
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G3L SDHI is close to existing variants but differs in three
ways the driver can't handle today:

- It has an 11-bit clock divider. The upper bits live in CLK_CTL
  bits [17:16], so the register must be written with a 32-bit access
  on this SoC.
- Tuning needs a second HW adjustment register (HWADJ2), programmed
  together with TMPPORT2.
- HWADJ4 must be cleared when tuning starts.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v24->v25:
 * Updated commit description.
 * Added macros RZG3L_SDHI_SCC_HWADJ2_{1_8V,3_3V}
 * Replaced the quirks sdhi_quirks_rzg3l with sdhi_quirks_fixed_addr.
 * Added helper renesas_sdhi_sclken() to handle 16-bit and 32-bit access.
 * Updated renesas_sdhi_set_clock() with max_divider check for
   TMIO_MMC_INTERNAL_DIVIDER instead of SDHI_MAX_DIVIDER_DEFAULT for
   consistency with tmio_mmc_reset().
v23->v24:
 * Replaced magic bits GENMASK(9, 8) and GENMASK(17, 16) with
   RZG3L_CLK_CTL_DIV9_DIV8 and RZG3L_CLK_CTL_DIV9_DIV8_SRC.
v22->v23:
 * Updated tmio_mmc_reset() to handle 32 bit divider register in RZ/G3L.
v21->v22:
 * Updated commit description.
 * Added `clock &= ~GENMASK(9, 8)` to clear the divider mask bits in
   the register value.
v20->v21:
 * Added clk_div_mask to RZ/G3L of_data.
 * Restored actual_clk calculation in renesas_sdhi_set_clock().
v19->v20:
 * Added bitfield.h header file.
 * Reworked on renesas_sdhi_set_clock() to handle the 11-bit divider
   case and the 32-bit register write.
v18->v19:
 * Update commit description.
 * Updated handling for clk divider.
 * Renamed TMIO_MMC_HWADJ2->TMIO_MMC_HWADJ to make it generic for
   hardware tuning delays
 * Dropped duplicate SH_MOBILE_SDHI_SCC_TMPPORT2 macro
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 84 +++++++++++++++++++--------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 34 +++++++++++
 drivers/mmc/host/tmio_mmc_core.c              | 16 ++++-
 include/linux/platform_data/tmio.h            |  3 +
 4 files changed, 110 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index cb41f38ec80e..4b6c0dbd15e7 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -18,6 +18,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
@@ -60,9 +61,13 @@
 #define SDHI_VER_GEN2_SDR104	0xcb0d
 #define SDHI_VER_GEN3_SD	0xcc10
 #define SDHI_VER_GEN3_SDMMC	0xcd10
+#define SDHI_VER_RZ_G3L_SDMMC	0xce10
 
 #define SDHI_GEN3_MMC0_ADDR	0xee140000
 
+#define RZG3L_CLK_CTL_DIV9_DIV8		GENMASK(17, 16)
+#define RZG3L_CLK_CTL_DIV9_DIV8_SRC	GENMASK(9, 8)
+
 static void renesas_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 {
 	u32 val;
@@ -80,6 +85,7 @@ static void renesas_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 		break;
 	case SDHI_VER_GEN3_SD:
 	case SDHI_VER_GEN3_SDMMC:
+	case SDHI_VER_RZ_G3L_SDMMC:
 		if (width == 64)
 			val = HOST_MODE_GEN3_64BIT;
 		else if (width == 32)
@@ -205,14 +211,28 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	return renesas_sdhi_clk_get_rate(host, priv->clk);
 }
 
+static void renesas_sdhi_sclken(struct tmio_mmc_host *host, bool enable)
+{
+	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) {
+		u32 val = sd_ctrl_read32(host, CTL_SD_CARD_CLK_CTL);
+
+		val = enable ? val | CLK_CTL_SCLKEN : val & ~CLK_CTL_SCLKEN;
+		sd_ctrl_write32(host, CTL_SD_CARD_CLK_CTL, val);
+	} else {
+		u16 val = sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL);
+
+		val = enable ? val | CLK_CTL_SCLKEN : val & ~CLK_CTL_SCLKEN;
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, val);
+	}
+}
+
 static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 				   unsigned int new_clock)
 {
 	unsigned int clk_margin;
 	u64 clk = 0, clock;
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	renesas_sdhi_sclken(host, false);
 
 	if (new_clock == 0) {
 		host->mmc->actual_clock = 0;
@@ -243,12 +263,21 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	if (clock != SDHI_SD_CLK_CTL_DIV1)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
+	if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) {
+		u64 tmp;
+
+		tmp = FIELD_GET(RZG3L_CLK_CTL_DIV9_DIV8_SRC, clk);
+		clock |= FIELD_PREP(RZG3L_CLK_CTL_DIV9_DIV8, tmp);
+		clock &= ~RZG3L_CLK_CTL_DIV9_DIV8_SRC;
+		sd_ctrl_write32(host, CTL_SD_CARD_CLK_CTL, clock);
+	} else {
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
+	}
+
 	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
 		usleep_range(10000, 11000);
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	renesas_sdhi_sclken(host, true);
 
 out:
 	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
@@ -279,12 +308,14 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_RVSCNTL	0x008
 #define SH_MOBILE_SDHI_SCC_RVSREQ	0x00A
 #define SH_MOBILE_SDHI_SCC_SMPCMP       0x00C
-#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E
+#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E /* G3L: SDm_SCC_HS400MODE1 */
+#define RZG3L_SDHI_SCC_HWADJ2		0x010
 #define SH_MOBILE_SDHI_SCC_TMPPORT3	0x014
 #define SH_MOBILE_SDHI_SCC_TMPPORT4	0x016
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT	16
@@ -305,6 +336,9 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
 
+#define RZG3L_SDHI_SCC_HWADJ2_1_8V	0xff
+#define RZG3L_SDHI_SCC_HWADJ2_3_3V	0x3fff
+
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
 #define SH_MOBILE_SDHI_SCC_TMPPORT4_DLL_ACC_START	BIT(0)
 
@@ -335,14 +369,22 @@ static void renesas_sdhi_set_hw_adjustment_delay(struct tmio_mmc_host *host,
 						 bool force_clear)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
+	bool hwadj2 = host->pdata->flags & TMIO_MMC_HWADJ;
 
 	if (!(host->pdata->flags & TMIO_MMC_TUNING_DELAY))
 		return;
 
-	if (host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330 || force_clear)
+	if (host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330 || force_clear) {
 		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x0);
-	else
+		if (hwadj2)
+			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2,
+				       RZG3L_SDHI_SCC_HWADJ2_3_3V);
+	} else {
 		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0x1);
+		if (hwadj2)
+			sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2,
+				       RZG3L_SDHI_SCC_HWADJ2_1_8V);
+	}
 }
 
 static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
@@ -390,8 +432,7 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 	/* Initialize SCC */
 	sd_ctrl_write32_as_16_and_16(host, CTL_STATUS, 0x0);
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	renesas_sdhi_sclken(host, false);
 
 	/* set sampling clock selection range */
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
@@ -409,9 +450,10 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
 
 	renesas_sdhi_set_hw_adjustment_delay(host, false);
+	if (host->pdata->flags & TMIO_MMC_HWADJ)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ4, 0x0);
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	renesas_sdhi_sclken(host, true);
 
 	/* Read TAPNUM */
 	return (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL) >>
@@ -426,8 +468,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 	u32 bad_taps = priv->quirks ? priv->quirks->hs400_bad_taps : 0;
 	bool use_4tap = sdhi_has_quirk(priv, hs400_4taps);
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	renesas_sdhi_sclken(host, false);
 
 	/* Set HS400 mode */
 	sd_ctrl_write16(host, CTL_SDIF_MODE, SDIF_MODE_HS400 |
@@ -473,8 +514,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 		       SH_MOBILE_SDHI_SCC_CKSEL_DTSEL |
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL));
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	renesas_sdhi_sclken(host, true);
 
 	if (priv->adjust_hs400_calib_table)
 		priv->needs_adjust_hs400 = true;
@@ -485,8 +525,7 @@ static void renesas_sdhi_disable_scc(struct mmc_host *mmc)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct renesas_sdhi *priv = host_to_priv(host);
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	renesas_sdhi_sclken(host, false);
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL,
 		       ~SH_MOBILE_SDHI_SCC_CKSEL_DTSEL &
@@ -498,8 +537,7 @@ static void renesas_sdhi_disable_scc(struct mmc_host *mmc)
 		       sd_scc_read32(host, priv,
 				     SH_MOBILE_SDHI_SCC_DTCNTL));
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	renesas_sdhi_sclken(host, true);
 }
 
 static u32 sd_scc_tmpport_read32(struct tmio_mmc_host *host,
@@ -573,8 +611,7 @@ static void renesas_sdhi_adjust_hs400_mode_disable(struct tmio_mmc_host *host)
 static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 					  struct renesas_sdhi *priv)
 {
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	renesas_sdhi_sclken(host, false);
 
 	/* Reset HS400 mode */
 	sd_ctrl_write16(host, CTL_SDIF_MODE, ~SDIF_MODE_HS400 &
@@ -590,8 +627,7 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
 		renesas_sdhi_adjust_hs400_mode_disable(host);
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	renesas_sdhi_sclken(host, true);
 }
 
 static int renesas_sdhi_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index e934b35fc205..eaf21f93f5d3 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -87,6 +87,13 @@ static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
 	},
 };
 
+static struct renesas_sdhi_scc rzg3l_scc_taps[] = {
+	{
+		.clk_rate = 0,
+		.tap = 0x00000300,
+	},
+};
+
 static const struct renesas_sdhi_of_data of_data_rza2 = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY,
@@ -152,6 +159,27 @@ static const struct renesas_sdhi_of_data of_data_rz_g2l = {
 	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
 };
 
+static const struct renesas_sdhi_of_data of_data_rzg3l = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
+			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
+			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
+			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
+	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
+	.bus_shift	= 2,
+	.scc_offset	= 0x1000,
+	.taps		= rzg3l_scc_taps,
+	.taps_num	= ARRAY_SIZE(rzg3l_scc_taps),
+	/* DMAC can handle 32bit blk count but only 1 segment */
+	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
+	.max_segs	= 1,
+	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
+	.clk_mask	= 0x200000200,
+	.max_divider	= 2048,
+	.clk_div_mask	= GENMASK(9, 0),
+};
+
 static const u8 r8a7796_es13_calib_table[2][SDHI_CALIB_TABLE_MAX] = {
 	{ 3,  3,  3,  3,  3,  3,  3,  4,  4,  5,  6,  7,  8,  9, 10, 15,
 	 16, 16, 16, 16, 16, 16, 17, 18, 18, 19, 20, 21, 22, 23, 24, 25 },
@@ -291,6 +319,11 @@ static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
 	.quirks = &sdhi_quirks_fixed_addr,
 };
 
+static const struct renesas_sdhi_of_data_with_quirks of_rzg3l_compatible = {
+	.of_data = &of_data_rzg3l,
+	.quirks = &sdhi_quirks_fixed_addr,
+};
+
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
@@ -304,6 +337,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
 	{ .compatible = "renesas,sdhi-r8a779md", .data = &of_rcar_gen3_nohs400_compatible, },
+	{ .compatible = "renesas,sdhi-r9a08g046", .data = &of_rzg3l_compatible, },
 	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,sdhi-r9a09g057", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 4fe98b437121..d016306956f9 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -180,11 +180,17 @@ static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
 
 static void tmio_mmc_reset(struct tmio_mmc_host *host, bool preserve)
 {
-	u16 card_opt, clk_ctrl, sdif_mode;
+	u16 card_opt, sdif_mode;
+	u32 clk_ctrl;
+	bool wide_clk = host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER;
 
 	if (preserve) {
 		card_opt = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT);
-		clk_ctrl = sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL);
+		if (wide_clk)
+			clk_ctrl = sd_ctrl_read32(host, CTL_SD_CARD_CLK_CTL);
+		else
+			clk_ctrl = sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL);
+
 		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
 			sdif_mode = sd_ctrl_read16(host, CTL_SDIF_MODE);
 	}
@@ -216,7 +222,11 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host, bool preserve)
 
 	if (preserve) {
 		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, card_opt);
-		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk_ctrl);
+		if (wide_clk)
+			sd_ctrl_write32(host, CTL_SD_CARD_CLK_CTL, clk_ctrl);
+		else
+			sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk_ctrl);
+
 		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
 			sd_ctrl_write16(host, CTL_SDIF_MODE, sdif_mode);
 	}
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 09b3411a59c9..99b05c8c840a 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -56,6 +56,9 @@
 /* Some controllers have internal divider */
 #define TMIO_MMC_INTERNAL_DIVIDER	BIT(14)
 
+/* Some controllers have hw adjustment delay */
+#define TMIO_MMC_HWADJ			BIT(15)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;

-- 
2.43.0


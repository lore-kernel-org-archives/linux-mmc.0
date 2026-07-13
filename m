Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615D34EF1F
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965137; cv=none; b=NlV2de5YLMbmPTM//WoDrpMdI+RyA3mfw1fDas5prGkW2Cgn+WWArPvlMrJOF5Uk3H63QbH1ddAO1zuKiDCBWmTwgAgcxhOP2sl+emAemnDZr3IRfXit4QS1UKHExMYg5Au2btAKb/w1txva9jJwcswlduxzhkOHZd2ljTDFzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965137; c=relaxed/simple;
	bh=F53C1iqXRlAlwJORWbbo5ELuNRayWLZ/7gJR9Tgg2wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYGxtT1069tYeNh5HyLojdI2bcvcSXBCW4oNvMaR7y856G+DMZBJ1mTJQmIKSNrkIcczonHhDPEhmYqXA8shgVYb7hLrTYIl/mzdkxZwkZ+oWKrrEsTxnvE9ZW8px2EoDkRIYer8uOCNCxzIPmHd1k64e4hf0QG5QIIaTnXxDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8x+REp1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8x+REp1"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so2657122f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965132; x=1784569932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r8hQtV9FPcGQLOAT5ebUGqKZF7X40ZDKPlKwg5vLNog=;
        b=M8x+REp1+4vmBxJSpgY4JKdSxcYUDGtINh2IVxShgmFKfrpx6w5uLxr8VpdpTsUW4M
         9+VLpNTs8S78bnljLbfxoWZfDsv40tV7EwkDD0NnHp7dPXSs1clrhA1AbtLkQ5yw9Nyc
         09//tn7+7Rx25rbDAbLp9Ihk7TbKS+WrC1zm7uLACpijE6xMtpeSTUExm3dJPcOT/U51
         K4kTZyykHefOgoAkncHybHXmDmaworQDt9XI72UakQEV2d4y6I1ttil9+rzGOWKi3gQm
         ubKMG4XdN+2O9ZkYcJ+S8+APO4GG9fobHHtKjE2Hs/hW4Qu4dvXMgBPiusynqRpCcwaf
         SwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965132; x=1784569932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r8hQtV9FPcGQLOAT5ebUGqKZF7X40ZDKPlKwg5vLNog=;
        b=An2tF+/hrjHhu1lzHdIo9J4uy85tSBW8IoaSN25Im3+WUrpz/4s0V47Vc6NIP385aH
         5UGXUoRNwoKToFWN6v7YdD20oThgrYDJkOkvfij33VGY7HTB52dbY+mbkWmGj/qKcJ0I
         QOGKjY7nrO2nDTxUN2PV5zuqtvbj1Btj4RWvo3qwR68yl4IcOkUv/43iynUkcJ+dhK5S
         owZnq6QWGDYlzo80UIOgyl66HtrT191AAj3Xa2uwdcgS5JHKOv02GCtl083Ox2zQi0nA
         Vz+pmi/PTla3ymklvzbBYTBRBPAJr74R0fJGg0WP7OoIkVb+njJugTDdgHa8LgdomIcP
         YacQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXdzSEUNKAD8hKMIl4vFoHK7nyBXjYHaUxGTYJGyza22o+NHSwEe2WuXbvxs/olgCRykWYAY++Tm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxhj5zHap9wtY3XBE103QrJHg1baBVOTEfo4Z9I74tFd/1t4q
	uEFdFY/38WOEwIkfbZT91ktQ4AweAMubdC7mbBTYPbApvdSjLrOqA772
X-Gm-Gg: AfdE7ckNKF0Qz4LcfPDpq2rHX7vbE2kYewNL6YXAox6aWo+Rsm4o8roE31SsX9K0Rb2
	yi3xR+nlFjsQ9th2IwZvSDuPzO4tVkqj2ZZX42q7c9BNpa0MTFwdt+WOO/WLR8FBb5dY3sI3SjH
	x6M7CHFMLYsfCeOecC4WynMb4ZISK1IKBsPjb5gegTUIeSg9FYKJy3nnf8lBgtsM6dauTQDR5LF
	TrwbW0uPc3EpM7Lx/fCd3pwYglIOcOFkQnkSFsqNFapg/8JPNMPKV0p0HFI1ellcBidFeZZKNA8
	QQDSqdlvBGuvFepFcVDeD6TCnIwR4uW9YzqIZhQexDkAeYRMMwjDkhKtNVh8CtM0mnqD9CQjgpm
	INkpSCi6k1hk/gnfxjnfp0WQ49PfhneXq5jXaOM7mkcfiUwdw6wYie+se/fR8W7ufaPE1NeBXGo
	GiVF8kvQqo+J0j9SmLHu92IwjVeO0YBqIs7WY49O5T+PfRhZ7YBEMcuEVnfK8=
X-Received: by 2002:a05:6000:2310:b0:47d:ef38:260 with SMTP id ffacd0b85a97d-47f2dcbf3b7mr11365717f8f.27.1783965131808;
        Mon, 13 Jul 2026 10:52:11 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm1011037f8f.37.2026.07.13.10.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:52:11 -0700 (PDT)
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
Subject: [PATCH v20 11/12] mmc: renesas_sdhi: Add RZ/G3L HS400 support
Date: Mon, 13 Jul 2026 18:51:52 +0100
Message-ID: <20260713175159.138334-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
References: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add HS400 support for the RZ/G3L SoC.

The RZ/G3L requires a dedicated HS400 enable register (SDm_SCC_HS400MODE2
at offset 0x020) in addition to the existing TMPPORT2 path used by R-Car.
Introduce a TMIO_MMC_HS400MODE2 flag (bit 16) to identify controllers
that require this second register.

When this flag is set, renesas_sdhi_hs400_complete() additionally sets
HS400EN2 in HS400MODE2, and renesas_sdhi_reset_hs400_mode() clears it on
exit. During tuning, when both TMIO_MMC_TUNING_DELAY and
TMIO_MMC_HS400MODE2 are set, the lower 16 bits of TMPPORT2 (TMPOUT) are
masked off while preserving the upper bits, replacing the previous
unconditional write of zero.

Enable the TMIO_MMC_HS400MODE2 flag in of_data_rzg3l to complete HS400
support for the RZ/G3L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v19->v20:
 * No change.
v18->v19:
 * Updated commit description.
 * Fixed extra space in HS400MODE2 comment block.
 * Updated the comment HS400mode2->HS400MODE2.
 * Dropped the updation of clk handling as it is taken care in
   previous patches.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 21 +++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 ++-
 include/linux/platform_data/tmio.h            |  3 +++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 57c7ec5424b5..4cab7a85d517 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -292,6 +292,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HS400MODE2	0x020
 #define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
@@ -324,6 +325,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT_DISABLE_WP_CODE	0xa5000000
 #define SH_MOBILE_SDHI_SCC_TMPPORT_CALIB_CODE_MASK	0x1f
 #define SH_MOBILE_SDHI_SCC_TMPPORT_MANUAL_MODE		BIT(7)
+#define RZG3L_SDHI_SCC_HS400MODE2_HS400EN2		BIT(0)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
@@ -459,6 +461,10 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2,
+			       RZG3L_SDHI_SCC_HS400MODE2_HS400EN2);
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
 		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
 		       sd_scc_read32(host, priv,
@@ -600,6 +606,9 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
+
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
 		renesas_sdhi_adjust_hs400_mode_disable(host);
 
@@ -757,8 +766,16 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (!priv->tap_num)
 		return 0; /* Tuning is not supported */
 
-	if ((host->pdata->flags & TMIO_MMC_TUNING_DELAY) && priv->tap_num == 8)
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0);
+	if ((host->pdata->flags & TMIO_MMC_TUNING_DELAY) && priv->tap_num == 8) {
+		u32 val = 0;
+
+		if (host->pdata->flags & TMIO_MMC_HS400MODE2) {
+			val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2);
+			val &= ~GENMASK(15, 0); /* TMPOUT MASK */
+		}
+
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, val);
+	}
 
 	if (priv->tap_num * 2 >= sizeof(priv->taps) * BITS_PER_BYTE) {
 		dev_err(&host->pdev->dev,
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 6a1b59d2e837..4000673ed7f8 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -174,7 +174,8 @@ static const struct renesas_sdhi_of_data of_data_rzg3l = {
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
index 6443ba01c723..8a5dc18d43da 100644
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB652340405;
	Tue,  9 Jun 2026 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015232; cv=none; b=IB0wNxhkHX0ZnWuQo+pgeSjBJ97x1j6n8UBqG+1FLB69h9fu/A2nhzf4fPSlkP4zLuwE/KJ+JXITir/Vh7gTahtOGzeJLjeo19BjsY3y6J9zcSXzv8eirWRZWAEX+1yq5veursNOjybA0UDKcn0s+Ex6cJ/1JGPoBY67Hy33NRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015232; c=relaxed/simple;
	bh=rzc75Une4XksouE+EJDTAmNaO9mGZSpp85vUi5ihuoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUIhR2+/Ex+S/s4fyf8uglk+vHp3RwX8bQ29iHs4cEAN6a+Wxlwzl8Y41dxHmbGN4zyHcmNiNHTN8nHcE3B8hXxnXTa1zVHcvLGwfUd+s79xIUYElJEnA3lnhOerosgRlQCk6PDSJYOUfFdDSN79p6ordh3XptyuWaSjbyPLiao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1F71F00898;
	Tue,  9 Jun 2026 14:27:07 +0000 (UTC)
From: Greg Ungerer <gerg@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	arnd@kernel.org,
	wei.fang@nxp.com,
	frank.li@nxp.com,
	shenwei.wang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	nico@fluxnic.net,
	adureghello@baylibre.com,
	ulfh@kernel.org,
	linux-mmc@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org,
	olteanv@gmail.com,
	Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCHv2 3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel() on ColdFire
Date: Wed, 10 Jun 2026 00:13:00 +1000
Message-ID: <20260609142139.1563360-5-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609142139.1563360-1-gerg@linux-m68k.org>
References: <20260609142139.1563360-1-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of the readX() and writeX() family of IO access
functions is non-standard on ColdFire platforms. They check the supplied
IO address and will return either big or little endian results based on
that check. This is non-standard, they are expected to always return
little-endian byte ordered data. Unfortunately this behavior also means
that ioreadX()/iowroteX() and their big-endian counter parts
ioreadXbe()/iowriteXbe() are wrong. This is now in the process of being
cleaned up and fixed.

Change the use of the readX() and writeX() access functions in this driver
to use the recently defined specific ColdFire internal SoC hardware IO
access functions mcf_read8()/mcf_read16()/mcf_read32() and
mcf_write8()/mcf_write16()/mcf_write32().

There is no functional change to the driver. Though it does have the
effect of making the IO access slightly more efficient, since there is
no longer a need to do the address check at every register access.

Acked-by: Angelo Dureghello <adureghello@baylibre.com>
Tested-by: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
v2: moved from RFC to PATCH

 drivers/mmc/host/sdhci-esdhc-mcf.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index 375fce5639d7..6853521e8b2c 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -55,7 +55,7 @@ static inline void esdhc_clrset_be(struct sdhci_host *host,
 	if (reg == SDHCI_HOST_CONTROL)
 		val |= ESDHC_PROCTL_D3CD;
 
-	writel((readl(base) & ~mask) | val, base);
+	mcf_write32((mcf_read32(base) & ~mask) | val, base);
 }
 
 /*
@@ -71,7 +71,7 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
 	if (reg == SDHCI_HOST_CONTROL) {
 		u32 host_ctrl = ESDHC_DEFAULT_HOST_CONTROL;
 		u8 dma_bits = (val & SDHCI_CTRL_DMA_MASK) >> 3;
-		u8 tmp = readb(host->ioaddr + SDHCI_HOST_CONTROL + 1);
+		u8 tmp = mcf_read8(host->ioaddr + SDHCI_HOST_CONTROL + 1);
 
 		tmp &= ~0x03;
 		tmp |= dma_bits;
@@ -82,12 +82,12 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
 		 */
 		host_ctrl |= val;
 		host_ctrl |= (dma_bits << 8);
-		writel(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
+		mcf_write32(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
 
 		return;
 	}
 
-	writel((readl(base) & mask) | (val << shift), base);
+	mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
 }
 
 static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
@@ -110,24 +110,24 @@ static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
 		 * As for the fsl driver,
 		 * we have to set the mode in a single write here.
 		 */
-		writel(val << 16 | mcf_data->aside,
+		mcf_write32(val << 16 | mcf_data->aside,
 		       host->ioaddr + SDHCI_TRANSFER_MODE);
 		return;
 	}
 
-	writel((readl(base) & mask) | (val << shift), base);
+	mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
 }
 
 static void esdhc_mcf_writel_be(struct sdhci_host *host, u32 val, int reg)
 {
-	writel(val, host->ioaddr + reg);
+	mcf_write32(val, host->ioaddr + reg);
 }
 
 static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
 {
 	if (reg == SDHCI_HOST_CONTROL) {
 		u8 __iomem *base = host->ioaddr + (reg & ~3);
-		u16 val = readw(base + 2);
+		u16 val = mcf_read16(base + 2);
 		u8 dma_bits = (val >> 5) & SDHCI_CTRL_DMA_MASK;
 		u8 host_ctrl = val & 0xff;
 
@@ -137,7 +137,7 @@ static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
 		return host_ctrl;
 	}
 
-	return readb(host->ioaddr + (reg ^ 0x3));
+	return mcf_read8(host->ioaddr + (reg ^ 0x3));
 }
 
 static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
@@ -149,14 +149,14 @@ static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
 	if (reg == SDHCI_HOST_VERSION)
 		reg -= 2;
 
-	return readw(host->ioaddr + (reg ^ 0x2));
+	return mcf_read16(host->ioaddr + (reg ^ 0x2));
 }
 
 static u32 esdhc_mcf_readl_be(struct sdhci_host *host, int reg)
 {
 	u32 val;
 
-	val = readl(host->ioaddr + reg);
+	val = mcf_read32(host->ioaddr + reg);
 
 	/*
 	 * RM (25.3.9) sd pin clock must never exceed 25Mhz.
@@ -245,7 +245,7 @@ static void esdhc_mcf_pltfm_set_clock(struct sdhci_host *host,
 	 * fvco = fsys * outdvi1 + 1
 	 * fshdc = fvco / outdiv3 + 1
 	 */
-	temp = readl(pll_dr);
+	temp = mcf_read32(pll_dr);
 	fsys = pltfm_host->clock;
 	fvco = fsys * ((temp & 0x1f) + 1);
 	fesdhc = fvco / (((temp >> 10) & 0x1f) + 1);
-- 
2.54.0


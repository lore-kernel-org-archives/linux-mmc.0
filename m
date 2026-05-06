Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98667480321;
	Wed,  6 May 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077771; cv=none; b=OQblvGKkc6rmbq5iqVDuVmYeOdOMiKlD/iBnrDKsGIU/qTNNkcTloGjJez14OWqkovyyCINjGdajl8c9Fyk6JKzx2N+Ib1zUiuxToVBWr0HgxQDg3nj2asp7fspVp5U2H9OAr9juUCdErpEncZb4HNJrQRKWxGIajJEVHKlL5ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077771; c=relaxed/simple;
	bh=0gZ0C4+Lc9IPXFUB3eJNzJTNTgchhjx3yW5gaMBVvNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVyzMoTJ7w+mjbu0NFsE+fFmyWY9W8nohopSHQ96P2fhy8rfdKRoqkxS6vbJjyLt/LgKrJzyATEJPi4TxHx/VF/N46g31xhqcZBcFuVybYYWnGtBusLXQDcXzNPBH+JVXOL9HykQaYkE78mfah3sX3NSDeV7yK6ZuJ9mncdPfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+18C5AC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+18C5AC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81215C2BCB0;
	Wed,  6 May 2026 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778077771;
	bh=0gZ0C4+Lc9IPXFUB3eJNzJTNTgchhjx3yW5gaMBVvNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+18C5ACkvM/uEG707g4BEeMRjbphKgwr7aBDovurXTNCZXkNDlEWt0E2Cc/t86D9
	 YslEQCQCXDe2SKDExlflyUsU8gec6Ykninf9jX4XUZlc/nFFbbFU7/GH9SmjizaYrm
	 RlrUsV4rzgON04GUPzPfCmuwH5JX8fiAONT9Mw52I+T/AZXmSY3zebvTYmk/LL+mKt
	 Ddl4zbb8OogEF6Gm6Wr98Q2WKQpS9C1EFjhGnEu+2p//xfKXE3RUDGMte6qZeIdalr
	 dlIZAbog50n5DDTU5A/5DNAPt4xL3nWtyQV8L28wlS5sw377of/kZ9goK30MkkQlop
	 Ji2ZWmX/NF3Uw==
From: Greg Ungerer <gerg@kernel.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	arnd@kernel.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	adureghello@baylibre.com,
	linux-mmc@vger.kernel.org
Subject: [RFC 3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel() on ColdFire
Date: Thu,  7 May 2026 00:26:46 +1000
Message-ID: <20260506142644.3234270-6-gerg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506142644.3234270-2-gerg@kernel.org>
References: <20260506142644.3234270-2-gerg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Greg Ungerer <gerg@linux-m68k.org>

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

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 drivers/mmc/host/sdhci-esdhc-mcf.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

Note that the patches to introduce mcf_readX() and mcf_writeX functions
are not in mainline yet. They are currently in the m68knommu git tree
for-next branch, and so should also be in linux-next.

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


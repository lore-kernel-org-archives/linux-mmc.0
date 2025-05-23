Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5629672F;
	Fri, 23 May 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011645; cv=none; b=NttpZYlbwcf0OWONWAKDUgT3oSkvLMWJ06Z7Xmx1ttXbrPFSySd/bKafQFp9tJQ5Vm0XEg7oZW5Ghmu4bksn9spzfCFIHjKCbMTZXRTRv3ZyQk70Se4eM8zrDti8PRAuKV0LdzPfkWzvr7hcGwj58B4zznbuKWDj7Kb/G8omQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011645; c=relaxed/simple;
	bh=20vn7o240Byz9+DdxAGTeQkz9K3GBVnGHtg0aSQBEFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C32ikHC3X7em2DXswUm3thScmCWuDstcZNFB/bXgp7rshZkkRylbQ8eagzfINef20SH7ZjfZsNqE1HQGun2s2Uw2oQ8kblCOvkHgqQSHHOoUo9srLUij+Yw2NHvRicdFtw2TA//k9iMe2B7ILfmlTLLy/i10RRQLRkouxwCIyhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 8BAD7343328;
	Fri, 23 May 2025 14:47:20 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Fri, 23 May 2025 22:46:31 +0800
Subject: [PATCH 1/2] mmc: sdhci-of-k1: make register definition vendor
 specific
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-21-k1-sdhci-v1-1-9f293116a7e7@gentoo.org>
References: <20250523-21-k1-sdhci-v1-0-9f293116a7e7@gentoo.org>
In-Reply-To: <20250523-21-k1-sdhci-v1-0-9f293116a7e7@gentoo.org>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8534; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=20vn7o240Byz9+DdxAGTeQkz9K3GBVnGHtg0aSQBEFQ=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoMIpuMLZnMWXgssM2f5be3ZTzdxd5FHkZ1uVuO
 eGAKs4ieZqJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaDCKbl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277ZvqEACdqavoYWbRZ7AJPS
 EcC/L+SDNrQF2GZk9O5w6bsvddkdANdXUKE25l9zDOG4oA5AVk/sP9YCPiToLbTFo1qonR+Ucpc
 BQnihJORBdR4cRNqyg+pyu0ZUjOmED5Dog9JIsYpVIh4MsiiRk0Vj7yaii/f5eUWRcCajXZTE6f
 JtBKxBEMLosNuVkxUy46UqfXS9uI9/F0nrERz9FtAXLrDAGsBREAPVh/dZmPqEwiswEB4trDjrD
 egbAL8ACTH1zPX20SgU1X3SA6OvfPsJokeja1MlUu8xItFkKPOllvTNjifHrGGAEetdag+vV+Td
 2j8K0IZx1lsjj2oZkyraYF+lLFz6UeZsPB2MrtpUvO2AO2KG1brAL9APpCD6yrR2dk+E+XCN4kD
 nhjDdgj5Bems2YU8aFwFNP22KhMPE7NvVQOA4FP1Ql6lbkstjJF2sl/5bpjV5yUCPCQY3UWHh7s
 ncgyd3LNQvWctj7lZP9ttGUtyahfsL/UQv1Hefo3WUGM7Ap6jzCeE6yKDN1QelYd39uxUBGjDWj
 dTmK6z8Bv2oa6EQKhxRPFm7K0QtevIabkIJsFU9oFBzr8u73/u5xQocTeJ7sJKnE05/ZJ2BFG+3
 r1OkmppEyqeEklSvqPZDeB+WvpSNWV06WWlLeAfsaNYJeuov4tDtbD2Aem9pvlPejwNg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Making register definition less generic which will potentially have
less collision with other files.

Add SpacemiT vendor prefix to K1 SoC SDHC register definitions,
also improve the BIT definitions to reflect them more SDHC specific.

Note, there should be no functional changes introduced in this commit.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 138 +++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 66 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 6880d3e9ab620dab5e5fea239cf1a78e1afe0d7c..1e1e012cdff9143a7dffa4e00bd9baac2a2dff2d 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -20,45 +20,45 @@
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 
-#define SDHC_MMC_CTRL_REG		0x114
-#define  MISC_INT_EN			BIT(1)
-#define  MISC_INT			BIT(2)
-#define  ENHANCE_STROBE_EN		BIT(8)
-#define  MMC_HS400			BIT(9)
-#define  MMC_HS200			BIT(10)
-#define  MMC_CARD_MODE			BIT(12)
-
-#define SDHC_TX_CFG_REG			0x11C
-#define  TX_INT_CLK_SEL			BIT(30)
-#define  TX_MUX_SEL			BIT(31)
-
-#define SDHC_PHY_CTRL_REG		0x160
-#define  PHY_FUNC_EN			BIT(0)
-#define  PHY_PLL_LOCK			BIT(1)
-#define  HOST_LEGACY_MODE		BIT(31)
-
-#define SDHC_PHY_FUNC_REG		0x164
-#define  PHY_TEST_EN			BIT(7)
-#define  HS200_USE_RFIFO		BIT(15)
-
-#define SDHC_PHY_DLLCFG			0x168
-#define  DLL_PREDLY_NUM			GENMASK(3, 2)
-#define  DLL_FULLDLY_RANGE		GENMASK(5, 4)
-#define  DLL_VREG_CTRL			GENMASK(7, 6)
-#define  DLL_ENABLE			BIT(31)
-
-#define SDHC_PHY_DLLCFG1		0x16C
-#define  DLL_REG1_CTRL			GENMASK(7, 0)
-#define  DLL_REG2_CTRL			GENMASK(15, 8)
-#define  DLL_REG3_CTRL			GENMASK(23, 16)
-#define  DLL_REG4_CTRL			GENMASK(31, 24)
-
-#define SDHC_PHY_DLLSTS			0x170
-#define  DLL_LOCK_STATE			BIT(0)
-
-#define SDHC_PHY_PADCFG_REG		0x178
-#define  PHY_DRIVE_SEL			GENMASK(2, 0)
-#define  RX_BIAS_CTRL			BIT(5)
+#define SPACEMIT_SDHC_MMC_CTRL_REG	0x114
+#define  SDHC_MISC_INT_EN		BIT(1)
+#define  SDHC_MISC_INT			BIT(2)
+#define  SDHC_ENHANCE_STROBE_EN		BIT(8)
+#define  SDHC_MMC_HS400			BIT(9)
+#define  SDHC_MMC_HS200			BIT(10)
+#define  SDHC_MMC_CARD_MODE		BIT(12)
+
+#define SPACEMIT_SDHC_TX_CFG_REG	0x11C
+#define  SDHC_TX_INT_CLK_SEL		BIT(30)
+#define  SDHC_TX_MUX_SEL		BIT(31)
+
+#define SPACEMIT_SDHC_PHY_CTRL_REG	0x160
+#define  SDHC_PHY_FUNC_EN		BIT(0)
+#define  SDHC_PHY_PLL_LOCK		BIT(1)
+#define  SDHC_HOST_LEGACY_MODE		BIT(31)
+
+#define SPACEMIT_SDHC_PHY_FUNC_REG	0x164
+#define  SDHC_PHY_TEST_EN		BIT(7)
+#define  SDHC_HS200_USE_RFIFO		BIT(15)
+
+#define SPACEMIT_SDHC_PHY_DLLCFG	0x168
+#define  SDHC_DLL_PREDLY_NUM		GENMASK(3, 2)
+#define  SDHC_DLL_FULLDLY_RANGE		GENMASK(5, 4)
+#define  SDHC_DLL_VREG_CTRL		GENMASK(7, 6)
+#define  SDHC_DLL_ENABLE		BIT(31)
+
+#define SPACEMIT_SDHC_PHY_DLLCFG1	0x16C
+#define  SDHC_DLL_REG1_CTRL		GENMASK(7, 0)
+#define  SDHC_DLL_REG2_CTRL		GENMASK(15, 8)
+#define  SDHC_DLL_REG3_CTRL		GENMASK(23, 16)
+#define  SDHC_DLL_REG4_CTRL		GENMASK(31, 24)
+
+#define SPACEMIT_SDHC_PHY_DLLSTS	0x170
+#define  SDHC_DLL_LOCK_STATE		BIT(0)
+
+#define SPACEMIT_SDHC_PHY_PADCFG_REG	0x178
+#define  SDHC_PHY_DRIVE_SEL		GENMASK(2, 0)
+#define  SDHC_RX_BIAS_CTRL		BIT(5)
 
 struct spacemit_sdhci_host {
 	struct clk *clk_core;
@@ -91,23 +91,24 @@ static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
 	if (mask != SDHCI_RESET_ALL)
 		return;
 
-	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
+	spacemit_sdhci_setbits(host, SDHC_PHY_FUNC_EN | SDHC_PHY_PLL_LOCK,
+			       SPACEMIT_SDHC_PHY_CTRL_REG);
 
-	spacemit_sdhci_clrsetbits(host, PHY_DRIVE_SEL,
-				  RX_BIAS_CTRL | FIELD_PREP(PHY_DRIVE_SEL, 4),
-				  SDHC_PHY_PADCFG_REG);
+	spacemit_sdhci_clrsetbits(host, SDHC_PHY_DRIVE_SEL,
+				  SDHC_RX_BIAS_CTRL | FIELD_PREP(SDHC_PHY_DRIVE_SEL, 4),
+				  SPACEMIT_SDHC_PHY_PADCFG_REG);
 
 	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
-		spacemit_sdhci_setbits(host, MMC_CARD_MODE, SDHC_MMC_CTRL_REG);
+		spacemit_sdhci_setbits(host, SDHC_MMC_CARD_MODE, SPACEMIT_SDHC_MMC_CTRL_REG);
 }
 
 static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
 {
 	if (timing == MMC_TIMING_MMC_HS200)
-		spacemit_sdhci_setbits(host, MMC_HS200, SDHC_MMC_CTRL_REG);
+		spacemit_sdhci_setbits(host, SDHC_MMC_HS200, SPACEMIT_SDHC_MMC_CTRL_REG);
 
 	if (timing == MMC_TIMING_MMC_HS400)
-		spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
+		spacemit_sdhci_setbits(host, SDHC_MMC_HS400, SPACEMIT_SDHC_MMC_CTRL_REG);
 
 	sdhci_set_uhs_signaling(host, timing);
 
@@ -120,9 +121,9 @@ static void spacemit_sdhci_set_clock(struct sdhci_host *host, unsigned int clock
 	struct mmc_host *mmc = host->mmc;
 
 	if (mmc->ios.timing <= MMC_TIMING_UHS_SDR50)
-		spacemit_sdhci_setbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
+		spacemit_sdhci_setbits(host, SDHC_TX_INT_CLK_SEL, SPACEMIT_SDHC_TX_CFG_REG);
 	else
-		spacemit_sdhci_clrbits(host, TX_INT_CLK_SEL, SDHC_TX_CFG_REG);
+		spacemit_sdhci_clrbits(host, SDHC_TX_INT_CLK_SEL, SPACEMIT_SDHC_TX_CFG_REG);
 
 	sdhci_set_clock(host, clock);
 };
@@ -132,20 +133,22 @@ static void spacemit_sdhci_phy_dll_init(struct sdhci_host *host)
 	u32 state;
 	int ret;
 
-	spacemit_sdhci_clrsetbits(host, DLL_PREDLY_NUM | DLL_FULLDLY_RANGE | DLL_VREG_CTRL,
-				  FIELD_PREP(DLL_PREDLY_NUM, 1) |
-				  FIELD_PREP(DLL_FULLDLY_RANGE, 1) |
-				  FIELD_PREP(DLL_VREG_CTRL, 1),
-				  SDHC_PHY_DLLCFG);
+	spacemit_sdhci_clrsetbits(host, SDHC_DLL_PREDLY_NUM |
+				  SDHC_DLL_FULLDLY_RANGE |
+				  SDHC_DLL_VREG_CTRL,
+				  FIELD_PREP(SDHC_DLL_PREDLY_NUM, 1) |
+				  FIELD_PREP(SDHC_DLL_FULLDLY_RANGE, 1) |
+				  FIELD_PREP(SDHC_DLL_VREG_CTRL, 1),
+				  SPACEMIT_SDHC_PHY_DLLCFG);
 
-	spacemit_sdhci_clrsetbits(host, DLL_REG1_CTRL,
-				  FIELD_PREP(DLL_REG1_CTRL, 0x92),
-				  SDHC_PHY_DLLCFG1);
+	spacemit_sdhci_clrsetbits(host, SDHC_DLL_REG1_CTRL,
+				  FIELD_PREP(SDHC_DLL_REG1_CTRL, 0x92),
+				  SPACEMIT_SDHC_PHY_DLLCFG1);
 
-	spacemit_sdhci_setbits(host, DLL_ENABLE, SDHC_PHY_DLLCFG);
+	spacemit_sdhci_setbits(host, SDHC_DLL_ENABLE, SPACEMIT_SDHC_PHY_DLLCFG);
 
-	ret = readl_poll_timeout(host->ioaddr + SDHC_PHY_DLLSTS, state,
-				 state & DLL_LOCK_STATE, 2, 100);
+	ret = readl_poll_timeout(host->ioaddr + SPACEMIT_SDHC_PHY_DLLSTS, state,
+				 state & SDHC_DLL_LOCK_STATE, 2, 100);
 	if (ret == -ETIMEDOUT)
 		dev_warn(mmc_dev(host->mmc), "fail to lock phy dll in 100us!\n");
 }
@@ -155,11 +158,11 @@ static void spacemit_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc, struct mm
 	struct sdhci_host *host = mmc_priv(mmc);
 
 	if (!ios->enhanced_strobe) {
-		spacemit_sdhci_clrbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
+		spacemit_sdhci_clrbits(host, SDHC_ENHANCE_STROBE_EN, SPACEMIT_SDHC_MMC_CTRL_REG);
 		return;
 	}
 
-	spacemit_sdhci_setbits(host, ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
+	spacemit_sdhci_setbits(host, SDHC_ENHANCE_STROBE_EN, SPACEMIT_SDHC_MMC_CTRL_REG);
 	spacemit_sdhci_phy_dll_init(host);
 }
 
@@ -174,7 +177,7 @@ static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 
-	spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
+	spacemit_sdhci_setbits(host, SDHC_MMC_HS400, SPACEMIT_SDHC_MMC_CTRL_REG);
 	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 
 	return 0;
@@ -192,13 +195,16 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 
-	spacemit_sdhci_clrbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
-	spacemit_sdhci_clrbits(host, MMC_HS400 | MMC_HS200 | ENHANCE_STROBE_EN, SDHC_MMC_CTRL_REG);
-	spacemit_sdhci_clrbits(host, HS200_USE_RFIFO, SDHC_PHY_FUNC_REG);
+	spacemit_sdhci_clrbits(host, SDHC_PHY_FUNC_EN | SDHC_PHY_PLL_LOCK,
+			       SPACEMIT_SDHC_PHY_CTRL_REG);
+	spacemit_sdhci_clrbits(host, SDHC_MMC_HS400 | SDHC_MMC_HS200 | SDHC_ENHANCE_STROBE_EN,
+			       SPACEMIT_SDHC_MMC_CTRL_REG);
+	spacemit_sdhci_clrbits(host, SDHC_HS200_USE_RFIFO, SPACEMIT_SDHC_PHY_FUNC_REG);
 
 	udelay(5);
 
-	spacemit_sdhci_setbits(host, PHY_FUNC_EN | PHY_PLL_LOCK, SDHC_PHY_CTRL_REG);
+	spacemit_sdhci_setbits(host, SDHC_PHY_FUNC_EN | SDHC_PHY_PLL_LOCK,
+			       SPACEMIT_SDHC_PHY_CTRL_REG);
 }
 
 static inline int spacemit_sdhci_get_clocks(struct device *dev,

-- 
2.49.0


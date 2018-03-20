From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH 3/3] mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
Date: Tue, 20 Mar 2018 16:36:26 +0800
Message-ID: <1521534986-21907-4-git-send-email-zhang.chunyan@linaro.org>
References: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Billows Wu <billows.wu@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

ADMA2 64-bit addressing support is divided into V3 mode and V4 mode.
There are two kinds of descriptors for ADMA2 64-bit addressing
i.e. 96-bit Descriptor for V3 mode, and 128-bit Descriptor for V4
mode. 128-bit Descriptor is aligned to 8-byte.

For V4 mode, ADMA2 64-bit addressing is enabled via Host Control 2
register.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 50 +++++++++++++++++++++++++++++++++++-------------
 drivers/mmc/host/sdhci.h | 23 +++++++++++++++++-----
 2 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 748a3a3..137905c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -585,6 +585,8 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 	void *desc, *align;
 	char *buffer;
 	int len, offset, i;
+	unsigned int adma2_align = SDHCI_ADMA2_ALIGN(host);
+	unsigned int adma2_mask = SDHCI_ADMA2_MASK(host);
 
 	/*
 	 * The spec does not specify endianness of descriptor table.
@@ -608,8 +610,8 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 		 * buffer for the (up to three) bytes that screw up the
 		 * alignment.
 		 */
-		offset = (SDHCI_ADMA2_ALIGN - (addr & SDHCI_ADMA2_MASK)) &
-			 SDHCI_ADMA2_MASK;
+		offset = (adma2_align - (addr & adma2_align)) &
+			 adma2_mask;
 		if (offset) {
 			if (data->flags & MMC_DATA_WRITE) {
 				buffer = sdhci_kmap_atomic(sg, &flags);
@@ -623,8 +625,8 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 
 			BUG_ON(offset > 65536);
 
-			align += SDHCI_ADMA2_ALIGN;
-			align_addr += SDHCI_ADMA2_ALIGN;
+			align += adma2_align;
+			align_addr += adma2_align;
 
 			desc += host->desc_sz;
 
@@ -668,13 +670,15 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	void *align;
 	char *buffer;
 	unsigned long flags;
+	unsigned int adma2_align = SDHCI_ADMA2_ALIGN(host);
+	unsigned int adma2_mask = SDHCI_ADMA2_MASK(host);
 
 	if (data->flags & MMC_DATA_READ) {
 		bool has_unaligned = false;
 
 		/* Do a quick scan of the SG list for any unaligned mappings */
 		for_each_sg(data->sg, sg, host->sg_count, i)
-			if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
+			if (sg_dma_address(sg) & adma2_mask) {
 				has_unaligned = true;
 				break;
 			}
@@ -686,15 +690,15 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 			align = host->align_buffer;
 
 			for_each_sg(data->sg, sg, host->sg_count, i) {
-				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
-					size = SDHCI_ADMA2_ALIGN -
-					       (sg_dma_address(sg) & SDHCI_ADMA2_MASK);
+				if (sg_dma_address(sg) & adma2_mask) {
+					size = adma2_align -
+					       (sg_dma_address(sg) & adma2_mask);
 
 					buffer = sdhci_kmap_atomic(sg, &flags);
 					memcpy(buffer, align, size);
 					sdhci_kunmap_atomic(buffer, &flags);
 
-					align += SDHCI_ADMA2_ALIGN;
+					align += adma2_align;
 				}
 			}
 		}
@@ -3387,6 +3391,26 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 	return 0;
 }
 
+static inline bool sdhci_use_64bit_dma(struct sdhci_host *host)
+{
+	u32 addr64bit_en;
+
+	/*
+	 * According to SD Host Controller spec v4.10, bit[27] added from
+	 * version 4.10 in Capabilities Register is used as 64-bit System
+	 * Address support for V4 mode, 64-bit DMA Addressing for V4 mode
+	 * is enabled only if 64-bit Addressing =1 in the Host Control 2
+	 * register.
+	 */
+	if (host->version == SDHCI_SPEC_410 && host->v4_mode) {
+		addr64bit_en = (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
+				SDHCI_CTRL_64BIT_ADDR);
+		return addr64bit_en && (host->caps & SDHCI_CAN_64BIT_V4);
+	}
+
+	return host->caps & SDHCI_CAN_64BIT;
+}
+
 int sdhci_setup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
@@ -3458,7 +3482,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
 	 * implement.
 	 */
-	if (host->caps & SDHCI_CAN_64BIT)
+	if (sdhci_use_64bit_dma(host))
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
@@ -3492,15 +3516,15 @@ int sdhci_setup_host(struct sdhci_host *host)
 		 */
 		if (host->flags & SDHCI_USE_64_BIT_DMA) {
 			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
-					      SDHCI_ADMA2_64_DESC_SZ;
-			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
+					      SDHCI_ADMA2_64_DESC_SZ(host);
+			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ(host);
 		} else {
 			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
 					      SDHCI_ADMA2_32_DESC_SZ;
 			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
 		}
 
-		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
+		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN(host);
 		buf = dma_alloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
 					 host->adma_table_sz, &dma, GFP_KERNEL);
 		if (!buf) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 128b0ba..820a863 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -185,6 +185,7 @@
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
 #define  SDHCI_CTRL_V4_MODE		0x1000
+#define  SDHCI_CTRL_64BIT_ADDR		0x2000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -206,6 +207,7 @@
 #define  SDHCI_CAN_VDD_300	0x02000000
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT	0x10000000
+#define  SDHCI_CAN_64BIT_V4	0x8000000
 
 #define  SDHCI_SUPPORT_SDR50	0x00000001
 #define  SDHCI_SUPPORT_SDR104	0x00000002
@@ -297,9 +299,14 @@ struct sdhci_adma2_32_desc {
 	__le32	addr;
 }  __packed __aligned(4);
 
-/* ADMA2 data alignment */
-#define SDHCI_ADMA2_ALIGN	4
-#define SDHCI_ADMA2_MASK	(SDHCI_ADMA2_ALIGN - 1)
+/*
+ * ADMA2 data alignment
+ * According to SD Host Controller spec v4.10, if Host Version 4 Enable is set
+ * in the Host Control 2 register, 128-bit Descriptor will be selected which
+ * shall be aligned 8-byte address boundary.
+ */
+#define SDHCI_ADMA2_ALIGN(host)	((host)->v4_mode ? 8 : 4)
+#define SDHCI_ADMA2_MASK(host)	(SDHCI_ADMA2_ALIGN(host) - 1)
 
 /*
  * ADMA2 descriptor alignment.  Some controllers (e.g. Intel) require 8 byte
@@ -308,8 +315,14 @@ struct sdhci_adma2_32_desc {
  */
 #define SDHCI_ADMA2_DESC_ALIGN	8
 
-/* ADMA2 64-bit DMA descriptor size */
-#define SDHCI_ADMA2_64_DESC_SZ	12
+/*
+ * ADMA2 64-bit DMA descriptor size
+ * According to SD Host Controller spec v4.10, there are two kinds of
+ * descriptors for 64-bit addressing mode: 96-bit Descriptor and 128-bit
+ * Descriptor, if Host Version 4 Enable is set in the Host Control 2
+ * register, 128-bit Descriptor will be selected.
+ */
+#define SDHCI_ADMA2_64_DESC_SZ(host)	((host)->v4_mode ? 16 : 12)
 
 /*
  * ADMA2 64-bit descriptor. Note 12-byte descriptor can't always be 8-byte
-- 
2.7.4

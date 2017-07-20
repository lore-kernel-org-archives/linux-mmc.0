From: Matt Brown <matthew.brown.dev@gmail.com>
Subject: [PATCH] powerpc/asm/cacheflush: Cleanup cacheflush function params
Date: Thu, 20 Jul 2017 16:28:50 +1000
Message-ID: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org, adi-buildroot-devel@lists.sourceforge.net, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The cacheflush prototypes currently use start and stop values and each
call requires typecasting the address to an unsigned long.
This patch changes the cacheflush prototypes to follow the x86 style of
using a base and size values, with base being a void pointer.

All callers of the cacheflush functions, including drivers, have been
modified to conform to the new prototypes.

The 64 bit cacheflush functions which were implemented in assembly code
(flush_dcache_range, flush_inval_dcache_range) have been translated into
C for readability and coherence.

Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
---
 arch/powerpc/include/asm/cacheflush.h        | 47 +++++++++++++++++--------
 arch/powerpc/kernel/misc_64.S                | 52 ----------------------------
 arch/powerpc/mm/dma-noncoherent.c            | 15 ++++----
 arch/powerpc/platforms/512x/mpc512x_shared.c | 10 +++---
 arch/powerpc/platforms/85xx/smp.c            |  6 ++--
 arch/powerpc/sysdev/dart_iommu.c             |  5 +--
 drivers/ata/pata_bf54x.c                     |  3 +-
 drivers/char/agp/uninorth-agp.c              |  6 ++--
 drivers/gpu/drm/drm_cache.c                  |  3 +-
 drivers/macintosh/smu.c                      | 15 ++++----
 drivers/mmc/host/bfin_sdh.c                  |  3 +-
 drivers/mtd/nand/bf5xx_nand.c                |  6 ++--
 drivers/soc/fsl/qbman/dpaa_sys.h             |  2 +-
 drivers/soc/fsl/qbman/qman_ccsr.c            |  3 +-
 drivers/spi/spi-bfin5xx.c                    | 10 +++---
 drivers/tty/serial/mpsc.c                    | 46 ++++++++----------------
 drivers/usb/musb/blackfin.c                  |  6 ++--
 17 files changed, 86 insertions(+), 152 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 11843e3..b8f04c3 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -51,13 +51,13 @@ static inline void __flush_dcache_icache_phys(unsigned long physaddr)
  * Write any modified data cache blocks out to memory and invalidate them.
  * Does not invalidate the corresponding instruction cache blocks.
  */
-static inline void flush_dcache_range(unsigned long start, unsigned long stop)
+static inline void flush_dcache_range(void *start, unsigned long size)
 {
-	void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
-	unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
+	void *addr = (void *)((u32)start & ~(L1_CACHE_BYTES - 1));
+	unsigned long len = size + (L1_CACHE_BYTES - 1);
 	unsigned long i;
 
-	for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
+	for (i = 0; i < len >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
 		dcbf(addr);
 	mb();	/* sync */
 }
@@ -67,13 +67,13 @@ static inline void flush_dcache_range(unsigned long start, unsigned long stop)
  * Does not invalidate the corresponding cache lines (especially for
  * any corresponding instruction cache).
  */
-static inline void clean_dcache_range(unsigned long start, unsigned long stop)
+static inline void clean_dcache_range(void *start, unsigned long size)
 {
-	void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
-	unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
+	void *addr = (void *)((u32)start & ~(L1_CACHE_BYTES - 1));
+	unsigned long len = size + (L1_CACHE_BYTES  - 1);
 	unsigned long i;
 
-	for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
+	for (i = 0; i < len >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
 		dcbst(addr);
 	mb();	/* sync */
 }
@@ -83,22 +83,39 @@ static inline void clean_dcache_range(unsigned long start, unsigned long stop)
  * to invalidate the cache so the PPC core doesn't get stale data
  * from the CPM (no cache snooping here :-).
  */
-static inline void invalidate_dcache_range(unsigned long start,
-					   unsigned long stop)
+static inline void invalidate_dcache_range(void *start, unsigned long size)
 {
-	void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
-	unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
+	void *addr = (void *)((u32)start & ~(L1_CACHE_BYTES - 1));
+	unsigned long len = size + (L1_CACHE_SHIFT - 1);
 	unsigned long i;
 
-	for (i = 0; i < size >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
+	for (i = 0; i < len >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
 		dcbi(addr);
 	mb();	/* sync */
 }
 
 #endif /* CONFIG_PPC32 */
 #ifdef CONFIG_PPC64
-extern void flush_dcache_range(unsigned long start, unsigned long stop);
-extern void flush_inval_dcache_range(unsigned long start, unsigned long stop);
+static inline void flush_dcache_range(void *start, unsigned long size)
+{
+	void *addr = (void *)((u64)start & ~(L1_CACHE_BYTES - 1));
+	unsigned long len = size + (L1_CACHE_BYTES - 1);
+	unsigned long i;
+
+	for (i = 0; i < len >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
+		dcbf(addr);
+	mb();	/* sync */
+}
+static inline void flush_inval_dcache_range(void *start, unsigned long size)
+{
+	void *addr = (void *)((u64)start & ~(L1_CACHE_BYTES - 1));
+	unsigned long len = size + (L1_CACHE_BYTES - 1);
+	unsigned long i;
+
+	for (i = 0; i < len >> L1_CACHE_SHIFT; i++, addr += L1_CACHE_BYTES)
+		dcbi(addr);
+	mb();	/* sync */
+}
 #endif
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 0ed5c55..a4ebeec 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -114,58 +114,6 @@ _ASM_NOKPROBE_SYMBOL(flush_icache_range)
 EXPORT_SYMBOL(flush_icache_range)
 
 /*
- * Like above, but only do the D-cache.
- *
- * flush_dcache_range(unsigned long start, unsigned long stop)
- *
- *    flush all bytes from start to stop-1 inclusive
- */
-_GLOBAL_TOC(flush_dcache_range)
-
-/*
- * Flush the data cache to memory 
- * 
- * Different systems have different cache line sizes
- */
- 	ld	r10,PPC64_CACHES@toc(r2)
-	lwz	r7,DCACHEL1BLOCKSIZE(r10)	/* Get dcache block size */
-	addi	r5,r7,-1
-	andc	r6,r3,r5		/* round low to line bdy */
-	subf	r8,r6,r4		/* compute length */
-	add	r8,r8,r5		/* ensure we get enough */
-	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)	/* Get log-2 of dcache block size */
-	srw.	r8,r8,r9		/* compute line count */
-	beqlr				/* nothing to do? */
-	mtctr	r8
-0:	dcbst	0,r6
-	add	r6,r6,r7
-	bdnz	0b
-	sync
-	blr
-EXPORT_SYMBOL(flush_dcache_range)
-
-_GLOBAL(flush_inval_dcache_range)
- 	ld	r10,PPC64_CACHES@toc(r2)
-	lwz	r7,DCACHEL1BLOCKSIZE(r10)	/* Get dcache block size */
-	addi	r5,r7,-1
-	andc	r6,r3,r5		/* round low to line bdy */
-	subf	r8,r6,r4		/* compute length */
-	add	r8,r8,r5		/* ensure we get enough */
-	lwz	r9,DCACHEL1LOGBLOCKSIZE(r10)/* Get log-2 of dcache block size */
-	srw.	r8,r8,r9		/* compute line count */
-	beqlr				/* nothing to do? */
-	sync
-	isync
-	mtctr	r8
-0:	dcbf	0,r6
-	add	r6,r6,r7
-	bdnz	0b
-	sync
-	isync
-	blr
-
-
-/*
  * Flush a particular page from the data cache to RAM.
  * Note: this is necessary because the instruction cache does *not*
  * snoop from the data cache.
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 3825284..5fd3171 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -204,9 +204,9 @@ __dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t
 	 * kernel direct-mapped region for device DMA.
 	 */
 	{
-		unsigned long kaddr = (unsigned long)page_address(page);
+		void *kaddr = page_address(page);
 		memset(page_address(page), 0, size);
-		flush_dcache_range(kaddr, kaddr + size);
+		flush_dcache_range(kaddr, size);
 	}
 
 	/*
@@ -316,9 +316,6 @@ EXPORT_SYMBOL(__dma_free_coherent);
  */
 void __dma_sync(void *vaddr, size_t size, int direction)
 {
-	unsigned long start = (unsigned long)vaddr;
-	unsigned long end   = start + size;
-
 	switch (direction) {
 	case DMA_NONE:
 		BUG();
@@ -328,15 +325,15 @@ void __dma_sync(void *vaddr, size_t size, int direction)
 		 * the potential for discarding uncommitted data from the cache
 		 */
 		if ((start | end) & (L1_CACHE_BYTES - 1))
-			flush_dcache_range(start, end);
+			flush_dcache_range(vaddr, size);
 		else
-			invalidate_dcache_range(start, end);
+			invalidate_dcache_range(vaddr, size);
 		break;
 	case DMA_TO_DEVICE:		/* writeback only */
-		clean_dcache_range(start, end);
+		clean_dcache_range(vaddr, size);
 		break;
 	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		flush_dcache_range(start, end);
+		flush_dcache_range(vaddr, size);
 		break;
 	}
 }
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 6b4f4cb..0f3a7d9 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -225,7 +225,7 @@ static void __init mpc512x_init_diu(void)
 	phys_addr_t desc;
 	void __iomem *vaddr;
 	unsigned long mode, pix_fmt, res, bpp;
-	unsigned long dst;
+	void *dst;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-diu");
 	if (!np) {
@@ -254,8 +254,8 @@ static void __init mpc512x_init_diu(void)
 	}
 	memcpy(&diu_shared_fb.ad0, vaddr, sizeof(struct diu_ad));
 	/* flush fb area descriptor */
-	dst = (unsigned long)&diu_shared_fb.ad0;
-	flush_dcache_range(dst, dst + sizeof(struct diu_ad) - 1);
+	dst = &diu_shared_fb.ad0;
+	flush_dcache_range(dst, sizeof(struct diu_ad) - 1);
 
 	res = in_be32(&diu_reg->disp_size);
 	pix_fmt = in_le32(vaddr);
@@ -274,8 +274,8 @@ static void __init mpc512x_init_diu(void)
 	}
 	memcpy(&diu_shared_fb.gamma, vaddr, sizeof(diu_shared_fb.gamma));
 	/* flush gamma table */
-	dst = (unsigned long)&diu_shared_fb.gamma;
-	flush_dcache_range(dst, dst + sizeof(diu_shared_fb.gamma) - 1);
+	dst = &diu_shared_fb.gamma;
+	flush_dcache_range(dst, sizeof(diu_shared_fb.gamma) - 1);
 
 	iounmap(vaddr);
 	out_be32(&diu_reg->gamma, virt_to_phys(&diu_shared_fb.gamma));
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index f51fd35..645edc9 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -166,14 +166,12 @@ static void qoriq_cpu_kill(unsigned int cpu)
  */
 static inline void flush_spin_table(void *spin_table)
 {
-	flush_dcache_range((ulong)spin_table,
-		(ulong)spin_table + sizeof(struct epapr_spin_table));
+	flush_dcache_range(spin_table, sizeof(struct epapr_spin_table));
 }
 
 static inline u32 read_spin_table_addr_l(void *spin_table)
 {
-	flush_dcache_range((ulong)spin_table,
-		(ulong)spin_table + sizeof(struct epapr_spin_table));
+	flush_dcache_range(spin_table, sizeof(struct epapr_spin_table));
 	return in_be32(&((struct epapr_spin_table *)spin_table)->addr_l);
 }
 
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 3573d54..149b6e8 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -152,12 +152,13 @@ static void dart_cache_sync(unsigned int *base, unsigned int count)
 	 * comment in Darwin indicating that the memory controller
 	 * can prefetch unmapped memory under some circumstances.
 	 */
+	unsigned long size = (count + 1) * sizeof(unsigned int);
 	unsigned long start = (unsigned long)base;
-	unsigned long end = start + (count + 1) * sizeof(unsigned int);
+	unsigned long end = start + size;
 	unsigned int tmp;
 
 	/* Perform a standard cache flush */
-	flush_inval_dcache_range(start, end);
+	flush_inval_dcache_range(base, size);
 
 	/*
 	 * Perform the sequence described in the CPC925 manual to
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 0e55a8d..485e070 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -866,8 +866,7 @@ static void bfin_bmdma_setup(struct ata_queued_cmd *qc)
 	/* Set the last descriptor to stop mode */
 	dma_desc_cpu[qc->n_elem - 1].cfg &= ~(DMAFLOW | NDSIZE);
 
-	flush_dcache_range((unsigned int)dma_desc_cpu,
-		(unsigned int)dma_desc_cpu +
+	flush_dcache_range(dma_desc_cpu,
 			qc->n_elem * sizeof(struct dma_desc_array));
 
 	/* Enable ATA DMA operation*/
diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index fdced54..e46eae2 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -186,8 +186,7 @@ static int uninorth_insert_memory(struct agp_memory *mem, off_t pg_start, int ty
 		else
 			gp[i] =	cpu_to_le32((page_to_phys(mem->pages[i]) & 0xFFFFF000UL) |
 					    0x1UL);
-		flush_dcache_range((unsigned long)__va(page_to_phys(mem->pages[i])),
-				   (unsigned long)__va(page_to_phys(mem->pages[i]))+0x1000);
+		flush_dcache_range(__va(page_to_phys(mem->pages[i])), 0x1000);
 	}
 	mb();
 	uninorth_tlbflush(mem);
@@ -416,8 +415,7 @@ static int uninorth_create_gatt_table(struct agp_bridge_data *bridge)
 
 	bridge->gatt_table_real = (u32 *) table;
 	/* Need to clear out any dirty data still sitting in caches */
-	flush_dcache_range((unsigned long)table,
-			   (unsigned long)table_end + 1);
+	flush_dcache_range(table,  (unsigned long)(table_end - table) + 1);
 	bridge->gatt_table = vmap(uninorth_priv.pages_arr, (1 << page_order), 0, PAGE_KERNEL_NCG);
 
 	if (bridge->gatt_table == NULL)
diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 3bd76e9..5b8062f 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -100,8 +100,7 @@ drm_clflush_pages(struct page *pages[], unsigned long num_pages)
 			continue;
 
 		page_virtual = kmap_atomic(page);
-		flush_dcache_range((unsigned long)page_virtual,
-				   (unsigned long)page_virtual + PAGE_SIZE);
+		flush_dcache_range(page_virtual, PAGE_SIZE);
 		kunmap_atomic(page_virtual);
 	}
 #else
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 1ac6642..e92507d 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -111,8 +111,9 @@ static void smu_i2c_retry(unsigned long data);
 
 static void smu_start_cmd(void)
 {
-	unsigned long faddr, fend;
 	struct smu_cmd *cmd;
+	unsigned long flen;
+	void *faddr;
 
 	if (list_empty(&smu->cmd_list))
 		return;
@@ -132,9 +133,9 @@ static void smu_start_cmd(void)
 	memcpy(smu->cmd_buf->data, cmd->data_buf, cmd->data_len);
 
 	/* Flush command and data to RAM */
-	faddr = (unsigned long)smu->cmd_buf;
-	fend = faddr + smu->cmd_buf->length + 2;
-	flush_inval_dcache_range(faddr, fend);
+	faddr = smu->cmd_buf;
+	flen = smu->cmd_buf->length + 2;
+	flush_inval_dcache_range(faddr, flen);
 
 
 	/* We also disable NAP mode for the duration of the command
@@ -186,8 +187,8 @@ static irqreturn_t smu_db_intr(int irq, void *arg)
 		goto bail;
 
 	if (rc == 0) {
-		unsigned long faddr;
 		int reply_len;
+		void *faddr;
 		u8 ack;
 
 		/* CPU might have brought back the cache line, so we need
@@ -195,8 +196,8 @@ static irqreturn_t smu_db_intr(int irq, void *arg)
 		 * flush the entire buffer for now as we haven't read the
 		 * reply length (it's only 2 cache lines anyway)
 		 */
-		faddr = (unsigned long)smu->cmd_buf;
-		flush_inval_dcache_range(faddr, faddr + 256);
+		faddr = smu->cmd_buf;
+		flush_inval_dcache_range(faddr, 256);
 
 		/* Now check ack */
 		ack = (~cmd->cmd) & 0xff;
diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 526231e..479a5cc 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -175,8 +175,7 @@ static int sdh_setup_data(struct sdh_host *host, struct mmc_data *data)
 				host->sg_cpu[i].x_modify);
 		}
 	}
-	flush_dcache_range((unsigned int)host->sg_cpu,
-		(unsigned int)host->sg_cpu +
+	flush_dcache_range(host->sg_cpu,
 			host->dma_len * sizeof(struct dma_desc_array));
 	/* Set the last descriptor to stop mode */
 	host->sg_cpu[host->dma_len - 1].cfg &= ~(DMAFLOW | NDSIZE);
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 3962f55..6f485a4 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -492,11 +492,9 @@ static void bf5xx_nand_dma_rw(struct mtd_info *mtd,
 	 * can be introduced to your driver.
 	 */
 	if (is_read)
-		invalidate_dcache_range((unsigned int)buf,
-				(unsigned int)(buf + chip->ecc.size));
+		invalidate_dcache_range(buf, chip->ecc.size);
 	else
-		flush_dcache_range((unsigned int)buf,
-				(unsigned int)(buf + chip->ecc.size));
+		flush_dcache_range(buf, chip->ecc.size);
 
 	/*
 	 * This register must be written before each page is
diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index 2ce394a..e49a961 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -56,7 +56,7 @@
 static inline void dpaa_flush(void *p)
 {
 #ifdef CONFIG_PPC
-	flush_dcache_range((unsigned long)p, (unsigned long)p+64);
+	flush_dcache_range(p, 64);
 #elif defined(CONFIG_ARM32)
 	__cpuc_flush_dcache_area(p, 64);
 #elif defined(CONFIG_ARM64)
diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 90bc40c..ba10979 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -450,8 +450,7 @@ static int zero_priv_mem(struct device *dev, struct device_node *node,
 		return -ENOMEM;
 
 	memset_io(tmpp, 0, sz);
-	flush_dcache_range((unsigned long)tmpp,
-			   (unsigned long)tmpp + sz);
+	flush_dcache_range(tmpp, sz);
 	iounmap(tmpp);
 
 	return 0;
diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index 249c7a3..7e90746 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -730,9 +730,8 @@ static void bfin_spi_pump_transfers(unsigned long data)
 
 			/* invalidate caches, if needed */
 			if (bfin_addr_dcacheable((unsigned long) drv_data->rx))
-				invalidate_dcache_range((unsigned long) drv_data->rx,
-							(unsigned long) (drv_data->rx +
-							drv_data->len_in_bytes));
+				invalidate_dcache_range(drv_data->rx,
+							drv_data->len_in_bytes);
 
 			dma_config |= WNR;
 			dma_start_addr = (unsigned long)drv_data->rx;
@@ -743,9 +742,8 @@ static void bfin_spi_pump_transfers(unsigned long data)
 
 			/* flush caches, if needed */
 			if (bfin_addr_dcacheable((unsigned long) drv_data->tx))
-				flush_dcache_range((unsigned long) drv_data->tx,
-						(unsigned long) (drv_data->tx +
-						drv_data->len_in_bytes));
+				flush_dcache_range(drv_data->tx,
+						drv_data->len_in_bytes);
 
 			dma_start_addr = (unsigned long)drv_data->tx;
 			cr |= BIT_CTL_TIMOD_DMA_TX;
diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index 67ffecc..eaab3b3 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -529,8 +529,7 @@ static void mpsc_sdma_start_tx(struct mpsc_port_info *pi)
 				DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-			invalidate_dcache_range((ulong)txre,
-					(ulong)txre + MPSC_TXRE_SIZE);
+			invalidate_dcache_range(txre, MPSC_TXRE_SIZE);
 #endif
 
 		if (be32_to_cpu(txre->cmdstat) & SDMA_DESC_CMDSTAT_O) {
@@ -875,9 +874,7 @@ static void mpsc_init_rings(struct mpsc_port_info *pi)
 			MPSC_DMA_ALLOC_SIZE, DMA_BIDIRECTIONAL);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-			flush_dcache_range((ulong)pi->dma_region,
-					(ulong)pi->dma_region
-					+ MPSC_DMA_ALLOC_SIZE);
+			flush_dcache_range(pi->dma_region, MPSC_DMA_ALLOC_SIZE);
 #endif
 
 	return;
@@ -950,8 +947,7 @@ static int mpsc_rx_intr(struct mpsc_port_info *pi, unsigned long *flags)
 			DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 	if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-		invalidate_dcache_range((ulong)rxre,
-				(ulong)rxre + MPSC_RXRE_SIZE);
+		invalidate_dcache_range(rxre, MPSC_RXRE_SIZE);
 #endif
 
 	/*
@@ -984,8 +980,7 @@ static int mpsc_rx_intr(struct mpsc_port_info *pi, unsigned long *flags)
 				DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-			invalidate_dcache_range((ulong)bp,
-					(ulong)bp + MPSC_RXBE_SIZE);
+			invalidate_dcache_range(bp, MPSC_RXBE_SIZE);
 #endif
 
 		/*
@@ -1060,8 +1055,7 @@ static int mpsc_rx_intr(struct mpsc_port_info *pi, unsigned long *flags)
 				DMA_BIDIRECTIONAL);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-			flush_dcache_range((ulong)rxre,
-					(ulong)rxre + MPSC_RXRE_SIZE);
+			flush_dcache_range(rxre, MPSC_RXRE_SIZE);
 #endif
 
 		/* Advance to next descriptor */
@@ -1072,8 +1066,7 @@ static int mpsc_rx_intr(struct mpsc_port_info *pi, unsigned long *flags)
 				DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-			invalidate_dcache_range((ulong)rxre,
-					(ulong)rxre + MPSC_RXRE_SIZE);
+			invalidate_dcache_range(rxre, MPSC_RXRE_SIZE);
 #endif
 		rc = 1;
 	}
@@ -1106,8 +1099,7 @@ static void mpsc_setup_tx_desc(struct mpsc_port_info *pi, u32 count, u32 intr)
 			DMA_BIDIRECTIONAL);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 	if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-		flush_dcache_range((ulong)txre,
-				(ulong)txre + MPSC_TXRE_SIZE);
+		flush_dcache_range(txre, MPSC_TXRE_SIZE);
 #endif
 }
 
@@ -1153,8 +1145,7 @@ static void mpsc_copy_tx_data(struct mpsc_port_info *pi)
 				DMA_BIDIRECTIONAL);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-			flush_dcache_range((ulong)bp,
-					(ulong)bp + MPSC_TXBE_SIZE);
+			flush_dcache_range(bp, MPSC_TXBE_SIZE);
 #endif
 		mpsc_setup_tx_desc(pi, i, 1);
 
@@ -1179,8 +1170,7 @@ static int mpsc_tx_intr(struct mpsc_port_info *pi)
 				DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-			invalidate_dcache_range((ulong)txre,
-					(ulong)txre + MPSC_TXRE_SIZE);
+			invalidate_dcache_range(txre, MPSC_TXRE_SIZE);
 #endif
 
 		while (!(be32_to_cpu(txre->cmdstat) & SDMA_DESC_CMDSTAT_O)) {
@@ -1198,8 +1188,7 @@ static int mpsc_tx_intr(struct mpsc_port_info *pi)
 					MPSC_TXRE_SIZE, DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 			if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-				invalidate_dcache_range((ulong)txre,
-						(ulong)txre + MPSC_TXRE_SIZE);
+				invalidate_dcache_range(txre, MPSC_TXRE_SIZE);
 #endif
 		}
 
@@ -1580,8 +1569,7 @@ static int mpsc_get_poll_char(struct uart_port *port)
 			       MPSC_RXRE_SIZE, DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-			invalidate_dcache_range((ulong)rxre,
-			(ulong)rxre + MPSC_RXRE_SIZE);
+			invalidate_dcache_range(rxre, MPSC_RXRE_SIZE);
 #endif
 		/*
 		 * Loop through Rx descriptors handling ones that have
@@ -1596,8 +1584,7 @@ static int mpsc_get_poll_char(struct uart_port *port)
 				       MPSC_RXBE_SIZE, DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 			if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-				invalidate_dcache_range((ulong)bp,
-					(ulong)bp + MPSC_RXBE_SIZE);
+				invalidate_dcache_range(bp, MPSC_RXBE_SIZE);
 #endif
 			if ((unlikely(cmdstat & (SDMA_DESC_CMDSTAT_BR |
 			 SDMA_DESC_CMDSTAT_FR | SDMA_DESC_CMDSTAT_OR))) &&
@@ -1622,8 +1609,7 @@ static int mpsc_get_poll_char(struct uart_port *port)
 				       MPSC_RXRE_SIZE, DMA_BIDIRECTIONAL);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 			if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-				flush_dcache_range((ulong)rxre,
-					   (ulong)rxre + MPSC_RXRE_SIZE);
+				flush_dcache_range(rxre, MPSC_RXRE_SIZE);
 #endif
 
 			/* Advance to next descriptor */
@@ -1635,8 +1621,7 @@ static int mpsc_get_poll_char(struct uart_port *port)
 				       MPSC_RXRE_SIZE, DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 			if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-				invalidate_dcache_range((ulong)rxre,
-						(ulong)rxre + MPSC_RXRE_SIZE);
+				invalidate_dcache_range(rxre, MPSC_RXRE_SIZE);
 #endif
 		}
 
@@ -1748,8 +1733,7 @@ static void mpsc_console_write(struct console *co, const char *s, uint count)
 				DMA_BIDIRECTIONAL);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
-			flush_dcache_range((ulong)bp,
-					(ulong)bp + MPSC_TXBE_SIZE);
+			flush_dcache_range(bp, MPSC_TXBE_SIZE);
 #endif
 		mpsc_setup_tx_desc(pi, i, 0);
 		pi->txr_head = (pi->txr_head + 1) & (MPSC_TXR_ENTRIES - 1);
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 4418574..092a011 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -90,8 +90,7 @@ static void bfin_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	if (!ANOMALY_05000380 && epnum != 0) {
 		u16 dma_reg;
 
-		flush_dcache_range((unsigned long)src,
-			(unsigned long)(src + len));
+		flush_dcache_range(src, len);
 
 		/* Setup DMA address register */
 		dma_reg = (u32)src;
@@ -144,8 +143,7 @@ static void bfin_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 	if (ANOMALY_05000467 && epnum != 0) {
 		u16 dma_reg;
 
-		invalidate_dcache_range((unsigned long)dst,
-			(unsigned long)(dst + len));
+		invalidate_dcache_range(dst, len);
 
 		/* Setup DMA address register */
 		dma_reg = (u32)dst;
-- 
2.9.3


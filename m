From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH mmc-next 2/3] mmc: sdhci: introduce adma_write_desc() hook
 to struct sdhci_ops
Date: Wed, 25 Jul 2018 17:46:18 +0800
Message-ID: <20180725174618.1dc9bdd4@xhacker.debian>
References: <20180725174235.1ca764cf@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725174235.1ca764cf@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add this hook so that it can be overridden with driver specific
implementations. We also rename the original sdhci_adma_write_desc()
to _sdhci_adma_write_desc() and export it, so that it could be reused
by driver's specific implementations.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci.c | 31 +++++++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |  6 ++++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 14dd4a49e03b..50c846d99182 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -554,8 +554,8 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 	local_irq_restore(*flags);
 }
 
-static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
-				  dma_addr_t addr, int len, unsigned cmd)
+unsigned int _sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+				    dma_addr_t addr, int len, unsigned int cmd)
 {
 	struct sdhci_adma2_64_desc *dma_desc = desc;
 
@@ -566,6 +566,19 @@ static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA)
 		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
+
+	return host->desc_sz;
+}
+EXPORT_SYMBOL_GPL(_sdhci_adma_write_desc);
+
+static unsigned int sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+					  dma_addr_t addr, int len,
+					  unsigned int cmd)
+{
+	if (host->ops->adma_write_desc)
+		return host->ops->adma_write_desc(host, desc, addr, len, cmd);
+
+	return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
 static void sdhci_adma_mark_end(void *desc)
@@ -585,6 +598,7 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 	void *desc, *align;
 	char *buffer;
 	int len, offset, i;
+	unsigned int desc_sz;
 
 	/*
 	 * The spec does not specify endianness of descriptor table.
@@ -618,15 +632,16 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 			}
 
 			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, align_addr, offset,
-					      ADMA2_TRAN_VALID);
+			desc_sz = sdhci_adma_write_desc(host, desc,
+							align_addr, offset,
+							ADMA2_TRAN_VALID);
 
 			BUG_ON(offset > 65536);
 
 			align += SDHCI_ADMA2_ALIGN;
 			align_addr += SDHCI_ADMA2_ALIGN;
 
-			desc += host->desc_sz;
+			desc += desc_sz;
 
 			addr += offset;
 			len -= offset;
@@ -636,9 +651,9 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 
 		if (len) {
 			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, addr, len,
-					      ADMA2_TRAN_VALID);
-			desc += host->desc_sz;
+			desc_sz = sdhci_adma_write_desc(host, desc, addr, len,
+							ADMA2_TRAN_VALID);
+			desc += desc_sz;
 		}
 
 		/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d55fd7033e93..0aad0ee8f63b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -605,6 +605,9 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	unsigned int	(*adma_write_desc)(struct sdhci_host *host, void *desc,
+					   dma_addr_t addr, int len,
+					   unsigned int cmd);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -735,6 +738,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
+unsigned int _sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
+				    dma_addr_t addr, int len,
+				    unsigned int cmd);
 
 #ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
-- 
2.18.0

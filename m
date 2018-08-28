From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH v6 2/3] mmc: sdhci: introduce adma_write_desc() hook to
 struct sdhci_ops
Date: Tue, 28 Aug 2018 17:47:23 +0800
Message-ID: <20180828174723.4e729a27@xhacker.debian>
References: <20180828174534.00fb5e24@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828174534.00fb5e24@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add this hook so that it can be overridden with driver specific
implementations. We also let the original sdhci_adma_write_desc()
accept &desc so that the function can set its new value. Then export
the function so that it could be reused by driver's specific
implementations.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 37 +++++++++++++++++++++++--------------
 drivers/mmc/host/sdhci.h |  4 ++++
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 52ccf4644384..eb21d2db7f05 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -554,10 +554,10 @@ static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 	local_irq_restore(*flags);
 }
 
-static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
-				  dma_addr_t addr, int len, unsigned cmd)
+void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
+			   dma_addr_t addr, int len, unsigned int cmd)
 {
-	struct sdhci_adma2_64_desc *dma_desc = desc;
+	struct sdhci_adma2_64_desc *dma_desc = *desc;
 
 	/* 32-bit and 64-bit descriptors have these members in same position */
 	dma_desc->cmd = cpu_to_le16(cmd);
@@ -566,6 +566,19 @@ static void sdhci_adma_write_desc(struct sdhci_host *host, void *desc,
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA)
 		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
+
+	*desc += host->desc_sz;
+}
+EXPORT_SYMBOL_GPL(sdhci_adma_write_desc);
+
+static inline void __sdhci_adma_write_desc(struct sdhci_host *host,
+					   void **desc, dma_addr_t addr,
+					   int len, unsigned int cmd)
+{
+	if (host->ops->adma_write_desc)
+		host->ops->adma_write_desc(host, desc, addr, len, cmd);
+
+	sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
 static void sdhci_adma_mark_end(void *desc)
@@ -618,28 +631,24 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 			}
 
 			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, align_addr, offset,
-					      ADMA2_TRAN_VALID);
+			__sdhci_adma_write_desc(host, &desc, align_addr,
+						offset, ADMA2_TRAN_VALID);
 
 			BUG_ON(offset > 65536);
 
 			align += SDHCI_ADMA2_ALIGN;
 			align_addr += SDHCI_ADMA2_ALIGN;
 
-			desc += host->desc_sz;
-
 			addr += offset;
 			len -= offset;
 		}
 
 		BUG_ON(len > 65536);
 
-		if (len) {
-			/* tran, valid */
-			sdhci_adma_write_desc(host, desc, addr, len,
-					      ADMA2_TRAN_VALID);
-			desc += host->desc_sz;
-		}
+		/* tran, valid */
+		if (len)
+			__sdhci_adma_write_desc(host, &desc, addr, len,
+						ADMA2_TRAN_VALID);
 
 		/*
 		 * If this triggers then we have a calculation bug
@@ -656,7 +665,7 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 		}
 	} else {
 		/* Add a terminating entry - nop, end, valid */
-		sdhci_adma_write_desc(host, desc, 0, 0, ADMA2_NOP_END_VALID);
+		__sdhci_adma_write_desc(host, &desc, 0, 0, ADMA2_NOP_END_VALID);
 	}
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 25bddd21de31..2115416f973a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -606,6 +606,8 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
+	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
+				   dma_addr_t addr, int len, unsigned int cmd);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -736,6 +738,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
+void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
+			   dma_addr_t addr, int len, unsigned int cmd);
 
 #ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
-- 
2.18.0

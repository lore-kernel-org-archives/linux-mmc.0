From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v1 4/4] mmc/host/sdhci: Make sdhci_read/sdhci_write call trace functions
Date: Thu, 11 Apr 2019 16:08:22 -0600
Message-ID: <20190411220822.81845-5-rrangel@chromium.org>
References: <20190411220822.81845-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411220822.81845-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-trace-devel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: djkurtz@chromium.org, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

An example trace can be seen here: https://pastebin.com/x73d5cvL

I was unable to leave sdhci_readX and sdhci_writeX as macros because
they are used in other modules (i.e., sdhci-pci). This means they can't
call the trace_sdhci_XXX functions without explicitly exporting the
private trace function name.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/host/sdhci-core.c | 136 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h      |  89 ++--------------------
 2 files changed, 142 insertions(+), 83 deletions(-)

diff --git a/drivers/mmc/host/sdhci-core.c b/drivers/mmc/host/sdhci-core.c
index a8141ff9be03..9e3f114629d9 100644
--- a/drivers/mmc/host/sdhci-core.c
+++ b/drivers/mmc/host/sdhci-core.c
@@ -36,6 +36,7 @@
 #include <linux/mmc/slot-gpio.h>
 
 #include "sdhci.h"
+#include "sdhci-trace.h"
 
 #define DRIVER_NAME "sdhci"
 
@@ -54,6 +55,141 @@ static void sdhci_finish_data(struct sdhci_host *);
 
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 
+#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
+
+void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	trace_sdhci_write(host, reg, val, U32_MAX);
+
+	if (unlikely(host->ops->write_l))
+		host->ops->write_l(host, val, reg);
+	else
+		writel(val, host->ioaddr + reg);
+}
+EXPORT_SYMBOL(sdhci_writel);
+
+void sdhci_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	trace_sdhci_write(host, reg, val, U16_MAX);
+
+	if (unlikely(host->ops->write_w))
+		host->ops->write_w(host, val, reg);
+	else
+		writew(val, host->ioaddr + reg);
+}
+EXPORT_SYMBOL(sdhci_writew);
+
+void sdhci_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+	trace_sdhci_write(host, reg, val, U8_MAX);
+
+	if (unlikely(host->ops->write_b))
+		host->ops->write_b(host, val, reg);
+	else
+		writeb(val, host->ioaddr + reg);
+}
+EXPORT_SYMBOL(sdhci_writeb);
+
+u32 sdhci_readl(struct sdhci_host *host, int reg)
+{
+	u32 val;
+
+	if (unlikely(host->ops->read_l))
+		val = host->ops->read_l(host, reg);
+	else
+		val = readl(host->ioaddr + reg);
+
+	trace_sdhci_read(host, reg, val, U32_MAX);
+
+	return val;
+}
+EXPORT_SYMBOL(sdhci_readl);
+
+u16 sdhci_readw(struct sdhci_host *host, int reg)
+{
+	u16 val;
+
+	if (unlikely(host->ops->read_w))
+		val = host->ops->read_w(host, reg);
+	else
+		val = readw(host->ioaddr + reg);
+
+	trace_sdhci_read(host, reg, val, U16_MAX);
+
+	return val;
+}
+EXPORT_SYMBOL(sdhci_readw);
+
+u8 sdhci_readb(struct sdhci_host *host, int reg)
+{
+	u8 val;
+
+	if (unlikely(host->ops->read_b))
+		val = host->ops->read_b(host, reg);
+	else
+		val = readb(host->ioaddr + reg);
+
+	trace_sdhci_read(host, reg, val, U8_MAX);
+
+	return val;
+}
+EXPORT_SYMBOL(sdhci_readb);
+
+#else
+
+void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	trace_sdhci_write(host, reg, val, U32_MAX);
+	writel(val, host->ioaddr + reg);
+}
+EXPORT_SYMBOL(sdhci_writel);
+
+void sdhci_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	trace_sdhci_write(host, reg, val, U16_MAX);
+	writew(val, host->ioaddr + reg);
+}
+EXPORT_SYMBOL(sdhci_writew);
+
+void sdhci_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+	trace_sdhci_write(host, reg, val, U8_MAX);
+	writeb(val, host->ioaddr + reg);
+}
+EXPORT_SYMBOL(sdhci_writeb);
+
+u32 sdhci_readl(struct sdhci_host *host, int reg)
+{
+	u32 val = readl(host->ioaddr + reg);
+
+	trace_sdhci_read(host, reg, val, U32_MAX);
+
+	return val;
+}
+EXPORT_SYMBOL(sdhci_readl);
+
+u16 sdhci_readw(struct sdhci_host *host, int reg)
+{
+	u16 val = readw(host->ioaddr + reg);
+
+	trace_sdhci_read(host, reg, val, U16_MAX);
+
+	return val;
+}
+EXPORT_SYMBOL(sdhci_readw);
+
+u8 sdhci_readb(struct sdhci_host *host, int reg)
+{
+	u8 val = readb(host->ioaddr + reg);
+
+	trace_sdhci_read(host, reg, val, U8_MAX);
+
+	return val;
+}
+EXPORT_SYMBOL(sdhci_readb);
+
+#endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
+
 void sdhci_dumpregs(struct sdhci_host *host)
 {
 	SDHCI_DUMP("============ SDHCI REGISTER DUMP ===========\n");
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 01002cba1359..052361f27ec0 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -647,89 +647,12 @@ struct sdhci_ops {
 				   dma_addr_t addr, int len, unsigned int cmd);
 };
 
-#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-
-static inline void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
-{
-	if (unlikely(host->ops->write_l))
-		host->ops->write_l(host, val, reg);
-	else
-		writel(val, host->ioaddr + reg);
-}
-
-static inline void sdhci_writew(struct sdhci_host *host, u16 val, int reg)
-{
-	if (unlikely(host->ops->write_w))
-		host->ops->write_w(host, val, reg);
-	else
-		writew(val, host->ioaddr + reg);
-}
-
-static inline void sdhci_writeb(struct sdhci_host *host, u8 val, int reg)
-{
-	if (unlikely(host->ops->write_b))
-		host->ops->write_b(host, val, reg);
-	else
-		writeb(val, host->ioaddr + reg);
-}
-
-static inline u32 sdhci_readl(struct sdhci_host *host, int reg)
-{
-	if (unlikely(host->ops->read_l))
-		return host->ops->read_l(host, reg);
-	else
-		return readl(host->ioaddr + reg);
-}
-
-static inline u16 sdhci_readw(struct sdhci_host *host, int reg)
-{
-	if (unlikely(host->ops->read_w))
-		return host->ops->read_w(host, reg);
-	else
-		return readw(host->ioaddr + reg);
-}
-
-static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
-{
-	if (unlikely(host->ops->read_b))
-		return host->ops->read_b(host, reg);
-	else
-		return readb(host->ioaddr + reg);
-}
-
-#else
-
-static inline void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
-{
-	writel(val, host->ioaddr + reg);
-}
-
-static inline void sdhci_writew(struct sdhci_host *host, u16 val, int reg)
-{
-	writew(val, host->ioaddr + reg);
-}
-
-static inline void sdhci_writeb(struct sdhci_host *host, u8 val, int reg)
-{
-	writeb(val, host->ioaddr + reg);
-}
-
-static inline u32 sdhci_readl(struct sdhci_host *host, int reg)
-{
-	return readl(host->ioaddr + reg);
-}
-
-static inline u16 sdhci_readw(struct sdhci_host *host, int reg)
-{
-	return readw(host->ioaddr + reg);
-}
-
-static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
-{
-	return readb(host->ioaddr + reg);
-}
-
-#endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
+void sdhci_writel(struct sdhci_host *host, u32 val, int reg);
+void sdhci_writew(struct sdhci_host *host, u16 val, int reg);
+void sdhci_writeb(struct sdhci_host *host, u8 val, int reg);
+u32 sdhci_readl(struct sdhci_host *host, int reg);
+u16 sdhci_readw(struct sdhci_host *host, int reg);
+u8 sdhci_readb(struct sdhci_host *host, int reg);
 
 struct sdhci_host *sdhci_alloc_host(struct device *dev, size_t priv_size);
 void sdhci_free_host(struct sdhci_host *host);
-- 
2.21.0.392.gf8f6787159e-goog

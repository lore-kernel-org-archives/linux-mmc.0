From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH v2 1/2] mmc: move sdhci_ops and sdhci_priv to header
Date: Wed, 18 May 2011 16:41:30 -0400
Message-ID: <1305751290-28093-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:60304 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab1ERImV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2011 04:42:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Philip Rakity <prakity@ma>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>

        Give a chance platfrom code could access sdhci_priv and pointer ops

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.h  |   32 --------------------------------
 include/linux/mmc/sdhci.h |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7e28eec..c9f3d86 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -247,33 +247,6 @@
 #define SDHCI_DEFAULT_BOUNDARY_SIZE  (512 * 1024)
 #define SDHCI_DEFAULT_BOUNDARY_ARG   (ilog2(SDHCI_DEFAULT_BOUNDARY_SIZE) - 12)
 
-struct sdhci_ops {
-#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-	u32		(*read_l)(struct sdhci_host *host, int reg);
-	u16		(*read_w)(struct sdhci_host *host, int reg);
-	u8		(*read_b)(struct sdhci_host *host, int reg);
-	void		(*write_l)(struct sdhci_host *host, u32 val, int reg);
-	void		(*write_w)(struct sdhci_host *host, u16 val, int reg);
-	void		(*write_b)(struct sdhci_host *host, u8 val, int reg);
-#endif
-
-	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
-
-	int		(*enable_dma)(struct sdhci_host *host);
-	unsigned int	(*get_max_clock)(struct sdhci_host *host);
-	unsigned int	(*get_min_clock)(struct sdhci_host *host);
-	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
-	int		(*platform_8bit_width)(struct sdhci_host *host,
-					       int width);
-	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
-					     u8 power_mode);
-	unsigned int    (*get_ro)(struct sdhci_host *host);
-	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
-	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
-	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
-
-};
-
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
 
 static inline void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
@@ -362,11 +335,6 @@ extern struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	size_t priv_size);
 extern void sdhci_free_host(struct sdhci_host *host);
 
-static inline void *sdhci_priv(struct sdhci_host *host)
-{
-	return (void *)host->private;
-}
-
 extern void sdhci_card_detect(struct sdhci_host *host);
 extern int sdhci_add_host(struct sdhci_host *host);
 extern void sdhci_remove_host(struct sdhci_host *host, int dead);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e902618..584532c 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -160,4 +160,37 @@ struct sdhci_host {
 
 	unsigned long private[0] ____cacheline_aligned;
 };
+
+struct sdhci_ops {
+#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
+	u32		(*read_l)(struct sdhci_host *host, int reg);
+	u16		(*read_w)(struct sdhci_host *host, int reg);
+	u8		(*read_b)(struct sdhci_host *host, int reg);
+	void		(*write_l)(struct sdhci_host *host, u32 val, int reg);
+	void		(*write_w)(struct sdhci_host *host, u16 val, int reg);
+	void		(*write_b)(struct sdhci_host *host, u8 val, int reg);
+#endif
+
+	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
+
+	int		(*enable_dma)(struct sdhci_host *host);
+	unsigned int	(*get_max_clock)(struct sdhci_host *host);
+	unsigned int	(*get_min_clock)(struct sdhci_host *host);
+	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	int		(*platform_8bit_width)(struct sdhci_host *host,
+					       int width);
+	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
+					     u8 power_mode);
+	unsigned int    (*get_ro)(struct sdhci_host *host);
+	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
+	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
+	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
+
+};
+
+static inline void *sdhci_priv(struct sdhci_host *host)
+{
+	return (void *)host->private;
+}
+
 #endif /* __SDHCI_H */
-- 
1.7.0.4


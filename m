From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH 1/2] mmc: move sdhci_ops and sdhci_priv to header
Date: Thu, 28 Apr 2011 23:56:07 -0400
Message-ID: <BANLkTikFKq=tVEvXr8so=exNrCdyrJk-hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52785 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab1D2D4I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 23:56:08 -0400
Received: by qwk3 with SMTP id 3so1553652qwk.19
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 20:56:07 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

Subject: [PATCH 1/2] mmc: move sdhci_ops and sdhci_priv to header

	Give a chance platfrom code could access sdhci_priv and pointer ops

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.h  |   30 ------------------------------
 include/linux/mmc/sdhci.h |   31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c6e25a7..3998a26 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -208,31 +208,6 @@
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
-};
-
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS

 static inline void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
@@ -321,11 +296,6 @@ extern struct sdhci_host *sdhci_alloc_host(struct
device *dev,
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
index 92e1c9a..f9c9b20 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -149,4 +149,35 @@ struct sdhci_host {

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

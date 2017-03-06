From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V1 11/18] mmc: host: Add CQE interface
Date: Mon,  6 Mar 2017 11:11:06 +0200
Message-ID: <1488791473-24981-12-git-send-email-adrian.hunter@intel.com>
References: <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:60745 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752768AbdCFJRi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Mar 2017 04:17:38 -0500
In-Reply-To: <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Add CQE host operations, capabilities, and host members.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/linux/mmc/host.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 83f1c4a9f03b..7624017e8bcd 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -160,6 +160,19 @@ struct mmc_host_ops {
 				  unsigned int direction, int blk_size);
 };
 
+struct mmc_cqe_ops {
+	int	(*cqe_enable)(struct mmc_host *host, struct mmc_card *card);
+	void	(*cqe_disable)(struct mmc_host *host);
+	int	(*cqe_request)(struct mmc_host *host, struct mmc_request *mrq);
+	void	(*cqe_post_req)(struct mmc_host *host, struct mmc_request *mrq);
+	void	(*cqe_off)(struct mmc_host *host);
+	int	(*cqe_wait_for_idle)(struct mmc_host *host);
+	bool	(*cqe_timeout)(struct mmc_host *host, struct mmc_request *mrq,
+			       bool *recovery_needed);
+	void	(*cqe_recovery_start)(struct mmc_host *host);
+	void	(*cqe_recovery_finish)(struct mmc_host *host, bool forget_reqs);
+};
+
 struct mmc_async_req {
 	/* active mmc request */
 	struct mmc_request	*mrq;
@@ -303,6 +316,8 @@ struct mmc_host {
 #define MMC_CAP2_HS400_ES	(1 << 20)	/* Host supports enhanced strobe */
 #define MMC_CAP2_NO_SD		(1 << 21)	/* Do not send SD commands during initialization */
 #define MMC_CAP2_NO_MMC		(1 << 22)	/* Do not send (e)MMC commands during initialization */
+#define MMC_CAP2_CQE		(1 << 23)	/* Has eMMC command queue engine */
+#define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
@@ -388,6 +403,15 @@ struct mmc_host {
 	int			dsr_req;	/* DSR value is valid */
 	u32			dsr;	/* optional driver stage (DSR) value */
 
+	/* Command Queue Engine (CQE) support */
+	const struct mmc_cqe_ops *cqe_ops;
+	void			*cqe_private;
+	void			(*cqe_recovery_notifier)(struct mmc_host *,
+							 struct mmc_request *);
+	int			cqe_qdepth;
+	bool			cqe_enabled;
+	bool			cqe_on;
+
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
-- 
1.9.1


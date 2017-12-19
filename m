From: Xinming Hu <huxm@marvell.com>
Subject: [PATCH v6 1/4] mmc: API for accessing host supported maximum segment count and size
Date: Tue, 19 Dec 2017 20:06:47 +0800
Message-ID: <1513685211-640-1-git-send-email-huxm@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43388 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751599AbdLSMHO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Dec 2017 07:07:14 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux MMC <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@qca.qualcomm.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Wright Feng <wright.feng@cypress.com>, Zhiyuan Yang <yangzy@marvell.com>, Tim Song <songtao@marvell.com>, Cathy Luo <cluo@marvell.com>, James Cao <jcao@marvell.com>, Ganapathi Bhat <gbhat@marvell.com>, Xu Wang <xwang4@marvell.com>, Bob Tan <tanbo@marvell.com>, Xinming Hu <huxm@marvell.com>, Amitkumar Karwar <akarwar@marvell.com>

sdio device drivers need be able to get the host supported max_segs
and max_seg_size, so that they know the buffer size to allocate while
utilizing the scatter/gather DMA buffer list.

This patch provides API for this purpose.

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
v2: v2 was submitted with minor improvement like replacing BUG_ON() with WARN_ON()
v3: Addressed below review comments from Ulf Hansson
    a) In v3, patch has been split into two separate patches.
    b) Patch 1/2 introduces an API to fetch max_seg_size and max_segs
    c) Replaced WARN_ON() with proper error code when sg_ptr->length is invalid
    d) Instead of duplicating the code in mmc_io_rw_extended(), extra bool parameter
       has been added to this function and used it in new APIs for SG.
v4: Removed WARN_ON() calls in newly added APIs. It's gets called in probe handler.
    Caller already takes care of it(Shawn Lin).
v5: Rebased on latest code base.
v6: Split driver caller to separate patch.
---
 drivers/mmc/core/sdio_io.c    | 21 +++++++++++++++++++++
 include/linux/mmc/sdio_func.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index d40744b..4806521 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -725,3 +725,24 @@ int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
+
+/**
+ *	sdio_get_host_max_seg_size - get host maximum segment size
+ *	@func: SDIO function attached to host
+ */
+unsigned int sdio_get_host_max_seg_size(struct sdio_func *func)
+{
+	return func->card->host->max_seg_size;
+}
+EXPORT_SYMBOL_GPL(sdio_get_host_max_seg_size);
+
+/**
+ *	sdio_get_host_max_seg_count - get host maximum segment count
+ *	@func: SDIO function attached to host
+ */
+unsigned short sdio_get_host_max_seg_count(struct sdio_func *func)
+{
+	return func->card->host->max_segs;
+}
+EXPORT_SYMBOL_GPL(sdio_get_host_max_seg_count);
+
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 97ca105..72d4de4 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -159,4 +159,7 @@ extern void sdio_f0_writeb(struct sdio_func *func, unsigned char b,
 extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
 extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
 
+unsigned short sdio_get_host_max_seg_count(struct sdio_func *func);
+unsigned int sdio_get_host_max_seg_size(struct sdio_func *func);
+
 #endif /* LINUX_MMC_SDIO_FUNC_H */
-- 
1.9.1


From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/4] mmc: dw_mmc: modify the variable type
Date: Fri, 05 Sep 2014 14:14:57 +0900
Message-ID: <1409894100-4713-2-git-send-email-jh80.chung@samsung.com>
References: <1409894100-4713-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36812 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbaIEFPE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Sep 2014 01:15:04 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBE00ID2X92CTD0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 05 Sep 2014 14:15:02 +0900 (KST)
In-reply-to: <1409894100-4713-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Fixed wrong variable type.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |    2 +-
 drivers/mmc/host/dw_mmc.c        |    2 +-
 drivers/mmc/host/dw_mmc.h        |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 0fbc53a..aee39bc 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -385,7 +385,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode,
 }
 
 /* Common capabilities of Exynos4/Exynos5 SoC */
-static unsigned long exynos_dwmmc_caps[4] = {
+static unsigned int exynos_dwmmc_caps[4] = {
 	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
 	MMC_CAP_CMD23,
 	MMC_CAP_CMD23,
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 835e913..b8e0ca8 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2202,7 +2202,7 @@ static struct dw_mci_of_slot_quirks {
 static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
 {
 	struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
-	int quirks = 0;
+	unsigned int quirks = 0;
 	int idx;
 
 	/* get quirks */
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 01b99e8..4096f2b 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -220,7 +220,7 @@ struct dw_mci_slot {
 	struct mmc_host		*mmc;
 	struct dw_mci		*host;
 
-	int			quirks;
+	unsigned int		quirks;
 
 	u32			ctype;
 
@@ -257,7 +257,7 @@ struct dw_mci_tuning_data {
  * is optional as well.
  */
 struct dw_mci_drv_data {
-	unsigned long	*caps;
+	unsigned int	*caps;
 	int		(*init)(struct dw_mci *host);
 	int		(*setup_clock)(struct dw_mci *host);
 	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
-- 
1.7.9.5


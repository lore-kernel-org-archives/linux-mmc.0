From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 4/4] mmc: dw-mmc: remove complier warning
Date: Thu, 08 Nov 2012 17:35:33 +0900
Message-ID: <509B6ED5.6070101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:56570 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab2KHIfs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Nov 2012 03:35:48 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MD500II1UJGAMI0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 08 Nov 2012 17:35:48 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MD500LSSUJN2IA0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 08 Nov 2012 17:35:47 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

drivers/mmc/host/dw_mmc.c: In function 'dw_mci_prepare_command':
drivers/mmc/host/dw_mmc.c:256:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
drivers/mmc/host/dw_mmc.c: In function 'dw_mci_set_ios':
drivers/mmc/host/dw_mmc.c:805:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
drivers/mmc/host/dw_mmc.c: In function 'dw_mci_init_slot':
drivers/mmc/host/dw_mmc.c:1849:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
drivers/mmc/host/dw_mmc.c: In function 'dw_mci_parse_dt':
drivers/mmc/host/dw_mmc.c:2049:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
drivers/mmc/host/dw_mmc.c: In function 'dw_mci_probe':
drivers/mmc/host/dw_mmc.c:2095:37: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9704b09..76c21e4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -253,7 +253,7 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct mmc_data	*data;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci_drv_data *drv_data = slot->host->drv_data;
+	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 cmdr;
 	cmd->error = -EINPROGRESS;
 
@@ -802,7 +802,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci_drv_data *drv_data = slot->host->drv_data;
+	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 regs;
 
 	switch (ios->bus_width) {
@@ -1846,7 +1846,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
-	struct dw_mci_drv_data *drv_data = host->drv_data;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int ctrl_id, ret;
 	u8 bus_width;
 
@@ -2046,7 +2046,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	struct dw_mci_board *pdata;
 	struct device *dev = host->dev;
 	struct device_node *np = dev->of_node;
-	struct dw_mci_drv_data *drv_data = host->drv_data;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int idx, ret;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
@@ -2092,7 +2092,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 int dw_mci_probe(struct dw_mci *host)
 {
-	struct dw_mci_drv_data *drv_data = host->drv_data;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int width, i, ret = 0;
 	u32 fifo_size;
 	int init_slots = 0;
-- 
1.7.4.1

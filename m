From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH 1/2] mmc: dw_mmc: add init_slot() hook to platform function table
Date: Wed, 20 Mar 2019 20:48:04 +0300
Message-ID: <1553104085-32312-2-git-send-email-al.kochet@gmail.com>
References: <1553104085-32312-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553104085-32312-1-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexander Kochetkov <al.kochet@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The init_slot() hook allow platform driver override slot defaults
provided by generic dw_mmc driver. It's required to fix EDMA based
transfer hangs observed on rockchip rk3188.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/mmc/host/dw_mmc.c |    4 ++++
 drivers/mmc/host/dw_mmc.h |    2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 80dc2fd..d3ecee9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2819,6 +2819,7 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
 
 static int dw_mci_init_slot(struct dw_mci *host)
 {
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
 	int ret;
@@ -2876,6 +2877,9 @@ static int dw_mci_init_slot(struct dw_mci *host)
 		mmc->max_seg_size = mmc->max_req_size;
 	}
 
+	if (drv_data && drv_data->init_slot)
+		drv_data->init_slot(host);
+
 	dw_mci_get_cd(mmc);
 
 	ret = mmc_add_host(mmc);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 46e9f8e..de51c59 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -548,6 +548,7 @@ struct dw_mci_slot {
  * @caps: mmc subsystem specified capabilities of the controller(s).
  * @num_caps: number of capabilities specified by @caps.
  * @init: early implementation specific initialization.
+ * @init_slot: platform specific slot initialization.
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
  * @execute_tuning: implementation specific tuning procedure.
@@ -560,6 +561,7 @@ struct dw_mci_drv_data {
 	unsigned long	*caps;
 	u32		num_caps;
 	int		(*init)(struct dw_mci *host);
+	void		(*init_slot)(struct dw_mci *host);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
 	int		(*execute_tuning)(struct dw_mci_slot *slot, u32 opcode);
-- 
1.7.9.5

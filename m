Received: from mail-m15598.qiye.163.com (mail-m15598.qiye.163.com [101.71.155.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96035F8A3
	for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886833; cv=none; b=Z3Dr0XsJn1BbM5Szrgi28ElpIQRgTkqRXzl8OF8p4oA7Zk2vIrtR/QFjwLeUBm+hU2spSbOINdGIZEp63SkOXWdLMQGeVf1uETXDYIv51MJniw4/tEGokVFZ+kb/umIANKdQ/z7bscrTG6ar2I2gnqR8+HbMyPltcMs1uFtXECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886833; c=relaxed/simple;
	bh=zIAHTjwm7GcBAweDGPnoGeyvU2U2Jt3bWVkyk1IYovw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CpEwSzNXgrwSU1JGcOomBkar4aSRoQSf/VesurQDGg0Tji8vYw44pRGxz7wuzYppILYwG+0kTcoinz+nTvcVSmwgfTFWNQVwu278KzTs/KjPipgVyAmZuCoPeVUs9sjPjyOBiqRmOFXFfWNV+yP/YqDp6uIWvWl5ZoRd+RjrfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RSd5J0Vj; arc=none smtp.client-ip=101.71.155.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RSd5J0Vj"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d6f8a87f;
	Tue, 16 Dec 2025 19:51:50 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 05/12] mmc: dw_mmc: Let glue drivers to use struct dw_mci as possible
Date: Tue, 16 Dec 2025 19:50:00 +0800
Message-Id: <1765885807-186577-6-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b27009cfd09cckunmc1d96abd3f9b1e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlCSlYZQk9JTUpKTU0dHU9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJMTU
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=RSd5J0VjdA5dDGSv9tFSGOfYJ+i5RF6qQJk0Qu7BxejAOIY9sN09QrLFZYxhA4NETl9Alvi84zcGcv0B2od7mYYBuE5jP7+gmyVpHddnyOATT8He80s8qXMxHG8xaq8wchZj9GPkKncvvuhGIDA+vbfreJKUlBSevxLkFYiRhnk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=9P2o40CQd2q7+mgDBze1A069ThdO1DwOpqpR07wCpSU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

This patch changes the callbacks of switch_voltage() and execute_tuning()
in order for glue drivers to avoid accessing to struct dw_mci_slot.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc-exynos.c      |  3 +--
 drivers/mmc/host/dw_mmc-hi3798cv200.c |  4 +---
 drivers/mmc/host/dw_mmc-hi3798mv200.c | 15 +++++++--------
 drivers/mmc/host/dw_mmc-k3.c          | 19 +++++++------------
 drivers/mmc/host/dw_mmc-rockchip.c    |  3 +--
 drivers/mmc/host/dw_mmc-starfive.c    |  3 +--
 drivers/mmc/host/dw_mmc.c             |  4 ++--
 drivers/mmc/host/dw_mmc.h             |  4 ++--
 8 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 067569b..4106985 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -530,9 +530,8 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candidates)
 	return loc;
 }
 
-static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
+static int dw_mci_exynos_execute_tuning(struct dw_mci *host, u32 opcode)
 {
-	struct dw_mci *host = slot->host;
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 	struct mmc_host *mmc = host->mmc;
 	u8 start_smpl, smpl, candidates = 0;
diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index 03f7ed8..4b723ed 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -57,11 +57,9 @@ static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 		clk_set_phase(priv->drive_clk, 135);
 }
 
-static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
-					     u32 opcode)
+static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci *host, u32 opcode)
 {
 	static const int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
-	struct dw_mci *host = slot->host;
 	struct hi3798cv200_priv *priv = host->priv;
 	int raise_point = -1, fall_point = -1;
 	int err, prev_err = -1;
diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
index 3cc4bc2..a64907e 100644
--- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
@@ -74,25 +74,24 @@ static void dw_mci_hi3798mv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	}
 }
 
-static inline int dw_mci_hi3798mv200_enable_tuning(struct dw_mci_slot *slot)
+static inline int dw_mci_hi3798mv200_enable_tuning(struct dw_mci *host)
 {
-	struct dw_mci_hi3798mv200_priv *priv = slot->host->priv;
+	struct dw_mci_hi3798mv200_priv *priv = host->priv;
 
 	return regmap_clear_bits(priv->crg_reg, priv->sap_dll_offset, SAP_DLL_CTRL_DLLMODE);
 }
 
-static inline int dw_mci_hi3798mv200_disable_tuning(struct dw_mci_slot *slot)
+static inline int dw_mci_hi3798mv200_disable_tuning(struct dw_mci *host)
 {
-	struct dw_mci_hi3798mv200_priv *priv = slot->host->priv;
+	struct dw_mci_hi3798mv200_priv *priv = host->priv;
 
 	return regmap_set_bits(priv->crg_reg, priv->sap_dll_offset, SAP_DLL_CTRL_DLLMODE);
 }
 
-static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
+static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci *host,
 					     u32 opcode)
 {
 	static const int degrees[] = { 0, 45, 90, 135, 180, 225, 270, 315 };
-	struct dw_mci *host = slot->host;
 	struct dw_mci_hi3798mv200_priv *priv = host->priv;
 	int raise_point = -1, fall_point = -1, mid;
 	int err, prev_err = -1;
@@ -101,7 +100,7 @@ static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
 	int i;
 	int ret;
 
-	ret = dw_mci_hi3798mv200_enable_tuning(slot);
+	ret = dw_mci_hi3798mv200_enable_tuning(host);
 	if (ret < 0)
 		return ret;
 
@@ -136,7 +135,7 @@ static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
 	}
 
 tuning_out:
-	ret = dw_mci_hi3798mv200_disable_tuning(slot);
+	ret = dw_mci_hi3798mv200_disable_tuning(host);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 4ef99c0..23c3031 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -138,15 +138,13 @@ static int dw_mci_hi6220_parse_dt(struct dw_mci *host)
 	return 0;
 }
 
-static int dw_mci_hi6220_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
+static int dw_mci_hi6220_switch_voltage(struct dw_mci *host, struct mmc_ios *ios)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct k3_priv *priv;
-	struct dw_mci *host;
+	struct mmc_host *mmc = host->mmc;
 	int min_uv, max_uv;
 	int ret;
 
-	host = slot->host;
 	priv = host->priv;
 
 	if (!priv || !priv->reg)
@@ -199,7 +197,7 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	host->bus_hz = clk_get_rate(host->biu_clk);
 }
 
-static int dw_mci_hi6220_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
+static int dw_mci_hi6220_execute_tuning(struct dw_mci *host, u32 opcode)
 {
 	return 0;
 }
@@ -364,10 +362,9 @@ static int dw_mci_get_best_clksmpl(unsigned int sample_flag)
 	return middle_range;
 }
 
-static int dw_mci_hi3660_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
+static int dw_mci_hi3660_execute_tuning(struct dw_mci *host, u32 opcode)
 {
 	int i = 0;
-	struct dw_mci *host = slot->host;
 	struct mmc_host *mmc = host->mmc;
 	int smpl_phase = 0;
 	u32 tuning_sample_flag = 0;
@@ -398,15 +395,13 @@ static int dw_mci_hi3660_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 	return 0;
 }
 
-static int dw_mci_hi3660_switch_voltage(struct mmc_host *mmc,
+static int dw_mci_hi3660_switch_voltage(struct dw_mci *host,
 					struct mmc_ios *ios)
 {
-	int ret = 0;
-	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct k3_priv *priv;
-	struct dw_mci *host;
+	struct mmc_host *mmc = host->mmc;
+	int ret = 0;
 
-	host = slot->host;
 	priv = host->priv;
 
 	if (!priv || !priv->reg)
diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index ffffbf59..743864b 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -282,9 +282,8 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 #define TUNING_ITERATION_TO_PHASE(i, num_phases) \
 		(DIV_ROUND_UP((i) * 360, num_phases))
 
-static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
+static int dw_mci_rk3288_execute_tuning(struct dw_mci *host, u32 opcode)
 {
-	struct dw_mci *host = slot->host;
 	struct dw_mci_rockchip_priv_data *priv = host->priv;
 	struct mmc_host *mmc = host->mmc;
 	int ret = 0;
diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
index d4ea289..11472a6 100644
--- a/drivers/mmc/host/dw_mmc-starfive.c
+++ b/drivers/mmc/host/dw_mmc-starfive.c
@@ -53,11 +53,10 @@ static void dw_mci_starfive_set_sample_phase(struct dw_mci *host, u32 smpl_phase
 	mdelay(1);
 }
 
-static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
+static int dw_mci_starfive_execute_tuning(struct dw_mci *host,
 					     u32 opcode)
 {
 	static const int grade  = MAX_DELAY_CHAIN;
-	struct dw_mci *host = slot->host;
 	int smpl_phase, smpl_raise = -1, smpl_fall = -1;
 	int ret;
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 01327a4..d773bd9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1480,7 +1480,7 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	int ret;
 
 	if (drv_data && drv_data->switch_voltage)
-		return drv_data->switch_voltage(mmc, ios);
+		return drv_data->switch_voltage(host, ios);
 
 	/*
 	 * Program the voltage.  Note that some instances of dw_mmc may use
@@ -1638,7 +1638,7 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	int err = -EINVAL;
 
 	if (drv_data && drv_data->execute_tuning)
-		err = drv_data->execute_tuning(slot, opcode);
+		err = drv_data->execute_tuning(host, opcode);
 	return err;
 }
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index b4efc58..594c8f7 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -604,10 +604,10 @@ struct dw_mci_drv_data {
 	int		(*init)(struct dw_mci *host);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
-	int		(*execute_tuning)(struct dw_mci_slot *slot, u32 opcode);
+	int		(*execute_tuning)(struct dw_mci *host, u32 opcode);
 	int		(*prepare_hs400_tuning)(struct dw_mci *host,
 						struct mmc_ios *ios);
-	int		(*switch_voltage)(struct mmc_host *mmc,
+	int		(*switch_voltage)(struct dw_mci *host,
 					  struct mmc_ios *ios);
 	void		(*set_data_timeout)(struct dw_mci *host,
 					  unsigned int timeout_ns);
-- 
2.7.4


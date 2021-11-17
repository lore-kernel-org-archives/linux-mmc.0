Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2A7C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 22:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0010961B5F
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 22:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbhKQWce (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Nov 2021 17:32:34 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:3206 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241177AbhKQWcc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2021 17:32:32 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AHJXBXR026889;
        Wed, 17 Nov 2021 14:29:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : in-reply-to : references :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=giI1exYjrJ3IknyV2Nvn7DDe0W3B/YMGshXGrcideCU=;
 b=hdXa2V9gT7saSVtrGbAewCXfHEV3Ktrn5I6waWSX2/uqLx/KLtHXasbvfheYKyHfay7e
 3mvfayPR+sniPPQ1UftNbSexF7p7495qLqmTU71vVGrd+Jzfab4m28/2gf1j1iowk57N
 FPDfgNA9RzkxCqSggxzAfafFboaTM53fpvo65mn17/wZ0Zk8eU+yIf5yJBEJzC5bqY0t
 m+ib/gDKsp2hB2ixPsVy7hdfvCdrrFRdU2C2ghUNorM7bNui6wLFp4bhQjbLlppt7fcb
 Btk3TbiX5XHI9xGljhZva3pZE2Zaot80DW16m04RTxhVfDXe527dTEVSgxEmQzcQkwkQ RA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3cd8028mm3-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:29:23 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 17 Nov
 2021 14:28:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 17 Nov 2021 14:28:39 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 03B795B694B;
        Wed, 17 Nov 2021 14:28:38 -0800 (PST)
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <beanhuo@micron.com>,
        <tanxiaofei@huawei.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wbartczak@marvell.com>
Subject: [PATCH 1/2] mmc: cavium: Fix voltage reg. switching for card slots
Date:   Wed, 17 Nov 2021 14:28:00 -0800
Message-ID: <a2df62402ba8e9683100d6099315ef8ac4848a9e.1637186803.git.wbartczak@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <cover.1637186803.git.wbartczak@marvell.com>
References: <cover.1637186803.git.wbartczak@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rXjZm4GoM_tcylM9ByTAENQiqY6vz9mg
X-Proofpoint-GUID: rXjZm4GoM_tcylM9ByTAENQiqY6vz9mg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_08,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Following commit enables usage of vqmmc and vmmc regulators
for devices with multiple voltages.
The MMC block is capable to control up to three devices at the same
time. However, only vmmc regulator has been used in the code.
The change is necessary to support SD and MMC devices
in single system. SD cards uses usually 3.3V regulators,
while faster MMC devices uses lower volatges (1.8V or 1.2V).

The switch operation logic remains unchanged. The sequence
has been rewritten to separate logic, register accesses and
voltage reguators manipulation.

Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
---
 drivers/mmc/host/cavium.c | 168 ++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/cavium.h |   8 +-
 2 files changed, 157 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 95a41983c6c0..35d0ea3e3dd4 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -193,36 +193,166 @@ static int get_bus_id(u64 reg)
 	return FIELD_GET(GENMASK_ULL(61, 60), reg);
 }
 
-/*
- * We never set the switch_exe bit since that would interfere
- * with the commands send by the MMC core.
+/**
+ * pre_switch - Switch voltage regulators
+ * @prev: Current slot, can be NULL
+ * @next: Next slot
+ *
+ * Switch between regulators used by slots. This call has to be done
+ * after call to pre_switch().
  */
-static void do_switch(struct cvm_mmc_host *host, u64 emm_switch)
+static void switch_vqmmc(struct cvm_mmc_slot *prev, struct cvm_mmc_slot *next)
 {
-	int retries = 100;
-	u64 rsp_sts;
-	int bus_id;
+	bool same_vqmmc = false;
+	struct regulator *next_vqmmc;
+	struct regulator *prev_vqmmc;
+
+	next_vqmmc = next->mmc->supply.vqmmc;
+	if (prev) {
+		prev_vqmmc = prev->mmc->supply.vqmmc;
+		/* Prev slot and next slot share vqmmc? */
+		same_vqmmc = prev_vqmmc == next_vqmmc;
+		/* Disable old regulator, if not the same */
+		if (!same_vqmmc && !IS_ERR_OR_NULL(prev_vqmmc))
+			regulator_disable(prev_vqmmc);
+	}
 
-	/*
-	 * Modes setting only taken from slot 0. Work around that hardware
-	 * issue by first switching to slot 0.
-	 */
-	bus_id = get_bus_id(emm_switch);
-	clear_bus_id(&emm_switch);
-	writeq(emm_switch, host->base + MIO_EMM_SWITCH(host));
+	/* Enable regulator for next slot */
+	if (!same_vqmmc && !IS_ERR_OR_NULL(next_vqmmc)) {
+		int ret;
 
-	set_bus_id(&emm_switch, bus_id);
-	writeq(emm_switch, host->base + MIO_EMM_SWITCH(host));
+		ret = regulator_enable(next_vqmmc);
+		if (ret)
+			dev_err(mmc_classdev(next->mmc),
+				"Can't enable vqmmc, error (%d)!\n", ret);
+	}
+}
+
+/**
+ * pre_switch - Start switch operation between slots
+ * @prev: Current slot, can be NULL
+ * @next: Next slot
+ *
+ * MMC block for octeontx2 shares data lines among the three card slots.
+ * To avoid transient states on DAT[0..7] and CLK lines set
+ * CMDn to tri-state when VQMMC is switched.
+ */
+static void pre_switch(struct cvm_mmc_slot *prev, struct cvm_mmc_slot *next)
+{
+	struct cvm_mmc_host *host; /* Common block for all slots */
+
+	host = next->host;
+	if (host->use_vqmmc)
+		/* Disable clock and data lines on all slots */
+		writeq(1ull << 3, host->base + MIO_EMM_CFG(host));
+
+	if (prev) {
+		/* Store current slot settings */
+		prev->cached_switch = readq(host->base + MIO_EMM_SWITCH(host));
+		prev->cached_rca = readq(host->base + MIO_EMM_RCA(host));
+	}
+}
+
+/**
+ * post_switch - Finish switch operation
+ * @prev: Current slot
+ * @next: Next slot
+ *
+ * Function finishes switch operation by enabling selcted slot
+ * and recovering its settigs.
+ */
+static void post_switch(struct cvm_mmc_slot *prev, struct cvm_mmc_slot *next)
+{
+	struct cvm_mmc_host *host; /* Common block for all slots */
+
+	host = next->host;
+	if (host->use_vqmmc)
+		/* Enable clock and data lines for current slot */
+		writeq(1ull << next->bus_id, host->base + MIO_EMM_CFG(host));
+
+	/* Read back values set during switch */
+	next->cached_switch = readq(host->base + MIO_EMM_SWITCH(host));
+	/* Set RCA value */
+	writeq(next->cached_rca, host->base + MIO_EMM_RCA(host));
+}
 
-	/* wait for the switch to finish */
+/**
+ * mode_switch - Performs low level switch operation
+ * @host: Common hardware block for all slots
+ * @emm_switch: register value to use for the operation
+ *
+ * Function finishes switch operation by enabling selcted slot
+ * and recovering its settigs.
+ */
+static inline void mode_switch(struct cvm_mmc_host *host, u64 emm_switch)
+{
+	unsigned int retries = MODE_SWITCH_RETRIES;
+	u64 rsp_sts;
+
+	writeq(emm_switch, host->base + MIO_EMM_SWITCH(host));
+	/* Wait for switch completion */
 	do {
 		rsp_sts = readq(host->base + MIO_EMM_RSP_STS(host));
 		if (!(rsp_sts & MIO_EMM_RSP_STS_SWITCH_VAL))
 			break;
 		udelay(10);
 	} while (--retries);
+}
+
+/**
+ * do_switch - Performs switch operation
+ * @host: Common hardware block for all slots
+ * @emm_switch: register value to use for the operation
+ *
+ * Function performs switch operation between slost on hardware level.
+ * It is also called when the same slot changes mode, class or bus width.
+ * Switch requires sometimes to change current slot, store some of the slot
+ * information. Additionally, the volatge regulator for a card has to be
+ * switched too. Function uses use_vqmmc quirk for hardware.
+ * The quirk is related to errata that requires to go over slot 0
+ * for all switch operations, otherwise no parameters are accepted.
+ */
+static void do_switch(struct cvm_mmc_host *host, u64 emm_switch)
+{
+	struct cvm_mmc_slot *next, *prev;
+	int bus_id;
+	bool slot_changed;
+
+	/* Initially previous slot is not set */
+	prev = NULL;
+	/* Read back bus id and get slot. Check does bus_id != last_slot */
+	bus_id = FIELD_GET(MIO_EMM_SWITCH_BUS_ID, emm_switch);
+	next = host->slot[bus_id];
+	slot_changed = host->last_slot != bus_id;
+	if (host->last_slot != -1)
+		prev = host->slot[host->last_slot];
+
+	/* Prepare to slot switch, switch voltage regulators */
+	if (slot_changed) {
+		pre_switch(prev, next);
+		switch_vqmmc(prev, next);
+	}
 
+	/*
+	 * Modes setting only taken from slot 0. Work around that hardware
+	 * issue by first switching to slot 0.
+	 */
+	if (bus_id) {
+		u64 emm_switch0;
+		/* Clear bus_id and switch through bus_id 0 */
+		emm_switch0 = emm_switch & (~MIO_EMM_SWITCH_BUS_ID);
+		mode_switch(host, emm_switch0);
+	}
+
+	/* Switch with target bus_id */
+	mode_switch(host, emm_switch);
 	check_switch_errors(host);
+
+	if (slot_changed)
+		post_switch(prev, next);
+
+	/* Set current slot id */
+	host->last_slot = bus_id;
 }
 
 static bool switch_val_changed(struct cvm_mmc_slot *slot, u64 new_val)
@@ -972,7 +1102,7 @@ static int cvm_mmc_of_parse(struct device *dev, struct cvm_mmc_slot *slot)
 	 * Legacy Octeon firmware has no regulator entry, fall-back to
 	 * a hard-coded voltage to get a sane OCR.
 	 */
-	if (IS_ERR(mmc->supply.vmmc))
+	if (IS_ERR_OR_NULL(mmc->supply.vmmc))
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
 	/* Common MMC bindings */
@@ -1058,6 +1188,8 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 
 	host->acquire_bus(host);
 	host->slot[id] = slot;
+	host->use_vqmmc = host->use_vqmmc ||
+			  !IS_ERR_OR_NULL(slot->mmc->supply.vqmmc);
 	cvm_mmc_switch_to(slot);
 	cvm_mmc_init_lowlevel(slot);
 	host->release_bus(host);
diff --git a/drivers/mmc/host/cavium.h b/drivers/mmc/host/cavium.h
index f3eea5eaa678..a581e0462c7e 100644
--- a/drivers/mmc/host/cavium.h
+++ b/drivers/mmc/host/cavium.h
@@ -56,6 +56,7 @@ struct cvm_mmc_host {
 	struct device *dev;
 	void __iomem *base;
 	void __iomem *dma_base;
+
 	int reg_off;
 	int reg_off_dma;
 	u64 emm_cfg;
@@ -70,6 +71,7 @@ struct cvm_mmc_host {
 	bool use_sg;
 
 	bool has_ciu3;
+	bool use_vqmmc;  /* Force disable slot over switch */
 	bool big_dma_addr;
 	bool need_irq_handler_lock;
 	spinlock_t irq_handler_lock;
@@ -206,10 +208,14 @@ struct cvm_mmc_cr_mods {
 #define MIO_EMM_SWITCH_CLK_HI		GENMASK_ULL(31, 16)
 #define MIO_EMM_SWITCH_CLK_LO		GENMASK_ULL(15, 0)
 
+/* Additional defines */
+#define MODE_SWITCH_RETRIES	100
+
 /* Protoypes */
 irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id);
 int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host);
 int cvm_mmc_of_slot_remove(struct cvm_mmc_slot *slot);
 extern const char *cvm_mmc_irq_names[];
 
-#endif
+#endif /* _CAVIUM_MMC_H_ */
+
-- 
2.17.1


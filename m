From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH 4/5] sdhci: dump vendor state and regs
Date: Tue, 22 Nov 2016 17:09:47 -0800
Message-ID: <1479863388-23678-5-git-send-email-jeremymc@redhat.com>
References: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751506AbcKWBSm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Nov 2016 20:18:42 -0500
In-Reply-To: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, jeremymc@redhat.com

This has proven very useful in debugging SDHCI RPM interaction
issues.

Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---
 drivers/mmc/host/sdhci-msm.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     | 25 ++++++++++++++
 drivers/mmc/host/sdhci.h     |  1 +
 3 files changed, 105 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index ee01d95..1fcda96 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -678,6 +678,84 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	return ret;
 }
 
+
+
+#define MAX_TEST_BUS				20
+#define CORE_MCI_DATA_CNT			0x30
+#define CORE_MCI_FIFO_CNT			0x44
+#define CORE_MCI_STATUS				0x34
+#define CORE_VENDOR_SPEC_ADMA_ERR_ADDR0		0x114
+#define CORE_VENDOR_SPEC_ADMA_ERR_ADDR1		0x118
+#define CORE_TESTBUS_SEL2_BIT			4
+#define CORE_TESTBUS_SEL2			(1 << CORE_TESTBUS_SEL2_BIT)
+
+#define CORE_TESTBUS_ENA			(1 << 3)
+
+#define CORE_TESTBUS_CONFIG			0x0CC
+
+#define CORE_SDCC_DEBUG_REG			0x124
+
+void sdhci_msm_dump_vendor_regs(struct sdhci_host *host)
+{
+
+	int tbsel, tbsel2;
+	int i, index = 0;
+	u32 test_bus_val = 0;
+	u32 debug_reg[MAX_TEST_BUS] = {0};
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_msm_host *msm_host;
+
+	pltfm_host = sdhci_priv(host);
+	msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	pr_info("----------- VENDOR REGISTER DUMP -----------\n");
+	pr_info("Data cnt: 0x%08x | Fifo cnt: 0x%08x | Int sts: 0x%08x\n",
+		readl_relaxed(msm_host->core_mem + CORE_MCI_DATA_CNT),
+		readl_relaxed(msm_host->core_mem + CORE_MCI_FIFO_CNT),
+		readl_relaxed(msm_host->core_mem + CORE_MCI_STATUS));
+	pr_info("DLL cfg:  0x%08x | DLL sts:  0x%08x | SDCC ver: 0x%08x\n",
+		readl_relaxed(host->ioaddr + CORE_DLL_CONFIG),
+		readl_relaxed(host->ioaddr + CORE_DLL_STATUS),
+		readl_relaxed(msm_host->core_mem + CORE_MCI_VERSION));
+	pr_info("Vndr func: 0x%08x | Vndr adma err : addr0: 0x%08x addr1: 0x%08x\n",
+		readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC),
+		readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC_ADMA_ERR_ADDR0),
+		readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC_ADMA_ERR_ADDR1));
+
+	/*
+	 * tbsel indicates [2:0] bits and tbsel2 indicates [7:4] bits
+	 * of CORE_TESTBUS_CONFIG register.
+	 *
+	 * To select test bus 0 to 7 use tbsel and to select any test bus
+	 * above 7 use (tbsel2 | tbsel) to get the test bus number. For eg,
+	 * to select test bus 14, write 0x1E to CORE_TESTBUS_CONFIG register
+	 * i.e., tbsel2[7:4] = 0001, tbsel[2:0] = 110.
+	 */
+	for (tbsel2 = 0; tbsel2 < 3; tbsel2++) {
+		for (tbsel = 0; tbsel < 8; tbsel++) {
+			if (index >= MAX_TEST_BUS)
+				break;
+			test_bus_val = (tbsel2 << CORE_TESTBUS_SEL2_BIT) |
+				tbsel | CORE_TESTBUS_ENA;
+			writel_relaxed(test_bus_val,
+				msm_host->core_mem + CORE_TESTBUS_CONFIG);
+			debug_reg[index++] = readl_relaxed(msm_host->core_mem +
+				CORE_SDCC_DEBUG_REG);
+		}
+	}
+
+	for (i = 0; i < MAX_TEST_BUS; i = i + 4)
+		pr_info(" Test bus[%d to %d]: 0x%08x 0x%08x 0x%08x 0x%08x\n",
+			i, i + 3, debug_reg[i], debug_reg[i+1],
+			debug_reg[i+2], debug_reg[i+3]);
+			/* Disable test bus */
+		writel_relaxed(~CORE_TESTBUS_ENA, msm_host->core_mem +
+			CORE_TESTBUS_CONFIG);
+}
+
+
+
+
 static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int tuning_seq_cnt = 3;
@@ -1081,6 +1159,7 @@ static const struct sdhci_ops sdhci_msm_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
 	.voltage_switch = sdhci_msm_voltage_switch,
+	.dump_vendor_regs = sdhci_msm_dump_vendor_regs,
 };
 
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 71654b9..5911f98 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -47,6 +47,27 @@ static void sdhci_finish_data(struct sdhci_host *);
 
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 
+static void sdhci_dump_rpm_info(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	pr_info("%s: rpmstatus[pltfm](runtime-suspend:usage_count:disable_depth)(%d:%d:%d)\n",
+		mmc_hostname(mmc), mmc->parent->power.runtime_status,
+		atomic_read(&mmc->parent->power.usage_count),
+		mmc->parent->power.disable_depth);
+}
+
+
+static void sdhci_dump_state(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	pr_info("%s: clk: %d claimer: %s pwr: %d\n",
+		mmc_hostname(mmc), host->clock,
+		mmc->claimer->comm, host->pwr);
+		sdhci_dump_rpm_info(host);
+}
+
 static void sdhci_dumpregs(struct sdhci_host *host)
 {
 	pr_err(DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
@@ -100,6 +121,10 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 			       readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
 	}
 
+	if (host->ops->dump_vendor_regs)
+		host->ops->dump_vendor_regs(host);
+
+	sdhci_dump_state(host);
 	pr_err(DRIVER_NAME ": ===========================================\n");
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 766df17..c055e24 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -563,6 +563,7 @@ struct sdhci_ops {
 					 struct mmc_card *card,
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
+	void    (*dump_vendor_regs)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.6.1


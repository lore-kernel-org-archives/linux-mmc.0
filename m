From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 6/8] mmc: sdhci-msm: Add pwr_irq support to sdhci-msm
Date: Wed, 29 Jun 2016 16:50:31 +0530
Message-ID: <1467199233-20506-7-git-send-email-riteshh@codeaurora.org>
References: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Asutosh Das <asutoshd@codeaurora.org>

MSM SDHCI doesn't control power as specified by the Standard
Host Controller 3.0 spec. Writing to power control register/
reset register/voltage bit of host control register would
trigger an IRQ with appropriate status bits set.

This adds the pwr_irq functionality to sdhci-msm.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 217 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4964eda..8badcf8 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -33,6 +33,23 @@
 #define CORE_POWER		0x0
 #define CORE_SW_RST		BIT(7)
 
+#define CORE_PWRCTL_STATUS	0xdc
+#define CORE_PWRCTL_MASK	0xe0
+#define CORE_PWRCTL_CLEAR	0xe4
+#define CORE_PWRCTL_CTL		0xe8
+
+#define CORE_PWRCTL_BUS_OFF	0x01
+#define CORE_PWRCTL_BUS_ON	BIT(1)
+#define CORE_PWRCTL_IO_LOW	BIT(2)
+#define CORE_PWRCTL_IO_HIGH	BIT(3)
+
+#define CORE_PWRCTL_BUS_SUCCESS	0x01
+#define CORE_PWRCTL_BUS_FAIL	BIT(1)
+#define CORE_PWRCTL_IO_SUCCESS	BIT(2)
+#define CORE_PWRCTL_IO_FAIL	BIT(3)
+
+#define INT_MASK		0xf
+
 #define MAX_PHASES		16
 #define CORE_DLL_LOCK		BIT(7)
 #define CORE_DLL_EN		BIT(16)
@@ -47,6 +64,7 @@
 #define CORE_VENDOR_SPEC	0x10c
 #define CORE_CLK_PWRSAVE	BIT(1)
 #define CORE_VENDOR_SPEC_POR_VAL	0xa1c
+#define CORE_IO_PAD_PWR_SWITCH	BIT(16)
 
 #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
@@ -88,6 +106,18 @@ struct sdhci_msm_pltfm_data {
 	struct sdhci_msm_slot_reg_data *vreg_data;
 };
 
+enum vdd_io_level {
+	/* set vdd_io_data->low_vol_level */
+	VDD_IO_LOW,
+	/* set vdd_io_data->high_vol_level */
+	VDD_IO_HIGH,
+	/*
+	 * set whatever there in voltage_level (third argument) of
+	 * sdhci_msm_set_vdd_io_vol() function.
+	 */
+	VDD_IO_SET_LEVEL,
+};
+
 struct sdhci_msm_host {
 	struct platform_device *pdev;
 	void __iomem *core_mem;	/* MSM SDCC mapped address */
@@ -96,6 +126,9 @@ struct sdhci_msm_host {
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	struct mmc_host *mmc;
 	struct sdhci_msm_pltfm_data *pdata;
+	int pwr_irq;
+	u32 curr_pwr_state;
+	u32 curr_io_level;
 };
 
 #define MAX_PROP_SIZE 32
@@ -426,6 +459,150 @@ out:
 	return ret;
 }
 
+
+static int sdhci_msm_set_vdd_io_vol(struct sdhci_msm_pltfm_data *pdata,
+			enum vdd_io_level level,
+			unsigned int voltage_level)
+{
+	int ret = 0;
+	int set_level;
+	struct sdhci_msm_reg_data *vdd_io_reg;
+
+	if (!pdata->vreg_data)
+		return ret;
+
+	vdd_io_reg = pdata->vreg_data->vdd_io_data;
+	if (vdd_io_reg && vdd_io_reg->is_enabled) {
+		switch (level) {
+		case VDD_IO_LOW:
+			set_level = vdd_io_reg->low_vol_level;
+			break;
+		case VDD_IO_HIGH:
+			set_level = vdd_io_reg->high_vol_level;
+			break;
+		case VDD_IO_SET_LEVEL:
+			set_level = voltage_level;
+			break;
+		default:
+			pr_err("%s: invalid argument level = %d",
+					__func__, level);
+			ret = -EINVAL;
+			return ret;
+		}
+		ret = sdhci_msm_vreg_set_voltage(vdd_io_reg, set_level,
+				set_level);
+	}
+	return ret;
+}
+
+static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
+{
+	struct sdhci_host *host = (struct sdhci_host *)data;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	u8 irq_status = 0;
+	u8 irq_ack = 0;
+	int ret = 0;
+	int pwr_state = 0, io_level = 0;
+	unsigned long flags;
+
+	irq_status = readb_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
+	pr_debug("%s: Received IRQ(%d), status=0x%x\n",
+		mmc_hostname(msm_host->mmc), irq, irq_status);
+
+	/* Clear the interrupt */
+	writeb_relaxed(irq_status, (msm_host->core_mem + CORE_PWRCTL_CLEAR));
+	/*
+	 * SDHC has core_mem and hc_mem device memory and these memory
+	 * addresses do not fall within 1KB region. Hence, any update to
+	 * core_mem address space would require an mb() to ensure this gets
+	 * completed before its next update to registers within hc_mem.
+	 */
+	mb();
+
+	/* Handle BUS ON/OFF*/
+	if (irq_status & CORE_PWRCTL_BUS_ON) {
+		ret = sdhci_msm_setup_vreg(msm_host->pdata, true, false);
+		if (!ret) {
+			ret = sdhci_msm_set_vdd_io_vol(msm_host->pdata,
+					VDD_IO_HIGH, 0);
+		}
+		if (ret)
+			irq_ack |= CORE_PWRCTL_BUS_FAIL;
+		else
+			irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+
+		pwr_state = REQ_BUS_ON;
+		io_level = REQ_IO_HIGH;
+	}
+	if (irq_status & CORE_PWRCTL_BUS_OFF) {
+		ret = sdhci_msm_setup_vreg(msm_host->pdata, false, false);
+		if (!ret) {
+			ret = sdhci_msm_set_vdd_io_vol(msm_host->pdata,
+					VDD_IO_LOW, 0);
+		}
+		if (ret)
+			irq_ack |= CORE_PWRCTL_BUS_FAIL;
+		else
+			irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+
+		pwr_state = REQ_BUS_OFF;
+		io_level = REQ_IO_LOW;
+	}
+	/* Handle IO LOW/HIGH */
+	if (irq_status & CORE_PWRCTL_IO_LOW) {
+		/* Switch voltage Low */
+		ret = sdhci_msm_set_vdd_io_vol(msm_host->pdata, VDD_IO_LOW, 0);
+		if (ret)
+			irq_ack |= CORE_PWRCTL_IO_FAIL;
+		else
+			irq_ack |= CORE_PWRCTL_IO_SUCCESS;
+
+		io_level = REQ_IO_LOW;
+	}
+	if (irq_status & CORE_PWRCTL_IO_HIGH) {
+		/* Switch voltage High */
+		ret = sdhci_msm_set_vdd_io_vol(msm_host->pdata, VDD_IO_HIGH, 0);
+		if (ret)
+			irq_ack |= CORE_PWRCTL_IO_FAIL;
+		else
+			irq_ack |= CORE_PWRCTL_IO_SUCCESS;
+
+		io_level = REQ_IO_HIGH;
+	}
+
+	/* ACK status to the core */
+	writeb_relaxed(irq_ack, (msm_host->core_mem + CORE_PWRCTL_CTL));
+	/*
+	 * SDHC has core_mem and hc_mem device memory and these memory
+	 * addresses do not fall within 1KB region. Hence, any update to
+	 * core_mem address space would require an mb() to ensure this gets
+	 * completed before its next update to registers within hc_mem.
+	 */
+	mb();
+
+	if (io_level & REQ_IO_HIGH)
+		writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC) &
+				~CORE_IO_PAD_PWR_SWITCH),
+				host->ioaddr + CORE_VENDOR_SPEC);
+	else if (io_level & REQ_IO_LOW)
+		writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC) |
+				CORE_IO_PAD_PWR_SWITCH),
+				host->ioaddr + CORE_VENDOR_SPEC);
+
+	/* Ensure before completion that above writes are propagated */
+	mb();
+
+	pr_debug("%s: Handled IRQ(%d), ret=%d, ack=0x%x\n",
+		mmc_hostname(msm_host->mmc), irq, ret, irq_ack);
+	if (pwr_state)
+		msm_host->curr_pwr_state = pwr_state;
+	if (io_level)
+		msm_host->curr_io_level = io_level;
+
+	return IRQ_HANDLED;
+}
+
 /* Platform specific tuning */
 static inline int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
 {
@@ -801,6 +978,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_msm_host *msm_host;
 	struct resource *core_memres;
+	u32 irq_status, irq_ctl;
 	int ret;
 	u16 host_version, core_minor;
 	u32 core_version, caps;
@@ -917,6 +1095,45 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 			       CORE_VENDOR_SPEC_CAPABILITIES0);
 	}
 
+	/*
+	 * POR reset of VENDOR_SPEC/CORE_SW_RST above may trigger power irq
+	 * if previous status of PWRCTL was either BUS_ON or IO_HIGH_V.
+	 * So before we enable the power irq interrupt in GIC
+	 * (by registering the interrupt handler), we need to
+	 * ensure that any pending power irq interrupt status is acknowledged
+	 * otherwise power irq interrupt handler would be fired prematurely.
+	 */
+	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
+	writel_relaxed(irq_status, (msm_host->core_mem + CORE_PWRCTL_CLEAR));
+	irq_ctl = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_CTL);
+	if (irq_status & (CORE_PWRCTL_BUS_ON | CORE_PWRCTL_BUS_OFF))
+		irq_ctl |= CORE_PWRCTL_BUS_SUCCESS;
+	if (irq_status & (CORE_PWRCTL_IO_HIGH | CORE_PWRCTL_IO_LOW))
+		irq_ctl |= CORE_PWRCTL_IO_SUCCESS;
+	writel_relaxed(irq_ctl, (msm_host->core_mem + CORE_PWRCTL_CTL));
+
+	/*
+	 * Ensure that above writes are propogated before interrupt enablement
+	 * in GIC.
+	 */
+	mb();
+
+	/* Setup PWRCTL irq */
+	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
+	if (msm_host->pwr_irq < 0) {
+		dev_err(&pdev->dev, "Failed to get pwr_irq by name (%d)\n",
+				msm_host->pwr_irq);
+		goto vreg_deinit;
+	}
+	ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
+					sdhci_msm_pwr_irq, IRQF_ONESHOT,
+					dev_name(&pdev->dev), host);
+	if (ret) {
+		dev_err(&pdev->dev, "Request threaded irq(%d) failed (%d)\n",
+				msm_host->pwr_irq, ret);
+		goto vreg_deinit;
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto vreg_deinit;
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

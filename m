From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] mmc: sdhci-msm: Add support for UHS cards
Date: Fri, 24 Jun 2016 18:07:14 +0300
Message-ID: <1466780834-1041-1-git-send-email-georgi.djakov@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-mmc@vger.kernel.org

Enabling support for ultra high speed mode cards requires some
voltage switching and interaction with the PMIC via a special
power IRQ. Add support for this.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c |   66 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 0653fe730150..ac5700233e12 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -32,6 +32,21 @@
 #define CORE_POWER		0x0
 #define CORE_SW_RST		BIT(7)
 
+#define CORE_PWRCTL_STATUS	0xdc
+#define CORE_PWRCTL_MASK	0xe0
+#define CORE_PWRCTL_CLEAR	0xe4
+#define CORE_PWRCTL_CTL		0xe8
+#define CORE_PWRCTL_BUS_OFF	BIT(0)
+#define CORE_PWRCTL_BUS_ON	BIT(1)
+#define CORE_PWRCTL_IO_LOW	BIT(2)
+#define CORE_PWRCTL_IO_HIGH	BIT(3)
+#define CORE_PWRCTL_BUS_SUCCESS BIT(0)
+#define CORE_PWRCTL_IO_SUCCESS	BIT(2)
+#define REQ_BUS_OFF		BIT(0)
+#define REQ_BUS_ON		BIT(1)
+#define REQ_IO_LOW		BIT(2)
+#define REQ_IO_HIGH		BIT(3)
+#define INT_MASK		0xf
 #define MAX_PHASES		16
 #define CORE_DLL_LOCK		BIT(7)
 #define CORE_DLL_EN		BIT(16)
@@ -56,6 +71,7 @@
 struct sdhci_msm_host {
 	struct platform_device *pdev;
 	void __iomem *core_mem;	/* MSM SDCC mapped address */
+	int pwr_irq;		/* power irq */
 	struct clk *clk;	/* main SD/MMC bus clock */
 	struct clk *pclk;	/* SDHC peripheral bus clock */
 	struct clk *bus_clk;	/* SDHC bus voter clock */
@@ -410,6 +426,39 @@ retry:
 	return rc;
 }
 
+static void sdhci_msm_voltage_switch(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	u32 irq_status, irq_ack = 0;
+
+	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
+	irq_status &= INT_MASK;
+
+	writel_relaxed(irq_status, msm_host->core_mem + CORE_PWRCTL_CLEAR);
+
+	if (irq_status & (CORE_PWRCTL_BUS_ON | CORE_PWRCTL_BUS_OFF))
+		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+	if (irq_status & (CORE_PWRCTL_IO_LOW | CORE_PWRCTL_IO_HIGH))
+		irq_ack |= CORE_PWRCTL_IO_SUCCESS;
+
+	/*
+	 * The driver has to acknowledge the interrupt, switch voltages and
+	 * report back if it succeded or not to this register. The voltage
+	 * switches are handled by the sdhci core, so just report success.
+	 */
+	writel_relaxed(irq_ack, msm_host->core_mem + CORE_PWRCTL_CTL);
+}
+
+static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
+{
+	struct sdhci_host *host = (struct sdhci_host *)data;
+
+	sdhci_msm_voltage_switch(host);
+
+	return IRQ_HANDLED;
+}
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{},
@@ -423,6 +472,7 @@ static const struct sdhci_ops sdhci_msm_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.voltage_switch = sdhci_msm_voltage_switch,
 };
 
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
@@ -545,6 +595,22 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 			       CORE_VENDOR_SPEC_CAPABILITIES0);
 	}
 
+	/* Setup IRQ for handling power/voltage tasks with PMIC */
+	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
+	if (msm_host->pwr_irq < 0) {
+		dev_err(&pdev->dev, "Get pwr_irq failed (%d)\n",
+			msm_host->pwr_irq);
+		goto clk_disable;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
+					sdhci_msm_pwr_irq, IRQF_ONESHOT,
+					dev_name(&pdev->dev), host);
+	if (ret) {
+		dev_err(&pdev->dev, "Request IRQ failed (%d)\n", ret);
+		goto clk_disable;
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto clk_disable;

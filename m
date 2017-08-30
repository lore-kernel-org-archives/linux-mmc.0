From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH v1 1/5] mmc: sdhci-msm: fix issue with power irq
Date: Wed, 30 Aug 2017 18:21:45 +0530
Message-ID: <1504097509-58983-2-git-send-email-vviswana@codeaurora.org>
References: <1504097509-58983-1-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1504097509-58983-1-git-send-email-vviswana@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: riteshh@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Vijay Viswanath <vviswana@codeaurora.org>, stummala@codeaurora.org, subhashj@codeaurora.org, linux-arm-kernel@lists.infradead.org, asutoshd@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

SDCC controller reset (SW_RST) during probe may trigger power irq if
previous status of PWRCTL was either BUS_ON or IO_HIGH_V. So before we
enable the power irq interrupt in GIC (by registering the interrupt
handler), we need to ensure that any pending power irq interrupt status
is acknowledged otherwise power irq interrupt handler would be fired
prematurely.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 9d601dc..d636251 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1250,6 +1250,21 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 			       CORE_VENDOR_SPEC_CAPABILITIES0);
 	}
 
+	/*
+	 * Power on reset state may trigger power irq if previous status of
+	 * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
+	 * interrupt in GIC, any pending power irq interrupt should be
+	 * acknowledged. Otherwise power irq interrupt handler would be
+	 * fired prematurely.
+	 */
+	sdhci_msm_voltage_switch(host);
+
+	/*
+	 * Ensure that above writes are propogated before interrupt enablement
+	 * in GIC.
+	 */
+	mb();
+
 	/* Setup IRQ for handling power/voltage tasks with PMIC */
 	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
 	if (msm_host->pwr_irq < 0) {
@@ -1259,6 +1274,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	/* Enable pwr irq interrupts */
+	writel_relaxed(INT_MASK, msm_host->core_mem + CORE_PWRCTL_MASK);
+
 	ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
 					sdhci_msm_pwr_irq, IRQF_ONESHOT,
 					dev_name(&pdev->dev), host);
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

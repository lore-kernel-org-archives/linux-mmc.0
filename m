From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 2/2] mmc: sdhci-msm: Enable delay circuit calibration clocks
Date: Fri, 15 Sep 2017 16:35:24 -0700
Message-ID: <20170915233524.1375-3-bjorn.andersson@linaro.org>
References: <20170915233524.1375-1-bjorn.andersson@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170915233524.1375-1-bjorn.andersson@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The delay circuit used to support HS400 is calibrated based on two
additional clocks. When these clocks are not available and
FF_CLK_SW_RST_DIS is not set in CORE_HC_MODE, reset might fail. But on
some platforms this doesn't work properly and below dump can be seen in
the kernel log.

  mmc0: Reset 0x1 never completed.
  mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
  mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00001102
  mmc0: sdhci: Blk size:  0x00004000 | Blk cnt:  0x00000000
  mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
  mmc0: sdhci: Present:   0x01f80000 | Host ctl: 0x00000000
  mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
  mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000002
  mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
  mmc0: sdhci: Int enab:  0x00000000 | Sig enab: 0x00000000
  mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
  mmc0: sdhci: Caps:      0x742dc8b2 | Caps_1:   0x00008007
  mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
  mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
  mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
  mmc0: sdhci: Host ctl2: 0x00000000
  mmc0: sdhci: ============================================

Add support for the additional calibration clocks to allow these
platforms to be configured appropriately.

Cc: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Cc: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Add new clocks to DT binding

 Documentation/devicetree/bindings/mmc/sdhci-msm.txt |  2 ++
 drivers/mmc/host/sdhci-msm.c                        | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 0576264eab5e..5d9c3cd1bdaa 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -18,6 +18,8 @@ Required properties:
 	"core"	- SDC MMC clock (MCLK) (required)
 	"bus"	- SDCC bus voter clock (optional)
 	"xo"	- TCXO clock (optional)
+	"cal"	- reference clock for RCLK delay calibration (optional)
+	"sleep"	- sleep clock for RCLK delay calibration (optional)
 
 Example:
 
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b9ca1b1ef9a8..ea330e8169dc 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -129,7 +129,7 @@ struct sdhci_msm_host {
 	int pwr_irq;		/* power irq */
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
-	struct clk_bulk_data bulk_clks[2]; /* core, iface clocks */
+	struct clk_bulk_data bulk_clks[4]; /* core, iface, cal, sleep clocks */
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
 	bool use_14lpp_dll_reset;
@@ -1183,6 +1183,16 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(&pdev->dev, "core clock boost failed\n");
 
+	clk = devm_clk_get(&pdev->dev, "cal");
+	if (IS_ERR(clk))
+		clk = NULL;
+	msm_host->bulk_clks[2].clk = clk;
+
+	clk = devm_clk_get(&pdev->dev, "sleep");
+	if (IS_ERR(clk))
+		clk = NULL;
+	msm_host->bulk_clks[3].clk = clk;
+
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
 				      msm_host->bulk_clks);
 	if (ret)
-- 
2.12.0

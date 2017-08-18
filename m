From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 2/2] mmc: sdhci-msm: Enable delay circuit calibration clocks
Date: Fri, 18 Aug 2017 10:55:06 -0700
Message-ID: <20170818175506.5035-3-bjorn.andersson@linaro.org>
References: <20170818175506.5035-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818175506.5035-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>
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
 drivers/mmc/host/sdhci-msm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 71e01cbc38b6..7b47906ba447 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -131,7 +131,7 @@ struct sdhci_msm_host {
 	struct clk *pclk;	/* SDHC peripheral bus clock */
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
-	struct clk_bulk_data bulk_clks[2];
+	struct clk_bulk_data bulk_clks[4];
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
 	bool use_14lpp_dll_reset;
@@ -1125,6 +1125,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_msm_host *msm_host;
 	struct resource *core_memres;
+	struct clk *clk;
 	int ret;
 	u16 host_version, core_minor;
 	u32 core_version, config;
@@ -1194,6 +1195,14 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	msm_host->bulk_clks[0].clk = msm_host->clk;
 	msm_host->bulk_clks[1].clk = msm_host->pclk;
 
+	clk = devm_clk_get(&pdev->dev, "cal");
+	if (!IS_ERR(clk))
+		msm_host->bulk_clks[2].clk = clk;
+
+	clk = devm_clk_get(&pdev->dev, "sleep");
+	if (!IS_ERR(clk))
+		msm_host->bulk_clks[3].clk = clk;
+
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
 				      msm_host->bulk_clks);
 	if (ret)
-- 
2.12.0

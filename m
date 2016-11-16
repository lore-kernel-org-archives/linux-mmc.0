From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v8 05/16] dt-bindings: sdhci-msm: Add xo_clock property
Date: Wed, 16 Nov 2016 21:30:41 +0530
Message-ID: <1479312052-22396-6-git-send-email-riteshh@codeaurora.org>
References: <1479312052-22396-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1479312052-22396-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 485483a..243c9f0 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -17,6 +17,7 @@ Required properties:
 	"iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
 	"core"	- SDC MMC clock (MCLK) (required)
 	"bus"	- SDCC bus voter clock (optional)
+	"xo_clock" - TCXO clock (optional)
 
 Example:
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.


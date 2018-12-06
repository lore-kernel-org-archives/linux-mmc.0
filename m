From: Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 1/3] dt-bindings: mmc: sdhci-msm: Clarify register requirements
Date: Thu,  6 Dec 2018 10:45:20 -0800
Message-ID: <20181206184522.118062-2-evgreen@chromium.org>
References: <20181206184522.118062-1-evgreen@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206184522.118062-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>, Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

In sdhci-msm-v5 and beyond, the MCI registers are removed, so there is only
one register region required.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2: None

 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index b72871ac90cb2..da4edb146a983 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -25,7 +25,7 @@ Required properties:
 
 - reg: Base address and length of the register in the following order:
 	- Host controller register map (required)
-	- SD Core register map (required)
+	- SD Core register map (required for msm-v4 and below)
 - interrupts: Should contain an interrupt-specifiers for the interrupts:
 	- Host controller interrupt (required)
 - pinctrl-names: Should contain only one value - "default".
-- 
2.18.1

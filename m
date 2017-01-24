From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH V3 1/6] dt-bindings: qcom: clk: Add missing binding for SDCHI enablement on Nexus 5X/6P
Date: Tue, 24 Jan 2017 01:36:23 -0800
Message-ID: <1485250588-24698-2-git-send-email-jeremymc@redhat.com>
References: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org

AHB clock branch is needed in order to enable SDHCI
on msm899(2/4).

Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---
 include/dt-bindings/clock/qcom,gcc-msm8994.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-msm8994.h b/include/dt-bindings/clock/qcom,gcc-msm8994.h
index 8fa535b..df47da0 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8994.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8994.h
@@ -133,5 +133,6 @@
 #define GCC_USB30_MOCK_UTMI_CLK			115
 #define GCC_USB3_PHY_AUX_CLK			116
 #define GCC_USB_HS_SYSTEM_CLK			117
+#define GCC_SDCC1_AHB_CLK			118
 
 #endif
-- 
2.6.1

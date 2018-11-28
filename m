From: Evan Green <evgreen@chromium.org>
Subject: [PATCH v1 0/3] arm64: dts: qcom: sdm845: Add SD nodes
Date: Wed, 28 Nov 2018 14:34:25 -0800
Message-ID: <20181128223428.177313-1-evgreen@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>, Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This series adds the nodes for the SD host controller on SDM845, and wires it
up on the MTP.

Though I tested similar changes on another board, I was unable to actually run
this on an MTP. If someone felt like trying this out on an MTP I would be
grateful.

The original downstream nodes had sleep pinctrl states. It's not obvious to
me that all this messing with drive-strength saves non-negligible amounts of
power, so I didn't add them and figured we could add them later if needed.


Evan Green (3):
  dt-bindings: mmc: sdhci-msm: Clarify register requirements
  arm64: dts: qcom: sdm845: Add SD nodes
  arm64: dts: qcom: sdm845: Add SD nodes for sdm845-mtp

 .../devicetree/bindings/mmc/sdhci-msm.txt     |  2 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       | 53 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 15 ++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

-- 
2.18.1

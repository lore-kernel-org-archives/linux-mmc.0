From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH V4 0/6] Enable onboard SDHCI for Nexus 5X (msm8992)
Date: Fri, 27 Jan 2017 01:09:59 -0800
Message-ID: <1485508205-1904-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754536AbdA0JKP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 27 Jan 2017 04:10:15 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com, jeremymc@redhat.com

Here links to previous versions:

[V1]
   https://www.spinics.net/lists/devicetree/msg151845.html

[V2]
  http://www.spinics.net/lists/devicetree/msg158808.html 

[V3]
  http://www.spinics.net/lists/devicetree/msg160644.html
 
What changed V3->V4:

  * Dropped [V3] (2/6) Add quirk for delayed IRQ ACK as this
    workaround was improving detection time but masking another
    issue with rpm-smd specific to msm899(2/4).  

  * Including the C code to enable/add missing clock branch.
    In V3 this change was split up between dt-bindings and C
    but the C part didn't get sent to the mailing list.
    Its in my inbox and tree ;-)

Note:
  -only the AHB clock was added for SDCC1 as it was tested.
   SDCC[2->4] ADB_CLK will be added once these branches are
   investigated against downstream.  ie) are they all clock
   branches the same as SDCC1_AHB ?

  6/6 was not separated out into dt-bindings and devicetree
      as it was just a simple search and replace.


Jeremy McNicoll (6):
  clk: qcom: SDHCI enablement on Nexus 5X / 6P
  dt-bindings: qcom: clk: Add missing binding for SDCHI enablement on
    Nexus 5X/6P
  arm64: dts: msm8992 add fixed regulator
  arm64: dts: smem enablement for msm8992
  dts: arm64: Enable onboard SDHCI on msm8992
  dts: doc: rename rpm_requests to respect DT naming conventions

 .../devicetree/bindings/clock/qcom,rpmcc.txt       |   2 +-
 .../bindings/regulator/qcom,smd-rpm-regulator.txt  |   2 +-
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |   6 +-
 .../devicetree/bindings/soc/qcom/qcom,smd.txt      |   2 +-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |   2 +-
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   2 +-
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |   2 +-
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |   2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   2 +-
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     |   2 +
 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |  60 +++++
 arch/arm64/boot/dts/qcom/msm8992.dtsi              | 143 ++++++++++-
 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi      | 276 +++++++++++++++++++++
 drivers/clk/qcom/gcc-msm8994.c                     |  18 ++
 include/dt-bindings/clock/qcom,gcc-msm8994.h       |   1 +
 16 files changed, 511 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi

-- 
2.6.1


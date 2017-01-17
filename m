From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH V2 0/4] Enable onboard SDHCI for Nexus 5X (msm8992)
Date: Mon, 16 Jan 2017 16:58:45 -0800
Message-ID: <1484614729-26751-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750933AbdAQA7D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Jan 2017 19:59:03 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com, jeremymc@redhat.com


V2->V1
------

* Removed SMD macro to define packet size
* Dropped "sdhci: dump vendor state and regs" as Ritesh has agreed to deal
  with it as part of [https://lkml.org/lkml/2016/12/30/102] . 
* Didn't include RobH's ACK as I stripped out the smd_rpm node from
   msm8992-bullhead-rev-101.dts and created msm8994-smd-rpm.dtsi to share
   between 8992 & 8994.  All feedback from RobH was applied prior to making
   this change.


All testing was performed with the inclusion of:
  RESEND v1 -> http://www.spinics.net/lists/linux-arm-msm/msg25484.html
  RESEND RFC -> http://www.spinics.net/lists/linux-arm-msm/msg25481.html


In V1 it was stated that
"Without the workaround (patch 5/5) mmc/sdhci didn't get detected 8/20
times.  When including the afore mentioned workaround MMC detection is
100% (35 boots) ."
It turns out we weren't waiting long enough for detection.  (see statement
below)

The following test results were obtained upon removing
the SDHCI workaround (patch 2/4):

  -50 iterations
  -100% successfully detected onboard storage
  -2 times SDHCI detection took over 4+ min
  -Sample size 1 (I only have 1 Nexus 5X)
 
General observations regarding workaround removal:
  -detection of onboard storage is generally slower without
   the workaround.  No hard numbers to back this up just
   a general observation.  It may be because the author has
   consumed far more caffeinated beverages compared to the 
   previous time V1.
  -the failures observed in V1 were because my test script
   did not wait long enough to declare failure.  Previously
   I was waiting 4 min to declare the SDHCI as missing.
   This round I increased the duration to 10min.

NOTE to SDHCI maintainers:
   "sdhci: Add quirk for delayed IRQ ACK" (patch 2/4) was
   included, if there is no interest in including this change
   feel free to drop it or provide guidance on how this type
   of issue is generally dealt with.  



Jeremy McNicoll (4):
  clk: gcc: Updates for SDHCI enablement
  sdhci: Add quirk for delayed IRQ ACK
  arm64: dts: Enable SDHCI for Nexus 5X (msm8992)
  dts: doc: rename rpm_requests to respect DT naming conventions

 .../devicetree/bindings/clock/qcom,rpmcc.txt       |   2 +-
 .../bindings/regulator/qcom,smd-rpm-regulator.txt  |  42 +++-
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |   6 +-
 .../devicetree/bindings/soc/qcom/qcom,smd.txt      |   2 +-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |   2 +-
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   2 +-
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |   2 +-
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |   2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   2 +-
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     |   2 +
 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |  82 ++++++
 arch/arm64/boot/dts/qcom/msm8992.dtsi              | 153 ++++++++++++
 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi      | 276 +++++++++++++++++++++
 drivers/clk/qcom/gcc-msm8994.c                     | 108 ++++++--
 drivers/mmc/host/sdhci-msm.c                       |   7 +
 drivers/mmc/host/sdhci.c                           |  12 +-
 drivers/mmc/host/sdhci.h                           |   2 +
 drivers/regulator/qcom_smd-regulator.c             |  49 ++++
 include/dt-bindings/clock/qcom,gcc-msm8994.h       |  32 ++-
 20 files changed, 739 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi

-- 
2.6.1


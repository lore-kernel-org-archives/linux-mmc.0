From: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 0/6] Enable onboard SDHCI for Nexus 5X (msm8992)
Date: Tue, 24 Jan 2017 01:36:22 -0800
Message-ID: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, git-LJ92rlH3Dns@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


Here is a reference to V2:
  http://www.spinics.net/lists/devicetree/msg158808.html [1]

V3->V2:
 * stripped down clock changes to just the essential bits'N pieces
 * split up clock changes between C and DT-binding changes
 * addressed feedback from BjorneA. 
 * Dropped RobH's ACK's as the patches aren't the same.  Sorry!  ;-(
   

The SDHCI workaround has been included again in V3 just like V2, please see justification[1].
 NOTE to SDHCI maintainers:
   "sdhci: Add quirk for delayed IRQ ACK" (patch 2/4) was
    included, if there is no interest in including this change
    feel free to drop it or provide guidance on how this type
    of issue is generally dealt with."

Testing:
  -both Nexus 5X & 6P behaviour was identical given the limited number of things / peripherals which
    are  currently supported. 
  -note to self or anyone reading this, see if there is some kind of cloud type automated testing
    that could help identify breakage as manual testing takes far too much time. 


This series has dependancies on:
   -> "regulator: qcom-smd: Add PM8994 regulator support"   now merged in git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
  -> https://lkml.org/lkml/2016/12/28/77 [SDHCI-msm support for enhanced strobe]
  -> https://lkml.org/lkml/2016/12/30/102 [sdhci-msm: add more debug logs]




Jeremy McNicoll (6):
  dt-bindings: qcom: clk: Add missing binding for SDCHI enablement on
    Nexus 5X/6P
  sdhci: Add quirk for delayed IRQ ACK
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
 drivers/mmc/host/sdhci-msm.c                       |   7 +
 drivers/mmc/host/sdhci.c                           |  12 +-
 drivers/mmc/host/sdhci.h                           |   2 +
 include/dt-bindings/clock/qcom,gcc-msm8994.h       |   1 +
 18 files changed, 512 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi

-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

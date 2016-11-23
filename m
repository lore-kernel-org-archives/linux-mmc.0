From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH 0/5] Enable onboard SDHCI for Nexus 5X (msm8992)
Date: Tue, 22 Nov 2016 17:09:43 -0800
Message-ID: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org



Now that the basic board support is available:
     http://www.spinics.net/lists/linux-arm-msm/msg24533.html

and the associated clock changes have been picked up for next,
      http://www.spinics.net/lists/linux-arm-msm/msg24499.html


Using V8 from Ritesh Harjani, with the additional changes provided to him for gcc-msm8994.c 
 [ http://www.spinics.net/lists/linux-arm-msm/msg24652.html ]


Additionally V9 of the RPM clock support [http://www.spinics.net/lists/linux-arm-msm/msg24211.html]
 is needed.  

At this point, "qcom,rpmcc-msm8916" was used successfully for testing of
the rpm clock controller.  It has been marked as a TODO item in the DTS
and once the rpmcc clocks are added for 8992/8994 the needed change will
be made.  i.e.) expect a follow up patch for rpmcc 

Currently, the minimal regulators to verify / enable SDHCI functionality
have been added.   While looking at the downstream code, I saw a few more
obvious entries so they have been included (completely untested).   Hopefully
someone with the hardware docs can provide feedback  and/or an individual
with better eye site than I who can ferret out more of the entries from
downstream.

The nonremovable "keyword/flag" was used to assess the reliability of the
initial mmc detection.  When the flag is present in the DTS only 1 check
for SDHCI was made, without non removable it checks over and over again.
Without the workaround (patch 5/5) mmc/sdhci didn't get detected 8/20
times.  When including the afore mentioned workaround MMC detection is
100% (35 boots) .  

While at it, I took the liberty of re-tabifying include/dt-bindings/
clock/qcom,gcc-msm8994.h to make it look nice according to VIM using (:set list ).  
Sorry emacs users, you are on your own.


Question:
   In what DT-bindings txt file should the following, compatible = "qcom,rpm-msm8994"; 
  be placed?  (arch/arm64/boot/dts/qcom/msm8992.dtsi, rpm_requests node)


Obviously, this is a work in progress,  and its progressing :-)



Jeremy McNicoll (5):
  clk: gcc: Updates for SDHCI enablement
  smd: Make packet size a constant
  arm64: dts: Enable SDHCI for Nexus 5X (msm8992)
  sdhci: dump vendor state and regs
  sdhci: Add quirk for delayed IRQ ACK

 .../bindings/regulator/qcom,smd-rpm-regulator.txt  |  40 ++++
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     | 262 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |  82 +++++++
 arch/arm64/boot/dts/qcom/msm8992.dtsi              | 153 ++++++++++++
 drivers/clk/qcom/gcc-msm8994.c                     | 108 +++++++--
 drivers/mmc/host/sdhci-msm.c                       |  86 +++++++
 drivers/mmc/host/sdhci.c                           |  37 ++-
 drivers/mmc/host/sdhci.h                           |   3 +
 drivers/regulator/qcom_smd-regulator.c             |  49 ++++
 drivers/soc/qcom/smd-rpm.c                         |   2 +-
 include/dt-bindings/clock/qcom,gcc-msm8994.h       |  32 ++-
 include/linux/soc/qcom/smd.h                       |   7 +
 12 files changed, 824 insertions(+), 37 deletions(-)

-- 
2.6.1

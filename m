From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH V1 0/3] Internal voltage control for platform drivers
Date: Fri, 20 Jul 2018 16:16:03 +0530
Message-ID: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, evgreen@chromium.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Certain SDHC controllers may require that voltage switching happen after
sepcial conditions. Added a QUIRK for such controllers to use.

For SDHCI-MSM controllers, power irq is a signal from controller to SW
that it is ready for voltage switch. So added support to register
voltage regulators from the msm driver and use them.
Voltage switching from core layer is causing CRC/cmd timeout errors in
some chipsets.

Changes since RFC:
	- Added DT option to pass regulator load values the sdhci-msm driver
	should vote during BUS_ON and BUS_OFF power irq.
	- Removed quirk and used local flags in sdhci_add_host to to avoid
	scenario of both sdhci & sdhci-msm layer controlling the regulators.
	- Introduced two sdhci msm layer APIs to replace the respective
	sdhci layer APIs. This is again to stop sdhci layer from
	controlling regulators if sdhci_msm layer is present.

Tested on: sdm845
Requies patch series:"[PATCH V3 0/4] Changes for SDCC5 version"

Vijay Viswanath (3):
  mmc: sdhci: Allow platform controlled voltage switching
  Documentation: sdhci-msm: Add entries for passing load values
  mmc: sdhci-msm: Use internal voltage control

 .../devicetree/bindings/mmc/sdhci-msm.txt          |   6 +
 drivers/mmc/host/sdhci-msm.c                       | 220 +++++++++++++++++++--
 drivers/mmc/host/sdhci.c                           |  21 +-
 3 files changed, 231 insertions(+), 16 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

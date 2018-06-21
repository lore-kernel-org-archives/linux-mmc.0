From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH RFC 0/2] Internal voltage control for platform drivers
Date: Thu, 21 Jun 2018 17:53:44 +0530
Message-ID: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Certain SDHC controllers may require that voltage switching happen after
sepcial conditions. Added a QUIRK for such controllers to use.

For SDHCI-MSM controllers, power irq is a signal from controller to SW
that it is ready for voltage switch. So added support to register
voltage regulators from the msm driver and use them.
Voltage switching from core layer is causing CRC/cmd timeout errors in
some chipsets.

Tested on: sdm845, db410c
Requies patch series:"[PATCH V3 0/4] Changes for SDCC5 version"

Vijay Viswanath (2):
  mmc: sdhci: Allow platform controlled voltage switching
  mmc: sdhci-msm: Use internal voltage control

 drivers/mmc/host/sdhci-msm.c | 99 ++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci.c     | 20 ++++++---
 drivers/mmc/host/sdhci.h     |  2 +
 3 files changed, 104 insertions(+), 17 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

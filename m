From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH v2 0/4] mmc: sdhci-msm: Corrections to implementation of power irq
Date: Wed, 27 Sep 2017 11:04:39 +0530
Message-ID: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52324 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdI0Fe7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2017 01:34:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org, Vijay Viswanath <vviswana@codeaurora.org>

Register writes which change voltage of IO lines or turn the IO bus on/off
require sdhc controller to be ready before progressing further. Once a
register write which affects IO lines is done, the driver should wait for
power irq from controller. Once the irq comes, the driver should acknowledge
the irq by writing to power control register. If the acknowledgement is not
given to controller, the controller may not complete the corresponding
register write action and this can mess up the controller if drivers proceeds
without power irq completing.

Changes since v1:
	Patch enabling MMC_IO_ACCESSORS in Kconfig moved up the patch list.
	Also corrected a mistake in the patch.
	Removed all ifdef CONFIG_MMC_IO_ACCESSORS since the patches using it
	will come after MMC_IO_ACCESSORS are enabled.
	Merged the patches 3 & 4 of earlier series into 1 patch (patch 4 in
	current series).
	Corrected a mistake in a comment text in patch 3 of previous series. 

Changes since RFC:
	wait_for_completion_timeout replaced with wait_event_timeout when
	waiting for power irq.
	Removed the spinlock within power irq handler and API which waits
	for power irq.
	Added comments to sdhci msm register write functions, warning that they
	can sleep.
	Sdhci msm register write functions will do a memory barrier before
	writing to the register if the particular register can trigger
	power irq.
	Instead of enabling SDHCI IO ACCESSORS config in arm64/defconfig, it
	will be selected in mmc/host/Kconfig if the platform is MMC_SDHCI_MSM.

Sahitya Tummala (1):
  mmc: sdhci-msm: Fix HW issue with power IRQ handling during reset

Subhash Jadavani (1):
  mmc: sdhci-msm: fix issue with power irq

Vijay Viswanath (2):
  mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
  mmc: sdhci-msm: Add sdhci msm register write APIs which wait for pwr
    irq

 drivers/mmc/host/Kconfig     |   1 +
 drivers/mmc/host/sdhci-msm.c | 235 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 231 insertions(+), 5 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


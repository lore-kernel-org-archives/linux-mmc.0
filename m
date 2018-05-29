From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH V2 0/4] Changes for SDCC5 version
Date: Tue, 29 May 2018 15:22:37 +0530
Message-ID: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

With SDCC5, the MCI register space got removed and the offset/order of
several registers have changed. Based on SDCC version used and the register,
we need to pick the base address and offset.

Changes since RFC:
	Dropped voltage regulator changes in sdhci-msm
	Split the "Register changes for sdcc V5" patch
	Instead of checking mci removal for deciding which base addr to use,
	new function pointers are defined for the 2 variants of sdcc: 
		1) MCI present
		2) V5 (mci removed)
	Instead of string comparing with the compatible string from DT file,
	the sdhci_msm_probe will now pick the data associated with the
	compatible entry and use it to load variant specific address offsets
	and msm variant specific read/write ops.

Changes since V1:
	Removed unused msm_reab & msm_writeb APIs
	Changed certain register addresses from uppercase to lowercase hex
	letters
	Removed extra lines and spaces
	Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
	one for Documentation and other for the driver changes.

Sayali Lokhande (2):
  mmc: sdhci-msm: Define new Register address map
  Documentation: sdhci-msm: Add new compatible string for SDCC v5

Vijay Viswanath (2):
  mmc: sdhci-msm: Add msm version specific ops and data structures
  mmc: host: Register changes for sdcc V5

 .../devicetree/bindings/mmc/sdhci-msm.txt          |   7 +-
 drivers/mmc/host/sdhci-msm.c                       | 513 ++++++++++++++++-----
 2 files changed, 393 insertions(+), 127 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

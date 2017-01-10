From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RESEND PATCHv1 0/8] mmc: sdhci-msm: Provide support for enhanced strobe
Date: Tue, 10 Jan 2017 12:30:44 +0530
Message-ID: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi, 

Resending this patch series, as no one could review it -possibly due to
holidays during that time.

This patch series mainly provides enhanced strobe support to sdhci-msm driver
along with some additions of HW recommended sequence. This has been tested on
8996 based internal target & on db410c.

Patches 1-3 :- Factors out few functions to be re-used again.
	       To also simplify large functions and makes it more readable.

Patches 4-5 :- Few recommendations based on HW prog. guide.

Patches 6 :- Clear SDHCI_HS400_TUNING flag after platform_execute_tuning
	     so that ->platform_execute_tuning (underlying platform driver) can
	     know about HS400 tuning.

Patch 7 :- Implements an additional step as per HPG for HS400 tuning.

Patch 8 :- Implements enhanced strobe functionality in sdhci-msm driver.


Ritesh Harjani (6):
  mmc: sdhci-msm: Factor out sdhci_msm_hc_select_mode
  mmc: sdhci-msm: Factor out function to set/get msm clock rate
  mmc: sdhci-msm: Factor out sdhci_msm_hs400
  mmc: sdhci: Clear SDHCI_HS400_TUNING flag after
    platform_execute_tuning
  mmc: sdhci-msm: Make HS400 tuning follow as per recommeneded HW
    sequence
  mmc: sdhci-msm: Provide enhanced_strobe mode feature support

Subhash Jadavani (1):
  mmc: sdhci-msm: configure CORE_CSR_CDC_DELAY_CFG to recommended value

Venkat Gopalakrishnan (1):
  mmc: sdhci-msm: Reset vendor specific func register on probe

 drivers/mmc/host/sdhci-msm.c | 356 ++++++++++++++++++++++++++-----------------
 drivers/mmc/host/sdhci.c     |   6 +-
 2 files changed, 224 insertions(+), 138 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

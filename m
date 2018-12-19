From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2] DMA Block size configuration prior to CQE
Date: Wed, 19 Dec 2018 12:33:03 -0800
Message-ID: <1545251584-2105-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

As per eMMC5.1 Spec Section 6.6.39.1, DMA Block size should be to 512 B
before enabling command queue.

Tegra SDHCI Host design strictly follows this sequence preventing write
access to SDHCI_BLOCK_SIZE when CQE is set in CQHCI_CFG. Writing to
SDHCI_BLOCK_SIZE register when CQE is enabled results in crash.

This patch is needed for enabling HW Command queue for Tegra SDHCI.

Note: couple more patches are needed for enabling HW CMDQ on Tegra SDHCI.
Based on patch review feedback from Ulf on the other HW Command queue
patch, I will resend new patch series with all these dependency patches
together along with covering letter.

[0] DMA Config prior to CQE
    https://lkml.org/lkml/2018/12/14/1062
[1] SDMMC address range
    https://lkml.org/lkml/2018/12/14/1323
[2] Fix sdhci_do_enable_v4_mode
    https://lkml.org/lkml/2018/12/14/72
[3] Add HW Command Queue for Tegra SDHCI
    https://patchwork.kernel.org/patch/10731915/

Sowjanya Komatineni (1):
  mmc: cqhci: DMA Configuration prior to CQE

 drivers/mmc/host/cqhci.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
2.7.4

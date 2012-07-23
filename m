From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V1] Add Quirk for Broken Configuration
Date: Mon, 23 Jul 2012 17:35:26 +0530
Message-ID: <1343045127-20227-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, will.newton@imgtec.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, shashidharh@vayavyalabs.com, thomas.abraham@linaro.org, jh80.chung@samsung.com, svenkatr@ti.com, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch is based on the device tree support of dw_mmc host controller
posted by Thomas Abraham. Below is the list of his patch in review stage

mmc: dw_mmc: convert copy of struct device in struct dw_mci to a reference
mmc: dw_mmc: allow probe to succeed even if one slot is initialized
mmc: dw_mmc: lookup for optional biu and ciu clocks
mmc: dw_mmc: add quirk to indicate missing write protect line
mmc: dw_mmc: add device tree support
mmc: dw_mmc: add samsung exynos5250 specific extentions

Girish K S (1):
  mmc: dwmmc: Add quirk for broken Hardware Config

 drivers/mmc/host/dw_mmc-pltfm.c |   10 +++-
 drivers/mmc/host/dw_mmc.c       |  151 ++++++++++++++++++++++++---------------
 drivers/mmc/host/dw_mmc.h       |    1 +
 include/linux/mmc/dw_mmc.h      |    4 +-
 4 files changed, 107 insertions(+), 59 deletions(-)

-- 
1.7.4.1

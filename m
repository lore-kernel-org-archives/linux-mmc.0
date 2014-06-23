From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH 0/3] Adding UHS support for dw_mmc driver
Date: Mon, 23 Jun 2014 16:15:18 +0530
Message-ID: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jh80.chung@samsung.com, cjb@laptop.org, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: sonnyrao@chromium.org, t.figa@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, ks.giri@samsung.com, prashanth.g@samsung.com, alim.akhtar@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This series adds UHS support for dw_mmc driver.
Patch[1] reworks the handling of vmmc and vqmmc regulators.
Patch[2] handles the case where in some boards uses built-in CD line for
card detection and connected to a same voltage domain as of the IO rails.
Patch[3] was taken from chrome tree originally developed by Doug Anderson.

These patches were tested on exynos based chromebook with 3.16-rc1.

Doug Anderson (1):
  mmc: dw_mmc: Support voltage changes

Yuvaraj Kumar C D (2):
  mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators
  mmc: dw_mmc: Dont cut off vqmmc and vmmc

 drivers/mmc/host/dw_mmc.c  |  239 +++++++++++++++++++++++++++++++++++---------
 drivers/mmc/host/dw_mmc.h  |    7 +-
 include/linux/mmc/dw_mmc.h |    2 +
 3 files changed, 201 insertions(+), 47 deletions(-)

-- 
1.7.10.4

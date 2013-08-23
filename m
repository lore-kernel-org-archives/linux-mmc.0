From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [RFC V2 0/4] dw_mmc platform specific private data init
Date: Fri, 23 Aug 2013 16:45:05 +0530
Message-ID: <1377256509-18922-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, alim.akhtar@samsung.com
Cc: ks.giri@samsung.com, t.figa@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

changes from V1:
	1.Added a new RFC patch 
		mmc: dw_mmc: socfpga: move socfpga private init
	2.Avoid code duplication in
		mmc: dw_mmc: exynos: add a quirk for SMU.

Yuvaraj Kumar C D (4):
  mmc: dw_mmc: exynos: move the exynos private init
  mmc: dw_mmc: socfpga: move socfpga private init
  mmc: dw_mmc: move the platform specific init call
  mmc: dw_mmc: exynos: add a quirk for SMU.

 drivers/mmc/host/dw_mmc-exynos.c  |   60 ++++++++++++++++++++++++++++---------
 drivers/mmc/host/dw_mmc-pltfm.c   |    7 -----
 drivers/mmc/host/dw_mmc-socfpga.c |   29 +++++++++---------
 drivers/mmc/host/dw_mmc.c         |   12 ++++++++
 include/linux/mmc/dw_mmc.h        |    2 ++
 5 files changed, 74 insertions(+), 36 deletions(-)

-- 
1.7.9.5

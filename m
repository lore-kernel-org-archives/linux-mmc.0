From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [RFC V4 0/4] dw_mmc platform specific private data and SMU init
Date: Fri, 30 Aug 2013 15:17:39 +0530
Message-ID: <1377856063-3391-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: ks.giri@samsung.com, t.figa@samsung.com, alim.akhtar@samsung.com, dianders@chromium.org, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org


changes from V3: changes only in the patch
	mmc: dw_mmc: exynos: configure SMU in exynos5420.
	1.Added new compatible string "samsung,exynos5420-dw-mshc-smu" for
	  the host with SMU.
	2.Used compatible string "samsung,exynos5420-dw-mshc-smu"
	  for controller instance which has SMU.
	3.Used compatible string "samsung,exynos5420-dw-mshc"
	  for controller instance which does not have SMU.

changes from V2:
	1.dropped the bypass-smu quirk 
		mmc: dw_mmc: exynos: configure SMU in exynos5420.
	2.Changed the subject line for this patch
	  add a quirk for SMU -> configure SMU in exynos5420
	
	mmc: dw_mmc: exynos: configure SMU in exynos5420 
	was earlier 
	mmc: dw_mmc: exynos: add a quirk for SMU.

changes from V1:
	1.Added a new RFC patch 
		mmc: dw_mmc: socfpga: move socfpga private init
	2.Avoid code duplication in
		mmc: dw_mmc: exynos: add a quirk for SMU.


Yuvaraj Kumar C D (4):
  mmc: dw_mmc: exynos: move the exynos private init
  mmc: dw_mmc: socfpga: move socfpga private init
  mmc: dw_mmc: move the platform specific init call
  mmc: dw_mmc: exynos: configure SMU in exynos5420.

 drivers/mmc/host/dw_mmc-exynos.c  |   65 ++++++++++++++++++++++++++++---------
 drivers/mmc/host/dw_mmc-pltfm.c   |    7 ----
 drivers/mmc/host/dw_mmc-socfpga.c |   29 ++++++++---------
 drivers/mmc/host/dw_mmc.c         |    9 +++++
 4 files changed, 73 insertions(+), 37 deletions(-)

-- 
1.7.9.5

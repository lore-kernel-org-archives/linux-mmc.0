From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 0/7] mmc: distinguish DDR timing mode for eMMC/UHS
Date: Wed, 15 Jan 2014 23:10:24 +0900
Message-ID: <001e01cf11fb$88a9b300$99fd1900$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:56021 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbaAOOKZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 09:10:25 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZG0005U4PCDJ70@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Jan 2014 23:10:24 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, rickard.andersson@stericsson.com, linux@arm.linux.org.uk, balajitk@ti.com, g.liakhovetski@gmx.de, wei_wang@realsil.com.cn, sameo@linux.intel.com, jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org

These changes intend to distinguish two DDR timing modes related to eMMC & UHS.
Even though two modes are different actually, UHS_DDR50 is used as eMMC DDR mode.
MMC_TIMING_MMC_DDR52 mode is added.

Seungwon Jeon (7):
  mmc: clarify DDR timing mode between SD-UHS and eMMC
  mmc: mmci: clarify DDR timing mode between SD-UHS and eMMC
  mmc: omap: clarify DDR timing mode between SD-UHS and eMMC
  mmc: sh_mmcif: clarify DDR timing mode between SD-UHS and eMMC
  mmc: rtsx: clarify DDR timing mode between SD-UHS and eMMC
  mmc: dw_mmc: clarify DDR timing mode between SD-UHS and eMMC
  mmc: sdhci: clarify DDR timing mode between SD-UHS and eMMC

 drivers/mmc/core/debugfs.c        |    3 +++
 drivers/mmc/core/mmc.c            |    2 +-
 drivers/mmc/host/dw_mmc-exynos.c  |    3 +--
 drivers/mmc/host/dw_mmc.c         |    2 +-
 drivers/mmc/host/mmci.c           |    4 ++--
 drivers/mmc/host/omap_hsmmc.c     |    4 ++--
 drivers/mmc/host/rtsx_pci_sdmmc.c |    2 ++
 drivers/mmc/host/sdhci.c          |    4 +++-
 drivers/mmc/host/sh_mmcif.c       |    9 +++++----
 include/linux/mmc/host.h          |    3 ++-
 10 files changed, 22 insertions(+), 14 deletions(-)



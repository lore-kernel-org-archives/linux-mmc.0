From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH RESEND v3 0/7] mmc: distinguish DDR timing mode for eMMC/UHS
Date: Fri, 14 Mar 2014 21:11:48 +0900
Message-ID: <003201cf3f7e$933ea860$b9bbf920$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <005f01cf2a57$6ed025d0$4c707170$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57667 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbaCNMLu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Mar 2014 08:11:50 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2F00K3WDVOK700@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 14 Mar 2014 21:11:49 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, rickard.andersson@stericsson.com, linux@arm.linux.org.uk, balajitk@ti.com, g.liakhovetski@gmx.de, wei_wang@realsil.com.cn, sameo@linux.intel.com, jh80.chung@samsung.com

These changes intend to distinguish two DDR timing modes related to eMMC & UHS.
Even though two modes are different actually, UHS_DDR50 is used as eMMC DDR mode.
MMC_TIMING_MMC_DDR52 mode is added.

Changes in V3:
 	(6/7) Added MMC-DDR52 mode instead of replacing UHS-DDR50 in dw_mmc-exynos
 
Changes in V2:
 	(2/7) Added MMC-DDR52 mode instead of replacing UHS-DDR50 in mmci
 
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
 drivers/mmc/host/dw_mmc-exynos.c  |    5 ++---
 drivers/mmc/host/dw_mmc.c         |    2 +-
 drivers/mmc/host/mmci.c           |    6 ++++--
 drivers/mmc/host/omap_hsmmc.c     |    4 ++--
 drivers/mmc/host/rtsx_pci_sdmmc.c |    2 ++
 drivers/mmc/host/sdhci.c          |    4 +++-
 drivers/mmc/host/sh_mmcif.c       |    9 +++++----
 include/linux/mmc/host.h          |    3 ++-
 10 files changed, 25 insertions(+), 15 deletions(-)> 


Thanks,
sw-j


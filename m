From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH RESEND v3 0/7] mmc: distinguish DDR timing mode for eMMC/UHS
Date: Thu, 03 Apr 2014 20:56:52 +0900
Message-ID: <000e01cf4f33$cdb2d790$691886b0$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <005f01cf2a57$6ed025d0$4c707170$%jun@samsung.com>
 <003201cf3f7e$933ea860$b9bbf920$%jun@samsung.com>
 <CAPDyKFpgfQvo-BP-Eb-2V9pypGianO4-3SnvtQphM+ONaaXdcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38031 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbaDCL4y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Apr 2014 07:56:54 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N3G00JOEEITR170@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 03 Apr 2014 20:56:53 +0900 (KST)
In-reply-to: <CAPDyKFpgfQvo-BP-Eb-2V9pypGianO4-3SnvtQphM+ONaaXdcQ@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <chris@printf.net>, 'Rickard Andersson' <rickard.andersson@stericsson.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'balajitk' <balajitk@ti.com>, 'Guennadi Liakhovetski' <g.liakhovetski@gmx.de>, 'Wei WANG' <wei_wang@realsil.com.cn>, 'Samuel Ortiz' <sameo@linux.intel.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

On Wed, April 02, 2014, Ulf Hansson wrote:
> On 14 March 2014 13:11, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > These changes intend to distinguish two DDR timing modes related to eMMC & UHS.
> > Even though two modes are different actually, UHS_DDR50 is used as eMMC DDR mode.
> > MMC_TIMING_MMC_DDR52 mode is added.
> 
> This will likely be one of first patchset applied to mmc-next when
> next 3.15 rc[n] becomes available.
Hi Chris,

Do you have any plan to pick this patch-set for 3.15?
I think there is no functional change.

Thanks,
Seungwon Jeon

> 
> From a bi-sectable point of view, we should squash the enrire patchset
> into one patch. I hope you are fine with that Seungwon!? If some of
> the host driver maintainers prefer another solution, also please tell
> me.
> 
> Kind regards
> Ulf Hansson
> 
> >
> > Changes in V3:
> >         (6/7) Added MMC-DDR52 mode instead of replacing UHS-DDR50 in dw_mmc-exynos
> >
> > Changes in V2:
> >         (2/7) Added MMC-DDR52 mode instead of replacing UHS-DDR50 in mmci
> >
> > Seungwon Jeon (7):
> >   mmc: clarify DDR timing mode between SD-UHS and eMMC
> >   mmc: mmci: clarify DDR timing mode between SD-UHS and eMMC
> >   mmc: omap: clarify DDR timing mode between SD-UHS and eMMC
> >   mmc: sh_mmcif: clarify DDR timing mode between SD-UHS and eMMC
> >   mmc: rtsx: clarify DDR timing mode between SD-UHS and eMMC
> >   mmc: dw_mmc: clarify DDR timing mode between SD-UHS and eMMC
> >   mmc: sdhci: clarify DDR timing mode between SD-UHS and eMMC
> >
> >  drivers/mmc/core/debugfs.c        |    3 +++
> >  drivers/mmc/core/mmc.c            |    2 +-
> >  drivers/mmc/host/dw_mmc-exynos.c  |    5 ++---
> >  drivers/mmc/host/dw_mmc.c         |    2 +-
> >  drivers/mmc/host/mmci.c           |    6 ++++--
> >  drivers/mmc/host/omap_hsmmc.c     |    4 ++--
> >  drivers/mmc/host/rtsx_pci_sdmmc.c |    2 ++
> >  drivers/mmc/host/sdhci.c          |    4 +++-
> >  drivers/mmc/host/sh_mmcif.c       |    9 +++++----
> >  include/linux/mmc/host.h          |    3 ++-
> >  10 files changed, 25 insertions(+), 15 deletions(-)>
> >
> >
> > Thanks,
> > sw-j
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND v3 0/7] mmc: distinguish DDR timing mode for eMMC/UHS
Date: Wed, 2 Apr 2014 13:50:04 +0200
Message-ID: <CAPDyKFpgfQvo-BP-Eb-2V9pypGianO4-3SnvtQphM+ONaaXdcQ@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<005f01cf2a57$6ed025d0$4c707170$%jun@samsung.com>
	<003201cf3f7e$933ea860$b9bbf920$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:62553 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758407AbaDBLuG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Apr 2014 07:50:06 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so60566qgd.23
        for <linux-mmc@vger.kernel.org>; Wed, 02 Apr 2014 04:50:05 -0700 (PDT)
In-Reply-To: <003201cf3f7e$933ea860$b9bbf920$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Rickard Andersson <rickard.andersson@stericsson.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, balajitk <balajitk@ti.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Wei WANG <wei_wang@realsil.com.cn>, Samuel Ortiz <sameo@linux.intel.com>, Jaehoon Chung <jh80.chung@samsung.com>

On 14 March 2014 13:11, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> These changes intend to distinguish two DDR timing modes related to eMMC & UHS.
> Even though two modes are different actually, UHS_DDR50 is used as eMMC DDR mode.
> MMC_TIMING_MMC_DDR52 mode is added.

This will likely be one of first patchset applied to mmc-next when
next 3.15 rc[n] becomes available.

>From a bi-sectable point of view, we should squash the enrire patchset
into one patch. I hope you are fine with that Seungwon!? If some of
the host driver maintainers prefer another solution, also please tell
me.

Kind regards
Ulf Hansson

>
> Changes in V3:
>         (6/7) Added MMC-DDR52 mode instead of replacing UHS-DDR50 in dw_mmc-exynos
>
> Changes in V2:
>         (2/7) Added MMC-DDR52 mode instead of replacing UHS-DDR50 in mmci
>
> Seungwon Jeon (7):
>   mmc: clarify DDR timing mode between SD-UHS and eMMC
>   mmc: mmci: clarify DDR timing mode between SD-UHS and eMMC
>   mmc: omap: clarify DDR timing mode between SD-UHS and eMMC
>   mmc: sh_mmcif: clarify DDR timing mode between SD-UHS and eMMC
>   mmc: rtsx: clarify DDR timing mode between SD-UHS and eMMC
>   mmc: dw_mmc: clarify DDR timing mode between SD-UHS and eMMC
>   mmc: sdhci: clarify DDR timing mode between SD-UHS and eMMC
>
>  drivers/mmc/core/debugfs.c        |    3 +++
>  drivers/mmc/core/mmc.c            |    2 +-
>  drivers/mmc/host/dw_mmc-exynos.c  |    5 ++---
>  drivers/mmc/host/dw_mmc.c         |    2 +-
>  drivers/mmc/host/mmci.c           |    6 ++++--
>  drivers/mmc/host/omap_hsmmc.c     |    4 ++--
>  drivers/mmc/host/rtsx_pci_sdmmc.c |    2 ++
>  drivers/mmc/host/sdhci.c          |    4 +++-
>  drivers/mmc/host/sh_mmcif.c       |    9 +++++----
>  include/linux/mmc/host.h          |    3 ++-
>  10 files changed, 25 insertions(+), 15 deletions(-)>
>
>
> Thanks,
> sw-j
>

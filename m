From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v4, 0/6] eSDHC patches introduction
Date: Mon, 14 Dec 2015 13:22:11 +0100
Message-ID: <CAPDyKFpykfkaELzOajQK5BQSZ9Hm4EZwkDwuL9MOoO0eVwPzrA@mail.gmail.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33188 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbbLNMWM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2015 07:22:12 -0500
Received: by qkck189 with SMTP id k189so95699344qkc.0
        for <linux-mmc@vger.kernel.org>; Mon, 14 Dec 2015 04:22:12 -0800 (PST)
In-Reply-To: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, X.Xie@freescale.com, Li Leo <LeoLi@freescale.com>

On 14 December 2015 at 05:24, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> This patchset is used to fix host version in eSDHC_HOSTVER for T4240-R1.0-R2.0.
> To get the SoC version and revision, it's needed to add the GUTS driver to access
> the global utilities registers.
>
> So, the first three patches are to add the GUTS driver.
> The following two patches are to enable GUTS driver support
> to get SVR in eSDHC driver.
> The last patch is to fix host version for T4240.
>
> Yangbo Lu (6):
>   soc: fsl: add GUTS driver for QorIQ platforms
>   dt: move guts devicetree doc out of powerpc directory
>   powerpc/fsl: move mpc85xx.h to include/linux
>   mmc: sdhci-of-esdhc: get SVR from global utilities registers
>   mmc: kconfig: select FSL_GUTS for MMC_SDHCI_OF_ESDHC
>   mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
>
>  .../bindings/{powerpc/fsl => soc}/guts.txt         |   3 +
>  drivers/clk/clk-qoriq.c                            |   2 +-
>  drivers/i2c/busses/i2c-mpc.c                       |   2 +-
>  drivers/iommu/fsl_pamu.c                           |   2 +-
>  drivers/mmc/host/Kconfig                           |   2 +
>  drivers/mmc/host/sdhci-of-esdhc.c                  |  26 ++++-
>  drivers/net/ethernet/freescale/gianfar.c           |   2 +-
>  drivers/soc/Kconfig                                |   1 +
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/fsl/Kconfig                            |  19 ++++
>  drivers/soc/fsl/Makefile                           |   4 +
>  drivers/soc/fsl/guts.c                             | 112 +++++++++++++++++++++
>  include/linux/fsl/guts.h                           | 103 ++++++++++---------
>  .../include/asm/mpc85xx.h => include/linux/svr.h   |   4 +-
>  14 files changed, 227 insertions(+), 56 deletions(-)
>  rename Documentation/devicetree/bindings/{powerpc/fsl => soc}/guts.txt (90%)
>  create mode 100644 drivers/soc/fsl/Kconfig
>  create mode 100644 drivers/soc/fsl/Makefile
>  create mode 100644 drivers/soc/fsl/guts.c
>  rename arch/powerpc/include/asm/mpc85xx.h => include/linux/svr.h (97%)
>
> --
> 2.1.0.27.g96db324
>

I think you need some additional maintainers to be involved here.
There are more than mmc parts in this patchset.

Please re-post.

Kind regards
Uffe

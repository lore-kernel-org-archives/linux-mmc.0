From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v3, 0/5] eSDHC patches introduction
Date: Tue, 8 Dec 2015 14:59:33 +0100
Message-ID: <CAPDyKFrWLw9RCde6yDYcAscTyB1wCGGKOvbvpaVp97q5CR5Low@mail.gmail.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34443 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbbLHN7e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2015 08:59:34 -0500
Received: by qgeb1 with SMTP id b1so16624118qge.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Dec 2015 05:59:33 -0800 (PST)
In-Reply-To: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Scott Wood <scottwood@freescale.com>, X.Xie@freescale.com, Li Leo <LeoLi@freescale.com>

On 27 November 2015 at 04:20, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> This patchset is used to fix host version in eSDHC_HOSTVER for T4240-R1.0-R2.0.
> To get the SoC version and revision, it's needed to add syscon support to access
> the SVR(system version register) of global utilities registers through regmap.
>
> So, the first three patches are to add syscon support to access SVR.
> The following two patches are to fix host version for T4240.
>
> Yangbo Lu (5):
>   powerpc/fsl: move mpc85xx.h to include/linux
>   mmc: sdhci-of-esdhc: get SVR from global utilities registers
>   mmc: kconfig: select MFD_SYSCON for MMC_SDHCI_OF_ESDHC
>   powerpc: dts: t4240: add syscon support for DCFG node
>   mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
>
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |  4 +-
>  arch/powerpc/include/asm/mpc85xx.h          | 95 ----------------------------
>  drivers/clk/clk-qoriq.c                     |  2 +-
>  drivers/i2c/busses/i2c-mpc.c                |  2 +-
>  drivers/iommu/fsl_pamu.c                    |  2 +-
>  drivers/mmc/host/Kconfig                    |  1 +
>  drivers/mmc/host/sdhci-of-esdhc.c           | 28 ++++++++-
>  drivers/net/ethernet/freescale/gianfar.c    |  2 +-
>  include/linux/fsl-svr.h                     | 97 +++++++++++++++++++++++++++++
>  9 files changed, 131 insertions(+), 102 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/mpc85xx.h
>  create mode 100644 include/linux/fsl-svr.h
>
> --
> 2.1.0.27.g96db324
>

Overall it looks good. I just posted some minor comments for two of the patches.

I assume it's easiest if I queue this via my mmc tree, but that
requires the non-mmc parts to be acked. Or you have another
suggestion?

Regarding the DT changes, normally SOC maintainers wants them to go
separately via their SOC trees. Although, I can pick them also, if
those are acked.

Kind regards
Uffe

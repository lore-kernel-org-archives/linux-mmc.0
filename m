From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v5, 0/5] Fix eSDHC host version register bug
Date: Fri, 4 Mar 2016 11:51:31 +0100
Message-ID: <CAPDyKFpXBmx7Tbdz5i4VHbnycUikZUwtv0BvPGXYKGOuU1g9PQ@mail.gmail.com>
References: <1457084321-10003-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34383 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbcCDKvd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 05:51:33 -0500
Received: by mail-wm0-f54.google.com with SMTP id p65so14922573wmp.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2016 02:51:32 -0800 (PST)
In-Reply-To: <1457084321-10003-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, scott.wood@nxp.com, leoyang.li@nxp.com, xiaobo.xie@nxp.com, Rob Herring <robh+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Zhao Qiang <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>

On 4 March 2016 at 10:38, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> This patchset is used to fix a host version register bug in the T4240-R1.0-R2.0
> eSDHC controller. To get the SoC version and revision, it's needed to add the
> GUTS driver to access the global utilities registers.
>
> So, the first three patches are to add the GUTS driver.
> The following two patches are to enable GUTS driver support to get SVR in eSDHC
> driver and fix host version for T4240.
>
> Yangbo Lu (5):
>   ARM64: dts: ls2080a: add device configuration node
>   soc: fsl: add GUTS driver for QorIQ platforms
>   dt: move guts devicetree doc out of powerpc directory
>   powerpc/fsl: move mpc85xx.h to include/linux/fsl
>   mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
>
>  .../bindings/{powerpc => soc}/fsl/guts.txt         |   3 +
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   6 ++
>  drivers/clk/clk-qoriq.c                            |   3 +-
>  drivers/i2c/busses/i2c-mpc.c                       |   2 +-
>  drivers/iommu/fsl_pamu.c                           |   3 +-
>  drivers/mmc/host/Kconfig                           |   1 +
>  drivers/mmc/host/sdhci-of-esdhc.c                  |  23 +++++
>  drivers/net/ethernet/freescale/gianfar.c           |   2 +-
>  drivers/soc/Kconfig                                |   2 +-
>  drivers/soc/fsl/Kconfig                            |   8 ++
>  drivers/soc/fsl/Makefile                           |   1 +
>  drivers/soc/fsl/guts.c                             | 103 +++++++++++++++++++++
>  include/linux/fsl/guts.h                           | 100 ++++++++++----------
>  .../asm/mpc85xx.h => include/linux/fsl/svr.h       |   4 +-
>  14 files changed, 204 insertions(+), 57 deletions(-)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
>  create mode 100644 drivers/soc/fsl/Kconfig
>  create mode 100644 drivers/soc/fsl/guts.c
>  rename arch/powerpc/include/asm/mpc85xx.h => include/linux/fsl/svr.h (97%)
>
> --
> 2.1.0.27.g96db324
>

Please resend this to the respective mailing lists. There's no arm,
dt, powerpc, clk, etc...

Regarding the mmc patch, it looks good to me so you can add my ack for it.

Kind regards
Uffe

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Wed, 21 Oct 2015 10:38:35 +0200
Message-ID: <CAPDyKFoGxEL_8KWbN-50EGMJB7MyiHxcvBCDJKcOW_ObLNcyHg@mail.gmail.com>
References: <5626FCB0.5040708@samsung.com>
	<562712E1.3020107@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38243 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbbJUIih (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 04:38:37 -0400
Received: by wicll6 with SMTP id ll6so63258255wic.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2015 01:38:36 -0700 (PDT)
In-Reply-To: <562712E1.3020107@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Govindraj Raja <govindraj.raja@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Vineet Gupta <vgupta@synopsys.com>, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>

On 21 October 2015 at 06:21, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf.
>
> Sorry..previously request-pull is wrong.
> Could you pull the below..?
>
> The following changes since commit 10e2cf053bbbaa76fcd919c0f59ae5bf8463a19c:
>
>   mmc: sdhci-of-esdhc: avoid writing power control register (2015-10-16 15:04:58 +0200)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to 13ae9dff2fe12409197fbd3620d2308888badbac:
>
>   arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC (2015-10-20 23:59:31 +0900)
>
> ----------------------------------------------------------------
> Shawn Lin (10):
>       mmc: dw_mmc: Add external dma interface support
>       mmc: dw_mmc: use macro for HCON register operations
>       Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
>       mips: pistachio_defconfig: remove CONFIG_MMC_DW_IDMAC
>       arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
>       arm: exynos_defconfig: remove CONFIG_MMC_DW_IDMAC
>       arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
>       arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
>       arm: multi_v7_defconfig: remove CONFIG_MMC_DW_IDMAC
>       arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC

Jaehoon,

The last two arm patches doesn't have acks. I realize that these
changes are trivial, but I can't pull these in without acks. All the
other patches I have picked up.

>
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  25 +++++++++++++
>  arch/arc/configs/axs101_defconfig                          |   1 -
>  arch/arc/configs/axs103_defconfig                          |   1 -
>  arch/arc/configs/axs103_smp_defconfig                      |   1 -
>  arch/arm/configs/exynos_defconfig                          |   1 -
>  arch/arm/configs/hisi_defconfig                            |   1 -
>  arch/arm/configs/lpc18xx_defconfig                         |   1 -
>  arch/arm/configs/multi_v7_defconfig                        |   1 -
>  arch/arm/configs/zx_defconfig                              |   1 -
>  arch/mips/configs/pistachio_defconfig                      |   1 -
>  drivers/mmc/host/Kconfig                                   |  11 +-----
>  drivers/mmc/host/dw_mmc-pltfm.c                            |   2 +
>  drivers/mmc/host/dw_mmc.c                                  | 272 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
>  drivers/mmc/host/dw_mmc.h                                  |   9 +++++
>  include/linux/mmc/dw_mmc.h                                 |  23 +++++++++++-
>  15 files changed, 276 insertions(+), 75 deletions(-)
>
> Best Regards,
> Jaehoon Chung

[...]

Thanks!

Kind regards
Uffe

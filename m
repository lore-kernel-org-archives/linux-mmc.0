From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: move rockchip related code to a separate file
Date: Thu, 14 Aug 2014 14:16:40 +0200
Message-ID: <1436855.vkDg4bXI8B@amdc1032>
References: <1406786498-3935-1-git-send-email-addy.ke@rock-chips.com>
 <1408003293-27375-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1408003293-27375-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, ulf.hansson@linaro.org, dinguyen@altera.com, heiko@sntech.de, olof@lixom.net, dianders@chromium.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, zhenfu.fang@rock-chips.com, cf@rock-chips.com, lintao@rock-chips.com, chenfen@rock-chips.com, zyf@rock-chips.com, xjq@rock-chips.com, huangtao@rock-chips.com, zyw@rock-chips.com, yzq@rock-chips.com, hj@rock-chips.com, kever.yang@rock-chips.com, zhangqing@rock-chips.com, hl@rock-chips.com
List-Id: linux-mmc@vger.kernel.org


Hi,

On Thursday, August 14, 2014 04:01:33 PM Addy Ke wrote:
> To support HS200 and UHS-1, we need add a big hunk of code,
> as shown in the following patches. So a separate file for
> rockchip SOCs is suitable.
> 
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  drivers/mmc/host/Kconfig           |   9 +++
>  drivers/mmc/host/Makefile          |   1 +
>  drivers/mmc/host/dw_mmc-pltfm.c    |  57 ---------------
>  drivers/mmc/host/dw_mmc-rockchip.c | 146 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 156 insertions(+), 57 deletions(-)
>  create mode 100644 drivers/mmc/host/dw_mmc-rockchip.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index a565254..ae61df6 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -621,6 +621,15 @@ config MMC_DW_PCI
>  
>  	  If unsure, say N.
>  
> +config MMC_DW_ROCKCHIP
> +	tristate "Rockchip specific extensions for Synopsys DW Memory Card Interface"
> +	depends on MMC_DW

While you are at it you may also add (in this or in incremental patch)
dependency on ARCH_ROCKCHIP so this driver becomes limited to Rockchip
architecture.

> +	select MMC_DW_PLTFM
> +	help
> +	  This selects support for Rockchip SoC specific extensions to the
> +	  Synopsys DesignWare Memory Card Interface driver. Select this option
> +	  for platforms based on RK3066, RK3188 and RK3288 SoC's.
> +
>  config MMC_SH_MMCIF
>  	tristate "SuperH Internal MMCIF support"
>  	depends on MMC_BLOCK

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND v11 6/7] ARM: OMAP: enable SYSCON and
 REGULATOR_PBIAS in omap2plus_defconfig
Date: Wed, 26 Feb 2014 09:01:53 -0800
Message-ID: <20140226170152.GA11654@atomide.com>
References: <1389627375-9107-1-git-send-email-balajitk@ti.com>
 <1392821801-29673-1-git-send-email-balajitk@ti.com>
 <1392821801-29673-7-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392821801-29673-7-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, broonie@kernel.org
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [140219 07:00]:
> Enable REGULATOR_PBIAS needed for SD card on most OMAPs.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>

I belive this is the only one missing my ack:

Acked-by: Tony Lindgren <tony@atomide.com>

Probably best that this all gets queued along with other MMC related
patches by Balaji and Chris.

> ---
>  arch/arm/configs/omap2plus_defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 3a0b53d..e4fec1c 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -169,6 +169,7 @@ CONFIG_DRA752_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_OMAP_WATCHDOG=y
>  CONFIG_TWL4030_WATCHDOG=y
> +CONFIG_MFD_SYSCON=y
>  CONFIG_MFD_PALMAS=y
>  CONFIG_MFD_TPS65217=y
>  CONFIG_MFD_TPS65910=y
> @@ -180,6 +181,7 @@ CONFIG_REGULATOR_TPS6507X=y
>  CONFIG_REGULATOR_TPS65217=y
>  CONFIG_REGULATOR_TPS65910=y
>  CONFIG_REGULATOR_TWL4030=y
> +CONFIG_REGULATOR_PBIAS=y
>  CONFIG_FB=y
>  CONFIG_FIRMWARE_EDID=y
>  CONFIG_FB_MODE_HELPERS=y
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

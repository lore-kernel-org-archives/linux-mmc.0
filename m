From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/6 v4] ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from
 koelsch
Date: Tue, 9 Sep 2014 17:20:44 +0900
Message-ID: <20140909082041.GA5819@verge.net.au>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
 <87k35d70pz.wl%kuninori.morimoto.gx@gmail.com>
 <87egvl70ls.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87egvl70ls.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Sep 08, 2014 at 11:46:10PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> sh_mobile_sdhi cares multiblock read bug.
> remove MMC_CAP2_NO_MULTI_READ flag from board code
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> v3 -> v4
> 
>  - no change
> 
>  arch/arm/mach-shmobile/board-koelsch.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
> index b7d5bc7..126a8b4 100644
> --- a/arch/arm/mach-shmobile/board-koelsch.c
> +++ b/arch/arm/mach-shmobile/board-koelsch.c
> @@ -331,7 +331,6 @@ SDHI_REGULATOR(2, RCAR_GP_PIN(7, 19), RCAR_GP_PIN(2, 26));
>  static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_POWER_OFF_CARD,
> -	.tmio_caps2	= MMC_CAP2_NO_MULTI_READ,
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
>  };
>  
> @@ -344,7 +343,6 @@ static struct resource sdhi0_resources[] __initdata = {
>  static struct sh_mobile_sdhi_info sdhi1_info __initdata = {
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_POWER_OFF_CARD,
> -	.tmio_caps2	= MMC_CAP2_NO_MULTI_READ,
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
>  };
>  
> @@ -357,7 +355,6 @@ static struct resource sdhi1_resources[] __initdata = {
>  static struct sh_mobile_sdhi_info sdhi2_info __initdata = {
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_POWER_OFF_CARD,
> -	.tmio_caps2	= MMC_CAP2_NO_MULTI_READ,
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
>  			  TMIO_MMC_WRPROTECT_DISABLE,
>  };
> -- 
> 1.7.9.5
> 

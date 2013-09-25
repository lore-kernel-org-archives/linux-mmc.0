From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/6] ARM: shmobile: armadillo800eva: disable MMCIF
 Command Completion Signal
Date: Wed, 25 Sep 2013 16:12:17 +0900
Message-ID: <20130925071217.GN6663@verge.net.au>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
 <1373484077-10460-4-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1373484077-10460-4-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 10, 2013 at 09:21:14PM +0200, Guennadi Liakhovetski wrote:
> MMCIF on r8a7740 doesn't support Command Completion Signal, a platform
> parameter has to be added to disable it on armadillo800eva.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 41ff7d65..3cb006b 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -778,6 +778,7 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
>  	.caps		= MMC_CAP_4_BIT_DATA |
>  			  MMC_CAP_8_BIT_DATA |
>  			  MMC_CAP_NONREMOVABLE,
> +	.ccs_unsupported = true,
>  	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
>  	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
>  };

Thanks, I have queued this up for v3.13.

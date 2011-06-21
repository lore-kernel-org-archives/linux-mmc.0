From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 5/5] ARM: mach-shmobile: ag5evm: SDHI requires waiting for idle
Date: Tue, 21 Jun 2011 12:10:22 -0400
Message-ID: <m2aadbtbbl.fsf@bob.laptop.org>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au>
	<1308610812-3479-6-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:32911 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab1FUQKh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Jun 2011 12:10:37 -0400
In-Reply-To: <1308610812-3479-6-git-send-email-horms@verge.net.au> (Simon
	Horman's message of "Tue, 21 Jun 2011 08:00:12 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>

Hi Paul,

On Mon, Jun 20 2011, Simon Horman wrote:
> The SDHI block on the ag5evm requires waiting for idle
> before writing to some registers.
>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
>
> ---
>
> Dependencies:
> 	"mmc: sdhi: Add write16_hook"
> 	"ARM: mach-shmobile: ag5evm: consistently name sdhi info structures"
> ---
>  arch/arm/mach-shmobile/board-ag5evm.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
> index ce5c251..cdfdd62 100644
> --- a/arch/arm/mach-shmobile/board-ag5evm.c
> +++ b/arch/arm/mach-shmobile/board-ag5evm.c
> @@ -341,6 +341,7 @@ static struct platform_device mipidsi0_device = {
>  static struct sh_mobile_sdhi_info sdhi0_info = {
>  	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
>  	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
> +	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
>  	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
>  };
> @@ -382,7 +383,7 @@ void ag5evm_sdhi1_set_pwr(struct platform_device *pdev, int state)
>  }
>  
>  static struct sh_mobile_sdhi_info sh_sdhi1_info = {
> -	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
> +	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
>  	.tmio_caps	= MMC_CAP_NONREMOVABLE | MMC_CAP_SDIO_IRQ,
>  	.tmio_ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
>  	.set_pwr	= ag5evm_sdhi1_set_pwr,

Could I get your ACK for this one, so that I can merge patches 1/2/3/5
together via the MMC tree?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

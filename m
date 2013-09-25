From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/6] ARM: shmobile: kzm9g: disable MMCIF Command
 Completion Signal
Date: Wed, 25 Sep 2013 16:12:20 +0900
Message-ID: <20130925071220.GO6663@verge.net.au>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
 <1373484077-10460-5-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:48609 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab3IYHMX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Sep 2013 03:12:23 -0400
Content-Disposition: inline
In-Reply-To: <1373484077-10460-5-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

On Wed, Jul 10, 2013 at 09:21:15PM +0200, Guennadi Liakhovetski wrote:
> MMCIF on sh73a0 doesn't support Command Completion Signal, a platform
> parameter has to be added to disable it on kzm9g.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/board-kzm9g.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index 165483c..7ec26a5 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -365,6 +365,7 @@ static struct resource sh_mmcif_resources[] = {
>  static struct sh_mmcif_plat_data sh_mmcif_platdata = {
>  	.ocr		= MMC_VDD_165_195,
>  	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
> +	.ccs_unsupported = true,
>  	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
>  	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
>  };
> -- 
> 1.7.2.5

Thanks, I have queued this up for v3.13.

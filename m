From: Matt Waddel <matt.waddel@canonical.com>
Subject: Re: [PATCH] arm: mmci: Add ARM variant with extended FIFO
Date: Wed, 16 Mar 2011 10:25:16 -0600
Message-ID: <4D80E46C.3010103@canonical.com>
References: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:59160 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab1CPQZV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2011 12:25:21 -0400
In-Reply-To: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Pawel Moll <pawel.moll@arm.com>, linux-mmc@vger.kernel.org

On 03/11/2011 10:18 AM, Pawel Moll wrote:
> New IO FPGA implementation for Versatile Express boards contain
> MMCI (PL180) cell with FIFO extended to 128 words (512 bytes).
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Tested-by: Matt Waddel <matt.waddel@linaro.org>

This patch improves MMC performance on my vexpress system. Also
fixes "mmcblk0: error -5 transferring data" errors.

> ---
>  drivers/mmc/host/mmci.c |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 2d6de3e..e7197b0 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -66,6 +66,12 @@ static struct variant_data variant_arm = {
>  	.datalength_bits	= 16,
>  };
>  
> +static struct variant_data variant_arm_extended_fifo = {
> +	.fifosize		= 128 * 4,
> +	.fifohalfsize		= 64 * 4,
> +	.datalength_bits	= 16,
> +};
> +
>  static struct variant_data variant_u300 = {
>  	.fifosize		= 16 * 4,
>  	.fifohalfsize		= 8 * 4,
> @@ -1019,10 +1025,15 @@ static int mmci_resume(struct amba_device *dev)
>  static struct amba_id mmci_ids[] = {
>  	{
>  		.id	= 0x00041180,
> -		.mask	= 0x000fffff,
> +		.mask	= 0xff0fffff,
>  		.data	= &variant_arm,
>  	},
>  	{
> +		.id	= 0x01041180,
> +		.mask	= 0xff0fffff,
> +		.data	= &variant_arm_extended_fifo,
> +	},
> +	{
>  		.id	= 0x00041181,
>  		.mask	= 0x000fffff,
>  		.data	= &variant_arm,


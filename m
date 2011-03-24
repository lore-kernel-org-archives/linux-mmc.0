From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] arm: mmci: Add ARM variant with extended FIFO
Date: Thu, 24 Mar 2011 18:47:49 -0400
Message-ID: <m3zkokm8yy.fsf@pullcord.laptop.org>
References: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40102 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932915Ab1CXWv3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Mar 2011 18:51:29 -0400
In-Reply-To: <1299863887-15490-1-git-send-email-pawel.moll@arm.com> (Pawel
	Moll's message of "Fri, 11 Mar 2011 17:18:07 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi Pawel,

On Fri, Mar 11 2011, Pawel Moll wrote:
> New IO FPGA implementation for Versatile Express boards contain
> MMCI (PL180) cell with FIFO extended to 128 words (512 bytes).
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
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

Pushed to mmc-next for .39-rc2, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

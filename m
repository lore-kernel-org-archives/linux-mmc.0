From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 5/5] sdhci: sdhci-pxa.c: Add QUIRKS for DMA/ADMA to match h/w
Date: Thu, 19 May 2011 15:05:46 -0400
Message-ID: <m3sjsabjed.fsf@pullcord.laptop.org>
References: <45293FA4-D66D-4817-AA18-6BD50264F87A@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53529 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728Ab1ESTD7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 May 2011 15:03:59 -0400
In-Reply-To: <45293FA4-D66D-4817-AA18-6BD50264F87A@marvell.com> (Philip
	Rakity's message of "Sun, 13 Feb 2011 23:01:24 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Mon, Feb 14 2011, Philip Rakity wrote:
> 32 Bit DMA/ADMA Access
> 32 Bit Size
> Support ADMA End Descriptor in current chain
> 	(no need for dummy entry)
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci-pxa.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
> index c8abf0f..215517f 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -120,6 +120,9 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
>  	host->ops = &sdhci_pxa_ops;
>  	host->irq = irq;
>  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +	host->quirks |= SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE
> +		| SDHCI_QUIRK_32BIT_ADMA_SIZE
> +		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>  
>  	if (pdata->quirks)
>  		host->quirks |= pdata->quirks;

Tested-by: Chris Ball <cjb@laptop.org> (on MMP2/XO-1.75)

.. and pushed to mmc-next for .40, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

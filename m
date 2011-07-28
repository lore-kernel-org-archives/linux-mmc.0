From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: pxav3 controller needs 32 bit ADMA addressing
Date: Thu, 28 Jul 2011 18:27:13 -0400
Message-ID: <m2k4b2jb26.fsf@bob.laptop.org>
References: <44DD7577-7CB6-42D0-9427-A8731C248612@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53990 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079Ab1G1W1U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jul 2011 18:27:20 -0400
In-Reply-To: <44DD7577-7CB6-42D0-9427-A8731C248612@marvell.com> (Philip
	Rakity's message of "Mon, 11 Jul 2011 14:47:54 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Zhangfei Gao <zgao6@marvell.com>

Hi Philip,

On Mon, Jul 11 2011, Philip Rakity wrote:
> enable the quirk.
>
> Best used in conjunction with patch downgrading
> ADMA to SDMA when transfer is not aligned.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci-pxav3.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 4198dbb..fc7e4a5 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -195,7 +195,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
>  	clk_enable(clk);
>  
>  	host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
> -		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
> +		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
> +		| SDHCI_QUIRK_32BIT_ADMA_SIZE;
>  
>  	/* enable 1/8V DDR capable */
>  	host->mmc->caps |= MMC_CAP_1_8V_DDR;

Pushed to mmc-next for 3.1 with Zhangfei's ACK, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

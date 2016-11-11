From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: fixup PRESENT_STATE read
Date: Fri, 11 Nov 2016 15:15:55 +0200
Message-ID: <0a5454e6-efa6-744e-4a2d-123a47e7cc40@intel.com>
References: <1478796456-30549-1-git-send-email-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28368 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754011AbcKKNUx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 11 Nov 2016 08:20:53 -0500
In-Reply-To: <1478796456-30549-1-git-send-email-michael@walle.cc>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, yangbo lu <yangbo.lu@freescale.com>

On 10/11/16 18:47, Michael Walle wrote:
> Since commit 87a18a6a5652 ("mmc: mmc: Use ->card_busy() to detect busy
> cards in __mmc_switch()") the ESDHC driver is broken:
>   mmc0: Card stuck in programming state! __mmc_switch
>   mmc0: error -110 whilst initialising MMC card
> 
> Since this commit __mmc_switch() uses ->card_busy(), which is
> sdhci_card_busy() for the esdhc driver. sdhci_card_busy() uses the
> PRESENT_STATE register, specifically the DAT0 signal level bit. But the
> ESDHC uses a non-conformant PRESENT_STATE register, thus a read fixup is
> required to make the driver work again.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Could add a Fixes tag here.

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index fb71c86..243fee9 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -66,6 +66,18 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>  			return ret;
>  		}
>  	}
> +	/*
> +	 * The DAT[3:0] line signal levels and the CMD line signal level is
> +	 * not compatible with standard SDHC reegister. Move the corresponding

reegister -> register

> +	 * bits around.
> +	 */
> +	if (spec_reg == SDHCI_PRESENT_STATE) {
> +		ret = value & 0xf8000000;
> +		ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
> +		ret |= (value << 1) & 0x01000000;
> +		return ret;

SDHCI also uses other bits in SDHCI_PRESENT_STATE like SDHCI_CMD_INHIBIT and
SDHCI_DATA_INHIBIT etc, but this looks like all those bits will be zero.  Is
that right?


> +	}
> +
>  	ret = value;
>  	return ret;
>  }
> 


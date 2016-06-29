From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFCv2 06/10] mmc: host: sdhci: don't set SDMA buffer
 boundary in ADMA mode
Date: Wed, 29 Jun 2016 13:55:49 +0300
Message-ID: <5773A935.7050209@intel.com>
References: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org>
 <1467033757-32498-7-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27814 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbcF2LAF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 07:00:05 -0400
In-Reply-To: <1467033757-32498-7-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, shawn.lin@rock-chips.com, Subhash Jadavani <subhashj@codeaurora.org>

On 27/06/16 16:22, Ritesh Harjani wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
> 
> SDMA buffer boundary size parameter in block size register should only be
> programmed if host controller DMA is operating in SDMA mode otherwise its
> better not to set this parameter to avoid any side effect when DMA is
> operating in ADMA mode operation.

Pedantically, the SDHCI specification does not say the SDMA Buffer Boundary
should not be set in ADMA mode.  All it says is that ADMA does not use it.
In fact it is impossible to avoid writing to it because it is part of the
Block Size register.  Unfortunately the value 0 does not mean "not used" but
instead means the boundary is 4K whereas the value presently being written
(7 which is the highest) means 512K.

Given that we have always been writing 7 to it, I don't see any reason to
change.  Murphy's law says if we do change it, someone else's driver will break.

However I presume you have hardware where value 7 doesn't work.  Can you
clarify that?

> 
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> [venkatg@codeaurora.org: fix trivial merge conflict]
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0e3d7c0..9f5cdaa 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -742,6 +742,17 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  }
>  
> +static void sdhci_set_blk_size_reg(struct sdhci_host *host, unsigned int blksz,
> +				   unsigned int sdma_boundary)
> +{
> +	if (host->flags & SDHCI_USE_ADMA)
> +		sdhci_writew(host, SDHCI_MAKE_BLKSZ(0, blksz),
> +			     SDHCI_BLOCK_SIZE);
> +	else
> +		sdhci_writew(host, SDHCI_MAKE_BLKSZ(sdma_boundary, blksz),
> +			     SDHCI_BLOCK_SIZE);
> +}
> +
>  static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	u8 ctrl;
> @@ -874,8 +885,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  	sdhci_set_transfer_irqs(host);
>  
>  	/* Set the DMA boundary value and block size */
> -	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
> -		data->blksz), SDHCI_BLOCK_SIZE);
> +	sdhci_set_blk_size_reg(host, data->blksz, SDHCI_DEFAULT_BOUNDARY_ARG);
>  	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>  }
>  
> @@ -1935,14 +1945,11 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		 */
>  		if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200) {
>  			if (mmc->ios.bus_width == MMC_BUS_WIDTH_8)
> -				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128),
> -					     SDHCI_BLOCK_SIZE);
> +				sdhci_set_blk_size_reg(host, 128, 7);
>  			else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4)
> -				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
> -					     SDHCI_BLOCK_SIZE);
> +				sdhci_set_blk_size_reg(host, 64, 7);
>  		} else {
> -			sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
> -				     SDHCI_BLOCK_SIZE);
> +			sdhci_set_blk_size_reg(host, 64, 7);
>  		}
>  
>  		/*
> 


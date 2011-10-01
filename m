From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] mmc: mmci: Fix incorrect handling of HW flow
	control for SDIO
Date: Sat, 1 Oct 2011 17:12:48 +0100
Message-ID: <20111001161248.GG11710@n2100.arm.linux.org.uk>
References: <1317109616-18010-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46800 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197Ab1JAQMz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Oct 2011 12:12:55 -0400
Content-Disposition: inline
In-Reply-To: <1317109616-18010-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

On Tue, Sep 27, 2011 at 09:46:56AM +0200, Ulf Hansson wrote:
>  	/* The ST Micro variants has a special bit to enable SDIO */
>  	if (variant->sdio && host->mmc->card)
> -		if (mmc_card_sdio(host->mmc->card))
> +		if (mmc_card_sdio(host->mmc->card)) {
> +			/*
> +			 * The ST Micro variants has a special bit
> +			 * to enable SDIO.
> +			 */
>  			datactrl |= MCI_ST_DPSM_SDIOEN;
>  
> +			/*
> +			 * The ST Micro variant for SDIO transfer sizes
> +			 * less then or equal to 8 bytes needs to have clock
> +			 * H/W flow control disabled. Since flow control is
> +			 * not really needed for anything that fits in the
> +			 * FIFO, we can disable it for any write smaller
> +			 * than the FIFO size.
> +			 */
> +			if ((host->size <= variant->fifosize) &&
> +			    (data->flags & MMC_DATA_WRITE))
> +				writel(readl(host->base + MMCICLOCK) &
> +				       ~variant->clkreg_enable,
> +				       host->base + MMCICLOCK);
> +			else
> +				writel(readl(host->base + MMCICLOCK) |
> +				       variant->clkreg_enable,
> +				       host->base + MMCICLOCK);
> +		}

Shouldn't this also re-enable the ST hardware flow control for non-SDIO
cards?

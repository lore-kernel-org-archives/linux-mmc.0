From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Fixup error handling for dma
Date: Wed, 30 Nov 2011 22:21:39 +0000
Message-ID: <20111130222139.GW9581@n2100.arm.linux.org.uk>
References: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47045 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab1K3WVu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 17:21:50 -0500
Content-Disposition: inline
In-Reply-To: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>

On Tue, Nov 29, 2011 at 03:51:26PM +0100, Ulf Hansson wrote:
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index e900f51..62ad649 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -761,8 +761,12 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>  	}
>  
>  	if (!cmd->data || cmd->error) {
> -		if (host->data)
> +		if (host->data) {
> +			/* Terminate the DMA transfer */
> +			if (dma_inprogress(host))
> +				mmci_dma_data_error(host);

Doesn't this leave the DMA buffers mapped?

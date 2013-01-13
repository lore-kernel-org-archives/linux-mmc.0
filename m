From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V3] mmc: mmci: Fixup and cleanup code for DMA handling
Date: Sun, 13 Jan 2013 19:24:29 +0000
Message-ID: <20130113192428.GU23505@n2100.arm.linux.org.uk>
References: <1357570707-28207-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45699 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab3AMTYg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Jan 2013 14:24:36 -0500
Content-Disposition: inline
In-Reply-To: <1357570707-28207-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Per Forlin <per.forlin@stericsson.com>

On Mon, Jan 07, 2013 at 03:58:27PM +0100, Ulf Hansson wrote:
> @@ -374,19 +415,12 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>  	 * contiguous buffers.  On TX, we'll get a FIFO underrun error.
>  	 */
>  	if (status & MCI_RXDATAAVLBLMASK) {
> -		dmaengine_terminate_all(chan);
> -		if (!data->error)
> -			data->error = -EIO;
> -	}
> -
> -	if (data->flags & MMC_DATA_WRITE) {
> -		dir = DMA_TO_DEVICE;
> -	} else {
> -		dir = DMA_FROM_DEVICE;
> +		data->error = -EIO;
> +		mmci_dma_data_error(host);

Please explain the change of behaviour here.  Before your change, we _only_
set data->error if the error is not set.  Here, we overwrite the error code
no matter what.  What is the reasoning for that change?

The reason the code is like it _was_ is so that any bytes remaining in the
FIFO are _only_ reported as an error if there wasn't a preceding error.
That is the behaviour I desired when I wrote this code.

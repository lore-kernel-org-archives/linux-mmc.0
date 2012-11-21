From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
	ux500v2 variant
Date: Wed, 21 Nov 2012 15:38:11 +0000
Message-ID: <20121121153811.GN3290@n2100.arm.linux.org.uk>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48106 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab2KUPiT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Nov 2012 10:38:19 -0500
Content-Disposition: inline
In-Reply-To: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Per Forlin <per.forlin@stericsson.com>

On Fri, Oct 12, 2012 at 04:02:02PM +0200, Ulf Hansson wrote:
>  /*
> + * Validate mmc prerequisites
> + */
> +static int mmci_validate_data(struct mmci_host *host,
> +			      struct mmc_data *data)
> +{
> +	if (!data)
> +		return 0;
> +
> +	if (!host->variant->non_power_of_2_blksize &&
> +	    !is_power_of_2(data->blksz)) {
> +		dev_err(mmc_dev(host->mmc),
> +			"unsupported block size (%d bytes)\n", data->blksz);
> +		return -EINVAL;
> +	}
> +
> +	if (data->sg->offset & 3) {
> +		dev_err(mmc_dev(host->mmc),
> +			"unsupported alginment (0x%x)\n", data->sg->offset);
> +		return -EINVAL;
> +	}

Why?  What's the reasoning behind this suddenly introduced restriction?
readsl()/writesl() copes just fine with non-aligned pointers.  It may be
that your DMA engine can not, but that's no business interfering with
non-DMA transfers, and no reason to fail such transfers.

If your DMA engine can't do that then its your DMA engine code which
should refuse to prepare the transfer.

Yes, that means problems with the way things are ordered - or it needs a
proper API where DMA engine can export these kinds of properties.

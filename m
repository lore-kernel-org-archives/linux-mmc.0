From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/1] of_mmc_spi: fix little endian support
Date: Mon, 30 Jan 2012 06:14:30 -0700
Message-ID: <20120130131430.GA28397@ponder.secretlab.ca>
References: <1327896929-16274-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61206 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab2A3NOe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2012 08:14:34 -0500
Received: by ggnb1 with SMTP id b1so1774063ggn.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2012 05:14:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327896929-16274-1-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Mon, Jan 30, 2012 at 05:15:29AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> the voltage_ranges is supposed to switch from big endian to little endian
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: linux-mmc@vger.kernel.org

Applied, thanks.

g.

> ---
>  drivers/mmc/host/of_mmc_spi.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index ab66f24..ede2c64 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -109,12 +109,13 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>  		goto err_ocr;
>  	}
>  
> +
>  	for (i = 0; i < num_ranges; i++) {
>  		const int j = i * 2;
>  		u32 mask;
>  
> -		mask = mmc_vddrange_to_ocrmask(voltage_ranges[j],
> -					       voltage_ranges[j + 1]);
> +		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
> +					       be32_to_cpu(voltage_ranges[j + 1]));
>  		if (!mask) {
>  			ret = -EINVAL;
>  			dev_err(dev, "OF: voltage-range #%d is invalid\n", i);
> -- 
> 1.7.7
> 

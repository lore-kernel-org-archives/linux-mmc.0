From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] mmc:of_spi: Update the code of getting voltage-ranges
Date: Thu, 8 Aug 2013 17:08:05 -0700
Message-ID: <20130809000805.GA7427@lizard.mcd01528.sjc.wayport.net>
References: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
 <1375251927-3330-3-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54769 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966748Ab3HIAMp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2013 20:12:45 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so4058047pbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 08 Aug 2013 17:12:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1375251927-3330-3-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com

On Wed, Jul 31, 2013 at 02:25:27PM +0800, Haijun Zhang wrote:
>  	int num_ranges;
> +	u32 ocr_mask;
>  	int i;
>  	int ret = -EINVAL;
>  
> @@ -102,26 +103,11 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>  	if (!oms)
>  		return NULL;
>  
> -	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
> -	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
> -	if (!voltage_ranges || !num_ranges) {
> -		dev_err(dev, "OF: voltage-ranges unspecified\n");
> +	ocr_mask = mmc_of_parse_voltage(np);
> +	if (ocr_mask <= 0)

'< 0' check for an unsigned type? :) I'd write just !ocr_mask...

But other than that the patch looks good to me...

Reviewed-by: Anton Vorontsov <anton@enomsg.org>

Thanks!

>  		goto err_ocr;
> -	}
> -
> -	for (i = 0; i < num_ranges; i++) {
> -		const int j = i * 2;
> -		u32 mask;
>  
> -		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
> -					       be32_to_cpu(voltage_ranges[j + 1]));
> -		if (!mask) {
> -			ret = -EINVAL;
> -			dev_err(dev, "OF: voltage-range #%d is invalid\n", i);
> -			goto err_ocr;
> -		}
> -		oms->pdata.ocr_mask |= mask;
> -	}
> +	oms->pdata.ocr_mask |= ocr_mask;
>  
>  	for (i = 0; i < ARRAY_SIZE(oms->gpios); i++) {
>  		enum of_gpio_flags gpio_flags;
> -- 
> 1.8.0

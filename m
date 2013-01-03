From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 6/8] MFD:rtsx: Add callback function conv_clk_and_div_n
Date: Thu, 3 Jan 2013 15:42:42 +0300
Message-ID: <20130103124242.GG7247@mwanda>
References: <cover.1356662293.git.wei_wang@realsil.com.cn>
 <0746763566e1d7b9902c18fc0539c3a099d28ae0.1356662294.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:43635 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab3ACMnT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Jan 2013 07:43:19 -0500
Content-Disposition: inline
In-Reply-To: <0746763566e1d7b9902c18fc0539c3a099d28ae0.1356662294.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: cjb@laptop.org, sameo@linux.intel.com, arnd@arndb.de, oakad@yahoo.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, devel@linuxdriverproject.org

On Fri, Dec 28, 2012 at 10:41:45AM +0800, wei_wang@realsil.com.cn wrote:
> diff --git a/drivers/mfd/rts5209.c b/drivers/mfd/rts5209.c
> index ba74de8..98fe0f3 100644
> --- a/drivers/mfd/rts5209.c
> +++ b/drivers/mfd/rts5209.c
> @@ -174,6 +174,7 @@ static const struct pcr_ops rts5209_pcr_ops = {
>  	.card_power_off = rts5209_card_power_off,
>  	.switch_output_voltage = rts5209_switch_output_voltage,
>  	.cd_deglitch = NULL,
> +	.conv_clk_and_div_n = NULL,

This isn't needed.  It's set to NULL by default.

> -	N = (u8)(clk - 2);
> +	if (pcr->ops->conv_clk_and_div_n)
> +		N = (u8)pcr->ops->conv_clk_and_div_n(clk, CLK_TO_DIV_N);
> +	else
> +		N = (u8)(clk - 2);

These unneeded casts are confusing.  Why are we doing them anyway?

regards,
dan carpenter


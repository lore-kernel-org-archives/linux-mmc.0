From: Ian Molton <ian.molton@codethink.co.uk>
Subject: Re: [PATCH v3] tmio_mmc_pio: prevent endless loop in
 tmio_mmc_set_clock()
Date: Mon, 15 Sep 2014 12:14:30 +0100
Message-ID: <20140915121430.b19ec6531ef5336fdd683c85@codethink.co.uk>
References: <3179866.4yEKrAKQ30@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34119 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbaIOLOn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Sep 2014 07:14:43 -0400
In-Reply-To: <3179866.4yEKrAKQ30@wasted.cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, linux-sh@vger.kernel.org

Seems reasonable,

Acked-by: Ian Molton <ian.molton@codethink.co.uk>

-Ian

On Sun, 14 Sep 2014 23:51:24 +0400
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:

> I spent a couple of days with the driver just hanging due to me forgetting to
> specify the external crystal frequency,  so that clk_get_rate() returned 0 and
> thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
> acceptable behavior, so I suggest that the minimum frequency is checked for 0
> in tmio_mmc_host_probe().
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: stable@vger.kernel.org
> 
> ---
> The patch is against Ulf Hansson's 'mmc.git' repo's 'fixes' branch.
> 
> Changes in version 3:
> - added Cc: stable.
> 
> Changes in version 2:
> - fixed grammar in the changelog.
> 
>  drivers/mmc/host/tmio_mmc_pio.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Index: mmc/drivers/mmc/host/tmio_mmc_pio.c
> ===================================================================
> --- mmc.orig/drivers/mmc/host/tmio_mmc_pio.c
> +++ mmc/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1044,6 +1044,15 @@ int tmio_mmc_host_probe(struct tmio_mmc_
>  	}
>  
>  	/*
> +	 * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
> +	 * looping forever...
> +	 */
> +	if (mmc->f_min == 0) {
> +		ret = -EINVAL;
> +		goto pm_disable;
> +	}
> +
> +	/*
>  	 * There are 4 different scenarios for the card detection:
>  	 *  1) an external gpio irq handles the cd (best for power savings)
>  	 *  2) internal sdhi irq handles the cd
> 


-- 
Ian Molton <ian.molton@codethink.co.uk>

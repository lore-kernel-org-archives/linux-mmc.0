From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] Powerpc/esdhc: Calculate the applicable timeout value
 for mmc erase
Date: Sun, 18 Nov 2012 16:32:44 -0800
Message-ID: <20121119003244.GI29066@lizard.sbx05977.paloaca.wayport.net>
References: <1351576856-32012-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56144 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab2KSAgF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 19:36:05 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so43992pad.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Nov 2012 16:36:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1351576856-32012-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Haijun.Zhang" <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Tue, Oct 30, 2012 at 02:00:55PM +0800, Haijun.Zhang wrote:
> As large area erase needs long time usually a few minutes,
> which the host can't wait will bring about timeout error.
> So we need to split the large area to small sections which
> only need short erase time to avoid timeout error.
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> ---
[...]
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2560,6 +2560,16 @@ int sdhci_add_host(struct sdhci_host *host)
>  	} else
>  		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
>  
> +	/*
> +	 * Calculate the max discard timeout  to limit the size one

Unneeded whitespace.

> +	 * discard request can issue.Just subtract the minimum timeout

Missing whitespace after the dot.

> +	 * value to avoid the circumstance the timeout value just equal to 0xF.
> +	 */
> +	if (host->timeout_clk &&
> +		!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK))

Wrong indentation on the second line (should be at least one more tab).

> +		mmc->max_discard_to = ((1 << 27) - (1 << 13) * 1000) /
> +			host->timeout_clk;

Is this some kind of generic formula? If not, it's better to place the
calculation into esdhc driver itself... Plus, where 27 and 13 came from?..

Otherwise, it looks good.

Thanks,
Anton.

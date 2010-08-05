From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] omap_hsmmc: remove 'UGLY HACK:  workaround regulator
 framework bugs'
Date: Thu, 05 Aug 2010 11:15:12 +0300
Message-ID: <4C5A7310.3020006@nokia.com>
References: <4C5A7212.6070207@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37496 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758810Ab0HEIPx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2010 04:15:53 -0400
In-Reply-To: <4C5A7212.6070207@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hunter Adrian (Nokia-MS/Helsinki)" <adrian.hunter@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, madhusudhan Chikkature <madhu.cr@ti.com>

Adding Madhu to cc

Hunter Adrian (Nokia-MS/Helsinki) wrote:
>>From 4e0d37a810e92395390640f699feac5de42a9b02 Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Thu, 5 Aug 2010 10:49:34 +0300
> Subject: [PATCH] omap_hsmmc: remove 'UGLY HACK:  workaround regulator framework bugs'
> 
> The framework is fixed.  The hack can be removed.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   19 -------------------
>  1 files changed, 0 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 4a8776f..6bdae60 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -401,25 +401,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>  		/* Allow an aux regulator */
>  		reg = regulator_get(host->dev, "vmmc_aux");
>  		host->vcc_aux = IS_ERR(reg) ? NULL : reg;
> -
> -		/*
> -		* UGLY HACK:  workaround regulator framework bugs.
> -		* When the bootloader leaves a supply active, it's
> -		* initialized with zero usecount ... and we can't
> -		* disable it without first enabling it.  Until the
> -		* framework is fixed, we need a workaround like this
> -		* (which is safe for MMC, but not in general).
> -		*/
> -		if (regulator_is_enabled(host->vcc) > 0) {
> -			regulator_enable(host->vcc);
> -			regulator_disable(host->vcc);
> -		}
> -		if (host->vcc_aux) {
> -			if (regulator_is_enabled(reg) > 0) {
> -				regulator_enable(reg);
> -				regulator_disable(reg);
> -			}
> -		}
>  	}
>  
>  	return 0;


From: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [PATCH 3/3] eSDHC: fix incorrect default value of the
 capabilities register on P4080
Date: Tue, 5 Jul 2011 14:18:01 +0400
Message-ID: <20110705101801.GA13052@oksana.dev.rtsoft.ru>
References: <1309839543-6031-1-git-send-email-tie-fei.zang@freescale.com>
 <1309839543-6031-2-git-send-email-tie-fei.zang@freescale.com>
 <1309839543-6031-3-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55556 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab1GEKSH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 06:18:07 -0400
Received: by bwd5 with SMTP id 5so4626414bwd.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Jul 2011 03:18:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309839543-6031-3-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org

On Tue, Jul 05, 2011 at 12:19:03PM +0800, Roy Zang wrote:
> P4080 eSDHC errata 12 describes incorrect default value of the
> the host controller capabilities register.
> 
> The default value of the VS18 and VS30 fields in the host controller
> capabilities register (HOSTCAPBLT) are incorrect. The default of these bits
> should be zero instead of one in the eSDHC logic.
> 
> This patch adds the workaround for these errata.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
>  drivers/mmc/host/sdhci-of-core.c |    3 +++
>  drivers/mmc/host/sdhci.c         |    6 ++++++
>  include/linux/mmc/sdhci.h        |    4 ++++
>  3 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
> index fede43d..9bdd30d 100644
> --- a/drivers/mmc/host/sdhci-of-core.c
> +++ b/drivers/mmc/host/sdhci-of-core.c
> @@ -182,6 +182,9 @@ static int __devinit sdhci_of_probe(struct platform_device *ofdev)
>  	if (of_device_is_compatible(np, "fsl,esdhc"))
>  		host->quirks |= SDHCI_QUIRK_QORIQ_PROCTL_WEIRD;
>  
> +	if (of_device_is_compatible(np, "fsl,p4080-esdhc"))
> +		host->quirks |= SDHCI_QUIRK_QORIQ_HOSTCAPBLT_ONLY_VS33;

Should really use voltage-ranges, not quirks.

http://www.spinics.net/lists/linux-mmc/msg02785.html

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com

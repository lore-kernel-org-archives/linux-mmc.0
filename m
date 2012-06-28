From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: V2:  Allow CAPS[1] to be set via QUIRK
Date: Thu, 28 Jun 2012 00:20:56 -0400
Message-ID: <87wr2s83tj.fsf@octavius.laptop.org>
References: <1340856945-1604-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53265 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab2F1EVC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jun 2012 00:21:02 -0400
In-Reply-To: <1340856945-1604-1-git-send-email-prakity@marvell.com>
	(philipspatches@gmail.com's message of "Wed, 27 Jun 2012 21:15:45
	-0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi,

On Thu, Jun 28 2012, philipspatches@gmail.com wrote:
> From: Philip Rakity <prakity@marvell.com>
>
> currently only the capability_0 register can be set if
> SDHCI_QUIRK_MISSING_CAPS is defined.  This is a problem when
> the capability_1 register also needs changing.  Use the
> SDHCI_QUIRK_MISSING_CAPS to allow both registers to be set.
>
> Redefining caps[1] is useful when the board design does not
> support 1.8v vccq so UHS modes are not available.  The code
> that calls sdhci_add_host can then detect this condition and
> adjust the caps so the UHS mode will not be attempted on UHS
> cards
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c  |    8 ++++++--
>  include/linux/mmc/sdhci.h |    3 ++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ef4231a..f46293d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2618,8 +2618,12 @@ int sdhci_add_host(struct sdhci_host *host)
>  	caps[0] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
>  		sdhci_readl(host, SDHCI_CAPABILITIES);
>  
> -	caps[1] = (host->version >= SDHCI_SPEC_300) ?
> -		sdhci_readl(host, SDHCI_CAPABILITIES_1) : 0;
> +	if (host->version >= SDHCI_SPEC_300)
> +		caps[1] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ?
> +			host->caps1 :
> +			sdhci_readl(host, SDHCI_CAPABILITIES_1);
> +	else
> +		caps[1] = 0;

What happened to using an initializer instead of the else for caps[1]?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

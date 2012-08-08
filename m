From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: vmmc regulator should be explicitly enabled/disabled
Date: Tue, 07 Aug 2012 22:33:35 -0400
Message-ID: <87628uyuww.fsf@octavius.laptop.org>
References: <1343089518-9219-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33626 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab2HHCdj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 22:33:39 -0400
In-Reply-To: <1343089518-9219-1-git-send-email-prakity@marvell.com>
	(philipspatches@gmail.com's message of "Mon, 23 Jul 2012 17:25:18
	-0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi,

On Mon, Jul 23 2012, philipspatches@gmail.com wrote:
> From: Philip Rakity <prakity@marvell.com>
>
> The vmmc regulator should not rely on it being enabled in
> the platform code.  Expliciitly enable and disable the
> regulator.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ac50d35..8c58865 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2908,7 +2908,8 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (IS_ERR(host->vmmc)) {
>  		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
>  		host->vmmc = NULL;
> -	}
> +	} else
> +		regulator_enable(host->vmmc);
>  
>  #ifdef CONFIG_REGULATOR
>  	if (host->vmmc) {
> @@ -3165,8 +3166,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>  	tasklet_kill(&host->card_tasklet);
>  	tasklet_kill(&host->finish_tasklet);
>  
> -	if (host->vmmc)
> +	if (host->vmmc) {
> +		regulator_disable(host->vmmc);
>  		regulator_put(host->vmmc);
> +	}
>  
>  	if (host->vqmmc) {
>  		regulator_disable(host->vqmmc);

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

From: Georgi Djakov <gdjakov@mm-sol.com>
Subject: Re: [PATCH] sdhci: Forward EPROBE_DEFER on vmmc and vqmmc regulators
Date: Wed, 26 Mar 2014 17:09:47 +0200
Message-ID: <5332EDBB.7010105@mm-sol.com>
References: <1394201923-27345-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:36407 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbaCZPJt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 26 Mar 2014 11:09:49 -0400
In-Reply-To: <1394201923-27345-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>, cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, git@xilinx.com

On 03/07/2014 04:18 PM, Mike Looijmans wrote:
> If vmmc or vqmmc regulators are controlled by an I2C device, the
> request for the regulator is likely to fail because the I2C bus has
> not been probed yet. The sdhci then incorrectly assumes that the user
> never wanted to use a regulator anyway and continues without ever
> enabling or configuring the required regulator.
>
> To solve this, when a required voltage regulator returns
> EPROBE_DEFER, signalling that the regulator exists but is not
> available yet, forward this error to the probe method instead
> of simply assuming that the user never wanted to use a regulator
> anyway.
>
> Tested on a custom board that has an I2C regulator for one of the sdhcis
> and no regulators at all for the other. This patch enables such a system
> to work correctly.
> ---
>   drivers/mmc/host/sdhci.c |    8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 34aef81..43b90c1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2972,6 +2972,8 @@ int sdhci_add_host(struct sdhci_host *host)
>   	host->vqmmc = regulator_get_optional(mmc_dev(mmc), "vqmmc");
>   	if (IS_ERR_OR_NULL(host->vqmmc)) {
>   		if (PTR_ERR(host->vqmmc) < 0) {
> +			if (PTR_ERR(host->vqmmc) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
>   			pr_info("%s: no vqmmc regulator found\n",
>   				mmc_hostname(mmc));
>   			host->vqmmc = NULL;
> @@ -3048,8 +3050,10 @@ int sdhci_add_host(struct sdhci_host *host)
>   	host->vmmc = regulator_get_optional(mmc_dev(mmc), "vmmc");
>   	if (IS_ERR_OR_NULL(host->vmmc)) {
>   		if (PTR_ERR(host->vmmc) < 0) {
> -			pr_info("%s: no vmmc regulator found\n",
> -				mmc_hostname(mmc));
> +			if (PTR_ERR(host->vmmc) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			pr_info("%s: no vmmc regulator found (%d)\n",

I suggest using %ld here. The rest looks fine to me! Thanks!

> +				mmc_hostname(mmc), PTR_ERR(host->vmmc));
>   			host->vmmc = NULL;
>   		}
>   	}
>

BR,
Georgi


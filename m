From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 05/14] mmc: sdhci: fix null return check of regulator_get
Date: Mon, 05 Nov 2012 08:56:32 -0500
Message-ID: <878vagb1bj.fsf@octavius.laptop.org>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-6-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38061 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654Ab2KEN4n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Nov 2012 08:56:43 -0500
In-Reply-To: <1350471893-29633-6-git-send-email-keyuan.liu@gmail.com> (Kevin
	Liu's message of "Wed, 17 Oct 2012 19:04:44 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Bin Wang <binw@marvell.com>, dsd@laptop.org

Hi,

On Wed, Oct 17 2012, Kevin Liu wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> regulator_get() returns NULL when CONFIG_REGULATOR not defined,
> which should not print out the warning.
>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Bin Wang <binw@marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |   18 ++++++++++++------
>  1 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8e6a6f0..0104ae9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2845,9 +2845,12 @@ int sdhci_add_host(struct sdhci_host *host)
>  
>  	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
>  	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
> -	if (IS_ERR(host->vqmmc)) {
> -		pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
> -		host->vqmmc = NULL;
> +	if (IS_ERR_OR_NULL(host->vqmmc)) {
> +		if (PTR_ERR(host->vqmmc) < 0) {
> +			pr_info("%s: no vqmmc regulator found\n",
> +				mmc_hostname(mmc));
> +			host->vqmmc = NULL;
> +		}
>  	}
>  	else if (regulator_is_supported_voltage(host->vqmmc, 1800000, 1800000))
>  		regulator_enable(host->vqmmc);
> @@ -2903,9 +2906,12 @@ int sdhci_add_host(struct sdhci_host *host)
>  	ocr_avail = 0;
>  
>  	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
> -	if (IS_ERR(host->vmmc)) {
> -		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
> -		host->vmmc = NULL;
> +	if (IS_ERR_OR_NULL(host->vmmc)) {
> +		if (PTR_ERR(host->vmmc) < 0) {
> +			pr_info("%s: no vmmc regulator found\n",
> +				mmc_hostname(mmc));
> +			host->vmmc = NULL;
> +		}
>  	} else
>  		regulator_enable(host->vmmc);

Pushed to mmc-next for 3.7 with this commit message:

Author: Kevin Liu <kliu5@marvell.com>
Date:   Wed Oct 17 19:04:44 2012 +0800

    mmc: sdhci: fix IS_ERR() checking of regulator_get()
    
    There are two problems here:
    
    The check for vmmc was printing an unnecessary pr_info() when
    host->vmmc is NULL.
    
    The intent of the check for vqmmc was to only remove UHS if we have a
    regulator that doesn't support the required voltage, but since IS_ERR()
    doesn't catch NULL, we were actually removing UHS modes if vqmmc isn't
    present at all -- since it isn't present for most users, this breaks
    UHS for them.  This patch fixes that UHS regression in 3.7-rc1.
    
    Signed-off-by: Kevin Liu <kliu5@marvell.com>
    Signed-off-by: Bin Wang <binw@marvell.com>
    Reviewed-by: Philip Rakity <prakity@marvell.com>
    Signed-off-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

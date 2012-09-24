From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v2 5/8] mmc: sdhci: fix null return check of
 regulator_get
Date: Mon, 24 Sep 2012 08:02:34 -0700
Message-ID: <0A1C2FD2-5F71-4472-A037-31ABE841876B@marvell.com>
References: <1348474558-23088-1-git-send-email-keyuan.liu@gmail.com>
 <1348474558-23088-6-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:46756 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756290Ab2IXPWr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Sep 2012 11:22:47 -0400
In-Reply-To: <1348474558-23088-6-git-send-email-keyuan.liu@gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "pierre@ossman.eu" <pierre@ossman.eu>, Haojian Zhuang <hzhuang1@marvell.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <kliu5@marvell.com>, Bin Wang <binw@marvell.com>


On Sep 24, 2012, at 1:15 AM, Kevin Liu <keyuan.liu@gmail.com> wrote:

> From: Kevin Liu <kliu5@marvell.com>
> 
> regulator_get() returns NULL when CONFIG_REGULATOR not defined,
> which should not print out the warning.
> 
> Signed-off-by: Bin Wang <binw@marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
> drivers/mmc/host/sdhci.c |   18 ++++++++++++------
> 1 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4b5631e..7c85e49 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2845,9 +2845,12 @@ int sdhci_add_host(struct sdhci_host *host)
> 
> 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
> 	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
> -	if (IS_ERR(host->vqmmc)) {
> -		pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
> -		host->vqmmc = NULL;
> +	if (IS_ERR_OR_NULL(host->vqmmc)) {
> +		if (PTR_ERR(host->vqmmc) < 0) {
> +			pr_info("%s: no vqmmc regulator found\n",
> +				mmc_hostname(mmc));
> +			host->vqmmc = NULL;
> +		}
> 	}
> 	else if (regulator_is_supported_voltage(host->vqmmc, 1650000, 1950000))
> 		regulator_enable(host->vqmmc);
> @@ -2912,9 +2915,12 @@ int sdhci_add_host(struct sdhci_host *host)
> 	ocr_avail = 0;
> 
> 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
> -	if (IS_ERR(host->vmmc)) {
> -		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
> -		host->vmmc = NULL;
> +	if (IS_ERR_OR_NULL(host->vmmc)) {
> +		if (PTR_ERR(host->vmmc) < 0) {
> +			pr_info("%s: no vmmc regulator found\n",
> +				mmc_hostname(mmc));
> +			host->vmmc = NULL;
> +		}
> 	} else
> 		regulator_enable(host->vmmc);
> 
> -- 
> 1.7.0.4
> 

Reviewed-by: Philip Rakity <prakity@marvell.com>


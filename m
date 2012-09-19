From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 6/6] mmc: sdhci: fix null return check of regulator_get
Date: Tue, 18 Sep 2012 22:50:19 -0400
Message-ID: <m3627alo9g.fsf@pullcord.laptop.org>
References: <1348020762-12932-1-git-send-email-keyuan.liu@gmail.com>
	<1348020762-12932-7-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44262 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab2ISCt5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 Sep 2012 22:49:57 -0400
In-Reply-To: <1348020762-12932-7-git-send-email-keyuan.liu@gmail.com> (Kevin
	Liu's message of "Wed, 19 Sep 2012 10:12:42 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Bin Wang <binw@marvell.com>

Hi,

On Tue, Sep 18 2012, Kevin Liu wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> regulator_get() returns NULL when CONFIG_REGULATOR not defined,
> which should be checked.
>
> Signed-off-by: Bin Wang <binw@marvell.com>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4b5631e..914147d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2845,7 +2845,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  
>  	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
>  	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
> -	if (IS_ERR(host->vqmmc)) {
> +	if (IS_ERR_OR_NULL(host->vqmmc)) {
>  		pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
>  		host->vqmmc = NULL;
>  	}
> @@ -2912,7 +2912,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  	ocr_avail = 0;
>  
>  	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
> -	if (IS_ERR(host->vmmc)) {
> +	if (IS_ERR_OR_NULL(host->vmmc)) {
>  		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
>  		host->vmmc = NULL;
>  	} else

Why should it be checked?  It looks like the only difference will be
that everyone gets the printk, which isn't desirable -- x86 laptop
users don't need to see a scary message about regulators.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

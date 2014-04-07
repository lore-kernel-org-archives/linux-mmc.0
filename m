From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sdhci: Forward EPROBE_DEFER on vmmc and vqmmc regulators
Date: Mon, 07 Apr 2014 10:11:20 +0200
Message-ID: <4366803.P4zmzQMZfl@wuerfel>
References: <1395991817-3503-1-git-send-email-mike.looijmans@topic.nl> <1396852708-11058-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58332 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaDGILw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Apr 2014 04:11:52 -0400
In-Reply-To: <1396852708-11058-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org, gdjakov@mm-sol.com

On Monday 07 April 2014 08:38:28 Mike Looijmans wrote:
> index 34aef81..43b90c1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2972,6 +2972,8 @@ int sdhci_add_host(struct sdhci_host *host)
>         host->vqmmc = regulator_get_optional(mmc_dev(mmc), "vqmmc");
>         if (IS_ERR_OR_NULL(host->vqmmc)) {
>                 if (PTR_ERR(host->vqmmc) < 0) {
> +                       if (PTR_ERR(host->vqmmc) == -EPROBE_DEFER)
> +                               return -EPROBE_DEFER;
>                         pr_info("%s: no vqmmc regulator found\n",
>                                 mmc_hostname(mmc));
>                         host->vqmmc = NULL;
> @@ -3048,8 +3050,10 @@ int sdhci_add_host(struct sdhci_host *host)
>         host->vmmc = regulator_get_optional(mmc_dev(mmc), "vmmc");
>         if (IS_ERR_OR_NULL(host->vmmc)) {
>                 if (PTR_ERR(host->vmmc) < 0) {
> -                       pr_info("%s: no vmmc regulator found\n",
> -                               mmc_hostname(mmc));
> +                       if (PTR_ERR(host->vmmc) == -EPROBE_DEFER)
> +                               return -EPROBE_DEFER;
> +                       pr_info("%s: no vmmc regulator found (%d)\n",
> +                               mmc_hostname(mmc), PTR_ERR(host->vmmc));
>                         host->vmmc = NULL;
>                 }

Please change the code to not use IS_ERR_OR_NULL() instead, getting
a NULL return value from regulator_get_optional() should not be
considered a bug, while getting an error return should always
cause the probe function to fail.

	Arnd

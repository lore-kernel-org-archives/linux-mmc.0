From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] sdhci: Forward EPROBE_DEFER on vmmc and vqmmc regulators
Date: Fri, 28 Mar 2014 11:20:47 +0100
Message-ID: <CAPDyKFpi9fAx6Ofebumbiw_gCG=jcaq_CV91xGjzrgB7NLdQdg@mail.gmail.com>
References: <1394201923-27345-1-git-send-email-mike.looijmans@topic.nl>
	<1395991817-3503-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:50719 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaC1KUs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Mar 2014 06:20:48 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so5593751qcx.41
        for <linux-mmc@vger.kernel.org>; Fri, 28 Mar 2014 03:20:47 -0700 (PDT)
In-Reply-To: <1395991817-3503-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Georgi Djakov <gdjakov@mm-sol.com>

On 28 March 2014 08:30, Mike Looijmans <mike.looijmans@topic.nl> wrote:
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

Missing Signed-off-by, could you resend?

Otherwise looks good, you may have my ack.

Kind regards
Ulf Hansson

>
> v2: Changed "%d" into "%ld" for PTR_ERR value.
> ---
>  drivers/mmc/host/sdhci.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 34aef81..de601f5 100644
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
> +                       pr_info("%s: no vmmc regulator found (%ld)\n",
> +                               mmc_hostname(mmc), PTR_ERR(host->vmmc));
>                         host->vmmc = NULL;
>                 }
>         }
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

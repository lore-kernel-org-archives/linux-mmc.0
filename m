From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: fix the wrong type of curr
Date: Wed, 13 Aug 2014 16:44:39 +0200
Message-ID: <CAPDyKFryA7UqRkE=oUFK6NEpzLphvU27SRfpregNUhz3Q=ESag@mail.gmail.com>
References: <20140801060012.GA2568@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:53933 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbaHMOok (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 10:44:40 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so10557166qge.25
        for <linux-mmc@vger.kernel.org>; Wed, 13 Aug 2014 07:44:39 -0700 (PDT)
In-Reply-To: <20140801060012.GA2568@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 1 August 2014 08:00, Chuanxiao Dong <chuanxiao.dong@intel.com> wrote:
> curr should use signed type since it will contain the returned
> value which is possible to be a negative value. Using u32 will
> make the returned value to be true even there is a negative result.
> Change to use int instead of u32
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Thanks! Queued for 3.18.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 47055f3..c026ec8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3078,7 +3078,7 @@ int sdhci_add_host(struct sdhci_host *host)
>          */
>         max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
>         if (!max_current_caps && host->vmmc) {
> -               u32 curr = regulator_get_current_limit(host->vmmc);
> +               int curr = regulator_get_current_limit(host->vmmc);
>                 if (curr > 0) {
>
>                         /* convert to SDHCI_MAX_CURRENT format */
> --
> 1.7.10.4

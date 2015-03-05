From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq_simple: fix error path in mmc_pwrseq_simple_alloc.
Date: Thu, 5 Mar 2015 15:56:41 +0100
Message-ID: <CAPDyKFqZrLYht+jGyyHVQyo-Nw-uHGDFzY1goOpVYkvjxo4qZA@mail.gmail.com>
References: <20150221151516.1b3bc8ae@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:48045 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbbCEO4m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 09:56:42 -0500
Received: by mail-qa0-f42.google.com with SMTP id w8so39265665qac.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 06:56:41 -0800 (PST)
In-Reply-To: <20150221151516.1b3bc8ae@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>

On 21 February 2015 at 05:15, NeilBrown <neilb@suse.de> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> The current error-path code (when gpiod_get_index() reports
> an error) can never free pwrseq->reset_gpios[0], but might
> try to tree pwrseq->reset_gpios[-1], which has unfortunate
> consequences.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> Fixes: 934f1f48330ed695927a51fa068dc5d673f2da19

Applied, thanks!

Kind regards
Uffe


>
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index e9f1d8d84613..c53f14a7ce54 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -124,7 +124,7 @@ int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>                     PTR_ERR(pwrseq->reset_gpios[i]) != -ENOSYS) {
>                         ret = PTR_ERR(pwrseq->reset_gpios[i]);
>
> -                       while (--i)
> +                       while (i--)
>                                 gpiod_put(pwrseq->reset_gpios[i]);
>
>                         goto clk_put;

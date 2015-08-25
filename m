From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: usdhi6rol0: handle probe deferral for regulator
Date: Tue, 25 Aug 2015 14:07:19 +0200
Message-ID: <CAPDyKFqYMdG=QQGgC8XbYyDFV8zW9ijrLb+YUkwmED2gaHFaRQ@mail.gmail.com>
References: <1439991696-28488-1-git-send-email-rabin.vincent@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33006 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396AbbHYMHU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:07:20 -0400
Received: by igfj19 with SMTP id j19so9487842igf.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:07:19 -0700 (PDT)
In-Reply-To: <1439991696-28488-1-git-send-email-rabin.vincent@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin.vincent@axis.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc <linux-mmc@vger.kernel.org>, Rabin Vincent <rabinv@axis.com>

On 19 August 2015 at 15:41, Rabin Vincent <rabin.vincent@axis.com> wrote:
> We ignore errors from mmc_regulator_get_supply() because the usage of
> the regulators is optional for the driver, but we still need to check
> for and handle EPROBE_DEFER, like it's done in for example dw_mmc.
> Otherwise we might end up not using the specified regulators just
> because of probe order.
>
> Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/usdhi6rol0.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 54b082b..63d5d72 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1715,12 +1715,14 @@ static int usdhi6_probe(struct platform_device *pdev)
>         if (!mmc)
>                 return -ENOMEM;
>
> +       ret = mmc_regulator_get_supply(mmc);
> +       if (ret == -EPROBE_DEFER)
> +               goto e_free_mmc;
> +
>         ret = mmc_of_parse(mmc);
>         if (ret < 0)
>                 goto e_free_mmc;
>
> -       mmc_regulator_get_supply(mmc);
> -
>         host            = mmc_priv(mmc);
>         host->mmc       = mmc;
>         host->wait      = USDHI6_WAIT_FOR_REQUEST;
> --
> 1.7.10.4
>

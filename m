From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/6] mmc: sdhci-bcm-kona: Handle error from mmc_of_parse()
Date: Sun, 21 Dec 2014 01:43:21 -0800
Message-ID: <CAGVrzcYd2PB7wF_ANiJstFr7iaedvaxuV_Cvitp6AUzuy5H9gg@mail.gmail.com>
References: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org> <1418895704-25908-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:42193 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaLUJoE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Dec 2014 04:44:04 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so2721074igi.0
        for <linux-mmc@vger.kernel.org>; Sun, 21 Dec 2014 01:44:02 -0800 (PST)
In-Reply-To: <1418895704-25908-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Christian Daudt <bcm@fixthebug.org>, Matt Porter <mporter@linaro.org>

2014-12-18 1:41 GMT-08:00 Ulf Hansson <ulf.hansson@linaro.org>:
> Since mmc_of_parse() may fail, let's deal with it and thus do proper
> error handling.
>
> Cc: Christian Daudt <bcm@fixthebug.org>
> Cc: Matt Porter <mporter@linaro.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/mmc/host/sdhci-bcm-kona.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index e7e4fbd..34bb8f9 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -254,7 +254,9 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>         kona_dev = sdhci_pltfm_priv(pltfm_priv);
>         mutex_init(&kona_dev->write_lock);
>
> -       mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret)
> +               goto err_pltfm_free;
>
>         if (!host->mmc->f_max) {
>                 dev_err(&pdev->dev, "Missing max-freq for SDHCI cfg\n");
> --
> 1.9.1
>



-- 
Florian

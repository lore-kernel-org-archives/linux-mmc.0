From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: mmci: Use devm_regulator_get API
Date: Tue, 8 Jan 2013 22:19:19 +0100
Message-ID: <CAPDyKFoCdeOUpmmyQ20fLyy_eLDHgRDBnUJKa_yt6Ew4rQtO-Q@mail.gmail.com>
References: <1357638169-23321-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:48634 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab3AHVTU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jan 2013 16:19:20 -0500
Received: by mail-lb0-f169.google.com with SMTP id gk1so732256lbb.28
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jan 2013 13:19:19 -0800 (PST)
In-Reply-To: <1357638169-23321-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org

On 8 January 2013 10:42, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> devm_regulator_get is device managed and saves some cleanup
> and exit code.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Compile tested against linux-next tree (20130108).
> ---
>  drivers/mmc/host/mmci.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 1507723..3ef9b1f 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1386,7 +1386,7 @@ static int mmci_probe(struct amba_device *dev,
>
>  #ifdef CONFIG_REGULATOR
>         /* If we're using the regulator framework, try to fetch a regulator */
> -       host->vcc = regulator_get(&dev->dev, "vmmc");
> +       host->vcc = devm_regulator_get(&dev->dev, "vmmc");

This is not needed. Host drivers shall instead use
mmc_regulator_get_supply API, which is already doing
devm_regulator_get. A patch for mmci to use mmc_regulator_get_supply
API has already been merged through Russell King's ARM tree.

>         if (IS_ERR(host->vcc))
>                 host->vcc = NULL;
>         else {
> @@ -1587,7 +1587,6 @@ static int mmci_remove(struct amba_device *dev)
>
>                 if (host->vcc)
>                         mmc_regulator_set_ocr(mmc, host->vcc, 0);
> -               regulator_put(host->vcc);
>
>                 mmc_free_host(mmc);
>
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson

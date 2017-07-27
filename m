From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 038/102] mmc: dw_mmc: explicitly request exclusive reset control
Date: Thu, 27 Jul 2017 16:48:50 +0200
Message-ID: <CAPDyKFp5Hu1jfhv3YnZQbC7khrr_DoKn2MKnbHmVwLMTR5GEsA@mail.gmail.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de> <20170719152646.25903-39-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35455 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdG0Osw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2017 10:48:52 -0400
Received: by mail-qt0-f175.google.com with SMTP id p3so62168490qtg.2
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2017 07:48:52 -0700 (PDT)
In-Reply-To: <20170719152646.25903-39-p.zabel@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 19 July 2017 at 17:25, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
>
> No functional changes.
>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a9dfb26972f21..7c1e2dbc76776 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2950,7 +2950,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>                 return ERR_PTR(-ENOMEM);
>
>         /* find reset controller when exist */
> -       pdata->rstc = devm_reset_control_get_optional(dev, "reset");
> +       pdata->rstc = devm_reset_control_get_optional_exclusive(dev, "reset");
>         if (IS_ERR(pdata->rstc)) {
>                 if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
>                         return ERR_PTR(-EPROBE_DEFER);
> --
> 2.11.0
>

From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/3] mmc: davinci: Remove redundant of_match_ptr
Date: Mon, 21 Oct 2013 08:37:43 +0530
Message-ID: <CAK9yfHzbWebair599Tr3u+Nrm_ypX0O8b7JPQLZ-aKUfe=ZWdQ@mail.gmail.com>
References: <1380517173-10537-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33068 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab3JUDHn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Oct 2013 23:07:43 -0400
Received: by mail-pd0-f182.google.com with SMTP id q10so5554909pdj.41
        for <linux-mmc@vger.kernel.org>; Sun, 20 Oct 2013 20:07:43 -0700 (PDT)
In-Reply-To: <1380517173-10537-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sachin Kamat <sachin.kamat@linaro.org>

On 30 September 2013 10:29, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/davinci_mmc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index e9fa87d..39b311e 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1193,7 +1193,7 @@ static struct davinci_mmc_config
>         struct device_node *np;
>         struct davinci_mmc_config *pdata = pdev->dev.platform_data;
>         const struct of_device_id *match =
> -               of_match_device(of_match_ptr(davinci_mmc_dt_ids), &pdev->dev);
> +               of_match_device(davinci_mmc_dt_ids, &pdev->dev);
>         u32 data;
>
>         np = pdev->dev.of_node;
> @@ -1484,7 +1484,7 @@ static struct platform_driver davinci_mmcsd_driver = {
>                 .name   = "davinci_mmc",
>                 .owner  = THIS_MODULE,
>                 .pm     = davinci_mmcsd_pm_ops,
> -               .of_match_table = of_match_ptr(davinci_mmc_dt_ids),
> +               .of_match_table = davinci_mmc_dt_ids,
>         },
>         .remove         = __exit_p(davinci_mmcsd_remove),
>         .id_table       = davinci_mmc_devtype,
> --
> 1.7.9.5
>

Gentle ping on this series, Chris.


-- 
With warm regards,
Sachin

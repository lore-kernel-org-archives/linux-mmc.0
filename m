From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: fix the wrong condition checking
Date: Mon, 10 Aug 2015 22:36:40 +0530
Message-ID: <CAGOxZ50G8hYZcArL+ybzyMcBaJpT-4JWYaVcso-qLqzQZMPdjA@mail.gmail.com>
References: <1438845806-4486-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35592 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbbHJRHV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Aug 2015 13:07:21 -0400
Received: by qgj62 with SMTP id 62so96695630qgj.2
        for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2015 10:07:20 -0700 (PDT)
In-Reply-To: <1438845806-4486-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Jaehoon

On Thu, Aug 6, 2015 at 12:53 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>
> When num-slots is lower than 1, it's right that should be returned -ENODEV.
>
make sense.

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>

> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3c0e199..de88e64 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2760,7 +2760,7 @@ int dw_mci_probe(struct dw_mci *host)
>                 }
>         }
>
> -       if (host->pdata->num_slots > 1) {
> +       if (host->pdata->num_slots < 1) {
>                 dev_err(host->dev,
>                         "Platform data must supply num_slots.\n");
>                 return -ENODEV;
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
Regards,
Alim

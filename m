From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] mmc: Remove redundant null check before kfree in sdio_bus.c
Date: Mon, 26 Nov 2012 16:02:57 +0530
Message-ID: <CAK9yfHz3rDwJ7H71xKesxZckoT3B=b-vde6FTBzUkv9EsENiiQ@mail.gmail.com>
References: <1353402797-6785-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:47844 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504Ab2KZKc6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 05:32:58 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so7437849vcm.19
        for <linux-mmc@vger.kernel.org>; Mon, 26 Nov 2012 02:32:58 -0800 (PST)
In-Reply-To: <1353402797-6785-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

Hi Chris

Any comments on these 2 patches?

On 20 November 2012 14:43, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> kfree on a null pointer is a no-op.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/core/sdio_bus.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 6bf6879..fdcf9e3 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -258,8 +258,7 @@ static void sdio_release_func(struct device *dev)
>
>         sdio_free_func_cis(func);
>
> -       if (func->info)
> -               kfree(func->info);
> +       kfree(func->info);
>
>         kfree(func);
>  }
> --
> 1.7.4.1
>



-- 
With warm regards,
Sachin

From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: vub300: Staticize vub300_init_card
Date: Fri, 2 Aug 2013 14:19:08 +0530
Message-ID: <CAK9yfHxL-EYNfCpAv8Y7hLZ8BfZ914t_c44p5sHjbvJM4TB4=Q@mail.gmail.com>
References: <1372228350-6375-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50229 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab3HBItJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2013 04:49:09 -0400
Received: by mail-oa0-f46.google.com with SMTP id l10so797852oag.5
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2013 01:49:09 -0700 (PDT)
In-Reply-To: <1372228350-6375-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, tony.olech@elandigitalsystems.com, sachin.kamat@linaro.org

On 26 June 2013 12:02, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> 'vub300_init_card' is used only in this file. Make it
> static.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/vub300.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index cb9f361..e9028ad 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2079,7 +2079,7 @@ static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
>         kref_put(&vub300->kref, vub300_delete);
>  }
>
> -void vub300_init_card(struct mmc_host *mmc, struct mmc_card *card)
> +static void vub300_init_card(struct mmc_host *mmc, struct mmc_card *card)
>  {                              /* NOT irq */
>         struct vub300_mmc_host *vub300 = mmc_priv(mmc);
>         dev_info(&vub300->udev->dev, "NO host QUIRKS for this card\n");
> --
> 1.7.9.5
>

Chris,

Any comments on this patch?

-- 
With warm regards,
Sachin

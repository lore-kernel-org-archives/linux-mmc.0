From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 7/7] mmc: dw_mmc: restore the card-present checking point
Date: Thu, 6 Mar 2014 08:36:37 +0100
Message-ID: <CAPDyKFqGzWrQ6W=mHc2MVH6ypr+kwkD+0HXkgtzmCztrJF9bVg@mail.gmail.com>
References: <5313EAC0.9040600@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:59751 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbaCFHgi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Mar 2014 02:36:38 -0500
Received: by mail-qa0-f51.google.com with SMTP id cm18so2118722qab.10
        for <linux-mmc@vger.kernel.org>; Wed, 05 Mar 2014 23:36:37 -0800 (PST)
In-Reply-To: <5313EAC0.9040600@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

On 3 March 2014 03:36, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Restore the card-present cheching point.
> (The following part was removed from commit bf626e5(mmc: dw_mmc: use slot-gpio to handle cd pin).)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/dw_mmc.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 22184c1..ab4c86d 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2113,6 +2113,11 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  #endif /* CONFIG_MMC_DW_IDMAC */
>         }
>
> +       if (dw_mci_get_cd(mmc))
> +               set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> +       else
> +               clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> +
>         ret = mmc_add_host(mmc);
>         if (ret)
>                 goto err_setup_bus;
> --
> 1.7.9.5

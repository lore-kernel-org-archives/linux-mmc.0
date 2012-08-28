From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v2 5/5] mmc: dw-mmc: fix the present flags for card detect
Date: Tue, 28 Aug 2012 19:34:01 +0530
Message-ID: <CAJuYYwQck2zXjQ9A5-m+cQd4DB55oBc4geJ35DEUQCYXdEDVWA@mail.gmail.com>
References: <503C7981.5050209@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59371 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751713Ab2H1OEC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 10:04:02 -0400
Received: by lagy9 with SMTP id y9so3299690lag.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Aug 2012 07:04:01 -0700 (PDT)
In-Reply-To: <503C7981.5050209@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

On 28 August 2012 13:25, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> dw_mci_get_cd() is registered to call-back function.
> If call host->ops->get_cd(), host didn't set any card present flag.
> Then host didn't know whether card is present or not.
> This patch fixed them.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Singed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3642455..8a87d38 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -909,10 +909,13 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>                 present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
>                         == 0 ? 1 : 0;
>
> -       if (present)
> +       if (present) {
> +               set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>                 dev_dbg(&mmc->class_dev, "card is present\n");
> -       else
> +       } else {
> +               clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>                 dev_dbg(&mmc->class_dev, "card is not present\n");
> +       }
>
>         return present;
>  }
> --
> 1.7.4.1

Isn't this already done in dw_mci_init_slot() function and other
places in the driver? I have tested with card insert/removal multiple
times and did not notice any failure.

Thanks,
Thomas.

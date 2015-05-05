From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdio: add reset callback to bus operations
Date: Tue, 5 May 2015 10:33:19 +0200
Message-ID: <CAPDyKFppaHQ1TQ5jdLA4Nf6pfpSKegU22=WA0WqsV55tRiMpaQ@mail.gmail.com>
References: <1429787742-4876-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36047 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782AbbEEIdU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 04:33:20 -0400
Received: by qgeb100 with SMTP id b100so77574927qge.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 01:33:20 -0700 (PDT)
In-Reply-To: <1429787742-4876-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, NeilBrown <neilb@suse.de>

On 23 April 2015 at 13:15, Andreas Fenkart <afenkart@gmail.com> wrote:
> Some drivers schedule automatic hw resets. An example is mwifiex,
> which schedules a card reset if the command handler between driver
> and card firmware becomes out of sync
>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

Thanks, applied!

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index ce6cc47..01255ef 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1064,6 +1064,12 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
>         return mmc_sdio_power_restore(host);
>  }
>
> +static int mmc_sdio_reset(struct mmc_host *host)
> +{
> +       mmc_power_cycle(host, host->card->ocr);
> +       return mmc_sdio_power_restore(host);
> +}
> +
>  static const struct mmc_bus_ops mmc_sdio_ops = {
>         .remove = mmc_sdio_remove,
>         .detect = mmc_sdio_detect,
> @@ -1074,6 +1080,7 @@ static const struct mmc_bus_ops mmc_sdio_ops = {
>         .runtime_resume = mmc_sdio_runtime_resume,
>         .power_restore = mmc_sdio_power_restore,
>         .alive = mmc_sdio_alive,
> +       .reset = mmc_sdio_reset,
>  };
>
>
> --
> 2.1.4
>

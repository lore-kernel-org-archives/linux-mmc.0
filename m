From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 02/18] mmc: meson-gx: remove code for unsupported CMD23
Date: Wed, 15 Feb 2017 08:54:00 -0800
Message-ID: <m2wpcrbdjr.fsf@baylibre.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
        <642a46aa-416c-32a3-f9ef-3feafca72636@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35263 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdBOQyD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 11:54:03 -0500
Received: by mail-pg0-f42.google.com with SMTP id 16so6377665pgg.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 08:54:02 -0800 (PST)
In-Reply-To: <642a46aa-416c-32a3-f9ef-3feafca72636@gmail.com> (Heiner
        Kallweit's message of "Tue, 14 Feb 2017 21:05:59 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> CMD23 isn't supported on meson-gx and therefore the "set block count"
> command isn't used. So remove this dead code.

I'm admittedly a bit unfamiliar with the MMC spec and wrote this driver
mostly by looking at the vendor driver, so forgive the silly
questions...

Why isn't CMD23 supported, and should we support instead of deleting
this support?

Kevin

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 1ad66f84..e89bdf5f 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -555,11 +555,7 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	writel(0, host->regs + SD_EMMC_START);
>  
>  	host->mrq = mrq;
> -
> -	if (mrq->sbc)
> -		meson_mmc_start_cmd(mmc, mrq->sbc);
> -	else
> -		meson_mmc_start_cmd(mmc, mrq->cmd);
> +	meson_mmc_start_cmd(mmc, mrq->cmd);
>  }
>  
>  static int meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
> @@ -690,7 +686,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>  	}
>  
>  	meson_mmc_read_resp(host->mmc, cmd);
> -	if (!data || !data->stop || mrq->sbc)
> +	if (!data || !data->stop)
>  		meson_mmc_request_done(host->mmc, mrq);
>  	else
>  		meson_mmc_start_cmd(host->mmc, data->stop);

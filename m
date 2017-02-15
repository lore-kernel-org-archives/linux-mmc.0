From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 08/18] mmc: meson-gx: make two functions return void
Date: Wed, 15 Feb 2017 09:18:28 -0800
Message-ID: <m2mvdn9xuj.fsf@baylibre.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
        <65a6f6a8-b650-81e9-2b3c-85d3dc89b9ba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36811 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdBORSb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 12:18:31 -0500
Received: by mail-pf0-f170.google.com with SMTP id 189so32910337pfu.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 09:18:31 -0800 (PST)
In-Reply-To: <65a6f6a8-b650-81e9-2b3c-85d3dc89b9ba@gmail.com> (Heiner
        Kallweit's message of "Tue, 14 Feb 2017 21:06:35 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> The return value of meson_mmc_request_done and meson_mmc_read_resp
> isn't used, so make both functions return void.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index f3963538..a67c811e 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -421,7 +421,8 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  			__func__, orig, val);
>  }
>  
> -static int meson_mmc_request_done(struct mmc_host *mmc, struct mmc_request *mrq)
> +static void meson_mmc_request_done(struct mmc_host *mmc,
> +				   struct mmc_request *mrq)
>  {
>  	struct meson_host *host = mmc_priv(mmc);
>  
> @@ -430,8 +431,6 @@ static int meson_mmc_request_done(struct mmc_host *mmc, struct mmc_request *mrq)
>  	host->mrq = NULL;
>  	host->cmd = NULL;
>  	mmc_request_done(host->mmc, mrq);
> -
> -	return 0;
>  }
>  
>  static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
> @@ -537,7 +536,7 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	meson_mmc_start_cmd(mmc, mrq->cmd);
>  }
>  
> -static int meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
> +static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>  {
>  	struct meson_host *host = mmc_priv(mmc);
>  
> @@ -549,8 +548,6 @@ static int meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>  	} else if (cmd->flags & MMC_RSP_PRESENT) {
>  		cmd->resp[0] = readl(host->regs + SD_EMMC_CMD_RSP);
>  	}
> -
> -	return 0;
>  }
>  
>  static irqreturn_t meson_mmc_irq(int irq, void *dev_id)

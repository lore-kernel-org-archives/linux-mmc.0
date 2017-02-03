From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 4/9] mmc: meson-gx: improve meson_mmc_irq_thread
Date: Fri, 03 Feb 2017 10:03:28 -0800
Message-ID: <7h4m0bw3rj.fsf@baylibre.com>
References: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
        <460d2337-7865-6c9c-21b6-98c2ea070926@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36861 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdBCSDb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 13:03:31 -0500
Received: by mail-pf0-f176.google.com with SMTP id 189so7480072pfu.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 10:03:31 -0800 (PST)
In-Reply-To: <460d2337-7865-6c9c-21b6-98c2ea070926@gmail.com> (Heiner
        Kallweit's message of "Wed, 1 Feb 2017 07:48:49 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Remove unneeded variable ret and simplify the if block.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - no changes

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 529a4f22..4ce4c640 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -670,7 +670,6 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>  	struct mmc_command *cmd = host->cmd;
>  	struct mmc_data *data;
>  	unsigned int xfer_bytes;
> -	int ret = IRQ_HANDLED;
>  
>  	if (WARN_ON(!mrq))
>  		return IRQ_NONE;
> @@ -679,14 +678,12 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>  		return IRQ_NONE;
>  
>  	data = cmd->data;
> -	if (data) {
> +	if (data && data->flags & MMC_DATA_READ) {
>  		xfer_bytes = data->blksz * data->blocks;
> -		if (data->flags & MMC_DATA_READ) {
> -			WARN_ON(xfer_bytes > host->bounce_buf_size);
> -			sg_copy_from_buffer(data->sg, data->sg_len,
> -					    host->bounce_buf, xfer_bytes);
> -			data->bytes_xfered = xfer_bytes;
> -		}
> +		WARN_ON(xfer_bytes > host->bounce_buf_size);
> +		sg_copy_from_buffer(data->sg, data->sg_len,
> +				    host->bounce_buf, xfer_bytes);
> +		data->bytes_xfered = xfer_bytes;
>  	}
>  
>  	meson_mmc_read_resp(host->mmc, cmd);
> @@ -695,7 +692,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>  	else
>  		meson_mmc_start_cmd(host->mmc, data->stop);
>  
> -	return ret;
> +	return IRQ_HANDLED;
>  }
>  
>  /*

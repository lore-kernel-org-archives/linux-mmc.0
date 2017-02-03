From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 8/9] mmc: meson-gx: remove unneeded checks in remove
Date: Fri, 03 Feb 2017 10:20:38 -0800
Message-ID: <7hr33fuoeh.fsf@baylibre.com>
References: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
        <abf8a44d-7381-ea1f-44c6-27ccec3f647d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35965 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbdBCSUp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 13:20:45 -0500
Received: by mail-pg0-f49.google.com with SMTP id v184so8514714pgv.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 10:20:45 -0800 (PST)
In-Reply-To: <abf8a44d-7381-ea1f-44c6-27ccec3f647d@gmail.com> (Heiner
        Kallweit's message of "Wed, 1 Feb 2017 07:49:27 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> The remove callback is called only if probe finished successfully.
> Therefore these checks are not needed.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>


> ---
> v2:
> - no changes
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 48ce4ba4..bc787444 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -811,15 +811,11 @@ static int meson_mmc_remove(struct platform_device *pdev)
>  {
>  	struct meson_host *host = dev_get_drvdata(&pdev->dev);
>  
> -	if (WARN_ON(!host))
> -		return 0;
> -
>  	/* disable interrupts */
>  	writel(0, host->regs + SD_EMMC_IRQ_EN);
>  
> -	if (host->bounce_buf)
> -		dma_free_coherent(host->dev, host->bounce_buf_size,
> -				  host->bounce_buf, host->bounce_dma_addr);
> +	dma_free_coherent(host->dev, host->bounce_buf_size,
> +			  host->bounce_buf, host->bounce_dma_addr);
>  
>  	clk_disable_unprepare(host->cfg_div_clk);
>  	clk_disable_unprepare(host->core_clk);

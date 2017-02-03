From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 5/9] mmc: meson-gx: improve interrupt handling
Date: Fri, 03 Feb 2017 10:10:27 -0800
Message-ID: <7hzii3uovg.fsf@baylibre.com>
References: <584e5061-d359-1436-05ee-3767a5a4b10f@gmail.com>
        <23e1aac3-5761-944a-f3ca-cb88a9e44ad8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35863 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdBCSK3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 13:10:29 -0500
Received: by mail-pg0-f46.google.com with SMTP id v184so8454979pgv.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 10:10:29 -0800 (PST)
In-Reply-To: <23e1aac3-5761-944a-f3ca-cb88a9e44ad8@gmail.com> (Heiner
        Kallweit's message of "Wed, 1 Feb 2017 07:48:58 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Disabling and immediately re-enabling interrupts in meson_mmc_request
> doesn't provide a benefit. Instead enable interrupts in probe already.
> And disable interrupts in remove, this was missing so far.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

This isn't quite functionaly equivalent...

> ---
> v2:
> - no changes
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 4ce4c640..0fba23d2 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -546,11 +546,6 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	/* Stop execution */
>  	writel(0, host->regs + SD_EMMC_START);
>  
> -	/* clear, ack, enable all interrupts */
> -	writel(0, host->regs + SD_EMMC_IRQ_EN);
> -	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
> -	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
> -
>  	host->mrq = mrq;
>  
>  	if (mrq->sbc)
> @@ -777,8 +772,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  	writel(0, host->regs + SD_EMMC_START);
>  
>  	/* clear, ack, enable all interrupts */
> -	writel(0, host->regs + SD_EMMC_IRQ_EN);

I'm not sure about this part.  Without the "disable all" here...

>  	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);

... this ack could cause an interrupt to fire, if one was pending based
on boot firmware activity.  I did notice this during driver development
on some boards, which is why the "disable all" was added.

That may have been an artifact of a buggy driver during development, but
I left it in anyways.

> +	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
>  
>  	ret = devm_request_threaded_irq(&pdev->dev, host->irq,
>  					meson_mmc_irq, meson_mmc_irq_thread,
> @@ -816,6 +811,9 @@ static int meson_mmc_remove(struct platform_device *pdev)
>  	if (WARN_ON(!host))
>  		return 0;
>  
> +	/* disable interrupts */
> +	writel(0, host->regs + SD_EMMC_IRQ_EN);
> +
>  	if (host->bounce_buf)
>  		dma_free_coherent(host->dev, host->bounce_buf_size,
>  				  host->bounce_buf, host->bounce_dma_addr);

Other than the nit above, the rest of the cleanup looks fine.

If you leave in the "disable all" during probe,

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin


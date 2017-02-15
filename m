From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 09/18] mmc: meson-gx: change interrupt name
Date: Wed, 15 Feb 2017 12:34:02 +0000
Message-ID: <7ccaed3c-199c-2897-5280-2790ce3676ea@codethink.co.uk>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
 <cbe84305-803a-5431-9246-0b30d6f135b0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imap0.codethink.co.uk ([185.43.218.159]:45561 "EHLO
        imap0.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdBOMeN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 07:34:13 -0500
In-Reply-To: <cbe84305-803a-5431-9246-0b30d6f135b0@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 14/02/17 20:06, Heiner Kallweit wrote:
> So far the driver name is used for the interrupt. Therefore in
> /proc/interrupts we can't tell which interrupt belongs to which
> SD_EMMC port.
> So let's use the device name instead (what is the OF node name).
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index a67c811e..1a76c925 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -757,9 +757,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
>  	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
>
> -	ret = devm_request_threaded_irq(&pdev->dev, host->irq,
> -					meson_mmc_irq, meson_mmc_irq_thread,
> -					IRQF_SHARED, DRIVER_NAME, host);
> +	ret = devm_request_threaded_irq(&pdev->dev, host->irq, meson_mmc_irq,
> +					meson_mmc_irq_thread, IRQF_SHARED,
> +					dev_name(&pdev->dev), host);
>  	if (ret)
>  		goto free_host;
>

I am surpised that the default is not to use dev_name(dev), I wonder if
that should be something that devm_request_threaded_irq() could be
updated to do.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pxamci: prepare and unprepare the clocks
Date: Mon, 1 Sep 2014 12:31:04 +0200
Message-ID: <CAPDyKFr2SXz2yco5jzbkmrRZvCNQNbA7OjjX=WAtmcBJ1vYynw@mail.gmail.com>
References: <1402343774-1072-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:64644 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbaIAKbH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Sep 2014 06:31:07 -0400
Received: by mail-la0-f48.google.com with SMTP id gl10so5908156lab.35
        for <linux-mmc@vger.kernel.org>; Mon, 01 Sep 2014 03:31:04 -0700 (PDT)
In-Reply-To: <1402343774-1072-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 9 June 2014 21:56, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Add the clock prepare and unprepare call to the driver initialization
> phase. This will remove a warning once the PXA architecture is migrated
> to the clock infrastructure.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/mmc/host/pxamci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 32fe113..f0f2074 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -681,6 +681,9 @@ static int pxamci_probe(struct platform_device *pdev)
>                 host->clk = NULL;
>                 goto out;
>         }
> +       ret = clk_prepare(host->clk);
> +       if (ret)
> +               goto out;
>
>         host->clkrate = clk_get_rate(host->clk);
>
> @@ -820,8 +823,10 @@ err_gpio_ro:
>                         iounmap(host->base);
>                 if (host->sg_cpu)
>                         dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
> -               if (host->clk)
> +               if (host->clk) {
> +                       clk_unprepare(host->clk);
>                         clk_put(host->clk);
> +               }
>         }
>         if (mmc)
>                 mmc_free_host(mmc);
> @@ -871,6 +876,7 @@ static int pxamci_remove(struct platform_device *pdev)
>                 iounmap(host->base);
>                 dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>
> +               clk_unprepare(host->clk);
>                 clk_put(host->clk);
>
>                 release_resource(host->res);
> --
> 2.0.0.rc2
>

I would suggest you to re-place the existing clk_enable() with
clk_prepare_enable() and clk_disable with clk_disable_unprepare()
instead of the approach taken in this patch.

Kind regards
Uffe

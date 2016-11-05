From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2] mmc: mxs: Initialize the spinlock prior to using it
Date: Sat, 5 Nov 2016 20:42:28 +0100 (CET)
Message-ID: <2084434059.163305.cc1bc76f-9bb1-4e7c-b1f9-271fed9f6c41.open-xchange@email.1und1.de>
References: <1478373803-31815-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1478373803-31815-1-git-send-email-festevam@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, ulf.hansson@linaro.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, marex@denx.de, Fabio Estevam <fabio.estevam@nxp.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Fabio,

> Fabio Estevam <festevam@gmail.com> hat am 5. November 2016 um 20:23
> geschrieben:
> 
> 
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> An interrupt may occur right after devm_request_irq() is called and
> prior to the spinlock initialization, leading to a kernel oops,
> as the interrupt handler uses the spinlock.
> 
> In order to prevent this problem, move the spinlock initialization 
> prior to requesting the interrupts.
> 
> Cc: <stable@vger.kernel.org>

my intention was to add something like this:

Fixes: e4243f13d10e (mmc: mxs-mmc: add mmc host driver for i.MX23/28)

because it's a bugfix. I wasn't absolutly sure it's a stable candidate.

Thanks
Stefan

> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
> Changes since v1:
> - Make it a standalone patch instead of patch series
> - Cc stable as suggested by Stefan
> 
>  drivers/mmc/host/mxs-mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index d839147..44ecebd 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -661,13 +661,13 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mmc);
>  
> +	spin_lock_init(&host->lock);
> +
>  	ret = devm_request_irq(&pdev->dev, irq_err, mxs_mmc_irq_handler, 0,
>  			       dev_name(&pdev->dev), host);
>  	if (ret)
>  		goto out_free_dma;
>  
> -	spin_lock_init(&host->lock);
> -
>  	ret = mmc_add_host(mmc);
>  	if (ret)
>  		goto out_free_dma;
> -- 
> 2.7.4
>

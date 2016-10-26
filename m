From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: s3cmci: Use DMA slave map rather than exported DMA filter
Date: Wed, 26 Oct 2016 11:21:28 +0200
Message-ID: <4067826.3L3geWCA41@wuerfel>
References: <1477472907-5932-1-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1477472907-5932-1-git-send-email-s.nawrocki@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: ulf.hansson@linaro.org, linux-samsung-soc@vger.kernel.org, sam.van.den.berge@telenet.be, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday, October 26, 2016 11:08:27 AM CEST Sylwester Nawrocki wrote:
> @@ -1685,13 +1684,7 @@ static int s3cmci_probe(struct platform_device *pdev)
>         /* depending on the dma state, get a dma channel to use. */
>  
>         if (s3cmci_host_usedma(host)) {
> -               dma_cap_mask_t mask;
> -
> -               dma_cap_zero(mask);
> -               dma_cap_set(DMA_SLAVE, mask);
> -
> -               host->dma = dma_request_slave_channel_compat(mask,
> -                       s3c24xx_dma_filter, (void *)DMACH_SDI, &pdev->dev, "rx-tx");
> +               host->dma = dma_request_slave_channel(&pdev->dev, "rx-tx");
>                 if (!host->dma) {
>                         dev_err(&pdev->dev, "cannot get DMA channel.\n");
>                         ret = -EBUSY;

Can you convert it to use dma_request_chan()+PTR_ERR_OR_ZERO() instead?

Otherwise looks good, thanks for looking into this!

	Arnd

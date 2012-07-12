From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: ensure probe returns error upon resource failure
Date: Thu, 12 Jul 2012 11:49:13 +0530
Message-ID: <CANfBPZ8afVFt8UFr2Bi1M=NYbr_W0oH5ZOy90EXdQ9zaVm63dQ@mail.gmail.com>
References: <1341963658-20896-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:57213 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752340Ab2GLGTg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jul 2012 02:19:36 -0400
Received: by bkcji1 with SMTP id ji1so1781755bkc.18
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jul 2012 23:19:33 -0700 (PDT)
In-Reply-To: <1341963658-20896-1-git-send-email-khilman@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, open list <linux-kernel@vger.kernel.org>

On Wed, Jul 11, 2012 at 5:10 AM, Kevin Hilman <khilman@ti.com> wrote:
> If platform_get_resource_by_name() fails, driver probe is aborted an
> should return an error so the driver is not bound to the device.
>
> However, in the current error path of platform_get_resource_by_name(),
> probe returns zero since the return value (ret) is not properly set.
> With a zero return value, the driver core assumes probe was successful
> and will bind the driver to the device.
>
> Fix this by ensuring that probe returns an error code in this failure
> path.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Good catch.
Acked-by: Venkatraman S <svenkatr@ti.com>


> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 389a3ee..19e60e9 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1931,6 +1931,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>         res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
>         if (!res) {
>                 dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> +               ret = -ENXIO;
>                 goto err_irq;
>         }
>         host->dma_line_tx = res->start;
> @@ -1938,6 +1939,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>         res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
>         if (!res) {
>                 dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> +               ret = -ENXIO;
>                 goto err_irq;
>         }
>         host->dma_line_rx = res->start;
> --
> 1.7.9.2
>

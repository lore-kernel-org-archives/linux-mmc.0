From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] mmc_spi: add a status check for spi_sync_locked
Date: Sun, 10 Mar 2019 14:58:41 +0200
Message-ID: <20190310125841.GA4814@pendragon.ideasonboard.com>
References: <20190310075306.2193-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190310075306.2193-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Kangjie,

Thank you for the patch.

On Sun, Mar 10, 2019 at 01:53:05AM -0600, Kangjie Lu wrote:
> In case spi_sync_locked fails, the fix reports the error and
> returns the error code upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/mmc/host/mmc_spi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 1b1498805972..32fea585262b 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -819,6 +819,10 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
>  	}
>  
>  	status = spi_sync_locked(spi, &host->m);
> +	if (status < 0) {
> +		dev_dbg(&spi->dev, "read error %02x (%d)\n", status, status);

I don't think you need to print the status in both hex and in decimal
forms. %d should be enough, error codes are usually printed in decimal
in the kernel. Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		return status;
> +	}
>  
>  	if (host->dma_dev) {
>  		dma_sync_single_for_cpu(host->dma_dev,

-- 
Regards,

Laurent Pinchart

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2] mmc_spi: add a status check for spi_sync_locked
Date: Mon, 11 Mar 2019 10:25:20 +0200
Message-ID: <20190311082520.GB4775@pendragon.ideasonboard.com>
References: <20190311055334.13670-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311055334.13670-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Kangjie,

Thank you for the patch.

On Mon, Mar 11, 2019 at 12:53:33AM -0500, Kangjie Lu wrote:
> In case spi_sync_locked fails, the fix reports the error and
> returns the error code upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/mmc/host/mmc_spi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 1b1498805972..a3533935e282 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -819,6 +819,10 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
>  	}
>  
>  	status = spi_sync_locked(spi, &host->m);
> +	if (status < 0) {
> +		dev_dbg(&spi->dev, "read error %d\n", status);
> +		return status;
> +	}
>  
>  	if (host->dma_dev) {
>  		dma_sync_single_for_cpu(host->dma_dev,

-- 
Regards,

Laurent Pinchart

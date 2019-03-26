From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] net: liquidio: fix NULL pointer dereferences
Date: Mon, 25 Mar 2019 17:14:28 -0700 (PDT)
Message-ID: <20190325.171428.816775455885557497.davem@davemloft.net>
References: <20190311.121710.968693621648443243.davem@davemloft.net>
        <20190323032420.21162-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190323032420.21162-1-kjlu@umn.edu>
Sender: netdev-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, ulf.hansson@linaro.org, dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com, linus.walleij@linaro.org, laurent.pinchart+renesas@ideasonboard.com, j.neuschaefer@gmx.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Fri, 22 Mar 2019 22:24:19 -0500

> In case octeon_alloc_soft_command fails, the fix reports the
> error and goes to cleanup to avoid NULL pointer dereferences.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> V2: goto setup_nic_dev_free for cleanup
> ---
>  drivers/mmc/host/mmc_spi.c                         |  2 +-
>  drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 32fea585262b..a3533935e282 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -820,7 +820,7 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
>  
>  	status = spi_sync_locked(spi, &host->m);
>  	if (status < 0) {
> -		dev_dbg(&spi->dev, "read error %02x (%d)\n", status, status);
> +		dev_dbg(&spi->dev, "read error %d\n", status);
>  		return status;
>  	}

This is:

1) Unrelated to your bug fix.

2) It is often the case that people print values in hex and decimal
   intentionally for debugging.  I've done this myself countless
   times.

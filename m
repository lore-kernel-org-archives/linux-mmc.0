From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/9] mmc: tmio: tmio_mmc_host has .dma
Date: Mon, 05 Jan 2015 09:43:27 +0100
Message-ID: <4405974.QQJ6fqAfNe@wuerfel>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com> <87wq51ogjx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87wq51ogjx.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Monday 05 January 2015 07:02:41 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current .dma is implemented under tmio_mmc_data.
> It goes to tmio_mmc_host by this patch.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

The patch looks good, just like the rest of the series, but there is
one aspect that I think would make sense to clean up at the same time,
since you are already touching all those lines:

> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 3d02a3c1..4c5eda8 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -40,6 +40,16 @@
>  
>  struct tmio_mmc_data;
>  
> +struct tmio_mmc_dma {
> +	void *chan_priv_tx;
> +	void *chan_priv_rx;
> +	int slave_id_tx;
> +	int slave_id_rx;
> +	int alignment_shift;
> +	dma_addr_t dma_rx_offset;
> +	bool (*filter)(struct dma_chan *chan, void *arg);
> +};

The slave_id/chan_priv values are now passed three times into the
driver, and one should really be enough. I'd suggest removing the
integer fields from both tmio_mmc_dma and tmio_mmc_data (added in
patch 9), and instead pass it as a void* argument only to tmio_mmc_data.

The alignment_shift and dma_rx_offset values seem to always be
the same for all users (at least the remaining ones, possibly there
were others originally), so you could hardcode those in tmio_mmc_dma.c
and remove the tmio_mmc_dma structure entirely.

The filter pointer should always be passed in the same structure
as the 'void *chan_priv' argument that is used when calling it, so
that would go into tmio_mmc_data as well if you add the data there.

Alternatively you could keep the tmio_mmc_dma structure and fill
it from the platform, but then only have the filter and void* arguments
in it.

For some obscure reason, the 'pdata->dma->slave_id_?x' fields currently
get passed into cfg.slave_id, which is something we really want to
get rid of so we can remove the slave_id field from dma_slave_config:
The slave ID is generally considered specific to the channel allocation,
not the configuration, and not all dmaengine drivers can express it
as a single integer, so the concept is obsolete. When you remove
the slave_id_?x fields here, you should also be able to just remove
the cfg.slave_id assignment without any replacement, unless there is
a bug in the dmaengine driver that should be fixed instead.

	Arnd

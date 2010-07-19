From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH v2] omap hsmmc: fix processing of all dma interrupts as block completion
Date: Mon, 19 Jul 2010 17:37:29 -0500
Message-ID: <D000741110734C2C922FC8C7967D9E63@am.dhcp.ti.com>
References: <1279272062-9068-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1279272062-9068-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: 'Venkatraman S' <svenkatr@ti.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'linux-omap' <linux-omap@vger.kernel.org>, 'Andrew Morton' <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Venkatraman S [mailto:svenkatr@ti.com]
> Sent: Friday, July 16, 2010 4:21 AM
> To: linux-mmc
> Cc: linux-omap; Venkatraman S; Madhusudhan Chikkature; Andrew Morton
> Subject: [PATCH v2] omap hsmmc: fix processing of all dma interrupts as
> block completion
> 
> If other informative interrupts are enabled for
> the DMA channel used by hsmmc, those are incorrectly
> treated as block completion. This patch lets only the
> block completion interrupt to be processed.
> 
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> CC: Madhusudhan Chikkature <madhu.cr@ti.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> ---
It looks like a valid case to fix.

Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>

>  Changes since v1: better commit log message
> 
>  drivers/mmc/host/omap_hsmmc.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b032828..d2901f8 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1273,8 +1273,11 @@ static void omap_hsmmc_dma_cb(int lch, u16
> ch_status, void *cb_data)
>  	struct mmc_data *data = host->mrq->data;
>  	int dma_ch, req_in_progress;
> 
> -	if (ch_status & OMAP2_DMA_MISALIGNED_ERR_IRQ)
> -		dev_dbg(mmc_dev(host->mmc), "MISALIGNED_ADRS_ERR\n");
> +	if (!(ch_status & OMAP_DMA_BLOCK_IRQ)) {
> +		dev_warn(mmc_dev(host->mmc), "unexpected dma status %x\n",
> +			ch_status);
> +		return;
> +	}
> 
>  	spin_lock(&host->irq_lock);
>  	if (host->dma_ch < 0) {
> --
> 1.6.3.3



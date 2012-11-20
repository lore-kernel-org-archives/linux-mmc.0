From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 1/3] mmc: omap_hsmmc: NULL pointer upon DTO after CC.
Date: Tue, 20 Nov 2012 13:06:43 +0530
Message-ID: <50AB330B.1080500@ti.com>
References: <1353361379-21002-1-git-send-email-andreas.fenkart@streamunlimited.com> <1353361379-21002-2-git-send-email-andreas.fenkart@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35335 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab2KTHhB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 20 Nov 2012 02:37:01 -0500
In-Reply-To: <1353361379-21002-2-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: linux-mmc@vger.kernel.org, david.vrabel@csr.com, daniel@zonque.org

On Tuesday 20 November 2012 03:12 AM, Andreas Fenkart wrote:
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> ---
>   drivers/mmc/host/omap_hsmmc.c |    7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 21ca331..13ef4a0 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -991,9 +991,12 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
>   static void hsmmc_command_incomplete(struct omap_hsmmc_host *host, int err)
>   {
>   	omap_hsmmc_reset_controller_fsm(host, SRC);
> -	host->cmd->error = err;
> +
> +	if (host->cmd)
> +		host->cmd->error = err;
>   
>   	if (host->data) {
> +		host->data->error = err;
>   		omap_hsmmc_reset_controller_fsm(host, SRD);
>   		omap_hsmmc_dma_cleanup(host, err);
>   	}
> @@ -1022,7 +1025,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>   		}
>   	}
>   
> -	if (end_cmd || ((status & CC) && host->cmd))
> +	if ((end_cmd || (status & CC)) && host->cmd)
>   		omap_hsmmc_cmd_done(host, host->cmd);
>   	if ((end_trans || (status & TC)) && host->mrq)
>   		omap_hsmmc_xfer_done(host, data);
Hi Andreas,
   Thanks for this, but it's been fixed already with Balaji's patches 
which I reposted a few hours ago.
Can you please check if it fixes your issues ?
~V

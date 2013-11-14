From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 04/17] mmc: tmio: Add error IRQ status clear
Date: Thu, 14 Nov 2013 14:34:15 +0100
Message-ID: <2948056.D57zXasjs4@avalon>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <87habfz3kd.wl%kuninori.morimoto.gx@renesas.com> <87eh6jz3fi.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87eh6jz3fi.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Thursday 14 November 2013 02:24:37 Kuninori Morimoto wrote:
> From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> 
> After a card is ejected during card access,
> the re-inserted card does not identified.
> It can be identified by clearing error IRQ status.
> 
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/host/tmio_mmc_pio.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c
> b/drivers/mmc/host/tmio_mmc_pio.c index 05ae15c..99f6d29 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -565,6 +565,9 @@ static void tmio_mmc_card_irq_status(struct
> tmio_mmc_host *host,
> 
>  	pr_debug_status(*status);
>  	pr_debug_status(*ireg);
> +
> +	/* Clear the status except the interrupt status */
> +	sd_ctrl_write32(host, CTL_STATUS, TMIO_MASK_IRQ);

You should write *status, not TMIO_MASK_IRQ, or you could loose an interrupt 
if it gets triggered between the status read and status write.

>  }
> 
>  static bool __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
-- 
Regards,

Laurent Pinchart


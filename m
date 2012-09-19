From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Subject: Re: [PATCH] mmc: sh-mmcif: properly handle MMC_WRITE_MULTIPLE_BLOCK
 completion IRQ
Date: Wed, 19 Sep 2012 11:50:17 +0900
Message-ID: <505932E9.8050202@kmckk.co.jp>
References: <Pine.LNX.4.64.1209190105080.31203@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vrgw7.firstserver.ne.jp ([164.46.1.105]:44023 "EHLO
	vrgw7.firstserver.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab2ISCug (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Sep 2012 22:50:36 -0400
In-Reply-To: <Pine.LNX.4.64.1209190105080.31203@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, yusuke.goda.sx@renesas.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, koba@kmckk.co.jp

(2012/09/19 8:10), Guennadi Liakhovetski wrote:
> Upon completion of a MMC_WRITE_MULTIPLE_BLOCK command MMCIF issues an IRQ
> with the DTRANE bit set and often with one or several of CMD12 bits set.
> If those interrupts are not acknowledged, an additional interrupt can be
> produced and will be delivered later, possibly, when the transaction has
> already been completed. To prevent this from happening, CMD12 completion
> interrupt sources have to be cleared too upon reception of an DTRANE IRQ.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> Tested on kzm9g and mackerel. Kobayashi-san, this fixes spurious
> interrupts, that you are observing.

I verified on kzm9g.
This works with
[PATCH] mmc: sh-mmcif: avoid Oops on spurious interrupts

Tested-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

>
>   drivers/mmc/host/sh_mmcif.c |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 82bf921..387bf63 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1213,7 +1213,9 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
>   		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_BUFRE);
>   		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
>   	} else if (state & INT_DTRANE) {
> -		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_DTRANE);
> +		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
> +			~(INT_CMD12DRE | INT_CMD12RBE |
> +			  INT_CMD12CRE | INT_DTRANE));
>   		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
>   	} else if (state & INT_CMD12RBE) {
>   		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
>


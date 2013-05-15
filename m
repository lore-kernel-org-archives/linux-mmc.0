From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Subject: Re: [PATCH] mmc: mmcif: don't clear masked interrupts
Date: Wed, 15 May 2013 17:39:23 +0900
Message-ID: <519349BB.6080200@jinso.co.jp>
References: <Pine.LNX.4.64.1305150746480.10596@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 219-118-191-131.cust.bit-drive.ne.jp ([219.118.191.131]:58009
	"EHLO mail.omesemicon.co.jp" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751060Ab3EOJEt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 05:04:49 -0400
In-Reply-To: <Pine.LNX.4.64.1305150746480.10596@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>

On 05/15/2013 02:50 PM, Guennadi Liakhovetski wrote:
> Masking events on MMCIF means, an occurrence of the masked event won't raise
> an interrupt, but the event bit will still be set in the interrupt status
> register. If simultaneously a different event occurs, that was enabled, both
> flags will be set. However, only the unmasked event bit should be cleared in
> the status register in such a case. Clearing also the masked bit can lead to
> lost interrupts, which indeed can be observed on the armadillo800eva r8a7740
> board with an eMMC chip. The problem has been introduced by the recent "mmc:
> sh_mmcif: simplify IRQ processing" patch. Fix the problem by only clearing
> enabled interrupts.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

tested-by: Nguyen Viet Dung<nv-dung@jinso.co.jp>

Best regards
Nguyen Viet Dung

> ---
>
> Chris, please, push this fix to 3.10, thanks.
>
>   drivers/mmc/host/sh_mmcif.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index ba76a53..06caaae 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1244,7 +1244,8 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
>   	u32 state;
>   
>   	state = sh_mmcif_readl(host->addr, MMCIF_CE_INT);
> -	sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
> +	sh_mmcif_writel(host->addr, MMCIF_CE_INT,
> +			~(state & sh_mmcif_readl(host->addr, MMCIF_CE_INT_MASK)));
>   	sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state & MASK_CLEAN);
>   
>   	if (state & ~MASK_CLEAN)


From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: correct mishandling error interrupt
Date: Tue, 07 Aug 2012 23:19:08 -0400
Message-ID: <878vdqxe8j.fsf@octavius.laptop.org>
References: <006401cd6f7c$e16605c0$a4321140$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56710 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab2HHDTM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 23:19:12 -0400
In-Reply-To: <006401cd6f7c$e16605c0$a4321140$%jun@samsung.com> (Seungwon
	Jeon's message of "Wed, 01 Aug 2012 09:30:40 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Hi,

On Tue, Jul 31 2012, Seungwon Jeon wrote:
> Datasheet of SYNOPSYS mentions that DTO(Data Transfer Over) interrupt
> will be raised even if some error interrupts, however it is actually
> found that DTO does not occur. SYNOPSYS has confirmed this issue.
> Current implementation defers the call of tasklet_schedule until DTO
> when the error interrupts is happened. This patch fixes error handling.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 7baed45..1a5db20 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1580,9 +1580,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  			host->data_status = pending;
>  			smp_wmb();
>  			set_bit(EVENT_DATA_ERROR, &host->pending_events);
> -			if (!(pending & (SDMMC_INT_DTO | SDMMC_INT_DCRC |
> -					 SDMMC_INT_SBE | SDMMC_INT_EBE)))
> -				tasklet_schedule(&host->tasklet);
> +			tasklet_schedule(&host->tasklet);
>  		}
>  
>  		if (pending & SDMMC_INT_DATA_OVER) {

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

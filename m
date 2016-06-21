From: Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: RE: mmc: dw_mmc: warning with CONFIG_DMA_API_DEBUG
Date: Tue, 21 Jun 2016 11:24:24 +0900
Message-ID: <000801d1cb64$070dfb60$1529f220$@samsung.com>
References: <001501d1cace$9b8f2b60$d2ad8220$@samsung.com>
 <CGME20160621015228epcas1p450d93158cd5028d3c8ab4f7e352ccaff@epcas1p4.samsung.com>
 <a50cabe9-2e41-92be-b886-103e2bb4edba@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:37210 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbcFUC6h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2016 22:58:37 -0400
In-reply-to: <a50cabe9-2e41-92be-b886-103e2bb4edba@rock-chips.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Shawn Lin' <shawn.lin@rock-chips.com>, jh80.chung@samsung.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, sw0312.kim@samsung.com

Hello Shawn,

> -----Original Message-----
> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
> Sent: Tuesday, June 21, 2016 10:52 AM
> To: Seung-Woo Kim; jh80.chung@samsung.com; ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: shawn.lin@rock-chips.com
> Subject: Re: mmc: dw_mmc: warning with CONFIG_DMA_API_DEBUG
> 
> On 2016/6/20 16:34, Seung-Woo Kim wrote:
> > Hi folks,
> >
> > During booting test on my Exynos5422 based Odroid-XU3, kernel compiled
> > with CONFIG_DMA_API_DEBUG reported following warning:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at lib/dma-debug.c:1096 check_unmap+0x7bc/0xb38
> > dwmmc_exynos 12200000.mmc: DMA-API: device driver tries to free DMA memory it has not allocated [device
> address=0x000000006d9d2200]
> 
> Thanks for this report and fix.
> 
> DTO(the same as IDMAC-RI/TI) interrupts may or may not come together
> with DATA_ERR. If DATA_ERR occur without geting DTO, we should issue
> CMD12 manually to generate DTO. It's a ugly deisgn for dwmmc but from
> the vendor's ask.
> 
> So you should never think we complete the xfer without
> checking DATA_ERR. This way you got the warning.
> 
> So could you try this one:

With your patch, there is no more the DMA API waring in my environment.

Best Regards,
- Seung-Woo Kim

> 
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2474,7 +2474,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void
> *dev_id)
>                          mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_TI |
> 
> SDMMC_IDMAC_INT_RI);
>                          mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
> -                       host->dma_ops->complete((void *)host);
> +                       if (!test_bit(EVENT_DATA_ERROR,
> &host->pending_events))
> +                               host->dma_ops->complete((void *)host);
>                  }
>          } else {
>                  pending = mci_readl(host, IDSTS);
> @@ -2482,7 +2483,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void
> *dev_id)
>                          mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI |
> 
> SDMMC_IDMAC_INT_RI);
>                          mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
> -                       host->dma_ops->complete((void *)host);
> +                       if (!test_bit(EVENT_DATA_ERROR,
> &host->pending_events))
> +                               host->dma_ops->complete((void *)host);
>                  }
>          }
> 
> 
> > [size=128 bytes]
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.7.0-rc4 #26
> > Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> > [<c0112b4c>] (unwind_backtrace) from [<c010d888>] (show_stack+0x20/0x24)
> > [<c010d888>] (show_stack) from [<c03fab0c>] (dump_stack+0x80/0x94)
> > [<c03fab0c>] (dump_stack) from [<c0123548>] (__warn+0xf8/0x110)
> > [<c0123548>] (__warn) from [<c01235a8>] (warn_slowpath_fmt+0x48/0x50)
> > [<c01235a8>] (warn_slowpath_fmt) from [<c042ac90>] (check_unmap+0x7bc/0xb38)
> > [<c042ac90>] (check_unmap) from [<c042b25c>] (debug_dma_unmap_sg+0x118/0x148)
> > [<c042b25c>] (debug_dma_unmap_sg) from [<c077512c>] (dw_mci_dma_cleanup+0x7c/0xb8)
> > [<c077512c>] (dw_mci_dma_cleanup) from [<c0773f24>] (dw_mci_stop_dma+0x40/0x50)
> > [<c0773f24>] (dw_mci_stop_dma) from [<c0777d04>] (dw_mci_tasklet_func+0x130/0x3b4)
> > [<c0777d04>] (dw_mci_tasklet_func) from [<c0129760>] (tasklet_action+0xb4/0x150)
> > [<c0129760>] (tasklet_action) from [<c0101674>] (__do_softirq+0xe4/0x3cc)
> > [<c0101674>] (__do_softirq) from [<c0129030>] (irq_exit+0xd0/0x10c)
> > [<c0129030>] (irq_exit) from [<c01778a0>] (__handle_domain_irq+0x90/0xfc)
> > [<c01778a0>] (__handle_domain_irq) from [<c0101548>] (gic_handle_irq+0x64/0xa8)
> > [<c0101548>] (gic_handle_irq) from [<c010e3d4>] (__irq_svc+0x54/0x90)
> > Exception stack(0xc1101ef8 to 0xc1101f40)
> > 1ee0:                                                       00000001 00000000
> > 1f00: 00000000 c011b600 c1100000 c110753c 00000000 c11c3984 c11074d4 c1107548
> > 1f20: 00000000 c1101f54 c1101f58 c1101f48 c010a1fc c010a200 60000013 ffffffff
> > [<c010e3d4>] (__irq_svc) from [<c010a200>] (arch_cpu_idle+0x48/0x4c)
> > [<c010a200>] (arch_cpu_idle) from [<c01669d8>] (default_idle_call+0x30/0x3c)
> > [<c01669d8>] (default_idle_call) from [<c0166d3c>] (cpu_startup_entry+0x358/0x3b4)
> > [<c0166d3c>] (cpu_startup_entry) from [<c0aa6ab8>] (rest_init+0x94/0x98)
> > [<c0aa6ab8>] (rest_init) from [<c1000d58>] (start_kernel+0x3a4/0x3b0)
> > [<c1000d58>] (start_kernel) from [<4000807c>] (0x4000807c)
> > ---[ end trace 256f83eed365daf0 ]---
> >
> > The warning occurs because after complete callback function,
> > dw_mci_dmac_complete_dma() is called, then dw_mci_stop_dma() is called
> > again. So it causes dma_unmap_sg() is called twice for same sg. It
> > occurs during clock setting at booting time.
> >
> > Simply, clearing host->using_dma flag on dw_mci_dmac_complete_dma() and
> > dw_mci_stop_dma() like following fixes the issue, but I am not sure
> > this approach is proper.
> > ---
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 2cc6123..a71c94b 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -388,6 +388,7 @@ static void dw_mci_stop_dma(struct dw_mci *host)
> >  	if (host->using_dma) {
> >  		host->dma_ops->stop(host);
> >  		host->dma_ops->cleanup(host);
> > +		host->using_dma = 0;
> >  	}
> >
> >  	/* Data transfer was stopped by the interrupt handler */
> > @@ -455,6 +456,7 @@ static void dw_mci_dmac_complete_dma(void *arg)
> >  				    DMA_FROM_DEVICE);
> >
> >  	host->dma_ops->cleanup(host);
> > +	host->using_dma = 0;
> >
> >  	/*
> >  	 * If the card was removed, data will be NULL. No point in trying to
> > @@ -943,8 +945,6 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
> >  	int sg_len;
> >  	u32 temp;
> >
> > -	host->using_dma = 0;
> > -
> >  	/* If we don't have a channel, we can't do DMA */
> >  	if (!host->use_dma)
> >  		return -ENODEV;
> > ---
> >
> > Best Regards,
> > - Seung-Woo Kim
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> --
> Best Regards
> Shawn Lin
> 



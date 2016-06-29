From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix unmap sg twice when finding data err
Date: Wed, 29 Jun 2016 10:31:06 +0900
Message-ID: <577324DA.9010703@samsung.com>
References: <CGME20160624074117epcas1p4eba42a3173cb5407c951215b0a590368@epcas1p4.samsung.com>
 <1466753992-13727-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1466753992-13727-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On 06/24/2016 04:39 PM, Shawn Lin wrote:
> DATA_OVER(the same for RI/TI of IDMAC) interrupt may come
> up together with data error interrupts. If so, the interrupt
> routine set EVENT_DATA_ERR to the pending_events and schedule
> the tasklet but we may still fallback to the IDMAC interrupt
> case as the tasklet may come up a little late, namely right
> after the IDMAC interrupt checking. This will casue dw_mmc
> unmap sg twice. We can easily see it with CONFIG_DMA_API_DEBUG
> enabled.
> 
> WARNING: CPU: 0 PID: 0 at lib/dma-debug.c:1096 check_unmap+0x7bc/0xb38
> dwmmc_exynos 12200000.mmc: DMA-API: device driver tries to free DMA memory it
> has not allocated [device address=0x000000006d9d2200]
> [size=128 bytes]
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.7.0-rc4 #26
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c0112b4c>] (unwind_backtrace) from [<c010d888>] (show_stack+0x20/0x24)
> [<c010d888>] (show_stack) from [<c03fab0c>] (dump_stack+0x80/0x94)
> [<c03fab0c>] (dump_stack) from [<c0123548>] (__warn+0xf8/0x110)
> [<c0123548>] (__warn) from [<c01235a8>] (warn_slowpath_fmt+0x48/0x50)
> [<c01235a8>] (warn_slowpath_fmt) from [<c042ac90>] (check_unmap+0x7bc/0xb38)
> [<c042ac90>] (check_unmap) from [<c042b25c>] (debug_dma_unmap_sg+0x118/0x148)
> [<c042b25c>] (debug_dma_unmap_sg) from [<c077512c>] (dw_mci_dma_cleanup+0x7c/0xb8)
> [<c077512c>] (dw_mci_dma_cleanup) from [<c0773f24>] (dw_mci_stop_dma+0x40/0x50)
> [<c0773f24>] (dw_mci_stop_dma) from [<c0777d04>] (dw_mci_tasklet_func+0x130/0x3b4)
> [<c0777d04>] (dw_mci_tasklet_func) from [<c0129760>] (tasklet_action+0xb4/0x150)
> [<c0129760>] (tasklet_action) from [<c0101674>] (__do_softirq+0xe4/0x3cc)
> [<c0101674>] (__do_softirq) from [<c0129030>] (irq_exit+0xd0/0x10c)
> [<c0129030>] (irq_exit) from [<c01778a0>] (__handle_domain_irq+0x90/0xfc)
> [<c01778a0>] (__handle_domain_irq) from [<c0101548>] (gic_handle_irq+0x64/0xa8)
> [<c0101548>] (gic_handle_irq) from [<c010e3d4>] (__irq_svc+0x54/0x90)
> Exception stack(0xc1101ef8 to 0xc1101f40)
> 1ee0:                                                       00000001 00000000
> 1f00: 00000000 c011b600 c1100000 c110753c 00000000 c11c3984 c11074d4 c1107548
> 1f20: 00000000 c1101f54 c1101f58 c1101f48 c010a1fc c010a200 60000013 ffffffff
> [<c010e3d4>] (__irq_svc) from [<c010a200>] (arch_cpu_idle+0x48/0x4c)
> [<c010a200>] (arch_cpu_idle) from [<c01669d8>] (default_idle_call+0x30/0x3c)
> [<c01669d8>] (default_idle_call) from [<c0166d3c>] (cpu_startup_entry+0x358/0x3b4)
> [<c0166d3c>] (cpu_startup_entry) from [<c0aa6ab8>] (rest_init+0x94/0x98)
> [<c0aa6ab8>] (rest_init) from [<c1000d58>] (start_kernel+0x3a4/0x3b0)
> [<c1000d58>] (start_kernel) from [<4000807c>] (0x4000807c)
> ---[ end trace 256f83eed365daf0 ]---
> 
> Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied this patch on my repository.
Thanks!

Best Regards,
Jaehoon Chung

> ---
> 
>  drivers/mmc/host/dw_mmc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 8012858..7e88541 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2473,7 +2473,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  			mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_TI |
>  							SDMMC_IDMAC_INT_RI);
>  			mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
> -			host->dma_ops->complete((void *)host);
> +			if (!test_bit(EVENT_DATA_ERROR, &host->pending_events))
> +				host->dma_ops->complete((void *)host);
>  		}
>  	} else {
>  		pending = mci_readl(host, IDSTS);
> @@ -2481,7 +2482,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  			mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI |
>  							SDMMC_IDMAC_INT_RI);
>  			mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
> -			host->dma_ops->complete((void *)host);
> +			if (!test_bit(EVENT_DATA_ERROR, &host->pending_events))
> +				host->dma_ops->complete((void *)host);
>  		}
>  	}
>  
> 

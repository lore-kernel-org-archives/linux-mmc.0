From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()
Date: Thu, 09 Jun 2016 21:38:22 +0900
Message-ID: <5759633E.7090706@samsung.com>
References: <CGME20160608040654epcas1p2be228e3e02e35a640cb1e65228df79ad@epcas1p2.samsung.com>
 <1465358840-22826-1-git-send-email-sw0312.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47546 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbcFIMia (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 08:38:30 -0400
In-reply-to: <1465358840-22826-1-git-send-email-sw0312.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seung-Woo Kim <sw0312.kim@samsung.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Seung-Woo,

On 06/08/2016 01:07 PM, Seung-Woo Kim wrote:
> This patch removes following UBSAN warnings in dw_mci_setup_bus().
> The warnings are caused because of shift with more than 31 on 32
> bit variable, so this patch fixes to shift only for less than 32.
> 
>   UBSAN: Undefined behaviour in drivers/mmc/host/dw_mmc.c:1102:14
>   shift exponent 250 is too large for 32-bit type 'unsigned int'
>   Call trace:
>   [<ffffff90080908a8>] dump_backtrace+0x0/0x380
>   [<ffffff9008090c3c>] show_stack+0x14/0x20
>   [<ffffff90087457b8>] dump_stack+0xe0/0x120
>   [<ffffff90087b1360>] ubsan_epilogue+0x18/0x68
>   [<ffffff90087b1a94>] __ubsan_handle_shift_out_of_bounds+0x18c/0x1bc
>   [<ffffff9008d89cb8>] dw_mci_setup_bus+0x3a0/0x438
>   [...]
> 
>   UBSAN: Undefined behaviour in drivers/mmc/host/dw_mmc.c:1132:27
>   shift exponent 250 is too large for 32-bit type 'unsigned int'
>   Call trace:
>   [<ffffff90080908a8>] dump_backtrace+0x0/0x380
>   [<ffffff9008090c3c>] show_stack+0x14/0x20
>   [<ffffff90087457b8>] dump_stack+0xe0/0x120
>   [<ffffff90087b1360>] ubsan_epilogue+0x18/0x68
>   [<ffffff90087b1a94>] __ubsan_handle_shift_out_of_bounds+0x18c/0x1bc
>   [<ffffff9008d89c9c>] dw_mci_setup_bus+0x384/0x438

The below message can be discarded.

>   [<ffffff9008d89ed4>] dw_mci_set_ios+0x184/0x798
>   [<ffffff9008d550ac>] mmc_power_up+0x11c/0x260
>   [<ffffff9008d56b78>] mmc_start_host+0x88/0x100
>   [<ffffff9008d583f4>] mmc_add_host+0x6c/0x128
>   [<ffffff9008d88f90>] dw_mci_probe+0x1088/0x1750
>   [<ffffff9008d8caa8>] dw_mci_pltfm_register+0x108/0x178
>   [<ffffff9008d8dae4>] dw_mci_exynos_probe+0x4c/0x88
>   [<ffffff9008a03838>] platform_drv_probe+0x78/0x180
>   [<ffffff90089fe9fc>] driver_probe_device+0x144/0x460
>   [<ffffff90089fee0c>] __driver_attach+0xf4/0x140
>   [<ffffff90089fad98>] bus_for_each_dev+0xf0/0x160
>   [<ffffff90089fdc9c>] driver_attach+0x34/0x58
>   [<ffffff90089fd3e0>] bus_add_driver+0x2c0/0x398
>   [<ffffff9008a00924>] driver_register+0xbc/0x1e0
>   [<ffffff9008a02a94>] __platform_driver_register+0x84/0xa8
>   [<ffffff9009dd5730>] dw_mci_exynos_pltfm_driver_init+0x18/0x20
>   [<ffffff9008082df8>] do_one_initcall+0xa0/0x2c8
>   [<ffffff9009d81780>] kernel_init_freeable+0x52c/0x5dc
>   [<ffffff9009519844>] kernel_init+0x1c/0xf8
>   [<ffffff9008086e10>] ret_from_fork+0x10/0x40
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2cc6123..dff045e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1099,7 +1099,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  
>  		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
>  
> -		if ((clock << div) != slot->__clk_old || force_clkinit)
> +		if (((div < 32) ? (clock << div) : 0) != slot->__clk_old ||

Well, we don't expect that clock is 0.
if clock is 0, it should be passed to " if (!clock)"..

During initializing card, clock is 400KHz or less..I understood what you want to fix.
But I taught this is not correct.


> +		    force_clkinit)
>  			dev_info(&slot->mmc->class_dev,
>  				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
>  				 slot->id, host->bus_hz, clock,
> @@ -1129,7 +1130,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
>  
>  		/* keep the clock with reflecting clock dividor */
> -		slot->__clk_old = clock << div;
> +		slot->__clk_old = (div < 32) ? (clock << div) : 0;

Also, clock is not 0..


Best Regards,
Jaehoon Chung

>  	}
>  
>  	host->current_speed = clock;
> 


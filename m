From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: host: sdhci check parameters before call dma_free_coherent
Date: Mon, 22 Jun 2015 10:04:22 +0300
Message-ID: <5587B376.4030904@intel.com>
References: <1434944483-4888-1-git-send-email-van.freenix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53018 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079AbbFVHHH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Jun 2015 03:07:07 -0400
In-Reply-To: <1434944483-4888-1-git-send-email-van.freenix@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peng Fan <van.freenix@gmail.com>, ulf.hansson@linaro.org
Cc: tim.kryger@gmail.com, b29396@freescale.com, haibo.chen@freescale.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 22/06/15 06:41, Peng Fan wrote:
> We should not call dma_free_coherent if host->adma_table is NULL,
> otherwise may trigger panic.
> 
>>From DMA-API.txt:
> "
> void
> dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
>                   dma_addr_t dma_handle)
> 
> Free a region of consistent memory you previously allocated.  dev,
> size and dma_handle must all be the same as those passed into
> dma_alloc_coherent().  cpu_addr must be the virtual address returned by
> the dma_alloc_coherent().
> "
> So we should check cpu_addr, but not directly call dma_free_coherent.
> 
> I met this when porting xen, log: "
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pltfm: SDHCI platform and OF driver helper
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = 80004000
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.38-02383-g5ccf32b-dirty #22
> task: 84074000 ti: 84078000 task.ti: 84078000
> PC is at bitmap_clear+0xc0/0xdc
> LR is at bitmap_clear+0x54/0xdc
> pc : [<8029deb8>]    lr : [<8029de4c>]    psr: 20000193
> sp : 84079d80  ip : 00000001  fp : 00000000
> r10: 00077fff  r9 : 00000404  r8 : 00000001
> r7 : 00000001  r6 : 00000001  r5 : 00000000  r4 : ffffffff
> r3 : 00000001  r2 : 00000001  r1 : 20000193  r0 : 00000015
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c53c7d  Table: 8800406a  DAC: 00000015
> Process swapper/0 (pid: 1, stack limit = 0x84078238)
> Stack: (0x84079d80 to 0x8407a000)
> 9d80: 80000113 00000000 87efa000 81109918 00001000 800197f8 84128558 00080008
> 9da0: 84079dec 000000d0 84bfeac0 84126c10 84126c10 ffffffff 00000404 ffffffff
> 9dc0: 00000000 00000402 00000000 00000000 84126c10 80310ba8 ffffffff 00000000
> 9de0: 00000000 00000524 84078000 00000000 00000000 ffffffff ffffffff 84bfeac0
> 9e00: 84bfe800 8000b407 07eb0000 8116e0f8 00000000 804ee81c ffffffff ffffffff
> 9e20: 00000000 84126c10 84c92010 84bfeac0 00000000 84126c10 84126c00 84bfeac0
> 9e40: 84078030 804f08e4 804f03d8 84126c10 fffffdfb 8115401c 8115401c 00000000
> 9e60: 0000010f 80362330 803622ec 84126c10 811c8098 00000000 8115401c 80360b1c
> 9e80: 84126c10 8115401c 84126c44 00000000 80de1888 80360d28 00000000 8115401c
> 9ea0: 80360c9c 8035f10c 8406965c 84123634 8115401c 84c8bf80 8112f3c8 803602bc
> 9ec0: 80d08314 8115401c 00000006 8115401c 00000006 8116e080 8116e080 8036130c
> 9ee0: 00000000 80e00f78 00000006 800088dc 8400f900 80c94fe0 840bd480 80735184
> 9f00: 00000000 8116e080 0000150c 8012d430 00000000 811105b0 60000113 00000001
> 9f20: 87ffc576 8075ca38 0000010f 8004b0f0 80d66884 00000006 87ffc583 00000006
> 9f40: 811105a0 80e00f78 00000006 8116e080 8116e080 80da150c 0000010f 80df4154
> 9f60: 80df4148 80da1c4c 00000006 00000006 80da150c 9355553c 84079f9c 80731338
> 9f80: 00000000 00000000 80727254 00000000 00000000 00000000 00000000 00000000
> 9fa0: 00000000 8072725c 00000000 8000ecf8 00000000 00000000 00000000 00000000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 9355553c 9355553c
> [<8029deb8>] (bitmap_clear) from [<800197f8>] (__arm_dma_free.isra.18+0xe4/0x228)
> [<800197f8>] (__arm_dma_free.isra.18) from [<80310ba8>] (xen_swiotlb_free_coherent+0xfc/0x140)
> [<80310ba8>] (xen_swiotlb_free_coherent) from [<804ee81c>] (sdhci_add_host+0xb34/0xe64)
> [<804ee81c>] (sdhci_add_host) from [<804f08e4>] (sdhci_esdhc_imx_probe+0x50c/0x808)
> [<804f08e4>] (sdhci_esdhc_imx_probe) from [<80362330>] (platform_drv_probe+0x44/0xa4)
> [<80362330>] (platform_drv_probe) from [<80360b1c>] (driver_probe_device+0x120/0x25c)
> [<80360b1c>] (driver_probe_device) from [<80360d28>] (__driver_attach+0x8c/0x90)
> [<80360d28>] (__driver_attach) from [<8035f10c>] (bus_for_each_dev+0x60/0x94)
> [<8035f10c>] (bus_for_each_dev) from [<803602bc>] (bus_add_driver+0x148/0x1f0)
> [<803602bc>] (bus_add_driver) from [<8036130c>] (driver_register+0x78/0xf8)
> [<8036130c>] (driver_register) from [<800088dc>] (do_one_initcall+0xf8/0x144)
> [<800088dc>] (do_one_initcall) from [<80da1c4c>] (kernel_init_freeable+0x138/0x1d8)
> [<80da1c4c>] (kernel_init_freeable) from [<8072725c>] (kernel_init+0x8/0xf0)
> [<8072725c>] (kernel_init) from [<8000ecf8>] (ret_from_fork+0x14/0x3c)
> Code: 10866003 1206601f 10633006 11e02312 (e5953000)
> ---[ end trace f6f103bb73cc0503 ]---
> note: swapper/0[1] exited with preempt_count 1
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b"
> 
> Because dma_alloc_coherent fail, it returns NULL, then
> "if (!host->adma_table || !host->align_buffer)" will return true, then
> dma_free_coherent trigger panic.
> 
> After applying this patch, no panic and all work well, kernel log:
> "
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pltfm: SDHCI platform and OF driver helper
> mmc0: Unable to allocate ADMA buffers. Falling back to standard DMA.
> mmc0: no vqmmc regulator found
> mmc0: SDHCI controller on 30b40000.usdhc [30b40000.usdhc] using DMA
> "
> 
> Signed-off-by: Peng Fan <van.freenix@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Looks like the problem started in v3.16 with:

commit d1e49f77d7c7b75fdc022e1d46c1549bbc91c5b7
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Fri Apr 25 12:58:34 2014 +0100

    mmc: sdhci: convert ADMA descriptors to a coherent allocation



> ---
>  drivers/mmc/host/sdhci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 706bb60..52e2327 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2978,8 +2978,11 @@ int sdhci_add_host(struct sdhci_host *host)
>  						      GFP_KERNEL);
>  		host->align_buffer = kmalloc(host->align_buffer_sz, GFP_KERNEL);
>  		if (!host->adma_table || !host->align_buffer) {
> -			dma_free_coherent(mmc_dev(mmc), host->adma_table_sz,
> -					  host->adma_table, host->adma_addr);
> +			if (host->adma_table)
> +				dma_free_coherent(mmc_dev(mmc),
> +						  host->adma_table_sz,
> +						  host->adma_table,
> +						  host->adma_addr);
>  			kfree(host->align_buffer);
>  			pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
>  				mmc_hostname(mmc));
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in

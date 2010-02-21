From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: support SDIO cards
Date: Sun, 21 Feb 2010 08:33:26 +0200
Message-ID: <4B80D3B6.3010008@compulab.co.il>
References: <cover.1265801967.git.david.vrabel@csr.com> <4B73BFD3.8090106@compulab.co.il> <4B73E59F.3020400@csr.com> <4B73ED3C.9010107@compulab.co.il> <4B73F418.6070804@csr.com> <4B73F8B0.100@compulab.co.il> <4B7CE4EC.5090403@compulab.co.il> <000901cab0ba$f30a8900$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:50848 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187Ab0BUGep (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 21 Feb 2010 01:34:45 -0500
In-Reply-To: <000901cab0ba$f30a8900$544ff780@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'David Vrabel' <david.vrabel@csr.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

Madhusudhan wrote:
> <snip>
>>>> Also, keep in mind that the buffers for transfers must begin and end on
>>>> a word boundary.  The OMAP's DMA controller can only transfer whole
>>>> words to the MMC FIFO.
>> I've slightly modified your patch "mmc: omap_hsmmc: use packet sync'd DMA"
>> and it
>> seems to work now, at least with SD card and libertas_sdio:
>>
> 
> Mike,
> 
> As per the latest discussion, David replied that this patch is not needed
> and FRAME sync just works fine. So, without this patch does SDIO int
> functionality work for you?

I had no luck with David's patches for SDIO IRQ, however with patches previously 
sent by Phaneendra ([1]) and fclk hack ([2]) SDIO IRQ works...
Without the fclk hack I get kernel panic in the omap_hsmmc:

Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0b4130 

Internal error: : 1028 [#1]
last sysfs file: /sys/class/net/lo/operstate
Modules linked in: libertas_sdio libertas cfg80211 lib80211 firmware_class 
ads7846 twl4030_keypad 

CPU: 0    Not tainted  (2.6.33-rc4-07078-gd8ebff3-dirty #8)
PC is at omap_hsmmc_irq+0xa8/0x59c
LR is at try_to_wake_up+0xd8/0xf4
pc : [<c021c49c>]    lr : [<c004f37c>]    psr: 60000193
sp : c03b5e28  ip : c03c3e08  fp : 00000000
r10: 0000001f  r9 : 411fc083  r8 : 00000000
r7 : cf9b79c0  r6 : 00000100  r5 : 00000056  r4 : cf9b7800
r3 : 00000000  r2 : fa0b4000  r1 : 20000193  r0 : 00000001
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 8faf0019  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc03b42e8)
Stack: (0xc03b5e28 to 0xc03b6000)
5e20:                   00000000 4c400e5f 000020b6 c006b8ec c03c2190 00000000
5e40: c03c2190 00000000 c03c1ce8 c03c2190 c03b5e74 c004e020 c03c2190 c03c2190
5e60: c03c2190 01dcd817 00000000 0000004b 00000000 515f5afc 000020b8 c006b8ec
5e80: 518247cf 00000000 c040b9a0 00000000 c03b5ed8 00000034 515f5afc 00000000
5ea0: 000225c1 00000000 1235a688 c0036e14 c03c0dc8 c006bb88 0000004a 00000000
5ec0: ffff6c00 ffffffff 15e77dcf 00000016 40000000 ffffff40 15e77dcf ffff84af
5ee0: 00000000 ffff84b1 00000000 00000001 00000000 ffff84af 00000000 c005b4ac
5f00: 00773594 00000000 00773594 00000000 00000001 c006f51c 00773594 00000000
5f20: 16d14154 00000035 2ff68e8c cf988f40 00000056 00000000 00000000 80023164
5f40: 0000001f c007972c c03c5b00 00000056 c0025014 c03b7bd8 80023164 c007b680
5f60: 00000056 00000000 c0025014 c002b070 ffffffff fa200000 c0025014 c002ba30
5f80: 00000000 1235a688 40000013 c03e94d4 c03b4000 c03e8adc c0025014 c03b7bd8
5fa0: 80023164 411fc083 0000001f 00000000 cfbfdae0 c03b5fc8 c003bff4 c003c02c
5fc0: 60000013 ffffffff c03b4000 c002d2e0 c040d250 c0008b1c c00084e8 00000000
5fe0: 00000000 c0025018 00000000 10c53c7d c03e8c04 80008034 00000000 00000000
[<c021c49c>] (omap_hsmmc_irq+0xa8/0x59c) from [<c007972c>] 
(handle_IRQ_event+0x34/0xf0)
[<c007972c>] (handle_IRQ_event+0x34/0xf0) from [<c007b680>] 
(handle_level_irq+0xdc/0xf4)
[<c007b680>] (handle_level_irq+0xdc/0xf4) from [<c002b070>] (asm_do_IRQ+0x70/0x90)
[<c002b070>] (asm_do_IRQ+0x70/0x90) from [<c002ba30>] (__irq_svc+0x30/0x80)
Exception stack(0xc03b5f80 to 0xc03b5fc8)
5f80: 00000000 1235a688 40000013 c03e94d4 c03b4000 c03e8adc c0025014 c03b7bd8
5fa0: 80023164 411fc083 0000001f 00000000 cfbfdae0 c03b5fc8 c003bff4 c003c02c
5fc0: 60000013 ffffffff
[<c002ba30>] (__irq_svc+0x30/0x80) from [<c003c02c>] (omap3_pm_idle+0x48/0x4c)
[<c003c02c>] (omap3_pm_idle+0x48/0x4c) from [<c002d2e0>] (cpu_idle+0x48/0x88)
[<c002d2e0>] (cpu_idle+0x48/0x88) from [<c0008b1c>] (start_kernel+0x24c/0x2a4)
[<c0008b1c>] (start_kernel+0x24c/0x2a4) from [<80008034>] (0x80008034)
Code: e5973008 e3530000 1a000005 e597203c (e5923130)
---[ end trace 2011509d5458c456 ]---
Kernel panic - not syncing: Fatal exception in interrupt


[1] http://thread.gmane.org/gmane.linux.kernel.mmc/967
[2] http://thread.gmane.org/gmane.linux.kernel.mmc/1107/focus=1109

> Regards,
> Madhu
> 
>> ---
>>  drivers/mmc/host/omap_hsmmc.c |   23 ++++++++---------------
>>  1 files changed, 8 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 4b23225..5408bcb 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -114,6 +114,7 @@
>>
>>  #define MMC_TIMEOUT_MS		20
>>  #define OMAP_MMC_MASTER_CLOCK	96000000
>> +#define OMAP_HSMMC_FIFO_WORDS	(512/4)
>>  #define DRIVER_NAME		"mmci-omap-hs"
>>
>>  /* Timeouts for entering power saving states on inactivity, msec */
>> @@ -884,24 +885,24 @@ static void omap_hsmmc_config_dma_params(struct
>> omap_hsmmc_host *host,
>>  {
>>  	int blksz, nblk, dma_ch;
>>
>> +	blksz = host->data->blksz;
>> +	nblk = sg_dma_len(sgl) / blksz;
>> +
>>  	dma_ch = host->dma_ch;
>>  	if (data->flags & MMC_DATA_WRITE) {
>>  		omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
>> -			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
>> +			(host->mapbase + OMAP_HSMMC_DATA), 0, blksz / 4);
>>  		omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
>>  			sg_dma_address(sgl), 0, 0);
>>  	} else {
>>  		omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
>> -			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
>> +			(host->mapbase + OMAP_HSMMC_DATA), 0, blksz / 4);
>>  		omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
>>  			sg_dma_address(sgl), 0, 0);
>>  	}
>>
>> -	blksz = host->data->blksz;
>> -	nblk = sg_dma_len(sgl) / blksz;
>> -
>>  	omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S32,
>> -			blksz / 4, nblk, OMAP_DMA_SYNC_FRAME,
>> +			blksz / 4, nblk, OMAP_DMA_SYNC_PACKET,
>>  			omap_hsmmc_get_dma_sync_dev(host, data),
>>  			!(data->flags & MMC_DATA_WRITE));
>>
>> @@ -944,17 +945,9 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status,
>> void *data)
>>  static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
>>  					struct mmc_request *req)
>>  {
>> -	int dma_ch = 0, ret = 0, err = 1, i;
>> +	int dma_ch = 0, ret = 0, err = 1;
>>  	struct mmc_data *data = req->data;
>>
>> -	/* Sanity check: all the SG entries must be aligned by block size.
>> */
>> -	for (i = 0; i < data->sg_len; i++) {
>> -		struct scatterlist *sgl;
>> -
>> -		sgl = data->sg + i;
>> -		if (sgl->length % data->blksz)
>> -			return -EINVAL;
>> -	}
>>  	if ((data->blksz % 4) != 0)
>>  		/* REVISIT: The MMC buffer increments only when MSB is
>> written.
>>  		 * Return error for blksz which is non multiple of four.
>> --
>> 1.6.4.4
>>
>>
>>
>>>> David
>>>
>>
>> --
>> Sincerely yours,
>> Mike.
>>
> 
> 


-- 
Sincerely yours,
Mike.


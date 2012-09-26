From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Subject: Re: [PATCH] mmc: sh-mmcif: avoid Oops on spurious interrupts
Date: Wed, 26 Sep 2012 10:47:55 +0900
Message-ID: <50625ECB.6020601@kmckk.co.jp>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com> <20120803050039.GA1614@linux-sh.org> <20120809042844.GF1614@linux-sh.org> <87hasc3bv5.wl%kuninori.morimoto.gx@renesas.com> <874nobqntv.wl%kuninori.morimoto.gx@renesas.com> <20120810123804.GK1614@linux-sh.org> <502DDC97.5080501@kmckk.co.jp> <87wr0us6tg.wl%kuninori.morimoto.gx@renesas.com> <20120820031352.GC25767@linux-sh.org> <87obm6ry98.wl%kuninori.morimoto.gx@renesas.com> <20120820043853.GD25767@linux-sh.org> <87mx1qrx1x.wl%kuninori.morimoto.gx@renesas.com> <5031D9FF.8060801@kmckk.co.jp> <Pine.LNX.4.64.1208220840400.26767@axis700.grange> <505932DD.8010703@kmckk.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <505932DD.8010703@kmckk.co.jp>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, yusuke.goda.sx@renesas.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

Dear linux-mmc maintainer,

(09/19/2012 11:50 AM), Tetsuyuki Kobayashi wrote:
> (2012/08/22 15:49), Guennadi Liakhovetski wrote:
>> On some systems, e.g., kzm9g, MMCIF interfaces can produce spurious
>> interrupts without any active request. To prevent the Oops, that results
>> in such cases, don't dereference the mmc request pointer until we make
>> sure, that we are indeed processing such a request.
>>
>> Reported-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> I verified on kzm9g.
> This works with
> [PATCH] mmc: sh-mmcif: properly handle MMC_WRITE_MULTIPLE_BLOCK 
> completion IRQ
> 
> Tested-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> 
>> ---
[snip]
>>
>>   drivers/mmc/host/sh_mmcif.c |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>> index 5d81427..82bf921 100644
>> --- a/drivers/mmc/host/sh_mmcif.c
>> +++ b/drivers/mmc/host/sh_mmcif.c
>> @@ -1104,7 +1104,6 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
>>   {
>>   	struct sh_mmcif_host *host = dev_id;
>>   	struct mmc_request *mrq = host->mrq;
>> -	struct mmc_data *data = mrq->data;
>>
>>   	cancel_delayed_work_sync(&host->timeout_work);
>>
>> @@ -1152,13 +1151,14 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
>>   	case MMCIF_WAIT_FOR_READ_END:
>>   	case MMCIF_WAIT_FOR_WRITE_END:
>>   		if (host->sd_error)
>> -			data->error = sh_mmcif_error_manage(host);
>> +			mrq->data->error = sh_mmcif_error_manage(host);
>>   		break;
>>   	default:
>>   		BUG();
>>   	}
>>
>>   	if (host->wait_for != MMCIF_WAIT_FOR_STOP) {
>> +		struct mmc_data *data = mrq->data;
>>   		if (!mrq->cmd->error && data && !data->error)
>>   			data->bytes_xfered =
>>   				data->blocks * data->blksz;
>>
> 

Without this patch, the following Oops occurs. (kzm9g on v3.6-rc7)
Please push this to v3.6, not only 3.7-next.


[   20.273437] Unable to handle kernel NULL pointer dereference at virtual address 00000008
[   20.281250] pgd = c0004000
[   20.281250] [00000008] *pgd=00000000
[   20.281250] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[   20.281250] Modules linked in:
[   20.281250] CPU: 1    Not tainted  (3.6.0-rc7 #28)
[   20.281250] PC is at sh_mmcif_irqt+0x18/0xb1c
[   20.281250] LR is at irq_thread+0x90/0x15c
[   20.281250] pc : [<c0250250>]    lr : [<c005f180>]    psr: 60000113
[   20.281250] sp : de23df58  ip : 00000000  fp : 00000000
[   20.281250] r10: 00000000  r9 : de1dcab4  r8 : dd9f6360
[   20.281250] r7 : de23c000  r6 : de23c000  r5 : 00000000  r4 : de1dca80
[   20.281250] r3 : c0250238  r2 : 00000000  r1 : de1dca80  r0 : de1dcab4
[   20.281250] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[   20.281250] Control: 10c5387d  Table: 5eb4804a  DAC: 00000015
[   20.281250] Process irq/173-sh_mmc: (pid: 406, stack limit = 0xde23c2f0)
[   20.281250] Stack: (0xde23df58 to 0xde23e000)
[   20.281250] df40:                                                       00000003 00000000
[   20.281250] df60: c0331f6c de1dca80 c046634c c0468190 dd9ca800 00000001 00000000 dd9f6340
[   20.281250] df80: de00bc40 de23c000 de23c000 dd9f6360 00000000 00000000 00000000 c005f180
[   20.281250] dfa0: 00000000 de23dfa4 c005f02c de043e3c dd9f6340 de043e3c dd9f6340 c005f0f0
[   20.281250] dfc0: 00000013 00000000 00000000 c00387ac 00000000 dd9f6340 00000000 00000000
[   20.281250] dfe0: de23dfe0 de23dfe0 de043e3c c0038728 c000f178 c000f178 00000000 00000000
[   20.281250] [<c0250250>] (sh_mmcif_irqt+0x18/0xb1c) from [<c005f180>] (irq_thread+0x90/0x15c)
[   20.281250] [<c005f180>] (irq_thread+0x90/0x15c) from [<c00387ac>] (kthread+0x84/0x90)
[   20.281250] [<c00387ac>] (kthread+0x84/0x90) from [<c000f178>] (kernel_thread_exit+0x0/0x8)
[   20.281250] Code: e5915004 e1a04001 e24dd024 e1a00009 (e595a008)
[   20.281250] ---[ end trace 6efe730b0884a251 ]---





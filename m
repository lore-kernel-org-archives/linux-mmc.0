From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 1/4] MMC: omap_hsmmc: set platform data after probe from
 DT node
Date: Fri, 12 Oct 2012 20:26:02 +0530
Message-ID: <50782F82.8060206@ti.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com> <1350039495-360-2-git-send-email-zonque@gmail.com> <5078295E.2090803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60253 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759124Ab2JLO4P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Oct 2012 10:56:15 -0400
In-Reply-To: <5078295E.2090803@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org

On Friday 12 October 2012 07:59 PM, Daniel Mack wrote:
> On 12.10.2012 12:58, Daniel Mack wrote:
>> When probed from DT, the self-allocated platform data has to be attached
>> to the actual device. Otherwise a NULL pointer will be dereferenced from
>> omap_hsmmc_card_detect if a gpio handle for card-detect has been passed.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Cc: Venkatraman S <svenkatr@ti.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: linux-omap@vger.kernel.org
>> ---
>>   drivers/mmc/host/omap_hsmmc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 19ccb59..4b70823 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1728,6 +1728,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>>   			const u16 *offsetp = match->data;
>>   			pdata->reg_offset = *offsetp;
>>   		}
>> +		pdev->dev.platform_data = pdata;
>>   	}
>>
>>   	if (pdata == NULL) {
>>
>
> FWIW, this is the Oops I see without this patch:
Hi,
Shouldn't pdev->dev.platform_data be set to NULL on _remove ?

BTW, I posted a patch for the same by accessing saved version from 
host->pdata
http://permalink.gmane.org/gmane.linux.kernel.mmc/16996


>
> [    1.492727] Unable to handle kernel NULL pointer dereference at
> virtual address 00000040
> [    1.501327] pgd = c0004000
> [    1.504166] [00000040] *pgd=00000000
> [    1.507993] Internal error: Oops: 5 [#1] SMP THUMB2
> [    1.513100] Modules linked in:
> [    1.516315] CPU: 0    Not tainted  (3.6.0-10656-g4bc7e4d-dirty #75)
> [    1.522890] PC is at omap_hsmmc_card_detect+0x6/0x18
> [    1.528090] LR is at omap_hsmmc_get_cd+0x1d/0x24
> [    1.532929] pc : [<c025a3ee>]    lr : [<c0259fed>]    psr: 40000133
> [    1.532929] sp : cf1b5e78  ip : 0c288145  fp : 00000002
> [    1.544939] r10: cf1b4000  r9 : cf1b5eb8  r8 : 00000000
> [    1.550408] r7 : cf1a4600  r6 : 60000113  r5 : cf33ba98  r4 : cf33b800
> [    1.557240] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : cf0d1c10
> [    1.564075] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb
> Segment kernel
> [    1.571906] Control: 50c5387d  Table: 80004019  DAC: 00000015
> [    1.577921] Process kworker/u:1 (pid: 19, stack limit = 0xcf1b4240)
> [    1.584480] Stack: (0xcf1b5e78 to 0xcf1b6000)
> [    1.589045] 5e60:
>     c025a3e9 c0259fed
> [    1.597611] 5e80: c0259fd1 c024f959 cf33bb0c cf1a5dc0 c05c87c0
> c003a42f 00000002 00000000
> [    1.606176] 5ea0: c003a3d8 c005e181 cf1b35c0 00000000 00000000
> c024f829 c0adfe68 c0687048
> [    1.614741] 5ec0: 00000000 c0494f78 c05c8780 cf1a5dc0 c05c88e8
> cf1b4000 c05c88f0 cf1a5dd0
> [    1.623306] 5ee0: c0531f40 c053d678 c05c8780 c003c2ab cf1b5f18
> c005e935 c05c87c0 c0531f40
> [    1.631872] 5f00: c0531f40 c7e3f1f9 cf1b5f34 cf069e20 cf1b5f34
> 00000000 cf1a5dc0 c003c191
> [    1.640436] 5f20: 00000000 00000000 00000000 c003f809 00000000
> 00000000 00000000 cf1a5dc0
> [    1.649001] 5f40: 00000000 00000000 dead4ead ffffffff ffffffff
> c05c8ef8 00000000 00000000
> [    1.657565] 5f60: c0455c08 cf1b5f64 cf1b5f64 00000000 00000000
> dead4ead ffffffff ffffffff
> [    1.666130] 5f80: c05c8ef8 00000000 00000000 c0455c08 cf1b5f90
> cf1b5f90 cf069e20 c003f791
> [    1.674694] 5fa0: 00000000 00000000 00000000 c000d1e1 aaa3aaab
> baaaa1ba aae3ea32 aba2a3aa
> [    1.683260] 5fc0: baaababe bbbaaaba aa2baaaa bb2e2aba aabaa2bb
> aaabb2bb aaabbaf3 f3bb2aaa
> [    1.691824] 5fe0: aabaabba 23ae2beb a2afab2a b2a2ab2a 00000013
> aaabaaab aaaabfaf a0bbbba2
> [    1.700399] [<c025a3ee>] (omap_hsmmc_card_detect+0x6/0x18) from
> [<c0259fed>] (omap_hsmmc_get_cd+0x1d/0x24)
> [    1.710528] [<c0259fed>] (omap_hsmmc_get_cd+0x1d/0x24) from
> [<c024f959>] (mmc_rescan+0x131/0x1e4)
> [    1.719842] [<c024f959>] (mmc_rescan+0x131/0x1e4) from [<c003a42f>]
> (process_one_work+0x137/0x37c)
> [    1.729234] [<c003a42f>] (process_one_work+0x137/0x37c) from
> [<c003c2ab>] (worker_thread+0x11b/0x364)
> [    1.738899] [<c003c2ab>] (worker_thread+0x11b/0x364) from
> [<c003f809>] (kthread+0x79/0x84)
> [    1.747572] [<c003f809>] (kthread+0x79/0x84) from [<c000d1e1>]
> (ret_from_kernel_thread+0xd/0x14)
> [    1.756773] Code: bf00 b508 f8d0 3084 (6c18) f75f
> [    1.761943] ---[ end trace b94c447c4835422d ]---
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


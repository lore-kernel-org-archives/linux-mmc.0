From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: Re: mxcmci_request() oops on idle system
Date: Wed, 11 Dec 2013 17:10:08 +0800
Message-ID: <52A82BF0.3040401@gtsys.com.hk>
References: <529E9CB2.1090403@gtsys.com.hk> <529EC085.4060500@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.fpasia.hk ([202.130.89.98]:60678 "EHLO fpa01n0.fpasia.hk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab3LKJIz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Dec 2013 04:08:55 -0500
In-Reply-To: <529EC085.4060500@gtsys.com.hk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

On Wednesday, December 04, 2013 01:41 PM, Chris Ruehl wrote:
> On Wednesday, December 04, 2013 11:08 AM, Chris Ruehl wrote:
>> Hi Chris,
>>
>> I had this oops pop up a while after boot the
>> Freescale IMX27 custom board with one 8G Flashcard running.
>> The system was idle, suddenly the oops show up.
>>
>> Here is the dump:
>> [ 516.783407] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000004
>> [ 516.791639] pgd = c0004000
>> [ 516.794445] [00000004] *pgd=00000000
>> [ 516.798088] Internal error: Oops: 17 [#1] ARM
>> [ 516.802472] Modules linked in:
>> [ 516.805593] CPU: 0 PID: 569 Comm: mmcqd/0 Not tainted
>> 3.13.0-rc1-next-20131125-00006-g5f6bb77-dirty #66
>> [ 516.815027] task: cfb8a2a0 ti: cfb88000 task.ti: cfb88000
>> [ 516.820484] PC is at mxcmci_request+0xd0/0x2f8
>> [ 516.824974] LR is at mxcmci_request+0xf8/0x2f8
>> [ 516.829466] pc : [<c02b6048>] lr : [<c02b6070>] psr: 00000013
>> [ 516.829466] sp : cfb89dd0 ip : cfb89dd0 fp : cfb89e1c
>> [ 516.840988] r10: 000001ff r9 : 00000002 r8 : cfa10620
>> [ 516.846250] r7 : 00000200 r6 : cfa0f02c r5 : cfa0f0ec r4 : cfa10400
>> [ 516.852812] r3 : a0000013 r2 : cfa0f410 r1 : 00040000 r0 : 00000000
>> [ 516.859376] Flags: nzcv IRQs on FIQs on Mode SVC_32 ISA ARM Segment
>> kernel
>> [ 516.866723] Control: 0005317f Table: afa74000 DAC: 00000017
>> [ 516.872503] Process mmcqd/0 (pid: 569, stack limit = 0xcfb881c0)
>> [ 516.878543] Stack: (0xcfb89dd0 to 0xcfb8a000)
>> [ 516.882951] 9dc0: c02bf7a4 cfbff530 cfbfd0cc 000000ff
>> [ 516.891199] 9de0: cfb89dfc cfb89df0 c02beb3c c02bf7b4 cfb89e1c
>> cfa0f02c cfa10400 cfa0f12c
>> [ 516.899444] 9e00: cfb89ebc cfa0f240 00000001 00000001 cfb89e34
>> cfb89e20 c02a51c8 c02b5f88
>> [ 516.907688] 9e20: cfa10400 00000000 cfb89e7c cfb89e38 c02a69b4
>> c02a50f8 cfb89e5c 00000000
>> [ 516.915933] 9e40: cfb8a2a0 c003a858 cfb89e48 cfb89e48 c00431d0
>> cfa0f028 cfa0f004 cfa10c00
>> [ 516.924180] 9e60: ce5a9c40 ce5a9c40 cfa10400 cfa0f000 cfb89eec
>> cfb89e80 c02b3784 c02a675c
>> [ 516.932423] 9e80: cfb89f24 cf9bf950 cfb89eac cfb89e98 c001b774
>> c00464b8 00000110 0000001a
>> [ 516.940664] 9ea0: cfa0f02c 00000000 00000000 c001b6b8 cfa0f000
>> 00000000 cfb89ef0 0000ffff
>> [ 516.948909] 9ec0: cfb89eec ce5a9c40 cfa10c00 cfa0f004 cfb88000
>> cfa0f000 cfa10400 cfa0f000
>> [ 516.957154] 9ee0: cfb89f34 cfb89ef0 c02b3e88 c02b33b0 ce5a9c40
>> ce5a9c40 cf9bf954 60000013
>> [ 516.965400] 9f00: cfa0f004 cfa0f00c cfb88038 cfa0f004 cfa0f00c
>> cfb88038 cfb88000 cf9bf950
>> [ 516.973644] 9f20: 00000001 322e800e cfb89f64 cfb89f38 c02b4874
>> c02b3d84 cfb8a2a0 cfbfdf20
>> [ 516.981885] 9f40: 00000000 cfa0f004 c02b47c4 00000000 00000000
>> 00000000 cfb89fac cfb89f68
>> [ 516.990126] 9f60: c0030010 c02b47d4 00000000 00000000 cfb89f9c
>> cfa0f004 00000000 cfb89f7c
>> [ 516.998367] 9f80: cfb89f7c 00000000 cfb89f88 cfb89f88 cfbfdf20
>> c002ff38 00000000 00000000
>> [ 517.006605] 9fa0: 00000000 cfb89fb0 c00094b0 c002ff48 00000000
>> 00000000 00000000 00000000
>> [ 517.014840] 9fc0: 00000000 00000000 00000000 00000000 00000000
>> 00000000 00000000 00000000
>> [ 517.023078] 9fe0: 00000000 00000000 00000000 00000000 00000013
>> 00000000 fffeffff fffdffff
>> [ 517.031275] Backtrace:
>> [ 517.033816] [<c02b5f78>] (mxcmci_request+0x0/0x2f8) from [<c02a51c8>]
>> (mmc_start_request+0xe0/0xe8)
>> [ 517.042938] [<c02a50e8>] (mmc_start_request+0x0/0xe8) from
>> [<c02a69b4>] (mmc_start_req+0x268/0x2f8)
>> [ 517.052011] r5:00000000 r4:cfa10400
>> [ 517.055697] [<c02a674c>] (mmc_start_req+0x0/0x2f8) from [<c02b3784>]
>> (mmc_blk_issue_rw_rq+0x3e4/0x9d4)
>> [ 517.065079] [<c02b33a0>] (mmc_blk_issue_rw_rq+0x0/0x9d4) from
>> [<c02b3e88>] (mmc_blk_issue_rq+0x114/0x460)
>> [ 517.074718] [<c02b3d74>] (mmc_blk_issue_rq+0x0/0x460) from
>> [<c02b4874>] (mmc_queue_thread+0xb0/0x138)
>> [ 517.084009] [<c02b47c4>] (mmc_queue_thread+0x0/0x138) from
>> [<c0030010>] (kthread+0xd8/0xec)
>> [ 517.092427] [<c002ff38>] (kthread+0x0/0xec) from [<c00094b0>]
>> (ret_from_fork+0x14/0x24)
>> [ 517.100457] r7:00000000 r6:00000000 r5:c002ff38 r4:cfbfdf20
>> [ 517.106251] Code: e59fa220 e5953024 e1590003 2a00000a (e5903004)
>> [ 517.112530] ---[ end trace 593b33fe81686cf7 ]---
>>
>> With kind regards
>> Chris
>>
>> Reported-by: <chris.ruehl@gtsys.com.hk>
>> -- 
>
> Additional info:
> I compiled the kernel with debug info and here is the gdb output:
>
> (gdb) list *(mxcmci_request+0xd0)
> 0xcac is at drivers/mmc/host/mxcmmc.c:350.
> 345
> 346        if (!mxcmci_use_dma(host))
> 347            return 0;
> 348
> 349        for_each_sg(data->sg, sg, data->sg_len, i) {
> 350            if (sg->offset & 3 || sg->length & 3 || sg->length < 
> 512) {
> 351                host->do_dma = 0;
> 352                return 0;
> 353            }
> 354        }
>
>

My system still oops .. with null pointer sg should be invalid for that 
reason.

Can someone look into it please?




From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 00/22] mmc: Add Command Queue support
Date: Thu, 6 Jul 2017 13:48:04 +0300
Message-ID: <5982a7db-ab35-22f3-3a05-6c3b5d9c374d@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFp=rrQbSAGMx=UF2abcLmzWjO4syq7eLAmChT_EQNvDgg@mail.gmail.com>
 <faa2a3d8-e045-8bd1-06c9-e5cf64713035@intel.com>
 <CACRpkdYBB1ZMnvCKet706bm12B3DWnie=0uDri835R_f81gMUw@mail.gmail.com>
 <AM4PR0401MB23244CD809159EF1CD897160901F0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <8009319e-356e-0b69-a30a-31b536f3643a@intel.com>
 <AM4PR0401MB2324C8B330EB320BFB35443590C00@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <AM4PR0401MB232449B222AA0A9FA7603A9B90C50@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <453a9fbc-c827-367e-f953-fbc9d6457375@intel.com>
 <AM4PR0401MB232412DCF1858144F39512B390D70@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:37517 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751833AbdGFKyV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Jul 2017 06:54:21 -0400
In-Reply-To: <AM4PR0401MB232412DCF1858144F39512B390D70@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 07/04/2017 01:21 PM, Bough Chen wrote:
>> -----Original Message-----
>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>> Sent: Tuesday, June 20, 2017 5:05 PM
>> To: Bough Chen <haibo.chen@nxp.com>; Linus Walleij
>> <linus.walleij@linaro.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc <linux-
>> mmc@vger.kernel.org>; Alex Lemberg <alex.lemberg@sandisk.com>; Mateusz
>> Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>> Dong Aisheng <dongas86@gmail.com>; Das Asutosh
>> <asutoshd@codeaurora.org>; Zhangfei Gao <zhangfei.gao@gmail.com>;
>> Dorfman Konstantin <kdorfman@codeaurora.org>; David Griego
>> <david.griego@linaro.org>; Sahitya Tummala <stummala@codeaurora.org>;
>> Harjani Ritesh <riteshh@codeaurora.org>; Venu Byravarasu
>> <vbyravarasu@nvidia.com>; Shawn Lin <shawn.lin@rock-chips.com>
>> Subject: Re: [PATCH V2 00/22] mmc: Add Command Queue support
>>
>> On 20/06/17 11:01, Bough Chen wrote:
>>>> -----Original Message-----
>>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>>>> owner@vger.kernel.org] On Behalf Of Bough Chen
>>>> Sent: Thursday, June 15, 2017 7:50 PM
>>>> To: Adrian Hunter <adrian.hunter@intel.com>; Linus Walleij
>>>> <linus.walleij@linaro.org>
>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc <linux-
>>>> mmc@vger.kernel.org>; Alex Lemberg <alex.lemberg@sandisk.com>;
>>>> Mateusz Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>>>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>>>> Dong Aisheng <dongas86@gmail.com>; Das Asutosh
>>>> <asutoshd@codeaurora.org>; Zhangfei Gao <zhangfei.gao@gmail.com>;
>>>> Dorfman Konstantin <kdorfman@codeaurora.org>; David Griego
>>>> <david.griego@linaro.org>; Sahitya Tummala <stummala@codeaurora.org>;
>>>> Harjani Ritesh <riteshh@codeaurora.org>; Venu Byravarasu
>>>> <vbyravarasu@nvidia.com>; Shawn Lin <shawn.lin@rock-chips.com>
>>>> Subject: RE: [PATCH V2 00/22] mmc: Add Command Queue support
>>>>
>>>>> -----Original Message-----
>>>>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>>>>> Sent: Thursday, June 15, 2017 7:38 PM
>>>>> To: Bough Chen <haibo.chen@nxp.com>; Linus Walleij
>>>>> <linus.walleij@linaro.org>
>>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc <linux-
>>>>> mmc@vger.kernel.org>; Alex Lemberg <alex.lemberg@sandisk.com>;
>>>> Mateusz
>>>>> Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>>>>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung
>>>>> <jh80.chung@samsung.com>; Dong Aisheng <dongas86@gmail.com>; Das
>>>>> Asutosh <asutoshd@codeaurora.org>; Zhangfei Gao
>>>>> <zhangfei.gao@gmail.com>; Dorfman Konstantin
>>>>> <kdorfman@codeaurora.org>; David Griego <david.griego@linaro.org>;
>>>>> Sahitya Tummala <stummala@codeaurora.org>; Harjani Ritesh
>>>>> <riteshh@codeaurora.org>; Venu Byravarasu <vbyravarasu@nvidia.com>;
>>>>> Shawn Lin <shawn.lin@rock-chips.com>
>>>>> Subject: Re: [PATCH V2 00/22] mmc: Add Command Queue support
>>>>>
>>>>> On 24/04/17 12:14, Bough Chen wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>>>>>>> owner@vger.kernel.org] On Behalf Of Linus Walleij
>>>>>>> Sent: Monday, April 24, 2017 4:13 PM
>>>>>>> To: Adrian Hunter <adrian.hunter@intel.com>
>>>>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc <linux-
>>>>>>> mmc@vger.kernel.org>; Alex Lemberg <alex.lemberg@sandisk.com>;
>>>>>>> Mateusz Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>>>>>>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung
>>>>>>> <jh80.chung@samsung.com>; Dong Aisheng <dongas86@gmail.com>;
>> Das
>>>>>>> Asutosh <asutoshd@codeaurora.org>; Zhangfei Gao
>>>>>>> <zhangfei.gao@gmail.com>; Dorfman Konstantin
>>>>>>> <kdorfman@codeaurora.org>; David Griego <david.griego@linaro.org>;
>>>>>>> Sahitya Tummala <stummala@codeaurora.org>; Harjani Ritesh
>>>>>>> <riteshh@codeaurora.org>; Venu Byravarasu
>>>>>>> <vbyravarasu@nvidia.com>; Shawn Lin <shawn.lin@rock-chips.com>
>>>>>>> Subject: Re: [PATCH V2 00/22] mmc: Add Command Queue support
>>>>>>>
>>>>>>> On Sat, Apr 22, 2017 at 9:45 AM, Adrian Hunter
>>>>>>> <adrian.hunter@intel.com>
>>>>>>> wrote:
>>>>>>>
>>>>>>>> Ulf and Linus have been doing a great job of keeping this moving,
>>>>>>>> but it would be nice to see some others taking more interest.
>>>>>>>> The first command queue patches were posted in February 2014,
>>>>>>>> over 3 years
>>>>> ago!
>>>>>>>
>>>>>>> I agree.
>>>>>>>
>>>>>>> I think both me & Ulf would also be doing more work if we had
>>>>>>> easily accessible hardware with upstream host controller support
>>>>>>> for native
>>>>> command queueing.
>>>>>>> (Hm, was just reading in libata about NCQ ...
>>>>>>> déja vu ... https://en.wikipedia.org/wiki/Native_Command_Queuing)
>>>>>>>
>>>>>>> Do we have some hardware with host-backed command queueing out
>>>>> there
>>>>>>> that is easily obtained and has upstream support for the basic system?
>>>>>>>
>>>>>>
>>>>>> The coming i.MX8 support hardware CMDQ, I will have a try when I
>>>>>> get one
>>>>> on May or June.
>>>>>
>>>>> I have sent updated patches.  Will you have a chance to test hardware
>> CMDQ?
>>>>
>>>> Yes, I will try to apply these patches on our local 4.9 branch.  Will
>>>> give you the test result.
>>>>
>>>
>>> Hi Adrian,
>>>
>>> i.MX8 still not upstream, and just work on our local 4.9 branch, to
>>> test your branch, I need to cherry pick some mmc patches and block layer
>> patches, I'm doing this now, but need some time.
>>
>> Thanks for the update.  I realize backporting anything related to mmc block is
>> now a big task.
>>
> 
> Hi Adrian,
> 
> I finish backporting, and have a try on our i.MX8 platform, seems it is easy to see the timeout error. I will try to dig it out.  
> Here I attach the detail log:
> 
> root@imx8qxplpddr4arm2:~# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=200
> [   41.846693] mmc0: starting CQE transfer for tag 1 blkaddr 0
> [   41.852310] mmc0:     blksz 512 blocks 512 flags 00000200 tsac 150 ms nsac 0
> [   41.859396] mmc0: cqhci: tag 1 task descriptor 0x016200102f
> [   68.665171] mmc0: cqhci: recovery needed
> [   68.669108] mmc0: cqhci: timeout for tag 0
> [   68.673205] mmc0: cqhci: ============ CQHCI REGISTER DUMP ===========
> [   68.679644] mmc0: cqhci: Caps:      0x0000310a | Version:  0x00000510
> [   68.686089] mmc0: cqhci: Config:    0x00000001 | Control:  0x00000000
> [   68.692527] mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
> [   68.698964] mmc0: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
> [   68.705402] mmc0: cqhci: TDL base:  0xd807a000 | TDL up32: 0x00000000
> [   68.711839] mmc0: cqhci: Doorbell:  0x00000003 | TCN:      0x00000000
> [   68.718277] mmc0: cqhci: Dev queue: 0x00000001 | Dev Pend: 0x00000001
> [   68.724714] mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
> [   68.731152] mmc0: cqhci: SSC2:      0x00000001 | DCMD rsp: 0x00000000
> [   68.737589] mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
> [   68.744026] mmc0: cqhci: Resp idx:  0x0000002e | Resp arg: 0x00000900
> [   68.750463] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   68.756903] mmc0: sdhci: Sys addr:  0xd5ccc000 | Version:  0x00000002
> [   68.763348] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
> [   68.769786] mmc0: sdhci: Argument:  0x40010200 | Trn mode: 0x00000030
> [   68.776231] mmc0: sdhci: Present:   0x010d8a8f | Host ctl: 0x00000030

We had a problem with CQE getting stuck if bit-11 was set in present state.
Refer glk_cqe_enable() in sdhci-pci-core.c.

> [   68.782668] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
> [   68.789106] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
> [   68.795543] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> [   68.801981] mmc0: sdhci: Int enab:  0x107f4000 | Sig enab: 0x107f4000
> [   68.808418] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000502
> [   68.814856] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
> [   68.821293] mmc0: sdhci: Cmd:       0x00002c1a | Max curr: 0x00ffffff
> [   68.827730] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [   68.834168] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d02700
> [   68.840605] mmc0: sdhci: Host ctl2: 0x00000000
> [   68.845046] mmc0: sdhci: ADMA Err:  0x00000003 | ADMA Ptr: 0xd8098004
> [   68.851481] mmc0: sdhci: ============================================
> [   68.857936] mmc0: CQE recovery start
> [   68.861554] mmc0: running CQE recovery
> [   68.865326] mmc0: cqhci: cqhci_recovery_start
> [   68.885159] mmc0: cqhci: Failed to halt
> [   68.889004] mmc0: sdhci: CQE off, IRQ mask 0xff1003, IRQ status 0x4000
> [   68.895574] mmc0: starting CMD12 arg 00000000 flags 00000019
> [   78.905144] mmc0: Timeout waiting for hardware interrupt.
> [   78.910558] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   78.917003] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [   78.923440] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
> [   78.929877] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000030
> [   78.936315] mmc0: sdhci: Present:   0x01fd8009 | Host ctl: 0x00000031
> [   78.942752] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
> [   78.949189] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
> [   78.955627] mmc0: sdhci: Timeout:   0x0000000f | Int stat: 0x00004000
> [   78.962064] mmc0: sdhci: Int enab:  0x007f1003 | Sig enab: 0x007f1003
> [   78.968501] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000502
> [   78.974939] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
> [   78.981376] mmc0: sdhci: Cmd:       0x00000cd3 | Max curr: 0x00ffffff
> [   78.987814] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [   78.994251] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d02700
> [   79.000688] mmc0: sdhci: Host ctl2: 0x00000000
> [   79.005129] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> [   79.011564] mmc0: sdhci: ============================================
> [   79.018522] mmc0: req done (CMD12): -110: 00000000 00000000 00000000 00000000
> [   79.025713] mmc0: starting CMD48 arg 00000001 flags 00000019
> [   79.031424] mmc0: sdhci: IRQ status 0x00004001
> [   79.035868] mmc0: sdhci: IRQ status 0x00004000
> [   79.040312] mmc0: sdhci: IRQ status 0x00004000
> [   79.044751] mmc0: sdhci: IRQ status 0x00004000
> [   79.049190] mmc0: sdhci: IRQ status 0x00004000
> [   79.053630] mmc0: sdhci: IRQ status 0x00004000
> [   79.058069] mmc0: sdhci: IRQ status 0x00004000
> [   79.062508] mmc0: sdhci: IRQ status 0x00004000
> [   79.066948] mmc0: sdhci: IRQ status 0x00004000
> [   79.071387] mmc0: sdhci: IRQ status 0x00004000
> [   79.075827] mmc0: sdhci: IRQ status 0x00004000
> [   79.080266] mmc0: sdhci: IRQ status 0x00004000
> [   79.084705] mmc0: sdhci: IRQ status 0x00004000
> [   79.089144] mmc0: sdhci: IRQ status 0x00004000
> [   79.093583] mmc0: sdhci: IRQ status 0x00004000
> [   79.098023] mmc0: sdhci: IRQ status 0x00004000
> [   79.102463] mmc0: Unexpected interrupt 0x00004000.
> [   79.107248] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   79.113687] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
> [   79.120125] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
> [   79.126562] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000030
> [   79.133000] mmc0: sdhci: Present:   0x01fd8009 | Host ctl: 0x00000031
> [   79.139436] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
> [   79.145874] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
> [   79.152312] mmc0: sdhci: Timeout:   0x0000000f | Int stat: 0x00004000
> [   79.158749] mmc0: sdhci: Int enab:  0x007f1003 | Sig enab: 0x007f1003
> [   79.165186] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000502
> [   79.171624] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
> [   79.178061] mmc0: sdhci: Cmd:       0x00002d12 | Max curr: 0x00ffffff
> [   79.184499] mmc0: sdhci: Resp[0]:   0x00400800 | Resp[1]:  0xffffffff
> [   79.190936] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d02700
> [   79.197373] mmc0: sdhci: Host ctl2: 0x00000000
> [   79.201814] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> [   79.208249] mmc0: sdhci: ============================================
> [   79.214737] mmc0: req done (CMD48): 0: 00400800 00000000 00000000 00000000
> [   79.221722] mmc0: cqhci: cqhci_recovery_finish
> [   79.226198] mmc0: CQE transfer done tag 0
> [   79.230223] mmc0:     0 bytes transferred: -110
> [   79.234796] mmc0: CQE transfer done tag 1
> [   79.238828] mmc0:     0 bytes transferred: 0
> [   79.243364] mmc0: cqhci: recovery done
> [   79.247146] mmc0: CQE recovery done
> [   79.250699] mmc0: starting CQE transfer for tag 0 blkaddr 0
> [   79.256299] mmc0:     blksz 512 blocks 512 flags 00000200 tsac 150 ms nsac 0
> [   79.263368] mmc0: cqhci: CQE on
> [   79.266540] mmc0: sdhci: CQE on, IRQ mask 0x2ff4000, IRQ status 0x4000
> [   79.273074] mmc0: sdhci: IRQ status 0x00004000
> [   79.277517] mmc0: cqhci: IRQ status: 0x00000006
> [   79.282043] mmc0: cqhci: error IRQ status: 0x00000006 cmd error 0 data error 0 TERRI: 0x00000000
> [   79.290835] mmc0: cqhci: error when idle. IRQ status: 0x00000006 cmd error 0 data error 0 TERRI: 0x00000000
> [   79.300621] ------------[ cut here ]------------
> [   79.305251] WARNING: CPU: 0 PID: 1273 at drivers/mmc/host/cqhci.c:671 cqhci_irq+0x1d0/0x4d0
> [   79.313603] Modules linked in:
> [   79.316660]
> [   79.318151] CPU: 0 PID: 1273 Comm: mmcqd/0 Not tainted 4.9.11-02713-g0aa36a6-dirty #659
> [   79.326156] Hardware name: Freescale i.MX8QXP LPDDR4 ARM2 (DT)
> [   79.329154] fec 5b040000.ethernet eth0: MDIO read timeout
> [   79.337381] task: ffff80083a1a6400 task.stack: ffff80083ae18000
> [   79.343299] PC is at cqhci_irq+0x1d0/0x4d0
> [   79.347399] LR is at cqhci_irq+0x1d0/0x4d0
> [   79.351490] pc : [<ffff0000087f6070>] lr : [<ffff0000087f6070>] pstate: 800001c5
> [   79.358882] sp : ffff80083ff6edc0
> [   79.362192] x29: ffff80083ff6edc0 x28: 0000000000004000
> [   79.367517] x27: ffff80083a807318 x26: ffff80083a807330
> [   79.372842] x25: ffff80083a36a008 x24: 0000000000000000
> [   79.378167] x23: 0000000000000000 x22: ffff80083a36a000
> [   79.383493] x21: ffff80083a807318 x20: 0000000000000000
> [   79.388818] x19: 0000000000000006 x18: 0000000000000006
> [   79.394144] x17: 0000ffff9792db60 x16: ffff0000081dcef8
> [   79.399469] x15: ffff000009083bb5 x14: 20726f7272652061
> [   79.404795] x13: 746164203020726f x12: 72726520646d6320
> [   79.410120] x11: 3630303030303030 x10: 0000000000000294
> [   79.415446] x9 : 747320515249202e x8 : 3030303030783020
> [   79.420771] x7 : 3a49525245542030 x6 : ffff000009083c16
> [   79.426097] x5 : ffff80083ff6fbb8 x4 : 0000000000000001
> [   79.431422] x3 : 0000000000000007 x2 : 0000000000000006
> [   79.436748] x1 : ffff80083ae18000 x0 : 000000000000005f
> [   79.442072]
> [   79.443559] ---[ end trace b7a758ac7d743c5f ]---
> [   79.448172] Call trace:
> [   79.450616] Exception stack(0xffff80083ff6ebf0 to 0xffff80083ff6ed20)
> [   79.457062] ebe0:                                   0000000000000006 0001000000000000
> [   79.472735] ec20: ffff80083ff6ec40 ffff000008d20fa8 ffff000009083000 0000000108f9e118
> [   79.480571] ec40: ffff80083ff6ece0 ffff000008100038 0000000000000006 0000000000000000
> [   79.488407] ec60: ffff80083a807318 ffff80083a36a000 0000000000000000 0000000000000000
> [   79.496243] ec80: ffff80083a36a008 ffff80083a807330 000000000000005f ffff80083ae18000
> [   79.504079] eca0: 0000000000000006 0000000000000007 0000000000000001 ffff80083ff6fbb8
> [   79.511916] ecc0: ffff000009083c16 3a49525245542030 3030303030783020 747320515249202e
> [   79.519752] ece0: 0000000000000294 3630303030303030 72726520646d6320 746164203020726f
> [   79.527588] ed00: 20726f7272652061 ffff000009083bb5 ffff0000081dcef8 0000ffff9792db60
> [   79.535424] [<ffff0000087f6070>] cqhci_irq+0x1d0/0x4d0
> [   79.540567] [<ffff0000087f3a30>] esdhc_cqhci_irq+0x50/0x60
> [   79.546057] [<ffff0000087e91a8>] sdhci_irq+0xe8/0xbe0
> [   79.551116] [<ffff0000081022ec>] __handle_irq_event_percpu+0x9c/0x128
> [   79.557559] [<ffff000008102394>] handle_irq_event_percpu+0x1c/0x58
> [   79.563744] [<ffff000008102418>] handle_irq_event+0x48/0x78
> [   79.569314] [<ffff000008105d28>] handle_fasteoi_irq+0xb8/0x1b0
> [   79.575151] [<ffff0000081013e4>] generic_handle_irq+0x24/0x38
> [   79.580902] [<ffff000008101a5c>] __handle_domain_irq+0x5c/0xb8
> [   79.586742] [<ffff000008081650>] gic_handle_irq+0xc0/0x160
> [   79.592229] Exception stack(0xffff80083ae1bb20 to 0xffff80083ae1bc50)
> [   79.598669] bb20: ffff80083a36a7b8 0000000000000140 000000000000010c 0000000000000007
> [   79.606505] bb40: 0000000000000001 ffff80083ff6fbb8 ffff000009083bf1 515249202c303030
> [   79.614341] bb60: 2073757461747320 ffff80083ae1b9b0 0000000000000290 0000000000000006
> [   79.622177] bb80: 0000000005f5e0ff 0000000000000000 000000000000028f ffff000009083bb5
> [   79.630013] bba0: ffff0000081dcef8 0000ffff9792db60 0000000000000006 ffff80083a36a580
> [   79.637850] bbc0: ffff80083a36a7b8 0000000000000140 ffff80083a36a000 ffff80083a5df880
> [   79.645686] bbe0: ffff80083b00bd78 0000000000000000 ffff80083ab05720 ffff80083ae18000
> [   79.653522] bc00: ffff80083ab05718 ffff80083ae1bc50 ffff0000087e5778 ffff80083ae1bc50
> [   79.661358] bc20: ffff0000089f44a8 0000000080000145 ffff80083a36aa00 0000000000000000
> [   79.669192] bc40: ffffffffffffffff 00000000000f000f
> [   79.674067] [<ffff0000080827b0>] el1_irq+0xb0/0x124
> [   79.678952] [<ffff0000089f44a8>] _raw_spin_unlock_irqrestore+0x10/0x48
> [   79.685483] [<ffff0000087f3914>] esdhc_cqe_enable+0x74/0x90
> [   79.691060] [<ffff0000087f6c58>] cqhci_request+0x588/0x5d0
> [   79.696552] [<ffff0000087cccdc>] mmc_cqe_start_req+0x9c/0xf0
> [   79.702217] [<ffff0000087e0730>] mmc_blk_cqe_issue_rq+0x1a8/0x290
> [   79.708314] [<ffff0000087e10e8>] mmc_cqe_thread+0x1f0/0x330
> [   79.713893] [<ffff0000080d9cf8>] kthread+0xd0/0xe8
> [   79.718686] [<ffff000008082e80>] ret_from_fork+0x10/0x50
> [   79.724002] mmc0: cqhci: TCN: 0x00000000
> [   79.727954] random: crng init done
> [   79.731484] mmc0: cqhci: tag 0 task descriptor 0x016200102f
> [   79.737157] mmc0: starting CQE transfer for tag 1 blkaddr 61071232
> [   79.743356] mmc0:     blksz 512 blocks 8 flags 00000200 tsac 150 ms nsac 0
> [   79.750260] mmc0: cqhci: tag 1 task descriptor 0x0163a3df800008102f
> 
>>>
>>>
>>>> Best Regards,
>>>> Haibo Chen
> 


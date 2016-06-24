From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: mmc: dw_mmc: warning with CONFIG_DMA_API_DEBUG
Date: Fri, 24 Jun 2016 15:08:18 +0800
Message-ID: <f9c0bb11-80df-e8fb-bb61-edb497fe72e0@rock-chips.com>
References: <001501d1cace$9b8f2b60$d2ad8220$@samsung.com>
 <CGME20160621015228epcas1p450d93158cd5028d3c8ab4f7e352ccaff@epcas1p4.samsung.com>
 <a50cabe9-2e41-92be-b886-103e2bb4edba@rock-chips.com>
 <000801d1cb64$070dfb60$1529f220$@samsung.com>
 <c4589cb4-b3b6-6f97-d994-cb311591e5b2@rock-chips.com>
 <5768D188.3080508@samsung.com>
 <f1414fff-0dd8-0441-2510-4d3f4b2208b0@rock-chips.com>
 <576BCA56.90206@samsung.com>
 <b61f6fdb-4f42-e889-ac39-1b32b3d73c38@rock-chips.com>
 <576CB765.1060709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:41574 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcFXHI3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jun 2016 03:08:29 -0400
In-Reply-To: <576CB765.1060709@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shawn.lin@rock-chips.com

=E5=9C=A8 2016/6/24 12:30, Jaehoon Chung =E5=86=99=E9=81=93:
> On 06/24/2016 10:25 AM, Shawn Lin wrote:
>> Hi Jaehoon,
>>
>> On 2016/6/23 19:39, Jaehoon Chung wrote:
>>> Hi Shawn,
>>>
>>> On 06/21/2016 04:39 PM, Shawn Lin wrote:
>>>> =E5=9C=A8 2016/6/21 13:32, Jaehoon Chung =E5=86=99=E9=81=93:
>>>>> Hi guys,
>>>>>
>>>>> On 06/21/2016 11:31 AM, Shawn Lin wrote:
>>>>>> On 2016/6/21 10:24, Seung-Woo Kim wrote:
>>>>>>> Hello Shawn,
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
>>>>>>>> Sent: Tuesday, June 21, 2016 10:52 AM
>>>>>>>> To: Seung-Woo Kim; jh80.chung@samsung.com; ulf.hansson@linaro.=
org; linux-mmc@vger.kernel.org; linux-
>>>>>>>> kernel@vger.kernel.org
>>>>>>>> Cc: shawn.lin@rock-chips.com
>>>>>>>> Subject: Re: mmc: dw_mmc: warning with CONFIG_DMA_API_DEBUG
>>>>>>>>
>>>>>>>> On 2016/6/20 16:34, Seung-Woo Kim wrote:
>>>>>>>>> Hi folks,
>>>>>>>>>
>>>>>>>>> During booting test on my Exynos5422 based Odroid-XU3, kernel=
 compiled
>>>>>>>>> with CONFIG_DMA_API_DEBUG reported following warning:
>>>>>>>>>
>>>>>>>>> ------------[ cut here ]------------
>>>>>>>>> WARNING: CPU: 0 PID: 0 at lib/dma-debug.c:1096 check_unmap+0x=
7bc/0xb38
>>>>>>>>> dwmmc_exynos 12200000.mmc: DMA-API: device driver tries to fr=
ee DMA memory it has not allocated [device
>>>>>>>> address=3D0x000000006d9d2200]
>>>>>>>>
>>>>>>>> Thanks for this report and fix.
>>>>>>>>
>>>>>>>> DTO(the same as IDMAC-RI/TI) interrupts may or may not come to=
gether
>>>>>>>> with DATA_ERR. If DATA_ERR occur without geting DTO, we should=
 issue
>>>>>>>> CMD12 manually to generate DTO. It's a ugly deisgn for dwmmc b=
ut from
>>>>>>>> the vendor's ask.
>>>>>>>>
>>>>>>>> So you should never think we complete the xfer without
>>>>>>>> checking DATA_ERR. This way you got the warning.
>>>>>
>>>>> Well, EVENT_DATA_ERR is already checked in tasklet_func..and clea=
red that flags.
>>>>
>>>> From my view, the reality is that when we got DATA_ERROR interrupt=
s,
>>>> we set EVENT_DATA_ERR to the pending_events and schedule the taskl=
et
>>>> but we may still fallback to the IDMAC interrupt case as the taskl=
et
>>>> may come up a little late, namely right after the IDMAC interrupt =
checking.
>>>>
>>>> I'm trying to add some log there, and it well proves my guess.
>>>
>>> You're right..This is appeared because of "Data Over".
>>> If Data Over interrupt is occurred, SW needs to read the remaining =
Data in FIFO.
>>> At that time, it was set to DATA_COMPLETE. Because SW might read th=
e remaining data, but already set to ERROR_DATA.
>>>
>>> In this case, Your suggestion may prevent to free twice.
>>>
>>> There is other case..during tuning sequence.. :(
>>> I found that it also appeared during the tuning sequence.
>>> - Really..stupid design..
>>>
>>> My suggestions are
>>> First, apply the below solution.
>>
>> Which solution? This $SUBJECT or the one I sent?
>
> Yours. :)


okay I will resend this pacth again for you to pick up.

>
>>
>>
>>
>>> And then consider the HS200 tuning block with the below patch.
>>>
>>> https://patchwork.kernel.org/patch/8935791/
>>
>> I saw this patch long ago, but I still have not seen
>> this issue or got reports for it. From the code itself, it should
>> be ok to landed as I checked the databook. :)
>>
>>>
>>> How about?
>>> Do you have any other opinion?
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>>
>>>>>
>>>>>>>>
>>>>>>>> So could you try this one:
>>>>>>>
>>>>>>> With your patch, there is no more the DMA API waring in my envi=
ronment.
>>>>>>
>>>>>> Nice to hear that.  Thanks for testing, Seung-Woo.
>>>>>
>>>>> Really? It's not solution..When send tuning command, it should be=
 returned CRC error.
>>>>> Then it called the dw_mci_stop_dma() and also dma_ops->complete()=
=2E
>>>>
>>>> Hrmm.. I can't see the reason it will also call dma_ops->complete.
>>>> Could you explain a bit more here? :)
>>>>
>>>> From V2.70a Table 3-2
>>>> For MMC CMD19, there may be no CRC status returned by the
>>>> card but EBE is generated. Hence, EBE is set for CMD19. The applic=
ation
>>>> should not treat this as an error.
>>>>
>>>>
>>>>>
>>>>> When i applied you suggestion, also produced.. :)
>>>>>
>>>>> [    2.469916] [<c010d6f0>] (unwind_backtrace) from [<c010a478>] =
(show_stack+0x10/0x14)
>>>>> [    2.469934] [<c010a478>] (show_stack) from [<c031b324>] (dump_=
stack+0x74/0x94)
>>>>> [    2.469949] [<c031b324>] (dump_stack) from [<c011b5ac>] (__war=
n+0xd4/0x100)
>>>>> [    2.469961] [<c011b5ac>] (__warn) from [<c011b678>] (warn_slow=
path_fmt+0x38/0x48)
>>>>> [    2.469975] [<c011b678>] (warn_slowpath_fmt) from [<c033ee20>]=
 (check_unmap+0x828/0x8a8)
>>>>> [    2.469991] [<c033ee20>] (check_unmap) from [<c033f7c0>] (debu=
g_dma_unmap_sg+0x5c/0x13c)
>>>>> [    2.470012] [<c033f7c0>] (debug_dma_unmap_sg) from [<c051e6a4>=
] (dw_mci_dma_cleanup+0x68/0xa4)
>>>>> [    2.470029] [<c051e6a4>] (dw_mci_dma_cleanup) from [<c0553bf4>=
] (dw_mci_stop_dma+0x30/0x40)
>>>>> [    2.470045] [<c0553bf4>] (dw_mci_stop_dma) from [<c0521b30>] (=
dw_mci_tasklet_func+0x340/0x3b4)
>>>>> [    2.470063] [<c0521b30>] (dw_mci_tasklet_func) from [<c011fcb0=
>] (tasklet_action+0x84/0x12c)
>>>>> [    2.470076] [<c011fcb0>] (tasklet_action) from [<c011f35c>] (_=
_do_softirq+0xec/0x244)
>>>>> [    2.470089] [<c011f35c>] (__do_softirq) from [<c011f750>] (irq=
_exit+0xb4/0xf8)
>>>>> [    2.470109] [<c011f750>] (irq_exit) from [<c015d004>] (__handl=
e_domain_irq+0x70/0xe4)
>>>>> [    2.470123] [<c015d004>] (__handle_domain_irq) from [<c0101470=
>] (gic_handle_irq+0x50/0x9c)
>>>>> [    2.470135] [<c0101470>] (gic_handle_irq) from [<c010af14>] (_=
_irq_svc+0x54/0x90)
>>>>> [    2.470141] Exception stack(0xee3d3c58 to 0xee3d3ca0)
>>>>> [    2.470148] 3c40:                                             =
          c0b1ef0c 0000000a
>>>>> [    2.470159] 3c60: 00000001 0000005c 0000016d 00000000 c0b4f7a4=
 00000006 00000000 0000005c
>>>>> [    2.470170] 3c80: 00000006 c0b671e8 60000013 ee3d3ca8 c0398e08=
 c015b830 60000013 ffffffff
>>>>> [    2.470183] [<c010af14>] (__irq_svc) from [<c015b830>] (consol=
e_unlock+0x560/0x628)
>>>>> [    2.470196] [<c015b830>] (console_unlock) from [<c015c1b0>] (v=
printk_emit+0x1fc/0x508)
>>>>> [    2.470211] [<c015c1b0>] (vprintk_emit) from [<c03ed21c>] (dev=
_vprintk_emit+0xf8/0x198)
>>>>> [    2.470224] [<c03ed21c>] (dev_vprintk_emit) from [<c03ed2d8>] =
(dev_printk_emit+0x1c/0x2c)
>>>>> [    2.470235] [<c03ed2d8>] (dev_printk_emit) from [<c03ed334>] (=
__dev_printk+0x4c/0x70)
>>>>> [    2.470246] [<c03ed334>] (__dev_printk) from [<c03ed390>] (_de=
v_info+0x38/0x48)
>>>>> [    2.470258] [<c03ed390>] (_dev_info) from [<c045a7a4>] (usb_ne=
w_device+0xe8/0x3d0)
>>>>> [    2.470270] [<c045a7a4>] (usb_new_device) from [<c045bc20>] (h=
ub_event+0x760/0xff4)
>>>>> [    2.470289] [<c045bc20>] (hub_event) from [<c012ff68>] (proces=
s_one_work+0x120/0x328)
>>>>> [    2.470304] [<c012ff68>] (process_one_work) from [<c01301d4>] =
(worker_thread+0x2c/0x4ac)
>>>>> [    2.470321] [<c01301d4>] (worker_thread) from [<c01353a4>] (kt=
hread+0xd8/0xf4)
>>>>> [    2.470335] [<c01353a4>] (kthread) from [<c0107978
>>>>>
>>>>> I'm checking this..
>>>>>
>>>>> Best Regards,
>>>>> Jaehoon Chung
>>>>>
>>>>>>
>>>>>> Hi Jaehoon,
>>>>>>
>>>>>> How about this?
>>>>>>
>>>>>>>
>>>>>>> Best Regards,
>>>>>>> - Seung-Woo Kim
>>>>>>>
>>>>>>>>
>>>>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>>>>> @@ -2474,7 +2474,8 @@ static irqreturn_t dw_mci_interrupt(int =
irq, void
>>>>>>>> *dev_id)
>>>>>>>>                          mci_writel(host, IDSTS64, SDMMC_IDMAC=
_INT_TI |
>>>>>>>>
>>>>>>>> SDMMC_IDMAC_INT_RI);
>>>>>>>>                          mci_writel(host, IDSTS64, SDMMC_IDMAC=
_INT_NI);
>>>>>>>> -                       host->dma_ops->complete((void *)host);
>>>>>>>> +                       if (!test_bit(EVENT_DATA_ERROR,
>>>>>>>> &host->pending_events))
>>>>>>>> +                               host->dma_ops->complete((void =
*)host);
>>>>>>>>                  }
>>>>>>>>          } else {
>>>>>>>>                  pending =3D mci_readl(host, IDSTS);
>>>>>>>> @@ -2482,7 +2483,8 @@ static irqreturn_t dw_mci_interrupt(int =
irq, void
>>>>>>>> *dev_id)
>>>>>>>>                          mci_writel(host, IDSTS, SDMMC_IDMAC_I=
NT_TI |
>>>>>>>>
>>>>>>>> SDMMC_IDMAC_INT_RI);
>>>>>>>>                          mci_writel(host, IDSTS, SDMMC_IDMAC_I=
NT_NI);
>>>>>>>> -                       host->dma_ops->complete((void *)host);
>>>>>>>> +                       if (!test_bit(EVENT_DATA_ERROR,
>>>>>>>> &host->pending_events))
>>>>>>>> +                               host->dma_ops->complete((void =
*)host);
>>>>>>>>                  }
>>>>>>>>          }
>>>>>>>>
>>>>>>>>
>>>>>>>>> [size=3D128 bytes]
>>>>>>>>> Modules linked in:
>>>>>>>>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.7.0-rc4 #26
>>>>>>>>> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>>>>>>>>> [<c0112b4c>] (unwind_backtrace) from [<c010d888>] (show_stack=
+0x20/0x24)
>>>>>>>>> [<c010d888>] (show_stack) from [<c03fab0c>] (dump_stack+0x80/=
0x94)
>>>>>>>>> [<c03fab0c>] (dump_stack) from [<c0123548>] (__warn+0xf8/0x11=
0)
>>>>>>>>> [<c0123548>] (__warn) from [<c01235a8>] (warn_slowpath_fmt+0x=
48/0x50)
>>>>>>>>> [<c01235a8>] (warn_slowpath_fmt) from [<c042ac90>] (check_unm=
ap+0x7bc/0xb38)
>>>>>>>>> [<c042ac90>] (check_unmap) from [<c042b25c>] (debug_dma_unmap=
_sg+0x118/0x148)
>>>>>>>>> [<c042b25c>] (debug_dma_unmap_sg) from [<c077512c>] (dw_mci_d=
ma_cleanup+0x7c/0xb8)
>>>>>>>>> [<c077512c>] (dw_mci_dma_cleanup) from [<c0773f24>] (dw_mci_s=
top_dma+0x40/0x50)
>>>>>>>>> [<c0773f24>] (dw_mci_stop_dma) from [<c0777d04>] (dw_mci_task=
let_func+0x130/0x3b4)
>>>>>>>>> [<c0777d04>] (dw_mci_tasklet_func) from [<c0129760>] (tasklet=
_action+0xb4/0x150)
>>>>>>>>> [<c0129760>] (tasklet_action) from [<c0101674>] (__do_softirq=
+0xe4/0x3cc)
>>>>>>>>> [<c0101674>] (__do_softirq) from [<c0129030>] (irq_exit+0xd0/=
0x10c)
>>>>>>>>> [<c0129030>] (irq_exit) from [<c01778a0>] (__handle_domain_ir=
q+0x90/0xfc)
>>>>>>>>> [<c01778a0>] (__handle_domain_irq) from [<c0101548>] (gic_han=
dle_irq+0x64/0xa8)
>>>>>>>>> [<c0101548>] (gic_handle_irq) from [<c010e3d4>] (__irq_svc+0x=
54/0x90)
>>>>>>>>> Exception stack(0xc1101ef8 to 0xc1101f40)
>>>>>>>>> 1ee0:                                                       0=
0000001 00000000
>>>>>>>>> 1f00: 00000000 c011b600 c1100000 c110753c 00000000 c11c3984 c=
11074d4 c1107548
>>>>>>>>> 1f20: 00000000 c1101f54 c1101f58 c1101f48 c010a1fc c010a200 6=
0000013 ffffffff
>>>>>>>>> [<c010e3d4>] (__irq_svc) from [<c010a200>] (arch_cpu_idle+0x4=
8/0x4c)
>>>>>>>>> [<c010a200>] (arch_cpu_idle) from [<c01669d8>] (default_idle_=
call+0x30/0x3c)
>>>>>>>>> [<c01669d8>] (default_idle_call) from [<c0166d3c>] (cpu_start=
up_entry+0x358/0x3b4)
>>>>>>>>> [<c0166d3c>] (cpu_startup_entry) from [<c0aa6ab8>] (rest_init=
+0x94/0x98)
>>>>>>>>> [<c0aa6ab8>] (rest_init) from [<c1000d58>] (start_kernel+0x3a=
4/0x3b0)
>>>>>>>>> [<c1000d58>] (start_kernel) from [<4000807c>] (0x4000807c)
>>>>>>>>> ---[ end trace 256f83eed365daf0 ]---
>>>>>>>>>
>>>>>>>>> The warning occurs because after complete callback function,
>>>>>>>>> dw_mci_dmac_complete_dma() is called, then dw_mci_stop_dma() =
is called
>>>>>>>>> again. So it causes dma_unmap_sg() is called twice for same s=
g. It
>>>>>>>>> occurs during clock setting at booting time.
>>>>>>>>>
>>>>>>>>> Simply, clearing host->using_dma flag on dw_mci_dmac_complete=
_dma() and
>>>>>>>>> dw_mci_stop_dma() like following fixes the issue, but I am no=
t sure
>>>>>>>>> this approach is proper.
>>>>>>>>> ---
>>>>>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_=
mmc.c
>>>>>>>>> index 2cc6123..a71c94b 100644
>>>>>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>>>>>> @@ -388,6 +388,7 @@ static void dw_mci_stop_dma(struct dw_mci=
 *host)
>>>>>>>>>      if (host->using_dma) {
>>>>>>>>>          host->dma_ops->stop(host);
>>>>>>>>>          host->dma_ops->cleanup(host);
>>>>>>>>> +        host->using_dma =3D 0;
>>>>>>>>>      }
>>>>>>>>>
>>>>>>>>>      /* Data transfer was stopped by the interrupt handler */
>>>>>>>>> @@ -455,6 +456,7 @@ static void dw_mci_dmac_complete_dma(void=
 *arg)
>>>>>>>>>                      DMA_FROM_DEVICE);
>>>>>>>>>
>>>>>>>>>      host->dma_ops->cleanup(host);
>>>>>>>>> +    host->using_dma =3D 0;
>>>>>>>>>
>>>>>>>>>      /*
>>>>>>>>>       * If the card was removed, data will be NULL. No point =
in trying to
>>>>>>>>> @@ -943,8 +945,6 @@ static int dw_mci_submit_data_dma(struct =
dw_mci *host, struct mmc_data *data)
>>>>>>>>>      int sg_len;
>>>>>>>>>      u32 temp;
>>>>>>>>>
>>>>>>>>> -    host->using_dma =3D 0;
>>>>>>>>> -
>>>>>>>>>      /* If we don't have a channel, we can't do DMA */
>>>>>>>>>      if (!host->use_dma)
>>>>>>>>>          return -ENODEV;
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Best Regards,
>>>>>>>>> - Seung-Woo Kim
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe lin=
ux-mmc" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>> Best Regards
>>>>>>>> Shawn Lin
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Best Regards
Shawn Lin


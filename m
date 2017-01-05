From: Ziyuan <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: revise the reset path in runtime resume
Date: Thu, 5 Jan 2017 09:47:01 +0800
Message-ID: <586DA595.9000505@rock-chips.com>
References: <1483534293-6192-1-git-send-email-xzy.xu@rock-chips.com>
 <CGME20170104160451epcas1p416fcb217eef3faf0c6604e5e690492a5@epcas1p4.samsung.com>
 <dc2d8514-6b01-150e-12a1-a47302c44723@soulik.info>
 <edc4c327-6947-6841-e7f1-3f621619a1c9@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <edc4c327-6947-6841-e7f1-3f621619a1c9-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ayaka <ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org>, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On 01/05/2017 09:29 AM, Jaehoon Chung wrote:
> On 01/05/2017 01:04 AM, ayaka wrote:
>>
>> On 01/04/2017 08:51 PM, Ziyuan Xu wrote:
>>> Immediately after reset, issue the command which sets
>>> update_clock_register_only bit, the card clock will restart. Revise
>>> dw_mci_ctrl_reset to dw_mci_reset, which has wrapped this sequence.
>>>
>>> The patch fixes commit e9ed8835e990 ("mmc: dw_mmc: add runtime PM
>>> callback"). MMC_PM_KEEP_POWEP is disabled for SD card and eMMC slots, so
>>> that they have no chance to invoke dw_mci_setup_bus for update clock
>>> behaviour. Let's consummate it.
>>>
>>> Reported-by: Randy Li <randy.li-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>> Signed-off-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> Thank you Ziyuan, it works for me, but I capture those warning message in boot log
>> [    5.943096] Unable to handle kernel NULL pointer dereference at virtual address 00000004
>> [    5.951227] pgd = c0004000
>> [    5.953958] [00000004] *pgd=00000000
>> [    5.957563] Internal error: Oops: 5 [#1] SMP ARM
>> [    5.962177] Modules linked in:
>> [    5.965238] CPU: 0 PID: 117 Comm: kworker/0:3 Not tainted 4.9.0-next-20161224+ #122
>> [    5.972875] Hardware name: Rockchip (Device Tree)
>> [    5.977586] Workqueue: events_freezable mmc_rescan
>> [    5.982377] task: ee186740 task.stack: ee1d2000
>> [    5.986908] PC is at mci_send_cmd.constprop.5+0x20/0xb0
>> [    5.992129] LR is at dw_mci_reset+0xdc/0x130
>> [    5.996400] pc : [<c05cf464>]    lr : [<c05d0308>] psr: 60000013
>> [    5.996400] sp : ee1d3d38  ip : ee1d3d68  fp : ee1d3d64
>> [    6.007862] r10: ee1d2000  r9 : c04fe918  r8 : c04fe918
>> [    6.013083] r7 : c0c03d00  r6 : ee171780  r5 : c0c03d00  r4 : ee17e618
>> [    6.019604] r3 : 00000201  r2 : f08e4000  r1 : 00200000  r0 : 00000000
>> [    6.026127] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM Segment none
>> [    6.033253] Control: 10c5387d  Table: 0000406a  DAC: 00000051
>> [    6.038994] Process kworker/0:3 (pid: 117, stack limit = 0xee1d2210)
>> [    6.045340] Stack: (0xee1d3d38 to 0xee1d4000)
>> [    6.049696] 3d20:                                                       c0495ed0 c0714e60
>> [    6.057870] 3d40: ee17e618 00000001 ee171780 c0c03d00 c04fe918 c04fe918 ee1d3d7c ee1d3d68
>> [    6.066043] 3d60: c05d0308 c05cf450 ee17e618 00000000 ee1d3da4 ee1d3d80 c05d07fc c05d0238
>> [    6.074216] 3d80: 00000000 eeae5a10 00000000 c0c03d00 c04fe918 c04fe918 ee1d3db4 ee1d3da8
>> [    6.082389] 3da0: c04fe954 c05d0718 ee1d3dec ee1d3db8 c0501c70 c04fe924 c0162310 c044f7b0
>> [    6.090563] 3dc0: 00000000 eeae5a10 c0c62510 00000000 c0c03d00 c04fe918 c0175574 ee1d2000
>> [    6.098737] 3de0: ee1d3e0c ee1d3df0 c0501df0 c0501b88 eeae5a10 c0c62510 00000000 c0c03d00
>> [    6.106911] 3e00: ee1d3e5c ee1d3e10 c0501898 c0501dcc c0c0408c eeae5aa8 eeda0d00 00000000
>> [    6.115085] 3e20: c0c04108 ee1867c0 ee1d3eac 00040900 c016e53c eeae5a10 00000004 eeae5a84
>> [    6.123259] 3e40: 60000013 ee1d2000 c0c0408c ee160c00 ee1d3e7c ee1d3e60 c0501b5c c05013e4
>> [    6.131433] 3e60: 00000000 ee160e1c 20000013 00000000 ee1d3ecc ee1d3e80 c05b0128 c0501af8
>> [    6.139607] 3e80: ffffe000 ee160e80 00000000 ee186740 c0156324 00000100 00000200 00040900
>> [    6.147781] 3ea0: ee1d3f14 ee160e94 ee160e1c ee160c00 60000013 eeda3e00 ee160e98 00000000
>> [    6.155956] 3ec0: ee1d3ef4 ee1d3ed0 c05b3a68 c05aff80 ee160e94 ee176380 eeda0880 00000000
>> [    6.164130] 3ee0: eeda3e00 ee160e98 ee1d3f2c ee1d3ef8 c0142374 c05b383c c0c03d00 eeda0898
>> [    6.172303] 3f00: ee1d2000 eeda0880 ee176398 00000008 c0c03d00 eeda0898 ee1d2000 ee176380
>> [    6.180477] 3f20: ee1d3f74 ee1d3f30 c014329c c01421d0 ee1d3f54 c0959c8c ee1d2000 00000000
>> [    6.188650] 3f40: ee15a880 c0c20f1a ee1d1e7c eea00600 ee1d2000 00000000 ee15a880 ee176380
>> [    6.196824] 3f60: ee1d1e7c eea0061c ee1d3fac ee1d3f78 c0148ed0 c0143248 00000000 c014323c
>> [    6.204996] 3f80: ee1d3fac ee15a880 c0148da8 00000000 00000000 00000000 00000000 00000000
>> [    6.213168] 3fa0: 00000000 ee1d3fb0 c0108e90 c0148db4 00000000 00000000 00000000 00000000
>> [    6.221341] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [    6.229514] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
>> [    6.237696] [<c05cf464>] (mci_send_cmd.constprop.5) from [<c05d0308>] (dw_mci_reset+0xdc/0x130)
>> [    6.246393] [<c05d0308>] (dw_mci_reset) from [<c05d07fc>] (dw_mci_runtime_resume+0xf0/0x1cc)
>> [    6.254833] [<c05d07fc>] (dw_mci_runtime_resume) from [<c04fe954>] (pm_generic_runtime_resume+0x3c/0x48)
>> [    6.264313] [<c04fe954>] (pm_generic_runtime_resume) from [<c0501c70>] (__rpm_callback+0xf4/0x244)
>> [    6.273273] [<c0501c70>] (__rpm_callback) from [<c0501df0>] (rpm_callback+0x30/0x90)
>> [    6.281017] [<c0501df0>] (rpm_callback) from [<c0501898>] (rpm_resume+0x4c0/0x714)
>> [    6.288588] [<c0501898>] (rpm_resume) from [<c0501b5c>] (__pm_runtime_resume+0x70/0x90)
>> [    6.296592] [<c0501b5c>] (__pm_runtime_resume) from [<c05b0128>] (__mmc_claim_host+0x1b4/0x1ec)
>> [    6.305287] [<c05b0128>] (__mmc_claim_host) from [<c05b3a68>] (mmc_rescan+0x238/0x3f4)
>> [    6.313206] [<c05b3a68>] (mmc_rescan) from [<c0142374>] (process_one_work+0x1b0/0x4c0)
>> [    6.321125] [<c0142374>] (process_one_work) from [<c014329c>] (worker_thread+0x60/0x548)
>> [    6.329215] [<c014329c>] (worker_thread) from [<c0148ed0>] (kthread+0x128/0x158)
>> [    6.336614] [<c0148ed0>] (kthread) from [<c0108e90>] (ret_from_fork+0x14/0x24)
>> [    6.343836] Code: e52de004 e8bd4000 e3035d00 e34c50c0 (e5909004)
>> [    6.349974] ---[ end trace b2215a1ef671f11e ]---
> It seems that cur_slot is NULL. Before calling the dw_mci_reset(),
> need to assign cur_slot...I will check this.

Yes, I got this warning when insert sd card. We don't need to reset the 
host without active solt.
mmc_rescan will start a set_ios request once sd card insert. :-)
I send a v3 patch for fix this pitfall.

Best Regards,
Ziyuan Xu

>
> Best Regards,
> Jaehoon Chung
>
>>> ---
>>>
>>> Changes in v2:
>>> - update the commit message
>>> - use dw_mci_reset instead of dw_mci_ctrl_reset
>>>
>>>    drivers/mmc/host/dw_mmc.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index b44306b..ed63237 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -3324,7 +3324,7 @@ int dw_mci_runtime_resume(struct device *dev)
>>>        if (ret)
>>>            goto err;
>>>    -    if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
>>> +    if (!dw_mci_reset(host)) {
>>>            clk_disable_unprepare(host->ciu_clk);
>>>            ret = -ENODEV;
>>>            goto err;
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: MMC locking: mmc_request accesses from dw_mmc driver ok?
Date: Fri, 23 Aug 2013 23:06:22 +0900
Message-ID: <52176C5E.2060101@samsung.com>
References: <CANEJEGuRAzsRdwYsdb5MMrpiQxG4DgiRW=XuuQoLz3_84o9Vig@mail.gmail.com>
 <CANEJEGtiwVo1K3Ht7iwMecfjA76M2JPFz+U_Hs8iRzNud=Y1-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:47807 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab3HWOGP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 10:06:15 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRZ00BD1LUDCFU0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 23 Aug 2013 23:06:13 +0900 (KST)
In-reply-to: <CANEJEGtiwVo1K3Ht7iwMecfjA76M2JPFz+U_Hs8iRzNud=Y1-A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Doug Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Grant,

I will check this.

Best Regards,
Jaehoon Chung

On 08/22/2013 05:18 AM, Grant Grundler wrote:
> On Mon, Aug 12, 2013 at 4:45 PM, Grant Grundler <grundler@chromium.org> wrote:
>> I've been working on an "task mmcqd/0:84 blocked for more than 120
>> seconds" panic for the past month or so in the chromeos-3.4 kernel
>> tree. Stack trace below. Feel free to tell me "fixed in v3.x". :)
> 
> I've added this change:
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1cf4900..a127ce1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -135,6 +135,9 @@ void mmc_request_done(struct mmc_host *host,
> struct mmc_request *mrq)
>         struct mmc_command *cmd = mrq->cmd;
>         int err = cmd->error;
> 
> +WARN_ON(!host->claimed);
> +WARN_ON(host->claimer != current);
> +
>         if (err && cmd->retries && mmc_host_is_spi(host)) {
>                 if (cmd->resp[0] & R1_SPI_ILLEGAL_COMMAND)
>                         cmd->retries = 0;
> 
> and the "WARN_ON(host->claimer != current)" is triggering with this
> stack trace (as I suspected):
> 
> WARNING: at /mnt/host/source/src/third_party/kernel/files/drivers/mmc/core/core.c:139
> mmc_request_done+0x6c/0xf0()
> Modules linked in: i2c_dev uinput asix usbnet nf_conntrack_ipv6
> nf_defrag_ipv6 uvcvideo videobuf2_vmalloc sbs_battery mwifiex_sdio
> mwifiex cfg80211 btmrvl_sdio btmrvl rtc_s3c bluetooth zram(C)
> zsmalloc(C) fuse ip6table_filter xt_mark ip6_tables joydev
> [<800150a4>] (unwind_backtrace+0x0/0x114) from [<804ee9a0>]
> (dump_stack+0x20/0x24)
> [<804ee9a0>] (dump_stack+0x20/0x24) from [<8002bff8>]
> (warn_slowpath_null+0x44/0x5c)
> [<8002bff8>] (warn_slowpath_null+0x44/0x5c) from [<803a3e74>]
> (mmc_request_done+0x6c/0xf0)
> [<803a3e74>] (mmc_request_done+0x6c/0xf0) from [<803b9c4c>]
> (dw_mci_request_end+0xc4/0xec)
> [<803b9c4c>] (dw_mci_request_end+0xc4/0xec) from [<803ba274>]
> (dw_mci_tasklet_func+0x354/0x3a8)
> [<803ba274>] (dw_mci_tasklet_func+0x354/0x3a8) from [<80034044>]
> (tasklet_action+0xac/0x12c)
> [<80034044>] (tasklet_action+0xac/0x12c) from [<800334f8>]
> (__do_softirq+0xc4/0x208)
> [<800334f8>] (__do_softirq+0xc4/0x208) from [<80033a54>] (irq_exit+0x54/0x94)
> [<80033a54>] (irq_exit+0x54/0x94) from [<8000ef68>] (handle_IRQ+0x8c/0xc8)
> [<8000ef68>] (handle_IRQ+0x8c/0xc8) from [<800085ec>] (gic_handle_irq+0x4c/0x70)
> [<800085ec>] (gic_handle_irq+0x4c/0x70) from [<8000e200>] (__irq_svc+0x40/0x60)
> 
> Is this expected behavior?
> 
> It feels wrong to me since it means the dw_mmc tasklet and whatever
> thread starts the IO can access the mmc_request data structure. Do I
> have this right?
> 
> If I have this right, any "obvious" fixes? e.g. add locking to
> mmc_start_request() and mmc_request_done()?
> 
> thanks,
> grant
> 
>> After staring at the 14 MMC and DW driver data structures,  I now
>> think dw_mmc driver is accessing MMC generic data structures
>> (mmc_request and mmc_queue_req) without grabbing either
>> mmc_blk_data->lock or mmc_queue->thread_sem and it needs to. I don't
>> have a specific stack trace yet where dw_mmc driver is accessing MMC
>> generic data without protection. This is where I need some guidance.
>>
>> I am confident dw_mmc driver is always acquiring dw_mci->lock when
>> accessing data in dw_mci structure(s). I don't see any locking around
>> access into the struct mmc_request by dw_mci_slot[]->mrq though - not
>> sure where that belongs.
>>
>> Two questions:
>> 1) is there interest in adding "assert_spin_locked()" calls to
>> document locking dependencies?
>> 2)  Does anyone understand this code well enough to confirm I'm on the
>> right track and which code path I should be looking at?
>>
>>
>> Back to the bug:  mmc_start_req() is sleeping, waiting for the
>> "previous" (in flight) "async" IO to complete. (1) This IO never
>> completes (unlikely) OR (2) already did (e.g. mmc_host->areq is stale)
>> OR (3) mmc_host->areq is non-zero garbage. I'll add some code to
>> confirm (3) not the last case.
>>
>> I have confirmed with the stress test I'm running (many async IO in
>> flight with two antagonist processes that burns CPU cycles) gets about
>> 4 completions per second that are "done" before we call
>> mmc_start_req(). So I know the race in (2) could happen.
>>
>>
>> thanks,
>> grant
>>
>>
>> INFO: task mmcqd/0:84 blocked for more than 120 seconds.
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> mmcqd/0         D 804f4890     0    84      2 0x00000000
>> [<804f4890>] (__schedule+0x614/0x780) from [<804f4dc0>] (schedule+0x94/0x98)
>> [<804f4dc0>] (schedule+0x94/0x98) from [<804f2ae0>]
>> (schedule_timeout+0x38/0x2d0)
>> [<804f2ae0>] (schedule_timeout+0x38/0x2d0) from [<804f4c14>]
>> (wait_for_common+0x164/0x1a0)
>> [<804f4c14>] (wait_for_common+0x164/0x1a0) from [<804f4d28>]
>> (wait_for_completion+0x20/0x24)
>> [<804f4d28>] (wait_for_completion+0x20/0x24) from [<803a39f8>]
>> (mmc_wait_for_req_done+0x2c/0x84)
>> [<803a39f8>] (mmc_wait_for_req_done+0x2c/0x84) from [<803a4b50>]
>> (mmc_start_req+0x60/0x120)
>> [<803a4b50>] (mmc_start_req+0x60/0x120) from [<803b09bc>]
>> (mmc_blk_issue_rw_rq+0xa0/0x3a8)
>> [<803b09bc>] (mmc_blk_issue_rw_rq+0xa0/0x3a8) from [<803b10e8>]
>> (mmc_blk_issue_rq+0x424/0x478)
>> [<803b10e8>] (mmc_blk_issue_rq+0x424/0x478) from [<803b220c>]
>> (mmc_queue_thread+0xb0/0x118)
>> [<803b220c>] (mmc_queue_thread+0xb0/0x118) from [<8004d620>] (kthread+0xa8/0xbc)
>> [<8004d620>] (kthread+0xa8/0xbc) from [<8000f1c8>] (kernel_thread_exit+0x0/0x8)
>> Kernel panic - not syncing: hung_task: blocked tasks
>> [<800150a4>] (unwind_backtrace+0x0/0x114) from [<804ee160>]
>> (dump_stack+0x20/0x24)
>> [<804ee160>] (dump_stack+0x20/0x24) from [<804ee2d0>] (panic+0xa8/0x1f4)
>> [<804ee2d0>] (panic+0xa8/0x1f4) from [<80086d44>] (watchdog+0x1f4/0x25c)
>> [<80086d44>] (watchdog+0x1f4/0x25c) from [<8004d620>] (kthread+0xa8/0xbc)
>> [<8004d620>] (kthread+0xa8/0xbc) from [<8000f1c8>] (kernel_thread_exit+0x0/0x8)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


From: Grant Grundler <grundler@chromium.org>
Subject: MMC locking: mmc_request accesses from dw_mmc driver ok?
Date: Mon, 12 Aug 2013 16:45:55 -0700
Message-ID: <CANEJEGuRAzsRdwYsdb5MMrpiQxG4DgiRW=XuuQoLz3_84o9Vig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:63282 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab3HLXp4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2013 19:45:56 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so9392397ieb.41
        for <linux-mmc@vger.kernel.org>; Mon, 12 Aug 2013 16:45:56 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I've been working on an "task mmcqd/0:84 blocked for more than 120
seconds" panic for the past month or so in the chromeos-3.4 kernel
tree. Stack trace below. Feel free to tell me "fixed in v3.x". :)

After staring at the 14 MMC and DW driver data structures,  I now
think dw_mmc driver is accessing MMC generic data structures
(mmc_request and mmc_queue_req) without grabbing either
mmc_blk_data->lock or mmc_queue->thread_sem and it needs to. I don't
have a specific stack trace yet where dw_mmc driver is accessing MMC
generic data without protection. This is where I need some guidance.

I am confident dw_mmc driver is always acquiring dw_mci->lock when
accessing data in dw_mci structure(s). I don't see any locking around
access into the struct mmc_request by dw_mci_slot[]->mrq though - not
sure where that belongs.

Two questions:
1) is there interest in adding "assert_spin_locked()" calls to
document locking dependencies?
2)  Does anyone understand this code well enough to confirm I'm on the
right track and which code path I should be looking at?


Back to the bug:  mmc_start_req() is sleeping, waiting for the
"previous" (in flight) "async" IO to complete. (1) This IO never
completes (unlikely) OR (2) already did (e.g. mmc_host->areq is stale)
OR (3) mmc_host->areq is non-zero garbage. I'll add some code to
confirm (3) not the last case.

I have confirmed with the stress test I'm running (many async IO in
flight with two antagonist processes that burns CPU cycles) gets about
4 completions per second that are "done" before we call
mmc_start_req(). So I know the race in (2) could happen.


thanks,
grant


INFO: task mmcqd/0:84 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
mmcqd/0         D 804f4890     0    84      2 0x00000000
[<804f4890>] (__schedule+0x614/0x780) from [<804f4dc0>] (schedule+0x94/0x98)
[<804f4dc0>] (schedule+0x94/0x98) from [<804f2ae0>]
(schedule_timeout+0x38/0x2d0)
[<804f2ae0>] (schedule_timeout+0x38/0x2d0) from [<804f4c14>]
(wait_for_common+0x164/0x1a0)
[<804f4c14>] (wait_for_common+0x164/0x1a0) from [<804f4d28>]
(wait_for_completion+0x20/0x24)
[<804f4d28>] (wait_for_completion+0x20/0x24) from [<803a39f8>]
(mmc_wait_for_req_done+0x2c/0x84)
[<803a39f8>] (mmc_wait_for_req_done+0x2c/0x84) from [<803a4b50>]
(mmc_start_req+0x60/0x120)
[<803a4b50>] (mmc_start_req+0x60/0x120) from [<803b09bc>]
(mmc_blk_issue_rw_rq+0xa0/0x3a8)
[<803b09bc>] (mmc_blk_issue_rw_rq+0xa0/0x3a8) from [<803b10e8>]
(mmc_blk_issue_rq+0x424/0x478)
[<803b10e8>] (mmc_blk_issue_rq+0x424/0x478) from [<803b220c>]
(mmc_queue_thread+0xb0/0x118)
[<803b220c>] (mmc_queue_thread+0xb0/0x118) from [<8004d620>] (kthread+0xa8/0xbc)
[<8004d620>] (kthread+0xa8/0xbc) from [<8000f1c8>] (kernel_thread_exit+0x0/0x8)
Kernel panic - not syncing: hung_task: blocked tasks
[<800150a4>] (unwind_backtrace+0x0/0x114) from [<804ee160>]
(dump_stack+0x20/0x24)
[<804ee160>] (dump_stack+0x20/0x24) from [<804ee2d0>] (panic+0xa8/0x1f4)
[<804ee2d0>] (panic+0xa8/0x1f4) from [<80086d44>] (watchdog+0x1f4/0x25c)
[<80086d44>] (watchdog+0x1f4/0x25c) from [<8004d620>] (kthread+0xa8/0xbc)
[<8004d620>] (kthread+0xa8/0xbc) from [<8000f1c8>] (kernel_thread_exit+0x0/0x8)

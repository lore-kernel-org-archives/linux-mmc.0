From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: mmc_rescan/sdio_reset timeout missing?
Date: Thu, 20 Jun 2013 10:58:06 +0900
Message-ID: <51C261AE.5020507@samsung.com>
References: <CANEJEGsPrkGwZVpK8bfYUyVYN2gfk2fbqs7D4DFaz5GhRaZRcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:18734 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935237Ab3FTB6C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jun 2013 21:58:02 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MOO0046M5GIU160@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 20 Jun 2013 10:57:54 +0900 (KST)
In-reply-to: <CANEJEGsPrkGwZVpK8bfYUyVYN2gfk2fbqs7D4DFaz5GhRaZRcw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>

Hi Grant,

Which kernel-version do you use?
And i want to know the controller IP version.

CC'd to Seungwon.

Best Regards,
Jaehoon Chung

On 06/19/2013 10:44 PM, Grant Grundler wrote:
> I've looking through the code to understand this bug that caused this
> stack trace (and ended up panicing below):
> 
> <3>[ 1680.501338] INFO: task kworker/u:22:9101 blocked for more than
> 120 seconds.
> <3>[ 1680.501348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> <6>[ 1680.501357] kworker/u:22    D 8050644c     0  9101      2 0x00000000
> <5>[ 1680.501385] [<8050644c>] (__schedule+0x608/0x758) from
> [<80506938>] (schedule+0x94/0x98)
> <5>[ 1680.501399] [<80506938>] (schedule+0x94/0x98) from [<80504830>]
> (schedule_timeout+0x38/0x2d0)
> <5>[ 1680.501413] [<80504830>] (schedule_timeout+0x38/0x2d0) from
> [<80506788>] (wait_for_common+0x138/0x178)
> <5>[ 1680.501427] [<80506788>] (wait_for_common+0x138/0x178) from
> [<805068a0>] (wait_for_completion+0x20/0x24)
> <5>[ 1680.501442] [<805068a0>] (wait_for_completion+0x20/0x24) from
> [<803bc424>] (mmc_wait_for_req_done+0x2c/0x84)
> <5>[ 1680.501455] [<803bc424>] (mmc_wait_for_req_done+0x2c/0x84) from
> [<803bc8e8>] (mmc_wait_for_req+0x2c/0x30)
> <5>[ 1680.501468] [<803bc8e8>] (mmc_wait_for_req+0x2c/0x30) from
> [<803bc968>] (mmc_wait_for_cmd+0x7c/0x8c)
> <5>[ 1680.501481] [<803bc968>] (mmc_wait_for_cmd+0x7c/0x8c) from
> [<803c4fe4>] (mmc_io_rw_direct_host+0xc8/0x138)
> <5>[ 1680.501496] [<803c4fe4>] (mmc_io_rw_direct_host+0xc8/0x138) from
> [<803c5440>] (sdio_reset+0x38/0x74)
> <5>[ 1680.501508] [<803c5440>] (sdio_reset+0x38/0x74) from
> [<803be330>] (mmc_rescan+0x214/0x2c0)
> <5>[ 1680.501523] [<803be330>] (mmc_rescan+0x214/0x2c0) from
> [<80045b04>] (process_one_work+0x210/0x424)
> <5>[ 1680.501536] [<80045b04>] (process_one_work+0x210/0x424) from
> [<80046128>] (worker_thread+0x1f0/0x39c)
> <5>[ 1680.501549] [<80046128>] (worker_thread+0x1f0/0x39c) from
> [<8004acc0>] (kthread+0x9c/0xac)
> <5>[ 1680.501563] [<8004acc0>] (kthread+0x9c/0xac) from [<8000ee48>]
> (kernel_thread_exit+0x0/0x8)
> <0>[ 1680.501573] Kernel panic - not syncing: hung_task: blocked tasks
> <5>[ 1680.501586] [<80014890>] (unwind_backtrace+0x0/0xec) from
> [<80500018>] (dump_stack+0x20/0x24)
> <5>[ 1680.501597] [<80500018>] (dump_stack+0x20/0x24) from
> [<80500178>] (panic+0x98/0x1e0)
> <5>[ 1680.501610] [<80500178>] (panic+0x98/0x1e0) from [<80082658>]
> (watchdog+0x1e8/0x24c)
> <5>[ 1680.501621] [<80082658>] (watchdog+0x1e8/0x24c) from
> [<8004acc0>] (kthread+0x9c/0xac)
> <5>[ 1680.501633] [<8004acc0>] (kthread+0x9c/0xac) from [<8000ee48>]
> (kernel_thread_exit+0x0/0x8)
> 
> I don't see any timers being set in any code path for the calls to
> mmc_io_rw_direct_host(host,... SDIO_CCCR_ABORT...) in sdio_reset()
> doesn't complete. I was thinking cmd_timeout_ms could be used but eMMC
> (dw_mmc driver) only appears to support data_timeout and
> response_timeout, not a cmd timeout. And even if dw_mmc did support
> that timeout in HW, cmd_timeout_ms isn't getting set in this code
> path.
> 
> Any advice on how that should be fixed?
> 
> I'm assuming the eMMC device (Sandisk SEM16G - eMMC 4.41) has buggy FW
> and just wedges after a suspend/resume.
> 
> cheers,
> grant
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


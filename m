From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: BUG/PATCH?  mmcblk devices don't suspend properly.
Date: Fri, 30 Mar 2012 10:55:45 +0530
Message-ID: <4F7543D9.7000100@codeaurora.org>
References: <20120330134745.2baa2766@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:22407 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab2C3FZw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Mar 2012 01:25:52 -0400
In-Reply-To: <20120330134745.2baa2766@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, per.forlin@linaro.org

On 3/30/2012 8:17 AM, NeilBrown wrote:
>
> I've been experimenting with removing the call to sys_sync() in
> enter_state().  For me (with verbose debugging and syslog running)
> this causes a noticeable delay when entering suspend.
>
> Removing it should not affect correctness as there is no locking the ensure
> that no other process writes out data immediately after the 'sync'
> completed.  But it could make existing bugs more obvious - in fact it does :-)
>
> The device I am doing this on is using a micro-SD card for storage.
> The card cannot be removed without removing the battery, so
> MMC_CAP_NONREMOVABLE is set for the mmc slot (which seems necessary for
> safely having '/' there).
>
> Since removing the sys_sync() call I've notices a number of problems with
> suspend/resume, the most obvious being that resume blocks in mmc_claim_host:
>
> [  263.585754] susman          D c046455c  5604  1086   1084 0x00000000
> [  263.592498] [<c046455c>] (__schedule+0x584/0x614) from [<c0302630>] (__mmc_claim_host+0xb8/0x154)
> [  263.601806] [<c0302630>] (__mmc_claim_host+0xb8/0x154) from [<c0308640>] (mmc_sd_resume+0x34/0x5c)
> [  263.611206] [<c0308640>] (mmc_sd_resume+0x34/0x5c) from [<c0301ce4>] (mmc_resume_host+0xc8/0x15c)
> [  263.620513] [<c0301ce4>] (mmc_resume_host+0xc8/0x15c) from [<c0317bdc>] (omap_hsmmc_resume+0xbc/0x104)
> [  263.630279] [<c0317bdc>] (omap_hsmmc_resume+0xbc/0x104) from [<c025b41c>] (platform_pm_resume+0x44/0x54)
> [  263.640197] [<c025b41c>] (platform_pm_resume+0x44/0x54) from [<c025f88c>] (dpm_run_callback+0x48/0x8c)
> [  263.649963] [<c025f88c>] (dpm_run_callback+0x48/0x8c) from [<c0260348>] (device_resume+0x204/0x268)
> [  263.659454] [<c0260348>] (device_resume+0x204/0x268) from [<c02604b8>] (dpm_resume+0x10c/0x244)
> [  263.668579] [<c02604b8>] (dpm_resume+0x10c/0x244) from [<c02605fc>] (dpm_resume_end+0xc/0x18)
> [  263.677490] [<c02605fc>] (dpm_resume_end+0xc/0x18) from [<c0061784>] (suspend_devices_and_enter+0x1d0/0x22c)
> [  263.687805] [<c0061784>] (suspend_devices_and_enter+0x1d0/0x22c) from [<c00618f8>] (enter_state+0x118/0x170)
> [  263.698089] [<c00618f8>] (enter_state+0x118/0x170) from [<c00605b4>] (state_store+0x94/0x118)
> [  263.707061] [<c00605b4>] (state_store+0x94/0x118) from [<c01df898>] (kobj_attr_store+0x1c/0x24)
> [  263.716186] [<c01df898>] (kobj_attr_store+0x1c/0x24) from [<c011dcf4>] (sysfs_write_file+0x108/0x13c)
> [  263.725860] [<c011dcf4>] (sysfs_write_file+0x108/0x13c) from [<c00c5748>] (vfs_write+0xac/0x180)
> [  263.735076] [<c00c5748>] (vfs_write+0xac/0x180) from [<c00c58d4>] (sys_write+0x40/0x6c)
> [  263.743469] [<c00c58d4>] (sys_write+0x40/0x6c) from [<c000ea00>] (ret_fast_syscall+0x0/0x3c)
>
>
> while mmcdq/0 is owning the device and waiting for something that will
> apparently never happen:
>
> [  262.566680] mmcqd/0         D c046455c  5828    53      2 0x00000000
> [  262.573425] [<c046455c>] (__schedule+0x584/0x614) from [<c04620f0>] (schedule_timeout+0x1c/0x1d0)
> [  262.582733] [<c04620f0>] (schedule_timeout+0x1c/0x1d0) from [<c0463eb4>] (wait_for_common+0xd8/0x150)
> [  262.592407] [<c0463eb4>] (wait_for_common+0xd8/0x150) from [<c0303488>] (mmc_wait_for_req_done+0x24/0xbc)
> [  262.602447] [<c0303488>] (mmc_wait_for_req_done+0x24/0xbc) from [<c0303f20>] (mmc_start_req+0x50/0x11c)
> [  262.612304] [<c0303f20>] (mmc_start_req+0x50/0x11c) from [<c030df2c>] (mmc_blk_issue_rw_rq+0x78/0x500)
> [  262.622070] [<c030df2c>] (mmc_blk_issue_rw_rq+0x78/0x500) from [<c030e7a4>] (mmc_blk_issue_rq+0x3f0/0x420)
> [  262.632171] [<c030e7a4>] (mmc_blk_issue_rq+0x3f0/0x420) from [<c030f884>] (mmc_queue_thread+0x98/0x100)
> [  262.642028] [<c030f884>] (mmc_queue_thread+0x98/0x100) from [<c004fcc8>] (kthread+0x84/0x90)
> [  262.650878] [<c004fcc8>] (kthread+0x84/0x90) from [<c000f398>] (kernel_thread_exit+0x0/0x8)
>
> I traced this to the fact that mmc_bus_suspend / mmc_bus_resume are *never*
> being called.  So mmc_blk_suspend isn't called and the queue isn't suspended.
>
> The problem appears to be that mmc_bus_suspend is defined as a 'legacy'
> suspend function. i.e. it is assigned to mmc_bus_type.suspend rather than
> mmc_bus_type.pm.suspend.
> In __device_suspend() I see that the legacy suspend function is only called if
> the bus has *no* dev_pm_ops at all.
> However when CONFIG_PM_RUNTIME is defined, mmc_bustype does have a dev_pm_ops
> which contains runtime_{suspend,resume,idle},but no suspend or resume.
>
> The net effect is that - as I observed - mmc_bus_suspend is never called.
>
> I added lines:
>
> 	.suspend		= mmc_bus_suspend,
> 	.resume			= mmc_bus_resume,
>
> to mmc_bus_pm_ops and can no longer reproduce the problem.  So maybe this
> patch is appropriate:
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 5d011a3..80c1e46 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -169,6 +169,8 @@ static const struct dev_pm_ops mmc_bus_pm_ops = {
>   	.runtime_suspend	= mmc_runtime_suspend,
>   	.runtime_resume		= mmc_runtime_resume,
>   	.runtime_idle		= mmc_runtime_idle,
> +	.suspend		= mmc_bus_suspend,
> +	.resume			= mmc_bus_resume,
>   };
>
>   #define MMC_PM_OPS_PTR	(&mmc_bus_pm_ops)
>
> however I suspect we should remove the 'legacy' pointers at the same time.(?).
This was pointed out earlier and a patch is posted but looks like it 
never went into mmc tree -- 
http://comments.gmane.org/gmane.linux.kernel.mmc/9168

>
> Also, while exploring this problem I could not find anything that would cause
> mmc_bus_suspend() to wait for an async request to complete.  Maybe  it is
> there somewhere that I don't understand yet, and I cannot be sure that any of
> my symptoms could be explained by an async request continuing while the
> hardware was powered off, but I wonder if something like this might be needed
> too:
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 2517547..cd36c30 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -354,6 +354,8 @@ void mmc_queue_suspend(struct mmc_queue *mq)
>   		spin_unlock_irqrestore(q->queue_lock, flags);
>
>   		down(&mq->thread_sem);
> +		/* wait for current request to complete */
> +		mmc_start_req(mq->card->host, NULL, NULL);
>   	}
This looks good to me but I would prefer Per Forlin to ack on it.

>   }
>
>
> Thanks for any help you can provide,
>
> NeilBrown
>


From: Per Forlin <per.lkml@gmail.com>
Subject: Re: BUG/PATCH? mmcblk devices don't suspend properly.
Date: Mon, 2 Apr 2012 22:43:54 +0200
Message-ID: <CAFEEs1mS1J0NMimAZF5fzs-B5eTar-2No=4bi18zKCz27GQR5g@mail.gmail.com>
References: <20120330134745.2baa2766@notabene.brown>
	<4F7543D9.7000100@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:56965 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab2DBUn4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Apr 2012 16:43:56 -0400
In-Reply-To: <4F7543D9.7000100@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: NeilBrown <neilb@suse.de>, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, Mar 30, 2012 at 7:25 AM, Sujit Reddy Thumma
<sthumma@codeaurora.org> wrote:
> On 3/30/2012 8:17 AM, NeilBrown wrote:
>>
>>
>> I've been experimenting with removing the call to sys_sync() in
>> enter_state(). =A0For me (with verbose debugging and syslog running)
>> this causes a noticeable delay when entering suspend.
>>
>> Removing it should not affect correctness as there is no locking the
>> ensure
>> that no other process writes out data immediately after the 'sync'
>> completed. =A0But it could make existing bugs more obvious - in fact=
 it does
>> :-)
>>
>> The device I am doing this on is using a micro-SD card for storage.
>> The card cannot be removed without removing the battery, so
>> MMC_CAP_NONREMOVABLE is set for the mmc slot (which seems necessary =
for
>> safely having '/' there).
>>
>> Since removing the sys_sync() call I've notices a number of problems=
 with
>> suspend/resume, the most obvious being that resume blocks in
>> mmc_claim_host:
>>
>> [ =A0263.585754] susman =A0 =A0 =A0 =A0 =A0D c046455c =A05604 =A0108=
6 =A0 1084 0x00000000
>> [ =A0263.592498] [<c046455c>] (__schedule+0x584/0x614) from [<c03026=
30>]
>> (__mmc_claim_host+0xb8/0x154)
>> [ =A0263.601806] [<c0302630>] (__mmc_claim_host+0xb8/0x154) from
>> [<c0308640>] (mmc_sd_resume+0x34/0x5c)
>> [ =A0263.611206] [<c0308640>] (mmc_sd_resume+0x34/0x5c) from [<c0301=
ce4>]
>> (mmc_resume_host+0xc8/0x15c)
>> [ =A0263.620513] [<c0301ce4>] (mmc_resume_host+0xc8/0x15c) from [<c0=
317bdc>]
>> (omap_hsmmc_resume+0xbc/0x104)
>> [ =A0263.630279] [<c0317bdc>] (omap_hsmmc_resume+0xbc/0x104) from
>> [<c025b41c>] (platform_pm_resume+0x44/0x54)
>> [ =A0263.640197] [<c025b41c>] (platform_pm_resume+0x44/0x54) from
>> [<c025f88c>] (dpm_run_callback+0x48/0x8c)
>> [ =A0263.649963] [<c025f88c>] (dpm_run_callback+0x48/0x8c) from [<c0=
260348>]
>> (device_resume+0x204/0x268)
>> [ =A0263.659454] [<c0260348>] (device_resume+0x204/0x268) from [<c02=
604b8>]
>> (dpm_resume+0x10c/0x244)
>> [ =A0263.668579] [<c02604b8>] (dpm_resume+0x10c/0x244) from [<c02605=
fc>]
>> (dpm_resume_end+0xc/0x18)
>> [ =A0263.677490] [<c02605fc>] (dpm_resume_end+0xc/0x18) from [<c0061=
784>]
>> (suspend_devices_and_enter+0x1d0/0x22c)
>> [ =A0263.687805] [<c0061784>] (suspend_devices_and_enter+0x1d0/0x22c=
) from
>> [<c00618f8>] (enter_state+0x118/0x170)
>> [ =A0263.698089] [<c00618f8>] (enter_state+0x118/0x170) from [<c0060=
5b4>]
>> (state_store+0x94/0x118)
>> [ =A0263.707061] [<c00605b4>] (state_store+0x94/0x118) from [<c01df8=
98>]
>> (kobj_attr_store+0x1c/0x24)
>> [ =A0263.716186] [<c01df898>] (kobj_attr_store+0x1c/0x24) from [<c01=
1dcf4>]
>> (sysfs_write_file+0x108/0x13c)
>> [ =A0263.725860] [<c011dcf4>] (sysfs_write_file+0x108/0x13c) from
>> [<c00c5748>] (vfs_write+0xac/0x180)
>> [ =A0263.735076] [<c00c5748>] (vfs_write+0xac/0x180) from [<c00c58d4=
>]
>> (sys_write+0x40/0x6c)
>> [ =A0263.743469] [<c00c58d4>] (sys_write+0x40/0x6c) from [<c000ea00>=
]
>> (ret_fast_syscall+0x0/0x3c)
>>
>>
>> while mmcdq/0 is owning the device and waiting for something that wi=
ll
>> apparently never happen:
>>
>> [ =A0262.566680] mmcqd/0 =A0 =A0 =A0 =A0 D c046455c =A05828 =A0 =A05=
3 =A0 =A0 =A02 0x00000000
>> [ =A0262.573425] [<c046455c>] (__schedule+0x584/0x614) from [<c04620=
f0>]
>> (schedule_timeout+0x1c/0x1d0)
>> [ =A0262.582733] [<c04620f0>] (schedule_timeout+0x1c/0x1d0) from
>> [<c0463eb4>] (wait_for_common+0xd8/0x150)
>> [ =A0262.592407] [<c0463eb4>] (wait_for_common+0xd8/0x150) from [<c0=
303488>]
>> (mmc_wait_for_req_done+0x24/0xbc)
>> [ =A0262.602447] [<c0303488>] (mmc_wait_for_req_done+0x24/0xbc) from
>> [<c0303f20>] (mmc_start_req+0x50/0x11c)
>> [ =A0262.612304] [<c0303f20>] (mmc_start_req+0x50/0x11c) from [<c030=
df2c>]
>> (mmc_blk_issue_rw_rq+0x78/0x500)
>> [ =A0262.622070] [<c030df2c>] (mmc_blk_issue_rw_rq+0x78/0x500) from
>> [<c030e7a4>] (mmc_blk_issue_rq+0x3f0/0x420)
>> [ =A0262.632171] [<c030e7a4>] (mmc_blk_issue_rq+0x3f0/0x420) from
>> [<c030f884>] (mmc_queue_thread+0x98/0x100)
>> [ =A0262.642028] [<c030f884>] (mmc_queue_thread+0x98/0x100) from
>> [<c004fcc8>] (kthread+0x84/0x90)
>> [ =A0262.650878] [<c004fcc8>] (kthread+0x84/0x90) from [<c000f398>]
>> (kernel_thread_exit+0x0/0x8)
>>
>> I traced this to the fact that mmc_bus_suspend / mmc_bus_resume are
>> *never*
>> being called. =A0So mmc_blk_suspend isn't called and the queue isn't
>> suspended.
>>
>> The problem appears to be that mmc_bus_suspend is defined as a 'lega=
cy'
>> suspend function. i.e. it is assigned to mmc_bus_type.suspend rather=
 than
>> mmc_bus_type.pm.suspend.
>> In __device_suspend() I see that the legacy suspend function is only
>> called if
>> the bus has *no* dev_pm_ops at all.
>> However when CONFIG_PM_RUNTIME is defined, mmc_bustype does have a
>> dev_pm_ops
>> which contains runtime_{suspend,resume,idle},but no suspend or resum=
e.
>>
>> The net effect is that - as I observed - mmc_bus_suspend is never ca=
lled.
>>
>> I added lines:
>>
>> =A0 =A0 =A0 =A0.suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mmc_bus_s=
uspend,
>> =A0 =A0 =A0 =A0.resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mmc_bus_r=
esume,
>>
>> to mmc_bus_pm_ops and can no longer reproduce the problem. =A0So may=
be this
>> patch is appropriate:
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 5d011a3..80c1e46 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -169,6 +169,8 @@ static const struct dev_pm_ops mmc_bus_pm_ops =3D=
 {
>> =A0 =A0 =A0 =A0.runtime_suspend =A0 =A0 =A0 =A0=3D mmc_runtime_suspe=
nd,
>> =A0 =A0 =A0 =A0.runtime_resume =A0 =A0 =A0 =A0 =3D mmc_runtime_resum=
e,
>> =A0 =A0 =A0 =A0.runtime_idle =A0 =A0 =A0 =A0 =A0 =3D mmc_runtime_idl=
e,
>> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mmc_bus_su=
spend,
>> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mmc_bus_re=
sume,
>> =A0};
>>
>> =A0#define MMC_PM_OPS_PTR =A0 =A0 =A0 =A0(&mmc_bus_pm_ops)
>>
>> however I suspect we should remove the 'legacy' pointers at the same
>> time.(?).
>
> This was pointed out earlier and a patch is posted but looks like it =
never
> went into mmc tree -- http://comments.gmane.org/gmane.linux.kernel.mm=
c/9168
>
>
>>
>> Also, while exploring this problem I could not find anything that wo=
uld
>> cause
>> mmc_bus_suspend() to wait for an async request to complete. =A0Maybe=
 =A0it is
>> there somewhere that I don't understand yet, and I cannot be sure th=
at any
>> of
>> my symptoms could be explained by an async request continuing while =
the
>> hardware was powered off, but I wonder if something like this might =
be
>> needed
>> too:
>>
>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>> index 2517547..cd36c30 100644
>> --- a/drivers/mmc/card/queue.c
>> +++ b/drivers/mmc/card/queue.c
>> @@ -354,6 +354,8 @@ void mmc_queue_suspend(struct mmc_queue *mq)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(q->queue_lock,=
 flags);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0down(&mq->thread_sem);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* wait for current request to complet=
e */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(mq->card->host, NULL, NU=
LL);
This shouldn't be necessary.

>> =A0 =A0 =A0 =A0}
>
> This looks good to me but I would prefer Per Forlin to ack on it.
My interpretation of the code is that the "thread_sem" blocks until
the mmc_qeueu_thread() has finished all request in the queue.
I refer to this code:
----------------
  		if (req || mq->mqrq_prev->req) {
			set_current_state(TASK_RUNNING);
			mq->issue_fn(mq, req);
		} else {
			if (kthread_should_stop()) {
				set_current_state(TASK_RUNNING);
				break;
			}
			up(&mq->thread_sem);
			schedule();
			down(&mq->thread_sem);
		}
--------------------------
mmc_queue_thread() will always finish off a sequence of requests by
issuing a NULL request to complete the ongoing async request,
If both the new req fetched from the queue and the ongoing (previous)
req are NULL, it will goto sleep.
At this point mmc_queue_thread will increase the sem, and wake up the
mmc_queue_suspend().

Regards,
Per

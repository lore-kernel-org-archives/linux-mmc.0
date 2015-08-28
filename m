From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH] mmc: core: fix race condition in mmc_wait_data_done
Date: Fri, 28 Aug 2015 10:55:25 +0200
Message-ID: <CAPDyKFqZXx11qsnPH_uTDptfkUFfDykNKPgVcH6AW5CbH6Fi8g@mail.gmail.com>
References: <1440731589-22241-1-git-send-email-shawn.lin@rock-chips.com>
	<55DFD4B7.3070601@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55DFD4B7.3070601@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jialing Fu <jlfu@marvell.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 28 August 2015 at 05:25, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2015/8/28 11:13, Shawn Lin wrote:
>>
>> From: Jialing Fu <jlfu@marvell.com>
>>
>> The following panic is captured in ker3.14, but the issue still exists
>> in latest kernel.
>> ---------------------------------------------------------------------
>> [   20.738217] c0 3136 (Compiler) Unable to handle kernel NULL pointer
>> dereference
>> at virtual address 00000578
>> ......
>> [   20.738499] c0 3136 (Compiler) PC is at
>> _raw_spin_lock_irqsave+0x24/0x60
>> [   20.738527] c0 3136 (Compiler) LR is at
>> _raw_spin_lock_irqsave+0x20/0x60
>> [   20.740134] c0 3136 (Compiler) Call trace:
>> [   20.740165] c0 3136 (Compiler) [<ffffffc0008ee900>]
>> _raw_spin_lock_irqsave+0x24/0x60
>> [   20.740200] c0 3136 (Compiler) [<ffffffc0000dd024>] __wake_up+0x1c/0x54
>> [   20.740230] c0 3136 (Compiler) [<ffffffc000639414>]
>> mmc_wait_data_done+0x28/0x34
>> [   20.740262] c0 3136 (Compiler) [<ffffffc0006391a0>]
>> mmc_request_done+0xa4/0x220
>> [   20.740314] c0 3136 (Compiler) [<ffffffc000656894>]
>> sdhci_tasklet_finish+0xac/0x264
>> [   20.740352] c0 3136 (Compiler) [<ffffffc0000a2b58>]
>> tasklet_action+0xa0/0x158
>> [   20.740382] c0 3136 (Compiler) [<ffffffc0000a2078>]
>> __do_softirq+0x10c/0x2e4
>> [   20.740411] c0 3136 (Compiler) [<ffffffc0000a24bc>] irq_exit+0x8c/0xc0
>> [   20.740439] c0 3136 (Compiler) [<ffffffc00008489c>]
>> handle_IRQ+0x48/0xac
>> [   20.740469] c0 3136 (Compiler) [<ffffffc000081428>]
>> gic_handle_irq+0x38/0x7c
>> ----------------------------------------------------------------------
>> Because in SMP, "mrq" has race condition between below two paths:
>> path1: CPU0: <tasklet context>
>>    static void mmc_wait_data_done(struct mmc_request *mrq)
>>    {
>>       mrq->host->context_info.is_done_rcv = true;
>>       //
>>       // If CPU0 has just finished "is_done_rcv = true" in path1, and at
>>       // this moment, IRQ or ICache line missing happens in CPU0.
>>       // What happens in CPU1 (path2)?
>>       //
>>       // If the mmcqd thread in CPU1(path2) hasn't entered to sleep mode:
>>       // path2 would have chance to break from wait_event_interruptible
>>       // in mmc_wait_for_data_req_done and continue to run for next
>>       // mmc_request (mmc_blk_rw_rq_prep).
>>       //
>>       // Within mmc_blk_rq_prep, mrq is cleared to 0.
>>       // If below line still gets host from "mrq" as the result of
>>       // compiler, the panic happens as we traced.
>>       wake_up_interruptible(&mrq->host->context_info.wait);
>>    }
>>
>> path2: CPU1: <The mmcqd thread runs mmc_queue_thread>
>>    static int mmc_wait_for_data_req_done(...
>>    {
>>       ...
>>       while (1) {
>>             wait_event_interruptible(context_info->wait,
>>                     (context_info->is_done_rcv ||
>>                      context_info->is_new_req));
>>            static void mmc_blk_rw_rq_prep(...
>>             {
>>             ...
>>             memset(brq, 0, sizeof(struct mmc_blk_request));
>>
>> This issue happens very coincidentally; however adding mdelay(1) in
>> mmc_wait_data_done as below could duplicate it easily.
>>
>>     static void mmc_wait_data_done(struct mmc_request *mrq)
>>     {
>>       mrq->host->context_info.is_done_rcv = true;
>> +    mdelay(1);
>>       wake_up_interruptible(&mrq->host->context_info.wait);
>>      }
>>
>
> Hi, ulf
>
> We find this bug on Intel-C3230RK platform for very small probability.
>
> Whereas I can easily reproduce this case if I add a mdelay(1) or  longer
> delay as Jialing did.
>
> This patch seems useful to me. Should we push it forward? :)

It seems like a very good idea!

Should we add a fixes tag to it?

[...]

Kind regards
Uffe

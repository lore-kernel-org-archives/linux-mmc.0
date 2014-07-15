From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: sdhci_s3c_consider_clock scheduling while atomic - clk_round_rate
Date: Tue, 15 Jul 2014 15:33:51 +0900
Message-ID: <53C4CB4F.6070007@samsung.com>
References: <CAD8Lp45QV4ZcfXA86hoseKfJLLV_BJ-g0UABnOGPkJW1pMXhFw@mail.gmail.com>
 <53A99EB5.6010907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <53A99EB5.6010907@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>, Daniel Drake <drake@endlessm.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, ben-linux@fluff.org, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

It's also related with clock-gating.
Mainline kernel is using the "clkgate-delay = 0" by default.
If we use this value, Every request time should be gated/ungated...
Then it may be faced the race-condition...In my experiment, it occasionally occurred the CRC error or other problem.
And it's also degraded the performance since add the overhead.
I'm using "clkgate-delay = 3 ~ 10".

Anyway, we need to fix this. I will consider this.


Best Regards,
Jaehoon Chung

On 06/25/2014 12:52 AM, Tomasz Figa wrote:
> Hi Daniel,
> 
> [adding Ulf, Chris and Mike to the discussion]
> 
> On 24.06.2014 11:48, Daniel Drake wrote:
>> sdhci_s3c_set_clock is called from sdhci_do_set_ios with interrupts
>> disabled, and this calls into sdhci_s3c_consider_clock().
>>
>> The patch "mmc: sdhci-s3c: Cache bus clock rates" addressed some
>> scheduling while atomic in this function, but there are more issues
>> here, seen while testing 3.16-rc2 on exynos4412:
>>
>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:103
>> in_atomic(): 1, irqs_disabled(): 128, pid: 75, name: mmcqd/0
>> Preemption disabled at:[<  (null)>]   (null)
>>
>> CPU: 0 PID: 75 Comm: mmcqd/0 Not tainted 3.16.0-rc2-00028-ge9fe7eb-dirty #77
>> [<c0016140>] (unwind_backtrace) from [<c0011e14>] (show_stack+0x10/0x14)
>> [<c0011e14>] (show_stack) from [<c05ce8a8>] (dump_stack+0x84/0xc4)
>> [<c05ce8a8>] (dump_stack) from [<c05d2de0>] (mutex_lock+0x1c/0x3c)
>> [<c05d2de0>] (mutex_lock) from [<c046214c>] (clk_prepare_lock+0x6c/0xf4)
>> [<c046214c>] (clk_prepare_lock) from [<c04625ac>] (clk_round_rate+0x10/0x2c)
>> [<c04625ac>] (clk_round_rate) from [<c0447628>] (sdhci_s3c_set_clock+0x4c/0x1e8)
>> [<c0447628>] (sdhci_s3c_set_clock) from [<c0447818>]
>> (sdhci_cmu_set_clock+0x54/0x140)
>> [<c0447818>] (sdhci_cmu_set_clock) from [<c0443a38>]
>> (sdhci_do_set_ios+0x138/0x58c)
>> [<c0443a38>] (sdhci_do_set_ios) from [<c0443864>] (sdhci_set_ios+0x28/0x34)
>>
>> clk_round_rate cannot be called here because it takes a mutex.
>>
>> sdhci_s3c_set_clock() also calls into clk_prepare_enable() which looks
>> like it could trigger this problem too.
> 
> Apparently this is related to generic sdhci code calling .set_clock()
> under spin_lock_irqsave(). For reference, see sdhci_do_set_ios() and
> sdhci_tasklet_finish().
> 
> Chris, Ulf, any suggestions?
> 
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

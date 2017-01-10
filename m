From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [BUG] Boot failure since df9bcc2bc on veyron_speedy
Date: Tue, 10 Jan 2017 08:47:16 +0800
Message-ID: <f30b97b0-d0e2-b6dd-e11e-ca4ea592b18d@rock-chips.com>
References: <20170109141955.GB13205@number18.npnth.net>
 <20170109144937.GC13205@number18.npnth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:56811 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964855AbdAJAsS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 19:48:18 -0500
In-Reply-To: <20170109144937.GC13205@number18.npnth.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S. Gilles" <sgilles@math.umd.edu>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi

On 2017/1/9 22:49, S. Gilles wrote:
> On 2017-01-09T09:19:55-0500, S. Gilles wrote:
>> Hi,
>>
>> I have a C201, a veyron_speedy device (which uses rk3288) running vanilla
>> kernels. With recent kernels it will fail to boot (screen is on, with
>> blinking cursor, but no login prompt and the machine does not respond
>> over ssh).
>>
>> I've bisected this to df9bcc2bc0a1f8d2963bd916698268fb2470713b, and
>> reverting that commit on -mainline gives me a bootable kernel. I can
>> provide more information as needed.
>

The fix is on the way,

https://patchwork.kernel.org/patch/9498527/

> As I was writing that, I let it sit in the non-booting state for longer
> than usual.  After about 6 minutes, I got panic output, which I hadn't
> observed before. I've transcribed it by hand, so there may be typos.
>
> ...
> 1f40: 60000013 ffffffff
> [<c010cdcc>] (__irq_svc) from [<c0108414>] (arch_cpu_idle+0x2c/0x48)
> [<c0108414>] (arch_cpu_idle) from [<c07925d8>] (default_idle_call+0x38/0x3c)
> [<c07925d8>] (default_idle_call) from [<c01661e0>] (do_idle+0x108/0x1e4)
> [<c01661e0>] (do_idle) from [<c016650>] (cpu_startup_entry+0x28/0x2c)
> [<c0166550>] (cpu_startup_entry) from [<c078cbfc>] (rest_init+0x70/0x88)
> [<c078cbfc>] (rest_init) from [<c9b99d18>] (start_kernel+0x374/0x3f8)
> [<c0b00d18>] (start_kernel) from [<0000807c>] (0x807c)
> CPU1: stopping
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.10.0-rc2-EXPERIMENTAL+ #17
> Hardware name: Rockchip (Device Tree)
> [<c0110938>] (unwind_backtrace) from [<c010c1e8>] (show_stack+0x20/0x24)
> [<c010c1e8>] (show_stack) from [<c03cdd3c>] (dump_stack+0x84/0xa0)
> [<c03cdd3c>] (dump_stack) from [<c010ee74>] (handle_IPI+0x1c0/0x298)
> [<c010ee74>] (handle_IPI) from [<c0101514>] (gic_handle_irq+0x88/0xa4)
> [<c0101514>] (gic_handle_irq) from [<c010cdcc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xed93bf40 to 0xed93bf88)
> bf40: 00000001 00000000 00000000 c011bde0 00000000 00000000 c0b8efd0 c0c942c0
> bf60: 0000406a 410fc0d1 00000000 ed93bf9c ed93bfa0 ed93bf90 c0108424 c0108414
> bf80: 60000013 ffffffff
> [<c010cdcc>] (__irq_svc) from [<c0108414>] (arch_cpu_idle+0x2c/0x48)
> [<c0108414>] (arch_cpu_idle) from [<c0166550>] (default_idle_call+0x38/0x3c)
> [<c07925d8>] (default_idle_call) from [<c01661e0>] (do_idle+0x108/0x1e4)
> [<c01661e0>] (do_idle) from [<c016650] (cpu_startup_entry+0x28/0x2c)
> [<c0166550>] (cpu_startup_entry) from [<c010ea34>] (secondary_start_kernel+0x114/0x134)
> [<c010ea34>] (secondary_start_kernel) from [<001018cc>] (0x1018cc)
> BUG: spinlock bad magic on CPU#2, khungtaskd/33
>  lock: 0xeda23a98, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> CPU: 2 PID: 33 Comm: khungtaskd Not tainted 4.10-rc2-EXPERIMENTAL+ #17
> Hardware name: Rockchip (Device Tree)
> [<c0110938>] (unwind_backtrace) from [<c010c1e8>] (show_stack+0x20/0x24)
> [<c010c1e8>] (show_stack) from [<c03cdd3c>] (dump_stack+0x84/0xa0)
> [<c03cdd3c>] (dump_stack) from [<c0168f74>] (spin_dump+0x8c/0xa0)
> [<c0168f74>] (spin_dump) from [<c0168fbc>] (spin_bug+0x34/0x38)
> [<c0168fbc>] (spin_bug) from [<c0169060>] (do_raw_spin_lock+0x30/0x1ac)
> [<c0169060>] (do_raw_spin_lock) from [<c0792600>] (_raw_spin_lock_irqsave+0x20/0x298)
> [<c0792600>] (_raw_spin_lock_irqsave) from [<c036fce0>] (buffer_size_add+0x34/0x74)
> [<c036fce0>] (buffer_size_add) from [<c0370234>] (persistent_ram_write+0x34/0xc0)
> [<c0370234>] (persistent_ram_write) from [<c036eb00>] (ramoops_pstore_write_buf+0x1ac/0x228)
> [<c036eb00>] (ramoops_pstore_write_buf) from [<c036dc4c>] (pstore_write_compat+0x48/0x55)
> [<c036dc4c>] (pstore_write_compat) from [<c036e2ec>] (pstore_dump+0x234/0x29c)
> [<c036e2ec>] (pstore_dump) from [<c01700ec>] (kmsg_dump+0xb4/0xcc)
> [<c01700ec>] (kmsg_dump) from [<c01ec8cc>] (panic+0x114/0x26c)
> [<c01ec8cc>] (panic) from [<c91afe5c>] (watchdog+0x36c/0x3ac)
> [<c01afe5c>] (watchdog) from [<c0140014>] (kthread+0x134/0x14c)
> [<c0140014>] (kthread) from [<c0107998>] (ret_from_fork+0x14/0x3c)
> ---[ end Kernel panic - not syncing: hung_task: blocked tasks
>
> Hopefully this is helpful.
>


-- 
Best Regards
Shawn Lin


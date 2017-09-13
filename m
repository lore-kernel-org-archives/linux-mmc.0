From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Date: Wed, 13 Sep 2017 12:04:39 +0800
Message-ID: <a1683a2f-1940-a787-645e-fbf63b50e8a8@rock-chips.com>
References: <20170905194739.GA31241@amd>
 <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
 <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com>
 <CAPDyKFqXaDFrJH1-YSSCx0xPXfMN99AM_Wu_sWQf5A6bw+zjdQ@mail.gmail.com>
 <CACRpkdb263SS-7H1wcp0THAwzKO7A-kE0DVUdTiuxTnuXtWVVw@mail.gmail.com>
 <b640c98b-c534-9d66-3136-d7ca47387af9@rock-chips.com>
 <CACRpkdb84DnU=f8RpRH2fiUcT6OYcbVLUEiLBfOdApo9g9Ehww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:60540 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbdIMEFD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Sep 2017 00:05:03 -0400
In-Reply-To: <CACRpkdb84DnU=f8RpRH2fiUcT6OYcbVLUEiLBfOdApo9g9Ehww@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Seraphime Kirkovski <kirkseraph@gmail.com>


On 2017/9/12 17:42, Linus Walleij wrote:
> On Fri, Sep 8, 2017 at 4:51 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> On 2017/9/8 4:02, Linus Walleij wrote:
>>> On Thu, Sep 7, 2017 at 9:18 AM, Ulf Hansson <ulf.hansson@linaro.org>
>>> wrote:
>>>
>>>> Even if this fixes the problem it seems like we are papering over the
>>>> real issue, which earlier fixes also did during the release cycle for
>>>> v4.13.
>>>
>>>
>>> I think this is the real solution to the issue.
>>>
>>>>> Another unrelated issue with mmc_init_request() is that
>>>>> mmc_exit_request()
>>>>> is not called if mmc_init_request() fails, which means
>>>>> mmc_init_request()
>>>>> must free anything it allocates when it fails.
>>>>
>>>>
>>>> Yes, the situations it's just too fragile. We need to fix the behavior
>>>> properly, although I haven't myself been able to investigate exactly
>>>> how yet.
>>>>
>>>> Adding, Linus, perhaps he has some ideas.
>>>
>>>
>>> Maybe we should simply bite the bullet and do what was suggested
>>> by another contributor when I refactored the bounce buffer handling:
>>> simply delete the bounce buffer code and let any remaining (few?)
>>> legacy devices suffer a bit (performancewise) at the gain of way
>>> simpler code?
>>
>> Are you in the same page with what Adrian pointed to?
>>
>> IIUC, the issue is:
>> init_rq_fn will be called each time when trying to create new reuqest
>> from the pre-allocated request_list memeory pool, and exit_rq_fn will is
>> in the corresponding routine to free request from request_list
>> (blk_free_request) when finished. But if alloc_request_size fails, it
>> won't call exit_rq_fn, so you need to prevent memory leak on your own
>> error path of init_rq_fn.
> 
> Yes and that is what the current patch fixes, is it not?

Nope. It fixed the *out-of-bound* memory usage as request queue will
hold 4 requests by default and only use these four requests when meeting
memory pressure. But the code didn't place the correct bouncesz so that
the 4 pre-allocated requests didn't have valid memory page when
allocated.  But in runtime, normally the request queue asks for new
request from request list by dynamically allocating it. So your
init_rq_fn will be called each time. However the mmc_init_request
didn't handle the error path properly。


I simply add SDHCI_QUIRK_BROKEN_ADMA for my SDHCI to force it use
SDMA so that the host->max_segs should be 1. Then add some a hack to
simulate some random failure for mmc_alloc_sg and then after some iozone
stress test, the memory is exhausted finally.

+static u64 skip = 0;
  static struct scatterlist *mmc_alloc_sg(int sg_len, gfp_t gfp)
  {
         struct scatterlist *sg;
+       u32 random = 0;
+
+       /* Simply skip the bootup stage */
+       if (skip++ >= 0x800)
+               random = get_random_int();
+
+       if (unlikely((random & 0xf) > 0xd)) {
+               printk("mmc_alloc_sg: make fake failure, random =
0x%x\n", random);
+               return NULL;
+       }


[  540.507195] iozone invoked oom-killer: 
gfp_mask=0x16040c0(GFP_KERNEL|__GFP_COMP|__GFP_NOTRACK), 
nodemask=(null),  order=0, oom_score_adj=0
[  540.508302] iozone cpuset=/ mems_allowed=0
[  540.508727] CPU: 2 PID: 3039 Comm: iozone Not tainted 
4.13.0-next-20170912-00003-g01cc0dd5-dirty #110
[  540.509537] Hardware name: Firefly-RK3399 Board (DT)
[  540.509977] Call trace:
[  540.510221] [<ffff20000808b3d0>] dump_backtrace+0x0/0x480
[  540.510707] [<ffff20000808b864>] show_stack+0x14/0x20
[  540.511164] [<ffff200008dfbabc>] dump_stack+0xa4/0xc8
[  540.511621] [<ffff2000081fc744>] dump_header+0xc4/0x2e8
[  540.512091] [<ffff2000081fb888>] oom_kill_process+0x3a8/0x728
[  540.512605] [<ffff2000081fc090>] out_of_memory+0x1a8/0x6d8
[  540.513099] [<ffff200008203ea8>] __alloc_pages_nodemask+0xef8/0xf80
[  540.513660] [<ffff200008275d6c>] alloc_pages_current+0x9c/0x128
[  540.514191] [<ffff200008281f60>] new_slab+0x488/0x5d8
[  540.514645] [<ffff200008284198>] ___slab_alloc+0x378/0x5d0
[  540.515138] [<ffff200008284414>] __slab_alloc.isra.23+0x24/0x38
[  540.515668] [<ffff200008284d44>] kmem_cache_alloc+0x1ec/0x218
[  540.516183] [<ffff20000830dc30>] __blockdev_direct_IO+0x220/0x4a00

> 
>> But you seem to talk about removing the bounce buffer and so finally
>> get rid of registering init_rq_fn/exit_rq_fn?
> 
> That is in direct response to Ulf's statement
> "the situations it's just too fragile" and what can be done about
> that is not make the code even more complex but make it
> simpler and easier to follow.
> 
> One way to achieve that in the long term, is to delete bounce
> buffer handling since it adds overhead and complexity.
> 
>> That is another thing,
>> and what we right now need to do is to fix the pontential memory leak.
>> It's quite a simple action, right? :)
> 
> It is another thing.
> 
> This patch fixes a memory leak, but Ulf is asking how we may
> avoid fragile behaviour.
> 
>>> I am a bit hesitant about that because Pierre Ossman said it was
>>> actually a big win on the SDHC hosts that made use of it at one
>>> point.
>>
>> You had removed packed cmd support to simplify the code, so I think
>> this is another trade-off need to ask: What you want? and keep
>> consistent with the direction you insisted on.
> 
> Packed command could be removed because it was not used by
> any in-tree code. See
> commit 03d640ae1f9b24b1d2a11f747143a1ecc0745019
> 

Ok, I was surprised that no any in-tree host enabled it, but if some
host did, the situation was similar with this one.

> Bounce buffers on the other hand, as this patch shows, is very much
> in use. So if they e.g. improve throughput on these systems
> (mainly laptops I think?) it should definately be kept around.
> 
> It might be a good idea to make a patch to remove the bounce
> buffers and ask people to do before/after throughput tests,
> because I do not have this hardware myself. If it doesn't provide
> any throughput improvements to any system in use, it should
> be deleted. But I don't know that yet.

yeap, sounds good but it's up to Ulf.

> 
> Yours,
> Linus Walleij
> 
> 
> 


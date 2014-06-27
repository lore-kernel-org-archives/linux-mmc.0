From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH V2 3/3] mmc: mmci: Reverse IRQ handling for the arm_variant
Date: Fri, 27 Jun 2014 15:53:19 -0700
Message-ID: <CALAqxLViuWehKgqHTf5SjLRXOXwzp-yNPehmYkfJGR4At63w7w@mail.gmail.com>
References: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
	<CALAqxLWs5HLhLo+BspcgyJe0O++PB1HU2G1GpsoQ=cVP34=v=A@mail.gmail.com>
	<CAPDyKFqK5G0j7ZKAYJqD+ZqBFCjuLTw=NtjBcAsfM=Xzd4cghA@mail.gmail.com>
	<CALAqxLXQeYA8jt_hLrJSuWtt7j3t2iZSZjEVAX7ScODAgrmVbA@mail.gmail.com>
	<CALAqxLX8TcFNDLvA1XozEZ_kf58jX0_SeDETfK9UcXVYajVVRQ@mail.gmail.com>
	<CAPDyKFry7_=-3kmydz7ikfDW5vMi512gC3Bj35PmuWT2z70GvQ@mail.gmail.com>
	<CAGXu5j+6Vuywpw_NrMDL0HN3N16TZvZidY0p6MfOakyqAO8TsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:36963 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbaF0WxU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jun 2014 18:53:20 -0400
Received: by mail-ve0-f172.google.com with SMTP id jz11so6018358veb.3
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jun 2014 15:53:19 -0700 (PDT)
In-Reply-To: <CAGXu5j+6Vuywpw_NrMDL0HN3N16TZvZidY0p6MfOakyqAO8TsA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jun 27, 2014 at 1:37 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jun 17, 2014 at 12:33 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 17 June 2014 01:29, John Stultz <john.stultz@linaro.org> wrote:
>>> On Mon, Jun 16, 2014 at 3:41 PM, John Stultz <john.stultz@linaro.org> wrote:
>>>> On Mon, Jun 16, 2014 at 2:20 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>> This patch based upon my latest mmc tree and the next branch. I tried
>>>>> to apply it for 3.15, and I think you will be able resolve the
>>>>> conflict - I should be quite trivial.
>>>>
>>>> No worries. I just didn't want to waste time resolving it if it was
>>>> logically dependent on some other change.
>>>>
>>>> I'll give it a shot and get back to you.
>>>
>>> So unfortunately I'm still seeing trouble..
>>>
>>> [   94.202843] EXT4-fs error (device mmcblk0p5):
>>> ext4_mb_generate_buddy:756: group 1, 2303 clusters in bitmap, 2272 in
>>> gd; block bitmap corrupt.
>>> [   94.203873] Aborting journal on device mmcblk0p5-8.
>>> [   94.206553] Kernel panic - not syncing: EXT4-fs (device mmcblk0p5):
>>> panic forced after error
>>> [   94.206553]
>>> [   94.207420] CPU: 0 PID: 1 Comm: init Not tainted
>>> 3.15.0-00002-g044f37a-dirty #589
>>> [   94.208330] [<c0011725>] (unwind_backtrace) from [<c000f3f1>]
>>> (show_stack+0x11/0x14)
>>> [   94.208835] [<c000f3f1>] (show_stack) from [<c042d599>]
>>> (dump_stack+0x59/0x7c)
>>> [   94.209288] [<c042d599>] (dump_stack) from [<c042a57f>] (panic+0x67/0x178)
>>> [   94.209724] [<c042a57f>] (panic) from [<c0135055>]
>>> (ext4_handle_error+0x69/0x74)
>>> [   94.210184] [<c0135055>] (ext4_handle_error) from [<c01358db>]
>>> (__ext4_grp_locked_error+0x6b/0x160)
>>> [   94.210747] [<c01358db>] (__ext4_grp_locked_error) from
>>> [<c0143691>] (ext4_mb_generate_buddy+0x1b1/0x29c)
>>> [   94.211392] [<c0143691>] (ext4_mb_generate_buddy) from [<c0144dfd>]
>>> (ext4_mb_init_cache+0x219/0x4e0)
>>> [   94.211959] [<c0144dfd>] (ext4_mb_init_cache) from [<c014517f>]
>>> (ext4_mb_init_group+0xbb/0x13c)
>>> [   94.213973] [<c014517f>] (ext4_mb_init_group) from [<c01452f3>]
>>> (ext4_mb_good_group+0xf3/0xfc)
>>> [   94.214873] [<c01452f3>] (ext4_mb_good_group) from [<c01462ab>]
>>> (ext4_mb_regular_allocator+0x153/0x2c4)
>>> [   94.215953] [<c01462ab>] (ext4_mb_regular_allocator) from
>>> [<c01486b1>] (ext4_mb_new_blocks+0x2fd/0x4e4)
>>> [   94.216939] [<c01486b1>] (ext4_mb_new_blocks) from [<c013fe41>]
>>> (ext4_ext_map_blocks+0x965/0x10f0)
>>> [   94.217694] [<c013fe41>] (ext4_ext_map_blocks) from [<c01230ff>]
>>> (ext4_map_blocks+0xff/0x374)
>>> [   94.219200] [<c0126839>] (mpage_map_and_submit_extent) from
>>> [<c0127049>] (ext4_writepages+0x2b9/0x4e8)
>>> [   94.219972] [<c0127049>] (ext4_writepages) from [<c0094e69>]
>>> (do_writepages+0x19/0x28)
>>> [   94.220648] [<c0094e69>] (do_writepages) from [<c008cbcd>]
>>> (__filemap_fdatawrite_range+0x3d/0x44)
>>> [   94.221391] [<c008cbcd>] (__filemap_fdatawrite_range) from
>>> [<c008cc3f>] (filemap_flush+0x23/0x28)
>>> [   94.222135] [<c008cc3f>] (filemap_flush) from [<c012c419>]
>>> (ext4_rename+0x2f9/0x3e4)
>>> [   94.222806] [<c012c419>] (ext4_rename) from [<c00c3707>]
>>> (vfs_rename+0x183/0x45c)
>>> [   94.223496] [<c00c3707>] (vfs_rename) from [<c00c3c0b>]
>>> (SyS_renameat2+0x22b/0x26c)
>>> [   94.224154] [<c00c3c0b>] (SyS_renameat2) from [<c00c3c83>]
>>> (SyS_rename+0x1f/0x24)
>>> [   94.224801] [<c00c3c83>] (SyS_rename) from [<c000cd41>]
>>> (ret_fast_syscall+0x1/0x5c)
>>>
>>>
>>> That said, this mirrors the behavior when I was reverting your change
>>> by hand on-top of 3.15. While git bisect pointed to your patch and
>>> reverting it from the commit seems to resolve the issue at that point,
>>> there seems to be some other commit in the 3.14->3.15-rc1 interval
>>> that is causing problems as well.
>>>
>>> Are there any sort of debugging options for mmc that I can use to try
>>> to better narrow down whats going wrong?
>>
>> It seems like you want to debug the mmci host driver and unfortunate
>> the debug utilities available are only dev_dbg prints. I wouldn't be
>> surprised if the problem goes away when you enable them. :-)
>>
>> I have some other locally stored debug patches for mmci, but those are
>> not re-based and I am not sure you want to deal with them as is.
>>
>> I guess I need to set up the QEMU environment and run the tests
>> myself, unless we go for the revert path.
>> How do you perform the tests, is just a simple mounting/un-mounting
>> that triggers the problem?
>> Any specific things that I need to think of when running QEMU?
>
> FWIW, I'm hitting this problem as well. For me, it is every time I try
> to boot. Only reverting to 3.14 makes it go away, and this series
> doesn't fix it for me either. :(
>
> My only difference is that I don't run with an initrd:
>
> qemu-system-arm -nographic -m 1024 -M vexpress-a15 -dtb
> rtsm_ve-cortex_a15x4.dtb -kernel ~/src/linux/arch/arm/boot/zImage
> -drive file=$HOME/image/arm/vda.qcow2,if=sd,format=qcow2 -append
> "root=/dev/mmcblk0p1 console=ttyAMA0"

I've been continuing to try to bisect this down with
8d94b54d99ea968a9d188ca0e68793ebed601220 and
e7f3d22289e4307b3071cc18b1d8ecc6598c0be4 reverted each step. It seems
like it pops up somewhere between 3.15-rc6 and 3.15-rc7, but the
bisection results are really inconsistent.  I suspect it actually
shows up earlier, its just its harder to trip the problem with the
patches reverted, so I'm marking good commits that are actually bad.

If you are seeing this on every bootup, it might be worth trying to do
the bisection with the two commits above reverted to see if you can
narrow it down any better?

thanks
-john

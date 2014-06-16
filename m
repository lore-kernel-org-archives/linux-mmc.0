From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH V2 3/3] mmc: mmci: Reverse IRQ handling for the arm_variant
Date: Mon, 16 Jun 2014 16:29:33 -0700
Message-ID: <CALAqxLX8TcFNDLvA1XozEZ_kf58jX0_SeDETfK9UcXVYajVVRQ@mail.gmail.com>
References: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
	<CALAqxLWs5HLhLo+BspcgyJe0O++PB1HU2G1GpsoQ=cVP34=v=A@mail.gmail.com>
	<CAPDyKFqK5G0j7ZKAYJqD+ZqBFCjuLTw=NtjBcAsfM=Xzd4cghA@mail.gmail.com>
	<CALAqxLXQeYA8jt_hLrJSuWtt7j3t2iZSZjEVAX7ScODAgrmVbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:39625 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbaFPX3e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 19:29:34 -0400
Received: by mail-vc0-f171.google.com with SMTP id id10so5607704vcb.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 16:29:34 -0700 (PDT)
In-Reply-To: <CALAqxLXQeYA8jt_hLrJSuWtt7j3t2iZSZjEVAX7ScODAgrmVbA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Peter Maydell <peter.maydell@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On Mon, Jun 16, 2014 at 3:41 PM, John Stultz <john.stultz@linaro.org> wrote:
> On Mon, Jun 16, 2014 at 2:20 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> This patch based upon my latest mmc tree and the next branch. I tried
>> to apply it for 3.15, and I think you will be able resolve the
>> conflict - I should be quite trivial.
>
> No worries. I just didn't want to waste time resolving it if it was
> logically dependent on some other change.
>
> I'll give it a shot and get back to you.

So unfortunately I'm still seeing trouble..

[   94.202843] EXT4-fs error (device mmcblk0p5):
ext4_mb_generate_buddy:756: group 1, 2303 clusters in bitmap, 2272 in
gd; block bitmap corrupt.
[   94.203873] Aborting journal on device mmcblk0p5-8.
[   94.206553] Kernel panic - not syncing: EXT4-fs (device mmcblk0p5):
panic forced after error
[   94.206553]
[   94.207420] CPU: 0 PID: 1 Comm: init Not tainted
3.15.0-00002-g044f37a-dirty #589
[   94.208330] [<c0011725>] (unwind_backtrace) from [<c000f3f1>]
(show_stack+0x11/0x14)
[   94.208835] [<c000f3f1>] (show_stack) from [<c042d599>]
(dump_stack+0x59/0x7c)
[   94.209288] [<c042d599>] (dump_stack) from [<c042a57f>] (panic+0x67/0x178)
[   94.209724] [<c042a57f>] (panic) from [<c0135055>]
(ext4_handle_error+0x69/0x74)
[   94.210184] [<c0135055>] (ext4_handle_error) from [<c01358db>]
(__ext4_grp_locked_error+0x6b/0x160)
[   94.210747] [<c01358db>] (__ext4_grp_locked_error) from
[<c0143691>] (ext4_mb_generate_buddy+0x1b1/0x29c)
[   94.211392] [<c0143691>] (ext4_mb_generate_buddy) from [<c0144dfd>]
(ext4_mb_init_cache+0x219/0x4e0)
[   94.211959] [<c0144dfd>] (ext4_mb_init_cache) from [<c014517f>]
(ext4_mb_init_group+0xbb/0x13c)
[   94.213973] [<c014517f>] (ext4_mb_init_group) from [<c01452f3>]
(ext4_mb_good_group+0xf3/0xfc)
[   94.214873] [<c01452f3>] (ext4_mb_good_group) from [<c01462ab>]
(ext4_mb_regular_allocator+0x153/0x2c4)
[   94.215953] [<c01462ab>] (ext4_mb_regular_allocator) from
[<c01486b1>] (ext4_mb_new_blocks+0x2fd/0x4e4)
[   94.216939] [<c01486b1>] (ext4_mb_new_blocks) from [<c013fe41>]
(ext4_ext_map_blocks+0x965/0x10f0)
[   94.217694] [<c013fe41>] (ext4_ext_map_blocks) from [<c01230ff>]
(ext4_map_blocks+0xff/0x374)
[   94.219200] [<c0126839>] (mpage_map_and_submit_extent) from
[<c0127049>] (ext4_writepages+0x2b9/0x4e8)
[   94.219972] [<c0127049>] (ext4_writepages) from [<c0094e69>]
(do_writepages+0x19/0x28)
[   94.220648] [<c0094e69>] (do_writepages) from [<c008cbcd>]
(__filemap_fdatawrite_range+0x3d/0x44)
[   94.221391] [<c008cbcd>] (__filemap_fdatawrite_range) from
[<c008cc3f>] (filemap_flush+0x23/0x28)
[   94.222135] [<c008cc3f>] (filemap_flush) from [<c012c419>]
(ext4_rename+0x2f9/0x3e4)
[   94.222806] [<c012c419>] (ext4_rename) from [<c00c3707>]
(vfs_rename+0x183/0x45c)
[   94.223496] [<c00c3707>] (vfs_rename) from [<c00c3c0b>]
(SyS_renameat2+0x22b/0x26c)
[   94.224154] [<c00c3c0b>] (SyS_renameat2) from [<c00c3c83>]
(SyS_rename+0x1f/0x24)
[   94.224801] [<c00c3c83>] (SyS_rename) from [<c000cd41>]
(ret_fast_syscall+0x1/0x5c)


That said, this mirrors the behavior when I was reverting your change
by hand on-top of 3.15. While git bisect pointed to your patch and
reverting it from the commit seems to resolve the issue at that point,
there seems to be some other commit in the 3.14->3.15-rc1 interval
that is causing problems as well.

Are there any sort of debugging options for mmc that I can use to try
to better narrow down whats going wrong?

thanks
-john

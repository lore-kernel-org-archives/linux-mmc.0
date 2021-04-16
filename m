Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F88C433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 23:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99D8610CD
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 23:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhDPXIR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbhDPXIQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Apr 2021 19:08:16 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A88C061574
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 16:07:49 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id z23so7898749uan.8
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 16:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZ5p+h2UaVJ82buRzYB0q3Q4RfZ4Miiy5/mbdrwiYGc=;
        b=RifagwrFsXYuuCR/KYHXpMUe+d2V11x3tPVwxSuXJtI+H/9qMhCJzzee6FolELXNjW
         AaBBFXxA6X26Nv5VWSh7hhsoUgQMREHSyEpHh3kmntudY31WALg/O7KgsP5KwvyxhQP/
         EW4efbfO6QUT67KHKhP7RRfEwN/wrjy+VFyrwWLike7rMr6NMotG9rnDT6vdxVuX+S7m
         IUbmuTmIVpmo23UrvMtO6KJCaFMJJnmwdDGvzzOnFYxAMhwHnNZrEN+9J5yNxR4Ogrfo
         Yb3Ik9yf6OSHhLUrLlO5SXBhXIcA8qjpLqXjiXaitkiQrUuqFWDLT1lPgAEUm5iqWxKc
         Be7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZ5p+h2UaVJ82buRzYB0q3Q4RfZ4Miiy5/mbdrwiYGc=;
        b=hpDix/xiu7B+gxC8FSBjfobJXBcZeC1GTNGksw5cnKtqASOCouwMfcwg6Ak5TE/WUT
         4sWzR288ywmZawIkfulXJ460hRYHU3Zb9SlduXSuyhLXHQ3VcR5A5642XBa8RG/Jk9vS
         W7xCR+Ml1J09IGwHAwK0n9zmMmbdu6pE/4YiwNI21zvJqqeYxT+xSirWq03xNG3IW6Zv
         L8prIg1qCZuQtRgJVqcTYN4lXKV6DB7TBHQZ5DqeynIDCHj1DqO6MCPf0+NN/0n5sToN
         7FCcCP7kOI6rWXUrR9Jmt7pek7JViZdh/tK+acBzox9H9OTvGogNPtAZOuA7ynam30wv
         CpRw==
X-Gm-Message-State: AOAM531vYk99tL+Kxz6xrKbrRf98Oo1s8euB+vWRhsUGyRDw2NU4i8mO
        oJcxjfLmPgG0TpKkT1Nf3/xuDLiWoXYBURp49vfIUg==
X-Google-Smtp-Source: ABdhPJwo4tTfahtmQ5UklnIgSHDXkaLxvh4zi0e1esSLIz02hfdW2N5a3cY5nJAgy4DcVzZHRnftnFc6y+9bfCXSAzk=
X-Received: by 2002:a9f:37c8:: with SMTP id q66mr1438886uaq.129.1618614468471;
 Fri, 16 Apr 2021 16:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210413003621.1403300-1-swboyd@chromium.org> <CAPDyKFquhnG1tGAx+GGNKM7_haThSa34FcONHGhdBwFYuryeag@mail.gmail.com>
 <161851496169.46595.399410018266490859@swboyd.mtv.corp.google.com>
 <CAPDyKFoZL6mygBQZiU329nagPJQzELPiFYjuJ0V3PfvaiJRv2w@mail.gmail.com> <161859541950.46595.6083644321477114769@swboyd.mtv.corp.google.com>
In-Reply-To: <161859541950.46595.6083644321477114769@swboyd.mtv.corp.google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Sat, 17 Apr 2021 01:07:11 +0200
Message-ID: <CAPDyKFryT63Jc7+DXWSpAC19qpZRqFr1orxwYGMuSqx247O8cQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Don't allocate IDA for OF aliases
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 16 Apr 2021 at 19:50, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Ulf Hansson (2021-04-16 00:17:10)
> > On Thu, 15 Apr 2021 at 21:29, Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > >
> > > Don't think so. The device (with the kobject inside) is removed, and
> > > thus the mmc1 device will be removed, but the kobject's release function
> > > is delayed due to the config. This means that
> > > mmc_host_classdev_release() is called at a later time. The only thing
> > > inside that function is the IDA removal and the kfree of the container
> > > object. Given that nothing else is in that release function I believe it
> > > is safe to skip IDA allocation as it won't be blocking anything in the
> > > reserved alias case.
> > >
> > > Furthermore, when the device is deleted in mmc_remove_host() there could
> > > be other users of the device that haven't called put_device() yet.
> > > Either way, those other users are keeping the device memory alive, but
> > > otherwise device_del() has unlinked it from the various driver core
> > > lists and sysfs has removed it too so it's in a state where code may be
> > > referencing it but it's on the way out so users of the device will not
> > > be able to do much with it during this time.
> >
> > Right, but see more below.
> >
> > >
> > > This sort of problem (if it exists which I don't think it does) would
> > > have been there all along and can't be fixed at this level. When a
> > > device that has an alias calls the mmc_alloc_host() function twice it
> > > gets two different device structures created so there are two distinct
> > > kobjects that will need to be released at some point. The index is
> > > usually different for those two kobjects, but with aliases it turns out
> > > it is the same. When it comes to registering that device with the same
> > > name the second one will fail because a device with that name already
> > > exists on the bus. This would be really hard to do given that it would
> > > need to be the same aliased device in DT calling the mmc_add_host()
> > > function without calling mmc_remove_host() for the first one it added in
> > > between.
> >
> > In fact, we have a few rare corner cases that can trigger KASAN splats
> > when mmc_remove_host() gets executed. Similar splats can be triggered
> > by just doing a sudden card removal. It's especially related to the
> > cases, where a thread holds a reference to the card/host object when
> > it's being removed. I am working on patches to fix these cases, but
> > haven't yet decided on the best solution.
>
> Ok. Can you share the KASAN reports? The memory allocated for this class
> object and associated index from the IDA will be unique for each call
> the mmc_alloc_host() so I don't see how KASAN could be noticing
> something unless a reference to the host is leaking out without the
> proper get_device() call being made to keep the underlying memory from
> being freed.

Removing the host, also means removing the card. Although, as I said,
I need some more time to think of the best solution.

Here's a report, triggered with some manual hacks and by using the
mmc-utils usesland tool.

/mmc status get /dev/mmcblk1
[   95.905913] DEBUG: mmc_blk_open: Let's sleep for 10s..
[   98.806639] mmc1: card 0007 removed
[  105.972139] BUG: KASAN: use-after-free in mmc_blk_get+0x58/0xb8
[  105.979144] Read of size 4 at addr ffff00000a394a28 by task mmc/180
[  105.984945]
[  105.991209] CPU: 2 PID: 180 Comm: mmc Not tainted
5.10.0-rc4-00069-gcc758c8c7127-dirty #5
[  105.992943] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[  106.001010] Call trace:
[  106.007799]  dump_backtrace+0x0/0x2b4
[  106.009965]  show_stack+0x18/0x6c
[  106.013779]  dump_stack+0xfc/0x168
[  106.017083]  print_address_description.constprop.0+0x6c/0x488
[  106.020384]  kasan_report+0x118/0x210
[  106.026193]  __asan_load4+0x94/0xd0
[  106.029844]  mmc_blk_get+0x58/0xb8
[  106.033141]  mmc_blk_open+0x7c/0xdc
[  106.036614]  __blkdev_get+0x3b4/0x964
[  106.039996]  blkdev_get+0x64/0x100
[  106.043815]  blkdev_open+0xe8/0x104
[  106.047114]  do_dentry_open+0x234/0x61c
[  106.050498]  vfs_open+0x54/0x64
[  106.054324]  path_openat+0xe04/0x1584
[  106.057450]  do_filp_open+0xe8/0x1e4
[  106.061263]  do_sys_openat2+0x120/0x230
[  106.064911]  __arm64_sys_openat+0xf0/0x15c
[  106.068477]  el0_svc_common.constprop.0+0xac/0x234
[  106.072639]  do_el0_svc+0x84/0xa0
[  106.077410]  el0_sync_handler+0x264/0x270
[  106.080790]  el0_sync+0x174/0x180
[  106.084768]
[  106.088070] Allocated by task 33:
[  106.089647]  stack_trace_save+0x9c/0xdc
[  106.092858]  kasan_save_stack+0x28/0x60
[  106.096506]  __kasan_kmalloc.constprop.0+0xc8/0xf0
[  106.100325]  kasan_kmalloc+0x10/0x20
[  106.105183]  mmc_blk_alloc_req+0x94/0x4b0
[  106.108913]  mmc_blk_probe+0x2d4/0xaa4
[  106.112829]  mmc_bus_probe+0x34/0x4c
[  106.116471]  really_probe+0x148/0x6e0
[  106.120202]  driver_probe_device+0x78/0xec
[  106.123764]  __device_attach_driver+0x108/0x16c
[  106.127754]  bus_for_each_drv+0xf4/0x15c
[  106.132180]  __device_attach+0x168/0x240
[  106.136349]  device_initial_probe+0x14/0x20
[  106.140253]  bus_probe_device+0xec/0x100
[  106.144167]  device_add+0x55c/0xaf0
[  106.148332]  mmc_add_card+0x288/0x380
[  106.151540]  mmc_attach_sd+0x18c/0x22c
[  106.155363]  mmc_rescan+0x444/0x4f0
[  106.159014]  process_one_work+0x3b8/0x650
[  106.162396]  worker_thread+0xa0/0x724
[  106.166556]  kthread+0x218/0x220
[  106.170201]  ret_from_fork+0x10/0x38
[  106.173482]
[  106.177045] Freed by task 33:
[  106.178533]  stack_trace_save+0x9c/0xdc
[  106.181399]  kasan_save_stack+0x28/0x60
[  106.185045]  kasan_set_track+0x28/0x40
[  106.188868]  kasan_set_free_info+0x24/0x4c
[  106.192684]  __kasan_slab_free+0x100/0x180
[  106.196764]  kasan_slab_free+0x14/0x20
[  106.200838]  kfree+0xb8/0x46c
[  106.204583]  mmc_blk_put+0xe4/0x11c
[  106.207624]  mmc_blk_remove_req.part.0+0x6c/0xe4
[  106.210914]  mmc_blk_remove+0x368/0x370
[  106.215778]  mmc_bus_remove+0x34/0x50
[  106.219336]  __device_release_driver+0x228/0x31c
[  106.223155]  device_release_driver+0x2c/0x44
[  106.227840]  bus_remove_device+0x1e4/0x200
[  106.232100]  device_del+0x2b0/0x770
[  106.236005]  mmc_remove_card+0xf0/0x150
[  106.239383]  mmc_sd_detect+0x9c/0x150
[  106.243207]  mmc_rescan+0x110/0x4f0
[  106.247032]  process_one_work+0x3b8/0x650
[  106.250329]  worker_thread+0xa0/0x724
[  106.254488]  kthread+0x218/0x220
[  106.258134]  ret_from_fork+0x10/0x38
[  106.261416]
[  106.264986] The buggy address belongs to the object at ffff00000a394800
[  106.264986]  which belongs to the cache kmalloc-1k of size 1024
[  106.266485] The buggy address is located 552 bytes inside of
[  106.266485]  1024-byte region [ffff00000a394800, ffff00000a394c00)
[  106.278710] The buggy address belongs to the page:
[  106.290520] page:00000000ff84ed53 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x8a390
[  106.295381] head:00000000ff84ed53 order:3 compound_mapcount:0
compound_pincount:0
[  106.304669] flags: 0x3fffc0000010200(slab|head)
[  106.312234] raw: 03fffc0000010200 dead000000000100 dead000000000122
ffff000009f03800
[  106.316571] raw: 0000000000000000 0000000000100010 00000001ffffffff
0000000000000000
[  106.324537] page dumped because: kasan: bad access detected
[  106.332254]
[  106.337543] Memory state around the buggy address:
[  106.339302]  ffff00000a394900: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  106.343907]  ffff00000a394980: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  106.351111] >ffff00000a394a00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  106.358303]                                   ^
[  106.365515]  ffff00000a394a80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  106.369948]  ffff00000a394b00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  106.377225] ==================================================================
[  106.384429] Disabling lock debugging due to kernel taint
open: No such device or address

>
> >
> > That's the reason why I was thinking that maybe returning
> > -EPROBE_DEFER could be an option, but certainly I need to think more
> > about this.
>
> I was hoping that you wouldn't need to think more about returning
> -EPROBE_DEFER after my email. :( Returning EPROBE_DEFER looks like it's
> a bandaid for bigger problems with reference counting the pointer
> allocated in mmc_alloc_host(). I hope I convinced you that there isn't
> any danger in reusing the IDA in the case of an alias because the only
> way that is a problem is if the same device calls mmc_alloc_host() twice
> without calling mmc_remove_host() in between. That should be a pretty
> obvious problem in driver code? The check to see if that same device has
> tried to alloc a host twice would still effectively happen after this
> patch because when mmc_add_host() tries to add that second device to the
> driver core it will complain about duplicate device names and fail.

You may very well be correct in you reasoning above, but I just need
to convince myself about it.

>
> Will you apply this patch?

It's likely, but allow me some more time to think about it. To make
sure we do the right thing.

Kind regards
Uffe

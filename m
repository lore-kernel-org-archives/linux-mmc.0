Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787F2C433ED
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Apr 2021 22:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAF1613FA
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Apr 2021 22:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhD3WUb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Apr 2021 18:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhD3WUa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Apr 2021 18:20:30 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A346C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 30 Apr 2021 15:19:40 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t8so1710376oij.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Apr 2021 15:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=oDUfi1mAqdAqTPRErgDIlIf3220Ov5qdnaUWhvxN8K4=;
        b=MVv9jdyq/jOUgaFKQCGIGX9JPwrKfp18Kdfb5Xjjx7qciNVbCFm99mRmHDyitTVupF
         EKQaYf3hc+Ghrh6x2PDhIwSgDlTEa4Vvg1ELBSfEkoMrYmU5CNyrmm3F0nd/qwT3X0pS
         lJPNxgP1/jf05FZ7KN97JSvNJMOG8MC1SLvPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=oDUfi1mAqdAqTPRErgDIlIf3220Ov5qdnaUWhvxN8K4=;
        b=lfMIYuTQa7SUpltjAUlwakmIeaxv9kRPC58QD1yWwEU1iUgG8f2U2rCgBSzV6FBufc
         HGbYSQxdBFWnB1Rt8H3r6GQD1zZPeZ7J78XIHDVDiFWeNw/f0F+QVTTCrbmsIwz2XlN3
         FQOE+ubV44TC9jG1+r4AH/u+VPuoKQEDnQx51htE7hMR8A80oecyOjPZMYFMAQXICD9w
         AUokPXdoRhJEg/AZvkYc+QRSisaz7PGCpu653jPKaPJKUfFovm2v/Do+fKhJPI8HNG6u
         PZSHiH2Uo8TvvYy9YXlFk2voE6TrRIDPEJG8jV9Sx76+IHlENsAsIukOyluZVd17vH9E
         TFzA==
X-Gm-Message-State: AOAM533PPn6dsmtBs8/26gC0YyktSTf6ra1bdsH0XLzgb5Ok0k01nPy7
        mwTbQ6iAo14CL0h5OfKWya9Ul4AtaU4pjWDnkWc+Uw==
X-Google-Smtp-Source: ABdhPJxahhnPuiK5wEbENVKmMmcsE4TUMDYMc1rwK1fJjfCALvC6UnO7579JPQdU7bLb1E2hbuB4rDfvPPKhjRmJRYc=
X-Received: by 2002:aca:ed12:: with SMTP id l18mr12520500oih.24.1619821180025;
 Fri, 30 Apr 2021 15:19:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Apr 2021 15:19:39 -0700
MIME-Version: 1.0
In-Reply-To: <CAPDyKFryT63Jc7+DXWSpAC19qpZRqFr1orxwYGMuSqx247O8cQ@mail.gmail.com>
References: <20210413003621.1403300-1-swboyd@chromium.org> <CAPDyKFquhnG1tGAx+GGNKM7_haThSa34FcONHGhdBwFYuryeag@mail.gmail.com>
 <161851496169.46595.399410018266490859@swboyd.mtv.corp.google.com>
 <CAPDyKFoZL6mygBQZiU329nagPJQzELPiFYjuJ0V3PfvaiJRv2w@mail.gmail.com>
 <161859541950.46595.6083644321477114769@swboyd.mtv.corp.google.com> <CAPDyKFryT63Jc7+DXWSpAC19qpZRqFr1orxwYGMuSqx247O8cQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 30 Apr 2021 15:19:39 -0700
Message-ID: <CAE-0n51LFWeHpiWGUcbpHyqhKYPZsi0N83Ho6VPbpRxJVKZAjA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Don't allocate IDA for OF aliases
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Ulf Hansson (2021-04-16 16:07:11)
> On Fri, 16 Apr 2021 at 19:50, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Ok. Can you share the KASAN reports? The memory allocated for this class
> > object and associated index from the IDA will be unique for each call
> > the mmc_alloc_host() so I don't see how KASAN could be noticing
> > something unless a reference to the host is leaking out without the
> > proper get_device() call being made to keep the underlying memory from
> > being freed.
>
> Removing the host, also means removing the card. Although, as I said,
> I need some more time to think of the best solution.
>
> Here's a report, triggered with some manual hacks and by using the
> mmc-utils usesland tool.

Thanks! I'm just getting back to this mail on a Friday afternoon!

>
> /mmc status get /dev/mmcblk1
> [   95.905913] DEBUG: mmc_blk_open: Let's sleep for 10s..
> [   98.806639] mmc1: card 0007 removed
> [  105.972139] BUG: KASAN: use-after-free in mmc_blk_get+0x58/0xb8
> [  105.979144] Read of size 4 at addr ffff00000a394a28 by task mmc/180
> [  105.984945]
> [  105.991209] CPU: 2 PID: 180 Comm: mmc Not tainted
> 5.10.0-rc4-00069-gcc758c8c7127-dirty #5
> [  105.992943] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [  106.001010] Call trace:
> [  106.007799]  dump_backtrace+0x0/0x2b4
> [  106.009965]  show_stack+0x18/0x6c
> [  106.013779]  dump_stack+0xfc/0x168
> [  106.017083]  print_address_description.constprop.0+0x6c/0x488
> [  106.020384]  kasan_report+0x118/0x210
> [  106.026193]  __asan_load4+0x94/0xd0
> [  106.029844]  mmc_blk_get+0x58/0xb8
> [  106.033141]  mmc_blk_open+0x7c/0xdc
> [  106.036614]  __blkdev_get+0x3b4/0x964
> [  106.039996]  blkdev_get+0x64/0x100
> [  106.043815]  blkdev_open+0xe8/0x104
> [  106.047114]  do_dentry_open+0x234/0x61c
> [  106.050498]  vfs_open+0x54/0x64
> [  106.054324]  path_openat+0xe04/0x1584
> [  106.057450]  do_filp_open+0xe8/0x1e4
> [  106.061263]  do_sys_openat2+0x120/0x230
> [  106.064911]  __arm64_sys_openat+0xf0/0x15c
> [  106.068477]  el0_svc_common.constprop.0+0xac/0x234
> [  106.072639]  do_el0_svc+0x84/0xa0
> [  106.077410]  el0_sync_handler+0x264/0x270
> [  106.080790]  el0_sync+0x174/0x180
> [  106.084768]
> [  106.088070] Allocated by task 33:
> [  106.089647]  stack_trace_save+0x9c/0xdc
> [  106.092858]  kasan_save_stack+0x28/0x60
> [  106.096506]  __kasan_kmalloc.constprop.0+0xc8/0xf0
> [  106.100325]  kasan_kmalloc+0x10/0x20
> [  106.105183]  mmc_blk_alloc_req+0x94/0x4b0

I see that this is a different IDA managed object, for mmc_blk_ida.
Presumably the object allocated is md?

	md = kzalloc(sizeof(struct mmc_blk_data), GFP_KERNEL);

Is that the line?

> [  106.108913]  mmc_blk_probe+0x2d4/0xaa4
> [  106.112829]  mmc_bus_probe+0x34/0x4c
> [  106.116471]  really_probe+0x148/0x6e0
> [  106.120202]  driver_probe_device+0x78/0xec
> [  106.123764]  __device_attach_driver+0x108/0x16c
> [  106.127754]  bus_for_each_drv+0xf4/0x15c
> [  106.132180]  __device_attach+0x168/0x240
> [  106.136349]  device_initial_probe+0x14/0x20
> [  106.140253]  bus_probe_device+0xec/0x100
> [  106.144167]  device_add+0x55c/0xaf0
> [  106.148332]  mmc_add_card+0x288/0x380
> [  106.151540]  mmc_attach_sd+0x18c/0x22c
> [  106.155363]  mmc_rescan+0x444/0x4f0
> [  106.159014]  process_one_work+0x3b8/0x650
> [  106.162396]  worker_thread+0xa0/0x724
> [  106.166556]  kthread+0x218/0x220
> [  106.170201]  ret_from_fork+0x10/0x38
> [  106.173482]
> [  106.177045] Freed by task 33:
> [  106.178533]  stack_trace_save+0x9c/0xdc
> [  106.181399]  kasan_save_stack+0x28/0x60
> [  106.185045]  kasan_set_track+0x28/0x40
> [  106.188868]  kasan_set_free_info+0x24/0x4c
> [  106.192684]  __kasan_slab_free+0x100/0x180
> [  106.196764]  kasan_slab_free+0x14/0x20
> [  106.200838]  kfree+0xb8/0x46c
> [  106.204583]  mmc_blk_put+0xe4/0x11c

Looking at mmc_blk_put() and mmc_blk_get() I see


	static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
	{
		...
		md = disk->private_data;
		if (md && md->usage == 0)
			md = NULL;
		...
	}

	static void mmc_blk_put(struct mmc_blk_data *md)
	{
		...
		if (md->usage == 0) {
			int devidx = mmc_get_devidx(md->disk);
			blk_put_queue(md->queue.queue);
			ida_simple_remove(&mmc_blk_ida, devidx);
			put_disk(md->disk);
			kfree(md);
		}
		...
	}

and notice that mmc_blk_get() takes a gendisk but mmc_blk_put() takes a
mmc_blk_data. That's already weird, but then I notice that 'md' comes
from disk->private_data in mmc_blk_get() and in mmc_blk_put() we kfree
'md' if usage drops to 0. The storage for md is inside
disk->private_data, according to mmc_blk_alloc_req()

	md->disk->private_data = md

so 'md' points to itself through gendisk private_data. Alright.

Either way, KASAN is telling us that 'md' got freed in mmc_blk_put() but
the gendisk is still around and valid, because it's held alive via some
kobject_get(). When we go to blkdev_open() we have that gendisk that has
private_data pointing to the freed 'md'.

This is a classic dangling pointer bug.

Given that mmc_blk_get() is checking for disk->private_data being
non-NULL, I looked to see where that is assigned to NULL, but I don't
see it. Is it ever set to NULL? We could set private_data to NULL after
freeing it, but that feels hacky. The md->usage code looks like a kref
design open-coded; probably replace that with a kref that does the code
in the if (md->usage == 0) path on the kref release function and then we
wouldn't need a mutex around these get/put APIs.

Does this patch fix it?

---8<----
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index d666e24fbe0e..c7939e8fe76f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -203,6 +203,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 		int devidx = mmc_get_devidx(md->disk);
 		blk_put_queue(md->queue.queue);
 		ida_simple_remove(&mmc_blk_ida, devidx);
+		md->disk->private_data = NULL;
 		put_disk(md->disk);
 		kfree(md);
 	}

> [  106.207624]  mmc_blk_remove_req.part.0+0x6c/0xe4
> [  106.210914]  mmc_blk_remove+0x368/0x370
> [  106.215778]  mmc_bus_remove+0x34/0x50
> [  106.219336]  __device_release_driver+0x228/0x31c
> [  106.223155]  device_release_driver+0x2c/0x44
> [  106.227840]  bus_remove_device+0x1e4/0x200
> [  106.232100]  device_del+0x2b0/0x770
> [  106.236005]  mmc_remove_card+0xf0/0x150
> [  106.239383]  mmc_sd_detect+0x9c/0x150
> [  106.243207]  mmc_rescan+0x110/0x4f0
> [  106.247032]  process_one_work+0x3b8/0x650
> [  106.250329]  worker_thread+0xa0/0x724
> [  106.254488]  kthread+0x218/0x220
> [  106.258134]  ret_from_fork+0x10/0x38
> [  106.261416]
> [  106.264986] The buggy address belongs to the object at ffff00000a394800
> [  106.264986]  which belongs to the cache kmalloc-1k of size 1024
> [  106.266485] The buggy address is located 552 bytes inside of
> [  106.266485]  1024-byte region [ffff00000a394800, ffff00000a394c00)
> [  106.278710] The buggy address belongs to the page:
> [  106.290520] page:00000000ff84ed53 refcount:1 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x8a390
> [  106.295381] head:00000000ff84ed53 order:3 compound_mapcount:0
> compound_pincount:0
> [  106.304669] flags: 0x3fffc0000010200(slab|head)
> [  106.312234] raw: 03fffc0000010200 dead000000000100 dead000000000122
> ffff000009f03800
> [  106.316571] raw: 0000000000000000 0000000000100010 00000001ffffffff
> 0000000000000000
> [  106.324537] page dumped because: kasan: bad access detected
> [  106.332254]
> [  106.337543] Memory state around the buggy address:
> [  106.339302]  ffff00000a394900: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [  106.343907]  ffff00000a394980: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [  106.351111] >ffff00000a394a00: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [  106.358303]                                   ^
> [  106.365515]  ffff00000a394a80: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [  106.369948]  ffff00000a394b00: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb

If you're interested in the kref patch it may also clean it up a bit. I
left the mutex in place, but otherwise now the refcount is an atomic
variable, so mmc_blk_put() can happen in parallel to mmc_blk_get() and
the release part can run later. This lets mmc_blk_get() start failing
earlier and returning NULL when the last user has called mmc_blk_put()
but the disk is still hanging around. No idea if this works though.

----8<----
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index d666e24fbe0e..8a300cc2c8be 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -27,6 +27,7 @@
 #include <linux/errno.h>
 #include <linux/hdreg.h>
 #include <linux/kdev_t.h>
+#include <linux/kref.h>
 #include <linux/blkdev.h>
 #include <linux/cdev.h>
 #include <linux/mutex.h>
@@ -110,7 +111,7 @@ struct mmc_blk_data {
 #define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
 #define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */

-	unsigned int	usage;
+	struct kref	kref;
 	unsigned int	read_only;
 	unsigned int	part_type;
 	unsigned int	reset_done;
@@ -180,10 +181,8 @@ static struct mmc_blk_data *mmc_blk_get(struct
gendisk *disk)

 	mutex_lock(&open_lock);
 	md = disk->private_data;
-	if (md && md->usage == 0)
+	if (md && !kref_get_unless_zero(&md->kref))
 		md = NULL;
-	if (md)
-		md->usage++;
 	mutex_unlock(&open_lock);

 	return md;
@@ -195,20 +194,26 @@ static inline int mmc_get_devidx(struct gendisk *disk)
 	return devidx;
 }

-static void mmc_blk_put(struct mmc_blk_data *md)
+static void mmc_blk_kref_release(struct kref *ref)
 {
+	struct mmc_blk_data *md = container_of(ref, struct mmc_blk_data, kref);
+	int devidx;
+
 	mutex_lock(&open_lock);
-	md->usage--;
-	if (md->usage == 0) {
-		int devidx = mmc_get_devidx(md->disk);
-		blk_put_queue(md->queue.queue);
-		ida_simple_remove(&mmc_blk_ida, devidx);
-		put_disk(md->disk);
-		kfree(md);
-	}
+	devidx = mmc_get_devidx(md->disk);
+	blk_put_queue(md->queue.queue);
+	ida_simple_remove(&mmc_blk_ida, devidx);
+	md->disk->private_data = NULL;
+	put_disk(md->disk);
+	kfree(md);
 	mutex_unlock(&open_lock);
 }

+static void mmc_blk_put(struct mmc_blk_data *md)
+{
+	kref_put(&md->kref, mmc_blk_kref_release);
+}
+
 static ssize_t power_ro_lock_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -2300,7 +2305,7 @@ static struct mmc_blk_data
*mmc_blk_alloc_req(struct mmc_card *card,

 	INIT_LIST_HEAD(&md->part);
 	INIT_LIST_HEAD(&md->rpmbs);
-	md->usage = 1;
+	kref_init(&md->kref);

 	ret = mmc_init_queue(&md->queue, card);
 	if (ret)

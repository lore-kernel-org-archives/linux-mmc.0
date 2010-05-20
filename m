From: Madhav Chauhan <madhav.imsec@gmail.com>
Subject: Re: MMC insert remove issue
Date: Thu, 20 May 2010 10:58:16 +0530
Message-ID: <AANLkTil-sGvGnfIUE05CRzEvsHrAoUQHtFg4fzlOXxMT@mail.gmail.com>
References: <AANLkTimg_VbK2uPZNCn3Il8klv22JhF7iEe-MTCA5NYe@mail.gmail.com>
	 <m3632lb61t.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38605 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab0ETF2S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2010 01:28:18 -0400
Received: by pva18 with SMTP id 18so1344080pva.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 May 2010 22:28:17 -0700 (PDT)
In-Reply-To: <m3632lb61t.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Tue, May 18, 2010 at 8:39 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> =A0 > In one ARM based boards I am facing soft lock up issue while
> =A0 > inserting/removing MMC/SD card continuously having 2K files. =A0=
Can
> =A0 > someone point me where should i look whether host controller
> =A0 > driver or MMC block layer/Kernel block layer??
>
> Could be any of the above, but perhaps most likely your host
> controller driver -- which one are you using? =A0Can you perform
> alt-sysrq-t when the lockup happens, or get a kgdb backtrace?
>
I am using Samsung Host controller and below is the complete
backtrace.Also in card detect interrupt handller we are using tasklet
which finally calls mmc_scan() i.e. workfunction having 200 ms
delay,but while debugging the issue we found that mmc_rescan() is
called very late and in the mean time kernel blk/mmc blk layer keep on
requesting (using mmc_request(), mmc_queue_thread()) to Host
controller eventhough SD card is removed.

[  110.181670] Backtrace:
[  110.184099] [<c0139b64>] (__bug+0x0/0x2c) from [<c0294580>]
(elv_rb_del+0x34/0x54)
[  110.191645] [<c029454c>] (elv_rb_del+0x0/0x54) from [<c02a0a98>]
(cfq_remove_request+0x104/0x1bc)
[  110.200492]  r5:dac34058 r4:df7ff360
[  110.204047] [<c02a0994>] (cfq_remove_request+0x0/0x1bc) from
[<c02a0b78>] (cfq_dispatch_insert+0x28/0x58)
[  110.213588] [<c02a0b50>] (cfq_dispatch_insert+0x0/0x58) from
[<c02a0bf8>] (cfq_add_rq_rb+0x50/0xd4)
[  110.222608]  r7:dac34074 r6:df7ff360 r5:c4596100 r4:dac34058
[  110.228245] [<c02a0ba8>] (cfq_add_rq_rb+0x0/0xd4) from [<c02a0cb4>]
(cfq_insert_request+0x38/0x360)
[  110.237266]  r7:df7ff360 r6:dac34058 r5:c33b4a40 r4:df7ff360
[  110.242903] [<c02a0c7c>] (cfq_insert_request+0x0/0x360) from
[<c02942cc>] (elv_insert+0x15c/0x244)
[  110.251836] [<c0294170>] (elv_insert+0x0/0x244) from [<c0294470>]
(__elv_add_request+0xbc/0xc0)
[  110.260510]  r7:00000010 r6:00000003 r5:df7ff360 r4:c33b4a40
[  110.266147] [<c02943b4>] (__elv_add_request+0x0/0xc0) from
[<c0296c50>] (__make_request+0x3cc/0x438)
[  110.275254]  r6:df7ff360 r5:00000000 r4:c33b4a40 r3:00000000
[  110.280891] [<c0296884>] (__make_request+0x0/0x438) from
[<c02956e0>] (generic_make_request+0x334/0x39c)
[  110.290345] [<c02953ac>] (generic_make_request+0x0/0x39c) from
[<c029580c>] (submit_bio+0xc4/0xe0)
[  110.299279] [<c0295748>] (submit_bio+0x0/0xe0) from [<c01ebaac>]
(mpage_bio_submit+0x24/0x34)
[  110.307779]  r8:00000004 r7:c3615880 r6:df043d68 r5:00000004 r4:d00b=
5e20
[  110.314457] [<c01eba88>] (mpage_bio_submit+0x0/0x34) from
[<c01ec83c>] (mpage_readpages+0x104/0x11c)
[  110.323564] [<c01ec738>] (mpage_readpages+0x0/0x11c) from
[<bf002d04>] (LxReadPages+0x20/0x28 [rfs_glue])
[  110.333104] [<bf002ce4>] (LxReadPages+0x0/0x28 [rfs_glue]) from
[<c01a1774>] (__do_page_cache_readahead+0x13c/0x1f0)
[  110.343599] [<c01a1638>] (__do_page_cache_readahead+0x0/0x1f0) from
[<c01a1894>] (do_page_cache_readahead+0x6c/0x74)
[  110.354093] [<c01a1828>] (do_page_cache_readahead+0x0/0x74) from
[<c0199eec>] (filemap_fault+0x154/0x364)
[  110.363634]  r7:c3c32964 r6:df043e30 r5:dafb9f00 r4:00000000
[  110.369271] [<c0199d98>] (filemap_fault+0x0/0x364) from
[<c01ac3a4>] (__do_fault+0x54/0x418)
[  110.377684] [<c01ac350>] (__do_fault+0x0/0x418) from [<c01ad7c8>]
(handle_mm_fault+0x28c/0x630)
[  110.386357] [<c01ad53c>] (handle_mm_fault+0x0/0x630) from
[<c013d95c>] (do_page_fault+0xf8/0x1e8)
[  110.395204] [<c013d864>] (do_page_fault+0x0/0x1e8) from
[<c01352c4>] (do_DataAbort+0x3c/0xa0)
[  110.403704] [<c0135288>] (do_DataAbort+0x0/0xa0) from [<c0135ee4>]
(ret_from_exception+0x0/0x10)
[  110.412464] Exception stack(0xdf043fb0 to 0xdf043ff8)
[  110.417494] 3fa0:                                     4230b820
00000000 4230bd24 00000000
[  110.425733] 3fc0: 00000484 00000000 4230b820 4230b820 bec17f30
4230bd24 bec17f48 bec18094
[  110.433972] 3fe0: 4230b8a0 bec17efc 410067cc 410184cc 20000010
ffffffff
[  110.442213]  r7:4230b820 r6:4230b820 r5:00000000 r4:ffffffff
[  110.447850] Code: e1a01000 e59f000c eb0d15c5 e3a03000 (e5833000)
[  110.574108] ---[ end trace 2082a2012f359128 ]---
tid[  118.038802] BUG: spinlock lockup on CPU#0, mmcqd/1284, c42e7200
[  118.043248] [<c047f164>] (dump_stack+0x0/0x14) from [<c02adf30>]
(_raw_spin_lock+0x12c/0x16c)
[  118.051745] [<c02ade04>] (_raw_spin_lock+0x0/0x16c) from
[<c0481c24>] (_spin_lock_irq+0x14/0x18)
[  118.060505]  r8:c33b4b7c r7:c33b4a40 r6:c42e721c r5:c42e7214 r4:c459=
4000
[  118.067182] [<c0481c10>] (_spin_lock_irq+0x0/0x18) from
[<c0370504>] (mmc_queue_thread+0x48/0xe8)
[  118.076029] [<c03704bc>] (mmc_queue_thread+0x0/0xe8) from
[<c016ef04>] (kthread+0x54/0x80)
[  118.084269] [<c016eeb0>] (kthread+0x0/0x80) from [<c015d9a8>]
(do_exit+0x0/0x640)
[  118.091728]  r5:00000000 r4:00000000
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org>
> One Laptop Per Child
>

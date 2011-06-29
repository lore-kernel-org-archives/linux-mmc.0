From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 14:07:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106291304350.2874@utopia.booyaka.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com> <1308752314-32079-3-git-send-email-balajitk@ti.com> <alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com> <BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com> <alpine.DEB.2.00.1106281240390.2874@utopia.booyaka.com>
 <BANLkTikni_xO7NQXQyv7XVeEH4Nowpr1Ow@mail.gmail.com> <alpine.DEB.2.00.1106290937350.2874@utopia.booyaka.com> <BANLkTikE_CV7+oQdtzxJYirZy4JnJcQVsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46256 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab1F2UHr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2011 16:07:47 -0400
In-Reply-To: <BANLkTikE_CV7+oQdtzxJYirZy4JnJcQVsQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, cjb <cjb@laptop.org>, tony <tony@atomide.com>, "madhu.cr" <madhu.cr@ti.com>, khilman <khilman@ti.com>, b-cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

cc'ing lakml

Hi Venkat, Balaji,

On Wed, 29 Jun 2011, S, Venkatraman wrote:

> On Wed, Jun 29, 2011 at 9:08 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Wed, 29 Jun 2011, T Krishnamoorthy, Balaji wrote:
> >
> >> There have been some experiments on our customer programs to reduce this
> >> value to a few ms and infrequent crashes were observed (stress testing
> >> for several hours) while trying to access the controller registers.
> >
> > By the way, could you send along a copy of the stress test script?
> >
> 
> Paul, these scenarios are not scripted but end user tests with
> additional devices
> (WLAN, which is connected on the same controller) and executed 'on field' .

OK, thanks Venkat.  Do you still have one of these devices so the test can 
be repeated?

> One such log is here .. http://pastebin.com/nq3cfZnT

Looks like this is an Android 2.6.35.7-derived kernel on a 4430 ES2.2 EMU.  
Power management is enabled but MPU, L3INIT, and PER aren't entering any 
deeper power states than retention idle, so no context save/restore or 
off-mode worries here.

The system looks like it's entered suspend at least once and resumed, 
before the oops.  Also the second CPU is starting up and shutting down 
dynamically.  Backtrace is copied below for the archives.

Does the above summary match your understanding?

...

Reviewing this backtrace and the one that Balaji sent, it looks to 
me like this write in omap_hsmmc_prepare_data() is the proximate 
cause of the abort:

	OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
					| (req->data->blocks << 16));

I'll bet this was first access to the MMC IP block after the MMC layer 
re-enabled it.  The abort is imprecise because the Linux OMAP4 kernel 
marks MMIO registers as bufferable, so the ARM can continue executing 
while a register write is making its way across the OMAP interconnect(s).  
This guess also assumes that the ARM is executing instructions out of 
order, which is a reasonable assumption on a Cortex-A9.  This could be 
confirmed by reading some HSMMC register right before the 
OMAP_HSMMC_WRITE(); then the abort would turn precise and occur on the 
read.

Anyway, it looks like the HSMMC IP block wasn't yet ready to be accessed.  
Probably, this is because either the HSMMC IP block hasn't yet left the 
Idle or SleepTrans states, and the OMAP4 clock framework doesn't wait for 
that; or the PRCM is getting confused because the correct clockdomain 
enable sequence isn't being followed -- see for example the "Fix 
module-mode enable sequence on OMAP4" patch series that have been posted 
to the linux-omap mailing list.  Probably one of those two issues is the 
root cause.

If you have a testing setup where you can reproduce this problem, I'd 
suggest adding the read as described above.  Otherwise, I don't think this 
will be an issue for the runtime PM conversion: first, because the hwmod 
code will wait for the HSMMC block to indicate that it has left idle 
before continuing; and second, because we'll hopefully have a patch series 
going in at the same time to make sure the clockdomain enable sequence is 
correct.


- Paul


<0> Process mmcqd (pid: 851, stack limit = 0xef9682f8)
<0> Stack: (0xef969db8 to 0xef96a000)
<0> 9da0:                                                       ef969ee4 efa30640
<0> 9dc0: ef969e78 00000000 00000001 efa30400 ef969e2c ef969de0 c06ae2b8 c06ace10
<0> 9de0: 00000000 efa305d8 ef969e04 efa30400 00000000 efa30578 ef969e44 ef969e08
<0> 9e00: c054ea5c ef969e78 efa30400 ef969e34 00000001 ef837e4c 00000000 ef969ee4
<0> 9e20: ef969e64 ef969e30 c06a54d8 c06adff4 00000000 00000000 00000000 00000000
<0> 9e40: ef969e40 ef969e40 ed3d4680 ed3d4680 efa30c00 ef837e40 ef969f94 ef969e68
<0> 9e60: c06abe80 c06a53cc 00000000 efa31458 ef0cfdb4 ef0cfdb4 ef969e8c ef969ee4
<0> 9e80: ef969eb8 ef969e34 c06a55d0 00000019 00fd50a2 00000000 00000000 00000000
<0> 9ea0: 00000000 000000b5 00000000 00000000 ef969ee4 ef969e78 0000000c 00000000
<0> 9ec0: 00000000 00000000 00000000 00000000 0000049d 00000000 00000000 00000000
<0> 9ee0: ef969e78 23c34600 00000fa0 00000200 00000400 00000000 00000100 00000000
<0> 9f00: ef969eb8 ef969e78 0000003f ef238000 ef969f54 ef969f20 c0556c00 c0555fac
<0> 9f20: ef969f3c 00000001 c0425fa0 ef837e4c ef230000 ef837e54 ef837e4c ef230000
<0> 9f40: ef837e54 ef230000 ef969f7c ef969f58 00000000 ed3d4680 ef969f7c ef969f68
<0> 9f60: c054911c c054ee7c 01082e21 ef837e4c ef968000 ef837e54 ef230000 ef2301d8
<0> 9f80: 00000000 ed3d4680 ef969fbc ef969f98 c06acab8 c06abccc ef985d68 ef969fc4
<0> 9fa0: c06ac9c4 ef837e4c 00000000 00000000 ef969ff4 ef969fc0 c041fd20 c06ac9d0
<0> 9fc0: 00000000 00000000 00000000 00000000 ef969fd0 ef969fd0 ef985d68 c041fc9c
<0> 9fe0: c040d67c 00000013 00000000 ef969ff8 c040d67c c041fca8 00000000 00000000
<4> Backtrace:
<4> [<c06ace04>] (set_data_timeout+0x0/0xcc) from [<c06ae2b8>] (omap_hsmmc_request+0x2d0/0x5c8)
<4>  r8:efa30400 r7:00000001 r6:00000000 r5:ef969e78 r4:efa30640
<4> r3:ef969ee4
<4> [<c06adfe8>] (omap_hsmmc_request+0x0/0x5c8) from [<c06a54d8>] (mmc_wait_for_req+0x118/0x130)
<4> [<c06a53c0>] (mmc_wait_for_req+0x0/0x130) from [<c06abe80>] (mmc_blk_issue_rq+0x1c0/0x500)
<4>  r6:ef837e40 r5:efa30c00 r4:ed3d4680
<4> [<c06abcc0>] (mmc_blk_issue_rq+0x0/0x500) from [<c06acab8>] (mmc_queue_thread+0xf4/0xf8)
<4> [<c06ac9c4>] (mmc_queue_thread+0x0/0xf8) from [<c041fd20>] (kthread+0x84/0x8c)
<4> [<c041fc9c>] (kthread+0x0/0x8c) from [<c040d67c>] (do_exit+0x0/0x604)
<4>  r7:00000013 r6:c040d67c r5:c041fc9c r4:ef985d68
<0> Code: 11a0c423 11c0c0b0 e1a0f00e e2512001 (01a0f00e)
<4> ---[ end trace d27fcce5bd5b71d6 ]---



From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Mon, 19 Sep 2016 13:48:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609191340320.1458-100000@iolanthe.rowland.org>
References: <CAPDyKFr1EAUd0E-VQh_Y3ptCNM4WymvqsyQ8Ev756Wrb+93V6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37512 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1750867AbcISRsW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2016 13:48:22 -0400
In-Reply-To: <CAPDyKFr1EAUd0E-VQh_Y3ptCNM4WymvqsyQ8Ev756Wrb+93V6g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Alex Dubov <oakad@yahoo.com>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Mon, 19 Sep 2016, Ulf Hansson wrote:

> On 18 September 2016 at 03:42, Alan Stern <stern@rowland.harvard.edu> wrote:

> > Well, this is pretty clear:
> >
> > Sep 17 15:55:52 learner kernel: CPU: 1 PID: 535 Comm: rtsx_usb_ms_1 Tainted: G     U          4.8.0-rc6ulf1alan1+ #19
> > Sep 17 15:55:52 learner kernel: Hardware name: LENOVO 20344/INVALID, BIOS 96CN31WW(V1.17) 07/21/2015
> > Sep 17 15:55:52 learner kernel:  0000000000000000 ffffffff81314be5 ffff8802476746c0 0000000002400000
> > Sep 17 15:55:52 learner kernel:  ffffffffa016f719 00000000523bec00 ffff88025f255780 ffff88024feff600
> > Sep 17 15:55:52 learner kernel:  0000000000018080 0000000000000000 ffff88025f258080 ffffffff815a0e60
> > Sep 17 15:55:52 learner kernel: Call Trace:
> > Sep 17 15:55:52 learner kernel:  [<ffffffff81314be5>] ? dump_stack+0x7d/0xb8
> > Sep 17 15:55:52 learner kernel:  [<ffffffffa016f719>] ? usb_hcd_submit_urb+0x3c9/0xad0 [usbcore]
> > Sep 17 15:55:52 learner kernel:  [<ffffffff815a0e60>] ? _raw_spin_lock_irqsave+0x20/0x47
> > Sep 17 15:55:52 learner kernel:  [<ffffffff810d5c8b>] ? lock_timer_base.isra.24+0x7b/0xa0
> > Sep 17 15:55:52 learner kernel:  [<ffffffff810d5d59>] ? try_to_del_timer_sync+0x49/0x60
> > Sep 17 15:55:52 learner kernel:  [<ffffffffa017180d>] ? usb_start_wait_urb+0x5d/0x140 [usbcore]
> > Sep 17 15:55:52 learner kernel:  [<ffffffffa00ee2be>] ? rtsx_usb_send_cmd+0x5e/0x80 [rtsx_usb]
> > Sep 17 15:55:52 learner kernel:  [<ffffffffa00ee4a7>] ? rtsx_usb_read_register+0x67/0xb0 [rtsx_usb]
> > Sep 17 15:55:52 learner kernel:  [<ffffffffa0b15ac1>] ? rtsx_usb_detect_ms_card+0x61/0xe0 [rtsx_usb_ms]
> > Sep 17 15:55:52 learner kernel:  [<ffffffffa0b15a60>] ? rtsx_usb_ms_set_param+0x770/0x770 [rtsx_usb_ms]
> > Sep 17 15:55:52 learner kernel:  [<ffffffff8108ee0d>] ? kthread+0xbd/0xe0
> > Sep 17 15:55:52 learner kernel:  [<ffffffff81024741>] ? __switch_to+0x2b1/0x6a0
> > Sep 17 15:55:52 learner kernel:  [<ffffffff815a118f>] ? ret_from_fork+0x1f/0x40
> > Sep 17 15:55:52 learner kernel:  [<ffffffff8108ed50>] ? kthread_create_on_node+0x180/0x180
> >
> > This is the rtsx_usb_detect_ms_card() routine in
> > drivers/memstick/host/rtsx_usb_ms.c, which runs as a kthread.  It
> > doesn't do any runtime PM.  So it looks like the bug is present in both
> > the MMC and MemoryStick interfaces.
> 
> I think the problem is even worse in the MemoryStick case, as the
> memstick core doesn't help with runtime PM. I am pretty sure there are
> other cases when the MemoryStick driver accesses the usb device
> without first runtime resuming it.

Maybe we should get a MemoryStick maintainer involved in this thread.  
I CC'ed Alex Dubov.

Alex, the problem here is that drivers/memstick/host/rtsx_usb_ms.c
tries to communicate with the host USB device while it is runtime
suspended.

> Of course we could start simple an fix the bug observed above and see
> if that solves the reported problem. Alan, do you want to post to
> patch or you want me?

This ought to help.  Ritesh, please apply this patch on top of the 
two earlier ones and let's see what happens.

Alan Stern



Index: usb-4.x/drivers/memstick/host/rtsx_usb_ms.c
===================================================================
--- usb-4.x.orig/drivers/memstick/host/rtsx_usb_ms.c
+++ usb-4.x/drivers/memstick/host/rtsx_usb_ms.c
@@ -681,6 +681,7 @@ static int rtsx_usb_detect_ms_card(void
 	int err;
 
 	for (;;) {
+		pm_runtime_get_sync(ms_dev(host));
 		mutex_lock(&ucr->dev_mutex);
 
 		/* Check pending MS card changes */
@@ -703,6 +704,7 @@ static int rtsx_usb_detect_ms_card(void
 		}
 
 poll_again:
+		pm_runtime_put(ms_dev(host));
 		if (host->eject)
 			break;
 


From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device loss]
Date: Mon, 19 Sep 2016 12:10:55 +0200
Message-ID: <CAPDyKFr1EAUd0E-VQh_Y3ptCNM4WymvqsyQ8Ev756Wrb+93V6g@mail.gmail.com>
References: <1474112525.11383.3.camel@researchut.com> <Pine.LNX.4.44L0.1609172131120.698-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1609172131120.698-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 18 September 2016 at 03:42, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> On Sat, 17 Sep 2016, Ritesh Raj Sarraf wrote:
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>>
>> Hello Alan,
>>
>>
>> On Fri, 2016-09-16 at 17:40 -0400, Alan Stern wrote:
>> > We're still getting runtime suspends, but now at 2-second intervals.
>> > This is partly because the driver isn't calling
>> > pm_runtime_mark_last_busy(), but there may be more to it.  The 2-second
>> > period is the default autosuspend timeout for USB devices.  However, I
>> > don't see the activity that rtsx_usb_get_card_status() should produce
>> > when rtsx_usb_suspend() runs; I don't know why not.
>> >
>> > We're also getting occasional I/O attempts while the device is
>> > suspended.  They must be on some other pathway, not the one fixed by
>> > the patch above.  Let's see if we can find out just where they come
>> > from.
>> >
>> > Ritesh, please try applying this patch on top of the previous one.  It
>> > will produce output in the kernel log whenever these bad I/O attempts
>> > occur.  Also, enable dynamic debugging for the rtsx_usb driver:
>> >
>>
>> Please find links to the usbmon trace and the kernel trace.
>>
>> https://people.debian.org/~rrs/tmp/4.8.0-rc6ulf1alan1+.kern.log
>> https://people.debian.org/~rrs/tmp/usb-4.8.0-rc6ulf1alan1+.log.gz
>
> Well, this is pretty clear:
>
> Sep 17 15:55:52 learner kernel: CPU: 1 PID: 535 Comm: rtsx_usb_ms_1 Tainted: G     U          4.8.0-rc6ulf1alan1+ #19
> Sep 17 15:55:52 learner kernel: Hardware name: LENOVO 20344/INVALID, BIOS 96CN31WW(V1.17) 07/21/2015
> Sep 17 15:55:52 learner kernel:  0000000000000000 ffffffff81314be5 ffff8802476746c0 0000000002400000
> Sep 17 15:55:52 learner kernel:  ffffffffa016f719 00000000523bec00 ffff88025f255780 ffff88024feff600
> Sep 17 15:55:52 learner kernel:  0000000000018080 0000000000000000 ffff88025f258080 ffffffff815a0e60
> Sep 17 15:55:52 learner kernel: Call Trace:
> Sep 17 15:55:52 learner kernel:  [<ffffffff81314be5>] ? dump_stack+0x7d/0xb8
> Sep 17 15:55:52 learner kernel:  [<ffffffffa016f719>] ? usb_hcd_submit_urb+0x3c9/0xad0 [usbcore]
> Sep 17 15:55:52 learner kernel:  [<ffffffff815a0e60>] ? _raw_spin_lock_irqsave+0x20/0x47
> Sep 17 15:55:52 learner kernel:  [<ffffffff810d5c8b>] ? lock_timer_base.isra.24+0x7b/0xa0
> Sep 17 15:55:52 learner kernel:  [<ffffffff810d5d59>] ? try_to_del_timer_sync+0x49/0x60
> Sep 17 15:55:52 learner kernel:  [<ffffffffa017180d>] ? usb_start_wait_urb+0x5d/0x140 [usbcore]
> Sep 17 15:55:52 learner kernel:  [<ffffffffa00ee2be>] ? rtsx_usb_send_cmd+0x5e/0x80 [rtsx_usb]
> Sep 17 15:55:52 learner kernel:  [<ffffffffa00ee4a7>] ? rtsx_usb_read_register+0x67/0xb0 [rtsx_usb]
> Sep 17 15:55:52 learner kernel:  [<ffffffffa0b15ac1>] ? rtsx_usb_detect_ms_card+0x61/0xe0 [rtsx_usb_ms]
> Sep 17 15:55:52 learner kernel:  [<ffffffffa0b15a60>] ? rtsx_usb_ms_set_param+0x770/0x770 [rtsx_usb_ms]
> Sep 17 15:55:52 learner kernel:  [<ffffffff8108ee0d>] ? kthread+0xbd/0xe0
> Sep 17 15:55:52 learner kernel:  [<ffffffff81024741>] ? __switch_to+0x2b1/0x6a0
> Sep 17 15:55:52 learner kernel:  [<ffffffff815a118f>] ? ret_from_fork+0x1f/0x40
> Sep 17 15:55:52 learner kernel:  [<ffffffff8108ed50>] ? kthread_create_on_node+0x180/0x180
>
> This is the rtsx_usb_detect_ms_card() routine in
> drivers/memstick/host/rtsx_usb_ms.c, which runs as a kthread.  It
> doesn't do any runtime PM.  So it looks like the bug is present in both
> the MMC and MemoryStick interfaces.

I think the problem is even worse in the MemoryStick case, as the
memstick core doesn't help with runtime PM. I am pretty sure there are
other cases when the MemoryStick driver accesses the usb device
without first runtime resuming it.

Of course we could start simple an fix the bug observed above and see
if that solves the reported problem. Alan, do you want to post to
patch or you want me?

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

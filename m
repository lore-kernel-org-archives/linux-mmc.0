From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device loss]
Date: Wed, 21 Sep 2016 13:17:46 +0200
Message-ID: <CAPDyKFrWHaPhubTsPjd7GpZcoQnGM9u1YEiy=iGpb1Qa2rJqPA@mail.gmail.com>
References: <Pine.LNX.4.44L0.1609201012290.1459-100000@iolanthe.rowland.org> <1474456212.8192.2.camel@researchut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474456212.8192.2.camel-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Alex Dubov <oakad-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 21 September 2016 at 13:10, Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> Hi Alan,
>
> On Tue, 2016-09-20 at 10:16 -0400, Alan Stern wrote:
>> This is a lot better.  No more I/O errors.
>>
>> We still have irregular suspends and resumes, but that's to be
>> expected.  More worrying are the spontaneous disconnects.  They don't
>> seem to be related to the suspend/resume activity.
>>
>> You can disable suspend for this device entirely by doing:
>>
>>         echo on >/sys/bus/usb/devices/2-4/power/control
>>
>> I'm afraid that this won't prevent the device from disconnecting
>> itself, though.  This appears to be some sort of hardware bug that
>> can't be fixed in software.
>
> I'm not sure what you were referring to when you said "No more I/O errors".
> But I still got these errors today, with all patches applied.
>
> Sep 21 14:58:11 learner kernel: usb 2-4: new high-speed USB device number 98
> using xhci_hcd
> Sep 21 14:58:18 learner kernel: usb 2-4: new high-speed USB device number 102
> using xhci_hcd
> Sep 21 14:58:24 learner kernel: usb 2-4: new high-speed USB device number 106
> using xhci_hcd
> Sep 21 14:58:31 learner kernel: usb 2-4: new high-speed USB device number 114
> using xhci_hcd
> Sep 21 14:58:41 learner kernel: usb 2-4: new high-speed USB device number 12
> using xhci_hcd
> Sep 21 14:58:41 learner kernel: usb 2-4: device descriptor read/64, error -71
> Sep 21 14:58:41 learner kernel: usb 2-4: device descriptor read/64, error -71
> Sep 21 14:58:41 learner kernel: usb 2-4: new high-speed USB device number 13
> using xhci_hcd
> Sep 21 14:58:41 learner kernel: usb 2-4: device descriptor read/64, error -71
> Sep 21 14:58:41 learner kernel: usb 2-4: device descriptor read/64, error -71
> Sep 21 14:58:42 learner kernel: usb 2-4: new high-speed USB device number 14
> using xhci_hcd
> Sep 21 14:58:42 learner kernel: usb 2-4: Device not responding to setup address.
> Sep 21 14:58:42 learner kernel: usb 2-4: Device not responding to setup address.
> Sep 21 14:58:42 learner kernel: usb 2-4: device not accepting address 14, error
> - -71
> Sep 21 14:58:42 learner kernel: usb 2-4: new high-speed USB device number 15
> using xhci_hcd
> Sep 21 14:58:42 learner kernel: usb 2-4: Device not responding to setup address.
> Sep 21 14:58:42 learner kernel: usb 2-4: Device not responding to setup address.
> Sep 21 14:58:43 learner kernel: usb 2-4: device not accepting address 15, error
> - -71
> Sep 21 14:58:43 learner kernel: usb usb2-port4: unable to enumerate USB device
> Sep 21 16:19:39 learner kernel: ahci 0000:00:1f.2: port does not support device
> sleep
> Sep 21 16:19:39 learner kernel: NMI watchdog: enabled on all CPUs, permanently
> consumes one hw-
> Sep 21 16:19:39 learner kernel: EXT4-fs (dm-0): re-mounted. Opts:
> errors=remount-ro,data=ordere
> Sep 21 16:19:39 learner kernel: EXT4-fs (sda6): re-mounted. Opts:
> data=ordered,commit=0
> Sep 21 16:19:39 learner kernel: EXT4-fs (dm-3): re-mounted. Opts:
> errors=remount-ro,data=writeb
> Sep 21 16:19:39 learner kernel: usb 2-4: new high-speed USB device number 16
> using xhci_hcd
> Sep 21 16:19:39 learner kernel: usb 2-4: device descriptor read/64, error -71
> Sep 21 16:19:40 learner kernel: usb 2-4: device descriptor read/64, error -71
> Sep 21 16:19:40 learner kernel: usb 2-4: new high-speed USB device number 17
> using xhci_hcd
> Sep 21 16:19:40 learner kernel: usb 2-4: device descriptor read/64, error -71
> Sep 21 16:19:40 learner kernel: usb 2-4: device descriptor read/64, error -71
> Sep 21 16:19:40 learner kernel: usb 2-4: new high-speed USB device number 18
> using xhci_hcd
> Sep 21 16:19:40 learner kernel: usb 2-4: Device not responding to setup address.
> Sep 21 16:19:41 learner kernel: usb 2-4: Device not responding to setup address.
> Sep 21 16:19:41 learner kernel: usb 2-4: device not accepting address 18, error
> - -71
> Sep 21 16:19:41 learner kernel: usb 2-4: new high-speed USB device number 19
> using xhci_hcd
>

I am pretty sure the memstick driver causes additional access to the
usb device without first calling pm_runtime_get_sync(). To eliminate
those cases from causing the issues, could you try disable the
memstick driver all-together?

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

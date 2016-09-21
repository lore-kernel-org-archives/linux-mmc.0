From: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Wed, 21 Sep 2016 16:40:12 +0530
Message-ID: <1474456212.8192.2.camel@researchut.com>
References: <Pine.LNX.4.44L0.1609201012290.1459-100000@iolanthe.rowland.org>
Reply-To: rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1609201012290.1459-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alex Dubov <oakad-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Alan,

On Tue, 2016-09-20 at 10:16 -0400, Alan Stern wrote:
> This is a lot better.  No more I/O errors.
> 
> We still have irregular suspends and resumes, but that's to be 
> expected.  More worrying are the spontaneous disconnects.  They don't 
> seem to be related to the suspend/resume activity.
> 
> You can disable suspend for this device entirely by doing:
> 
>         echo on >/sys/bus/usb/devices/2-4/power/control
> 
> I'm afraid that this won't prevent the device from disconnecting
> itself, though.  This appears to be some sort of hardware bug that
> can't be fixed in software.

I'm not sure what you were referring to when you said "No more I/O errors".
But I still got these errors today, with all patches applied.

Sep 21 14:58:11 learner kernel: usb 2-4: new high-speed USB device number 98
using xhci_hcd
Sep 21 14:58:18 learner kernel: usb 2-4: new high-speed USB device number 102
using xhci_hcd
Sep 21 14:58:24 learner kernel: usb 2-4: new high-speed USB device number 106
using xhci_hcd
Sep 21 14:58:31 learner kernel: usb 2-4: new high-speed USB device number 114
using xhci_hcd
Sep 21 14:58:41 learner kernel: usb 2-4: new high-speed USB device number 12
using xhci_hcd
Sep 21 14:58:41 learner kernel: usb 2-4: device descriptor read/64, error -71
Sep 21 14:58:41 learner kernel: usb 2-4: device descriptor read/64, error -71
Sep 21 14:58:41 learner kernel: usb 2-4: new high-speed USB device number 13
using xhci_hcd
Sep 21 14:58:41 learner kernel: usb 2-4: device descriptor read/64, error -71
Sep 21 14:58:41 learner kernel: usb 2-4: device descriptor read/64, error -71
Sep 21 14:58:42 learner kernel: usb 2-4: new high-speed USB device number 14
using xhci_hcd
Sep 21 14:58:42 learner kernel: usb 2-4: Device not responding to setup address.
Sep 21 14:58:42 learner kernel: usb 2-4: Device not responding to setup address.
Sep 21 14:58:42 learner kernel: usb 2-4: device not accepting address 14, error
- -71
Sep 21 14:58:42 learner kernel: usb 2-4: new high-speed USB device number 15
using xhci_hcd
Sep 21 14:58:42 learner kernel: usb 2-4: Device not responding to setup address.
Sep 21 14:58:42 learner kernel: usb 2-4: Device not responding to setup address.
Sep 21 14:58:43 learner kernel: usb 2-4: device not accepting address 15, error
- -71
Sep 21 14:58:43 learner kernel: usb usb2-port4: unable to enumerate USB device
Sep 21 16:19:39 learner kernel: ahci 0000:00:1f.2: port does not support device
sleep
Sep 21 16:19:39 learner kernel: NMI watchdog: enabled on all CPUs, permanently
consumes one hw-
Sep 21 16:19:39 learner kernel: EXT4-fs (dm-0): re-mounted. Opts:
errors=remount-ro,data=ordere
Sep 21 16:19:39 learner kernel: EXT4-fs (sda6): re-mounted. Opts:
data=ordered,commit=0
Sep 21 16:19:39 learner kernel: EXT4-fs (dm-3): re-mounted. Opts:
errors=remount-ro,data=writeb
Sep 21 16:19:39 learner kernel: usb 2-4: new high-speed USB device number 16
using xhci_hcd
Sep 21 16:19:39 learner kernel: usb 2-4: device descriptor read/64, error -71
Sep 21 16:19:40 learner kernel: usb 2-4: device descriptor read/64, error -71
Sep 21 16:19:40 learner kernel: usb 2-4: new high-speed USB device number 17
using xhci_hcd
Sep 21 16:19:40 learner kernel: usb 2-4: device descriptor read/64, error -71
Sep 21 16:19:40 learner kernel: usb 2-4: device descriptor read/64, error -71
Sep 21 16:19:40 learner kernel: usb 2-4: new high-speed USB device number 18
using xhci_hcd
Sep 21 16:19:40 learner kernel: usb 2-4: Device not responding to setup address.
Sep 21 16:19:41 learner kernel: usb 2-4: Device not responding to setup address.
Sep 21 16:19:41 learner kernel: usb 2-4: device not accepting address 18, error
- -71
Sep 21 16:19:41 learner kernel: usb 2-4: new high-speed USB device number 19
using xhci_hcd


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX4mqUAAoJEKY6WKPy4XVpEHMP/RhcDQXxt3LTOpGhJizyqZ4z
7Sm1tcBe/4NKP80nUpiI0geQYHYfRTR93hGKFayp48ULstn8xJ8T3ItZIS0WmZDK
TJcdxXzrkWMGNAGQFjNd9Lk1C7h1IIuo2D5xDuhrpHGMc5y4UVmpPixQRwEnbzG9
zX+PabvummAmlzT1+cRyO10uwpGFzsJ3SDkokjkxZ/aViL+vBU58/qiXIFH1D1hX
KTY8ABZjh4Hnkw07EcQh0xKztEbE/v2wJWPSx4RCPbsRdO5vdKUtOtWB7+1WVAY3
noSrvNWjj0Ntnm0+t4XIid1fDmNumK0EcYe8fDb/GqAuYDTqjcIZ5ANCaVSM/joq
suY7KTXVe44Pol1Bb89lERR49QAkxyKJViNc0bNSkp0+F4u4cDW9o0q6s0X6xw5b
LdAQHQek92IRNmT7v4gYO9bUKUBurqgHuUdi3iYlylbvs8UAzHmOL3nrFBz2GIcG
KQvqmvENy31VIlIMx+k3SipyedG77LIAmxX8bG7Xlu8lSZz3sPkMz7RJYeW0QwQ6
lC2cWiF2cn5K/0eTQPW3MX5H9m5qlq0QGaDrf8kGX6XpRKR3Qsu98L+R+AAmViQ9
kd2eBFzL4JdNVhXgNWrNk5mr0R0D9RB/58YWize3sASPg75zCFQCNOoFTPNZGN1q
edPs8uwkN5O2cy+0ur8n
=uZvc
-----END PGP SIGNATURE-----

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

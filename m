From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Sun, 4 Sep 2016 15:46:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609041544190.7019-100000@netrider.rowland.org>
References: <1473012074.5339.6.camel@researchut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473012074.5339.6.camel-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, 4 Sep 2016, Ritesh Raj Sarraf wrote:

> > This issue has been around with previous kernels too.
> > 
> > > Perhaps you can run a test on a 4.8 rc4 kernel, just to double check.
> > > The 4.8 rc4, contains the following fixes in the mmc block layer.
> > > 
> > > commit 7afafc8a44bf ("block: Fix secure erase")
> > > commit 869c554808cc ("mmc: fix use-after-free of struct request")
> > 
> > I'll share my 4.8-rc4 results soon.
> 
> As I hoped, I was able to reproduce this with 4.8-rc4 too.
> 
> [  857.999547] systemd[1]: apt-daily.timer: Adding 10h 21min 53.234725s random
> time.
> [13071.615285] usb 2-4: USB disconnect, device number 2
> [13072.794802] usb 2-4: new high-speed USB device number 7 using xhci_hcd
> [13072.925092] usb 2-4: New USB device found, idVendor=0bda, idProduct=0129
> [13072.925094] usb 2-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [13072.925095] usb 2-4: Product: USB2.0-CRW
> [13072.925096] usb 2-4: Manufacturer: Generic
> [13072.925097] usb 2-4: SerialNumber: 20100201396000000
> [13093.499011] usb 2-4: reset high-speed USB device number 7 using xhci_hcd
> [13093.612239] usb 2-4: Device not responding to setup address.
> [13093.818896] usb 2-4: Device not responding to setup address.
> [13094.025491] usb 2-4: device not accepting address 7, error -71
> [13094.138844] usb 2-4: reset high-speed USB device number 7 using xhci_hcd
> [13094.252178] usb 2-4: device descriptor read/64, error -71
> [13094.489037] usb 2-4: device descriptor read/all, error -71
> [13094.602374] usb 2-4: reset high-speed USB device number 7 using xhci_hcd
> [13094.602453] usb 2-4: Device not responding to setup address.
> [13094.808929] usb 2-4: Device not responding to setup address.
> [13095.015523] usb 2-4: device not accepting address 7, error -71
> [13095.128879] usb 2-4: reset high-speed USB device number 7 using xhci_hcd
> [13095.145799] usb 2-4: device descriptor read/all, error 8
> [13095.145842] usb 2-4: USB disconnect, device number 7
> [13095.492216] usb 2-4: new high-speed USB device number 8 using xhci_hcd
> [13095.605642] usb 2-4: Device not responding to setup address.
> [13095.812294] usb 2-4: Device not responding to setup address.

This is not the problem I was discussing with Ulf.  The problem was why
the device kept going into and out of runtime suspend every three
seconds.  The kernel log above does not say whether this was happening.
One way to tell is to look at a usbmon trace (like we did before).

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

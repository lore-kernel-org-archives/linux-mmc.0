From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Wed, 21 Sep 2016 10:37:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609211035230.1996-100000@iolanthe.rowland.org>
References: <1474456212.8192.2.camel@researchut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37066 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S933318AbcIUOhj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2016 10:37:39 -0400
In-Reply-To: <1474456212.8192.2.camel@researchut.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Raj Sarraf <rrs@researchut.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alex Dubov <oakad@yahoo.com>, USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Wed, 21 Sep 2016, Ritesh Raj Sarraf wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> Hi Alan,
> 
> On Tue, 2016-09-20 at 10:16 -0400, Alan Stern wrote:
> > This is a lot better.  No more I/O errors.
> > 
> > We still have irregular suspends and resumes, but that's to be 
> > expected.  More worrying are the spontaneous disconnects.  They don't 
> > seem to be related to the suspend/resume activity.
> > 
> > You can disable suspend for this device entirely by doing:
> > 
> >         echo on >/sys/bus/usb/devices/2-4/power/control
> > 
> > I'm afraid that this won't prevent the device from disconnecting
> > itself, though.  This appears to be some sort of hardware bug that
> > can't be fixed in software.
> 
> I'm not sure what you were referring to when you said "No more I/O errors".

I was referring to the attempts at I/O while the device was suspended.  
They didn't occur in your most recent test.

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

These are a completely different kind of error.  They occurred during a 
reset, which followed one of those spontaneous disconnects.  Probably 
the cause of the disconnect is also the cause of these errors.

Alan Stern


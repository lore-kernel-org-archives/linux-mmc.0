From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Tue, 20 Sep 2016 10:16:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609201012290.1459-100000@iolanthe.rowland.org>
References: <1474374977.12288.2.camel@researchut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54212 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752541AbcITOQw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2016 10:16:52 -0400
In-Reply-To: <1474374977.12288.2.camel@researchut.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Raj Sarraf <rrs@researchut.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alex Dubov <oakad@yahoo.com>, USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Tue, 20 Sep 2016, Ritesh Raj Sarraf wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> On Mon, 2016-09-19 at 13:48 -0400, Alan Stern wrote:
> > 
> > This ought to help.  Ritesh, please apply this patch on top of the 
> > two earlier ones and let's see what happens.
> > 
> > Alan Stern
> > 
> > 
> 
> Please find the logs at the following links. On this boot, I did not see any
> kernel stack being printed.
> 
> https://people.debian.org/~rrs/tmp/4.8.0-rc7ulf1alan2+.kern.log
> https://people.debian.org/~rrs/tmp/usb-4.8.0-rc7ulf1alan2+.log

This is a lot better.  No more I/O errors.

We still have irregular suspends and resumes, but that's to be 
expected.  More worrying are the spontaneous disconnects.  They don't 
seem to be related to the suspend/resume activity.

You can disable suspend for this device entirely by doing:

	echo on >/sys/bus/usb/devices/2-4/power/control

I'm afraid that this won't prevent the device from disconnecting
itself, though.  This appears to be some sort of hardware bug that
can't be fixed in software.

Alan Stern


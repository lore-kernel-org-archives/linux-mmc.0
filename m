From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing
 led
Date: Tue, 20 Sep 2016 10:12:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609201009470.1459-100000@iolanthe.rowland.org>
References: <1474364420.4358.21.camel@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54180 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1753560AbcITOMJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2016 10:12:09 -0400
In-Reply-To: <1474364420.4358.21.camel@suse.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Micky Ching <micky_ching@realsil.com.cn>, Wei WANG <wei_wang@realsil.com.cn>, Roger Tseng <rogerable@realtek.com>, Ritesh Raj Sarraf <rrs@researchut.com>, linux-mmc <linux-mmc@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>

On Tue, 20 Sep 2016, Oliver Neukum wrote:

> On Mon, 2016-09-19 at 14:02 -0400, Alan Stern wrote:
> > > We can for sure enable autosuspend for the sdmmc device, although as
> > > soon as an SD card will be detected the rtsx driver will increase
> > the
> > > runtime PM usage count. The count is decreased when the card is
> > > removed (or failed to be initialized), thus runtime suspend is
> > > prevented as long as there is a functional card inserted.
> 
> Testing autosuspend with card readers on usb_storage I saw a uniform
> response of reporting a medium change event upon resume.
> I am afraid other kinds of readers are not better in that regard.

That shouldn't be an issue in this case, at least, not with the current 
code.  The sdmmc and memstick drivers block autosuspend if media is 
present.

> > Which means that autosuspend matters only when a card isn't present, 
> > and the host is polled every second or so to see whether a card has 
> > been inserted.
> > 
> > Under those circumstances you probably don't want to use
> > autosuspend.  
> > That is, resuming before each poll and suspending afterward may use 
> > less energy than staying at full power all the time.
> 
> Is that based on concrete figures about power consumption?

No.

> And it seems to me that we need a way to indicate that the heuristics
> should not be used, but a device immediately suspended. The timer
> is sensible only if the next wakeup is unknown.

The driver can always turn off autosuspend if it wants to.

Alan Stern


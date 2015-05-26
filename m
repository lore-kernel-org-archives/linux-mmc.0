From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: sdhci(imx6): misbehaves while installing debian jessie, "Got
 data interrupt 0x00100000"
Date: Tue, 26 May 2015 16:01:22 +0100
Message-ID: <20150526150122.GP2067@n2100.arm.linux.org.uk>
References: <20150519222320.GM2067@n2100.arm.linux.org.uk>
 <CAPDyKFqR3NwBd9O40BPzHG7Y4wyyJwgdB4NsA_GUO=YEyqFSXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44174 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbbEZPBa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 May 2015 11:01:30 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqR3NwBd9O40BPzHG7Y4wyyJwgdB4NsA_GUO=YEyqFSXQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 26, 2015 at 04:49:34PM +0200, Ulf Hansson wrote:
> On 20 May 2015 at 00:23, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > iMX6 with a Samsung EVO UHS-1 16GB card.
> >
> > There's actually two problems here.
> >
> > 1. SDHCI chooses to impose a 10 second timeout on any data operation.
> >    This magic value of 10 seconds is rediculous.  Consider that SD
> >    cards are typically slower than ATA, and ATA has a timeout of more
> >    than one minute for a stuck command...  And yes, I've had this fire
> >    a good 10 seconds before I then got...
> >
> > 2. "Got data interrupt 0x00100000 even though no data operation was in progress."
> >
> >    That's SDHCI_INT_DATA_TIMEOUT.
> >
> >    Unfortunately, I have no other information, as the registers are
> >    dumped at pr_debug() level, which means that they're all compiled
> >    out in normal kernel builds.  In any case, I have no way to copy
> >    information off of the installing system; debian does not start up
> >    a ssh daemon during the install, so remote login is not possible.
> >    Nor can I photograph the rather reflective TV screen.
> >
> > The side-effect of this is that the entire MMC IO subsystem locks up
> > and I'm left with lots of processes stuck in IO-wait state, with the
> > hungtask detector spewing onto the console.
> 
> Sorry, I can't tell much around the host driver and HW as such. I
> don't have any iMX6 boards at hand.
> 
> Though, the side-effect you are describing isn't very nice. Even if it
> doesn't solve you problem, perhaps we should discuss about converting
> from wait_for_completion() to wait_for_completion_timeout(), when the
> mmc core waits for the host driver to return the result for the
> request.
> 
> I guess the tricky part is to find a decent value for the "timeout".

There's two issues which would need solving for that:

1. The only sane timeout is one which will never trigger under normal
   operating circumstances, and abnormal load conditions.

2. When the timeout occurs, the core would need some way to reset the
   host driver back to a sane state before retrying the command.

However, the better question to ask is what's causing this.  It seemed
to lock up at the same point in the installation - after the base system
had been installed, but while it was installing additional stuff (for
xfce.)  From what I remember, it was exactly the same package that the
MMC host failed at.

I suppose it's entirely possible that the Debian install is running
some package scripts which end up poking about in memory, which are
screwing up the MMC host - nothing would surprise me... the Debian
Jessie install is screwed in other ways (if you select Gnome instead,
the installer aborts because it discovers that the distro packages
are missing some dependencies, though I had put that down to the UK
mirror possibly being out of date...)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

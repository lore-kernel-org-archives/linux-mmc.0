From: Chris Ball <cjb@laptop.org>
Subject: Re: Erasing an SD/MMC card from usermode?
Date: Thu, 6 Jan 2011 04:48:43 +0000
Message-ID: <20110106044843.GA17617@void.printf.net>
References: <201101052303.p05N3gAN015791@new.toad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57420 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137Ab1AFEso (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jan 2011 23:48:44 -0500
Content-Disposition: inline
In-Reply-To: <201101052303.p05N3gAN015791@new.toad.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Gilmore <gnu@toad.com>
Cc: linux-mmc@vger.kernel.org

Hi John,

On Wed, Jan 05, 2011 at 03:03:42PM -0800, John Gilmore wrote:
> I'm working on secure deletion of data on various media.  I recalled
> that the MMC and SD card specs contain a low-level command for erasing
> blocks, which could be used to erase a whole card if desired.  And later
> MMC specs provide a secure block erase command that also erases ancillary
> unaddressable garbage blocks, etc.
> 
> However, after a perusal of the relevant kernel code (as of the 2.6.35
> shipped by Ubuntu), I see no support for invoking these commands from a
> user program.  I saw some patches on the LKML from Adrian Hunter in
> June 2010 that added support for ioctl(BLKSECDISCARD).  Are these in
> an upcoming mainline kernel? 

These patches were included in the 2.6.36 release, back in October.

> Has someone provided a clean userspace way to invoke it on an entire SD
> card or MMC card?

Not that I can see.  http://sourceforge.net/projects/test-discard/ looks
like it would be trivially modifiable to use BLKSECDISCARD, and would
also tell you some interesting things about timing.  Of course, a tiny
script would be enough to open an MMC block device and call the ioctl.

> (On ATA disks, access to the SECURITY ERASE command is via the hdparm user
> program, which invokes the SG_IO (SCSI Generic) driver.  But SECURITY ERASE
> has odd edges, e.g. it requires that you set and then supply a password.  It
> would be a shame if higher level programs, e.g. the Linux installer, had
> to run different "secure erase" commands depending on what medium is being
> erased.)
> 
> 	John Gilmore
> 
> PS:  Does anyone know a way to do secure erase via a USB Mass Storage adapter?

Don't know, sorry.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

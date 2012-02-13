From: Chris Ball <cjb@laptop.org>
Subject: Re: staging status of rts_pstor and rts5139
Date: Mon, 13 Feb 2012 15:01:23 -0500
Message-ID: <m2hayujyek.fsf@bob.laptop.org>
References: <20120213192518.GJ9751@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37532 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757833Ab2BMUBb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Feb 2012 15:01:31 -0500
In-Reply-To: <20120213192518.GJ9751@redhat.com> (Don Zickus's message of "Mon,
	13 Feb 2012 14:25:18 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
Cc: linux-mmc@vger.kernel.org

Hi Don,

On Mon, Feb 13 2012, Don Zickus wrote:
> Hi Chris,
>
> My name is Don Zickus from Red Hat.  I am working with a vendor that would
> like to ship hardware that requires the rts_pstor and rts5139 drivers (two
> different hardware platforms).  Before we include them in our RHEL OS, we
> would like to figure what is needed to bump those drivers from 'staging'
> status to something the linux-mmc community would fully support.  Is there
> a lot of work to be done or just some style cleanups?  Or perhaps you
> haven't really looked at them yet.

I have had a chance to look at rts_pstor: it's awful, I'm afraid.  It
emulates a SCSI device out of the PCI card reader, and it embeds its
own copy of an SD stack inside the driver (in sd.c) behind the scenes
instead of using the kernel's drivers/mmc stack, which is not acceptable.
I don't think there's any future for the driver in mainline until these
complaints are changed; it probably shouldn't even be in staging.

So, I think that for it to be merged, it must first be rewritten to be
a driver that's a few hundred lines long -- instead of 20,000! -- that
(a) uses Linux's SD stack and (b) exposes MMC devices, not SCSI ones.
That's a fairly complete rewrite, unfortunately, and would only cover
the MMC/SD interface on the hardware -- the same hardware supports
memorystick and xD too, which are different standards/subsystems.

I had not looked at rts5139, but just took a quick look and it seems
like it's an unmerged duplicate fork of the rts_pstor driver -- another
20k lines, mostly the same as the ones in rts_pstor, of SCSI emulation
and bundled SD stack, so all of my comments would apply to it too.

Sorry I don't have better news!  I think your best option for mainline
support would be to find a way to offer a long-term loan of systems with
this hardware inside to any volunteers from linux-mmc@ who want to work
on a replacement driver for it; I asked Dell for the same when I learned
they were shipping these devices in laptops, but they don't seem to be
able to loan out laptops for more than a couple of weeks.  I did start
out on an rts_pstor rewrite, but wasn't able to get it working before
my temporary access to the hardware ran out.

(I do wish there were better relationships between the kernel community
and people with new hardware that needs support added for it, such that
we could just file a request with Red Hat, Lenovo or Dell to get access
to shipping hardware with some new chip..)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

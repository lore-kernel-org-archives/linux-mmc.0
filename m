From: John Calixto <john.calixto@modsystems.com>
Subject: RE: [PATCH resend] mmc: Added ioctl to let userspace apps send
 ACMDs
Date: Fri, 18 Mar 2011 10:32:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1103180927390.5267@peruna>
References: <201103172255.51442.arnd@arndb.de> <203F41F6E33F954E8E8B02559FDC906F7431FC48EA@modex01>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:54200 "EHLO
	elasmtp-banded.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757074Ab1CRRc4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2011 13:32:56 -0400
In-Reply-To: <201103172255.51442.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org

Hello Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Thursday, March 17, 2011 2:56 PM
> To: John Calixto
> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org
> Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send ACMDs
>
> On Thursday 17 March 2011 19:28:55 John Calixto wrote:
> > Part 3 of the SD Specification (SD Card Association; www.sdcard.org) describes
> > how to use the security function of an SD card using application specific
> > commands in conjunction with CPRM algorithms and keys licensed from the 4C
> > Entity (www.4centity.com).  This allows userspace applications to access this
> > security feature.
>
> Having the ability to send commands from user space sounds useful,
> a number of other block drivers can do this, too.
>
> However, for the specific example you mention, I think it would be
> nicer to implement it in kernel space, and have a high-level
> interface.

I started down that route, but part of the problem with putting any more
than a simple passthrough in kernel space is that the CPRM algorithms
live in the next highest logic layer, and 4C licensees are not allowed
to reveal those algorithms.  If you have access to the SD Specification,
you will see that it documents all of the individual security commands.
However, the sequence of commands is documented in the 4C CPRM
Specification.

Installing this passthrough also has the added benefit of allowing
other, non-security-related, application specific commands to be sent.

>
> A few more comments about the implementation below.
>
> > Tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652 SoC, TI OMAP3621 SoC, TI
> > OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm MSM7200A SoC.
>
> Is this safe to do while the device is operating and a file system
> writes data?

If you mean:

    Is it safe for one process to write data to the User Area (i.e. the
    non-secure part; the normal use case for SD as unencrypted storage),
    while another process issues secure commands?

then, no, it is not.  Should I try and protect against this in the
kernel driver?

If you mean:

    Can a program use both the User Area and the Protected Area?

then, yes, it can.  In broad terms, the typical program would:

    - mount /dev/mmcblk0p1 /mnt/sdcard
    - find encrypted file /mnt/sdcard/encrypted_blob
    - issue secure commands via ioctl() to /dev/mmcblk0p1 to find
      decryption keys; no need to umount
    - decrypt /mnt/sdcard/encrypted_blob using keys retrieved above

>
> Does it allow sending all commands or just the ones you require?
>

I did not choose to filter out commands.  I expected that other folks
might want to send other ACMDs.

<snip>

I'll apply the rest of your feedback and Ben Dooks' tip about the
unnecessary cast in the next revision of the patch.

Thanks!

John

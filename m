From: John Gilmore <gnu@toad.com>
Subject: Erasing an SD/MMC card from usermode?
Date: Wed, 05 Jan 2011 15:03:42 -0800
Message-ID: <201101052303.p05N3gAN015791@new.toad.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from new.toad.com ([209.237.225.253]:54410 "EHLO new.toad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048Ab1AEXNQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jan 2011 18:13:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, gnu@toad.com

I'm working on secure deletion of data on various media.  I recalled
that the MMC and SD card specs contain a low-level command for erasing
blocks, which could be used to erase a whole card if desired.  And later
MMC specs provide a secure block erase command that also erases ancillary
unaddressable garbage blocks, etc.

However, after a perusal of the relevant kernel code (as of the 2.6.35
shipped by Ubuntu), I see no support for invoking these commands from a
user program.  I saw some patches on the LKML from Adrian Hunter in
June 2010 that added support for ioctl(BLKSECDISCARD).  Are these in
an upcoming mainline kernel?  Has someone provided a clean userspace
way to invoke it on an entire SD card or MMC card?

(On ATA disks, access to the SECURITY ERASE command is via the hdparm user
program, which invokes the SG_IO (SCSI Generic) driver.  But SECURITY ERASE
has odd edges, e.g. it requires that you set and then supply a password.  It
would be a shame if higher level programs, e.g. the Linux installer, had
to run different "secure erase" commands depending on what medium is being
erased.)

	John Gilmore

PS:  Does anyone know a way to do secure erase via a USB Mass Storage adapter?

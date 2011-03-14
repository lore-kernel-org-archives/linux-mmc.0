From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Memory replacement
Date: Mon, 14 Mar 2011 15:01:11 +0100
Message-ID: <201103141501.11797.arnd@arndb.de>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com> <4D7D37C2.2030102@laptop.org> <4D7D4670.1050009@bga.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50196 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab1CNOBU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 10:01:20 -0400
In-Reply-To: <4D7D4670.1050009@bga.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: mikus@bga.com
Cc: "Richard A. Smith" <richard@laptop.org>, devel@lists.laptop.org, linux-mmc@vger.kernel.org

On Sunday 13 March 2011, Mikus Grinbergs wrote:
> > The tests have also helped expose other issues with things like sudden 
> > power off.  In one case a SPO during a write would corrupt the card so 
> > badly it became useless.  You could only recover them via a super secret 
> > tool from the manufacturer.
> 
> Is there any "sledgehammer" process available to users without a super
> secret tool ?

You can recover some cards by issueing an erase on the full drive.
Unfortunately, this requires a patch to the SDHCI device driver,
which is only now going into the kernel, I think it will be
in 2.6.39.

Issuing an erase (ioctl BLKDISCARD) also helps recover the performance
on cards that get slower with increased internal fragmentation, but
most cards use GC algorithms far too simple to get into that problem
in the first place.

	Arnd

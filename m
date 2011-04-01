From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Fri, 1 Apr 2011 11:23:14 +0200
Message-ID: <201104011123.14675.arnd@arndb.de>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com> <m3bp0rukeq.fsf@pullcord.laptop.org> <AANLkTinUyixNuOnEVdwWVKQ6sf=CdwEGTOGd9RQuGTX_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63977 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192Ab1DAJXS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2011 05:23:18 -0400
In-Reply-To: <AANLkTinUyixNuOnEVdwWVKQ6sf=CdwEGTOGd9RQuGTX_@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thursday 31 March 2011, Andrei Warkentin wrote:
> > Another strawman, after brainstorming a bit on IRC -- how about
> > the block device itself comes up read-only, until you use a module
> > parameter/sysfs entry to make it read-write.  As a strawman:
> >
> > echo 1 > /sys/module/mmc_block/boot_partitions_are_writeable
> >
> > (That way people who write to it regularly can throw the module parameter
> > in their boot environment, and the rooting enthusiasts who didn't compile
> > the kernel are safe until they learn enough to be really dangerous..)
> 
> Sure, I like this, I'll do it.

I don't think it's even needed, but it sounds much more useful than
a Kconfig option, so no objections from me.

	Arnd

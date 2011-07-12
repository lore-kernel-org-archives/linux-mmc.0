From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: Added quirks for Ricoh 1180:e823 lower base clock frequency
Date: Tue, 12 Jul 2011 20:00:50 +0200
Message-ID: <201107122000.50309.arnd@arndb.de>
References: <1310419715-13254-1-git-send-email-manoj.iyer@canonical.com> <alpine.DEB.2.02.1107121123140.1767@lazy> <m2ei1v76f1.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63501 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab1GLSBg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2011 14:01:36 -0400
In-Reply-To: <m2ei1v76f1.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Manoj Iyer <manoj.iyer@canonical.com>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, matsumur@nts.ricoh.co.jp, linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org

On Tuesday 12 July 2011 19:30:42 Chris Ball wrote:
> On Tue, Jul 12 2011, Manoj Iyer wrote:
> > btw only the 1st write was slower, subsequent writes looks ok.
> > [..]
> > I have attached the output of flashbench and the time test to
> >
> > http://launchpad.net/bugs/773524
> > [..]
> > == Finding the number of open erase blocks ==
> > u@u:~/flash/flashbench$ sudo ./flashbench -O --erasesize=$[4 * 1024 *
> > 1024] --blocksize=$[256 * 1024] /dev/mmcblk0  --open-au-nr=2
> > 4MiB    6.36M/s
> > 2MiB    6.24M/s
> > 1MiB    6.17M/s
> > 512KiB  6.19M/s
> > 256KiB  6.22M/s
> > u@u:~/flash/flashbench$
> > [..]
> > ====== AFTER PATCH ========
> > [..]
> > == Finding the number of open erase blocks ==
> > u@u:~/flash/flashbench$ sudo ./flashbench -O --erasesize=$[4 * 1024 *
> > 1024]         --blocksize=$[256 * 1024] /dev/mmcblk0  --open-au-nr=2
> > [sudo] password for u:
> > 4MiB    5.49M/s
> > 2MiB    6.22M/s
> > 1MiB    6.22M/s
> > 512KiB  6.21M/s
> > 256KiB  6.21M/s
> > u@u:~/flash/flashbench$
> 
> That's interesting.  Arnd, any idea why only the first test of the
> flashbench run would be slower after the patch?

I would very much expect that to be nonreproducible. The first row
in each test is the result of a single write() system call and does
not get averaged out. More importantly the time for each write
depends a lot of the state of the card before the write.

For instance when you do a lot of random writes to a card, optionally
take it out and put it into a different machine, and then do a large
linear write, that linear write will be very slow because the
card has to garbage collect all the random writes that were done
earlier. After a few writes (usually one is enough), it gets back
to the full performance.

	Arnd

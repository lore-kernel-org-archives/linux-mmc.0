From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sat, 12 Feb 2011 10:59:18 +0000
Message-ID: <20110212105918.GG15616@n2100.arm.linux.org.uk>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102091013.56670.arnd@arndb.de> <AANLkTimZb-hxz-31nGmycdtU-i=t=9wBoDJ-chAXUmD6@mail.gmail.com> <201102121145.42053.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42269 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1BLK7e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 05:59:34 -0500
Content-Disposition: inline
In-Reply-To: <201102121145.42053.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Ulf Hansson <Ulf.Hansson@stericsson.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, linux-arm-kernel@lists.infradead.org, Sebastian Rasmussen <Sebastian.Rasmussen@stericsson.com>

On Sat, Feb 12, 2011 at 11:45:41AM +0100, Arnd Bergmann wrote:
> * The FAT location is clearly visible in a number of tests
>   done inside of an allocation unit. It's normally slower for
>   linear access, but faster for random access. Sometimes
>   reading the FAT is also slower than reading elsewhere.

I wouldn't also be surprised if there's some cards out there which parse
the FAT being written, and start activities (such as erasing clusters)
based upon changes therein.  Such cards would be unsuitable for use with
non-FAT filesystems.

It might be worth devising some sort of check for this kind of behaviour.

Unrelated, I have a USB based device which provides an emulated FAT
filesystem - all files except one on this filesystem are read-only.
The writable file is a textual configuration file.  It can be reliably
updated by Windows based systems, but updates from Linux based systems
are ignored - presumably because updates to the FAT/directory/data
clusters are occuring in a different order.

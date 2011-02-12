From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sat, 12 Feb 2011 17:28:32 +0100
Message-ID: <201102121728.32585.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102121145.42053.arnd@arndb.de> <20110212105918.GG15616@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62534 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab1BLQ2r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 11:28:47 -0500
In-Reply-To: <20110212105918.GG15616@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Ulf Hansson <Ulf.Hansson@stericsson.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, linux-arm-kernel@lists.infradead.org, Sebastian Rasmussen <Sebastian.Rasmussen@stericsson.com>

On Saturday 12 February 2011 11:59:18 Russell King - ARM Linux wrote:
> On Sat, Feb 12, 2011 at 11:45:41AM +0100, Arnd Bergmann wrote:
> > * The FAT location is clearly visible in a number of tests
> >   done inside of an allocation unit. It's normally slower for
> >   linear access, but faster for random access. Sometimes
> >   reading the FAT is also slower than reading elsewhere.
> 
> I wouldn't also be surprised if there's some cards out there which parse
> the FAT being written, and start activities (such as erasing clusters)
> based upon changes therein.  Such cards would be unsuitable for use with
> non-FAT filesystems.
> 
> It might be worth devising some sort of check for this kind of behaviour.

Possible, but doesn't seem to happen with any of the cards I have
tested, the controllers in there appear to be too simplistic.
Also, the recommendations for SD cards are to issue explicit erase
requests, which would make this unnecessary.

OTOH, SD cards do specify exactly where the FAT should be stored on
the medium, so it would be possible to make this kind of assumption.

USB sticks and CF cards might be smart enough to actually do it,
some of them have more sophisticated logic than SD cards (most
do not), and there is no usb mass storage command for erase.

> Unrelated, I have a USB based device which provides an emulated FAT
> filesystem - all files except one on this filesystem are read-only.
> The writable file is a textual configuration file.  It can be reliably
> updated by Windows based systems, but updates from Linux based systems
> are ignored - presumably because updates to the FAT/directory/data
> clusters are occuring in a different order.

Fun. I think qemu also comes with one of these FAT emulation layers,
as do some mp3 players, but from what I have heard, they are not as
broken.

	Arnd

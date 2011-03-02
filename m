From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 2/3] MMC: Add block quirks support.
Date: Wed, 2 Mar 2011 22:04:15 +0100
Message-ID: <201103022204.15235.arnd@arndb.de>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com> <201103021819.52837.arnd@arndb.de> <AANLkTimYf01Y6FLYGdyeozvxVO0mxX_QOn2XQ5AHGEFk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62474 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab1CBVEY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2011 16:04:24 -0500
In-Reply-To: <AANLkTimYf01Y6FLYGdyeozvxVO0mxX_QOn2XQ5AHGEFk@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Wednesday 02 March 2011 21:48:25 Andrei Warkentin wrote:

> >
> > Instead of the dynamic registration, I'd just put all quirks into
> > one file and have an array of them:
> 
> Ideally, you'd have the most important workarounds always built in, to
> deal with important problems like out-of-spec devices. The eMMC ones
> you would select, but the external device ones would be "by default".
> This could potentially explode in the amount of quirks, so maybe
> linear search isn't the best?
> 
> Or you think that there will be sufficiently small number that doesn't
> justify the complexity?

I think we will start with a small number, and a linear search once
at insertion time is good for a significant amount of quirks. We do this
for all PCI and USB devices, see drivers/usb/storage/usual-tables.c.

I would certainly not do anything more complex than this unless we
get into scalability problems with the simple approach.

	Arnd

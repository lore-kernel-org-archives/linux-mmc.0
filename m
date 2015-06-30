From: Venkatraman S <svenkatr@gmail.com>
Subject: Re: mmc driver read/write detect problem with Baytrail tablet
Date: Tue, 30 Jun 2015 12:06:11 -0400
Message-ID: <CAOyx1Loar=hRrqgbuQqWuy4XswoLcNP6Wr5X+jdapt9PxA3P9Q@mail.gmail.com>
References: <CAGwpYodzn4TGiCp7L1+KQgb+JreMx2y07wgRmUsDHG-3fwetLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vn0-f45.google.com ([209.85.216.45]:35366 "EHLO
	mail-vn0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbbF3QGM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Jun 2015 12:06:12 -0400
Received: by vnbg190 with SMTP id g190so2294576vnb.2
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2015 09:06:11 -0700 (PDT)
In-Reply-To: <CAGwpYodzn4TGiCp7L1+KQgb+JreMx2y07wgRmUsDHG-3fwetLg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Mansfield <paul@mansfield.co.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Jun 30, 2015 at 10:13 AM, Paul Mansfield <paul@mansfield.co.uk> wrote:
>
> Hello,
>
> I am trying to get a baytrail-t based convertible tablet working with
> linux, using kernel 4.1 built for 32 bit Debian Jessie. I've made
> good progress, making my Toshiba Click Mini work
> sufficiently well to be useable with a USB wifi adaptor (the driver
> for the integrated SDIO wifi makes it unstable).
>
> A major sticking point is that the internal microSDHC slot is always
> read only; the device node /dev/mmcblk1 is read-write but when I
> try and mount it the kernel complains it's not writable.
>
> Meanwhile the tablet has a dock which has an full sized SDHC slot,
> and that works perfectly. I can put cards in the internal and dock
> card slots and they come up as separate devices, so they're
> definitely different devices on different buses.
>
> Is there some debug I can enable to let me find out why the driver
> thinks that internal card slot is read only?
>
> Is there some way to override the mmc driver read-only/write-protect
> function to force the driver to allow writing?
>
> Needless to say the card works fine in Windows 8.1.
>

Are the reads working properly ?
Can you enable MMC_DEBUG in the kernel config to collect more information ?

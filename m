From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: SDHC Read Performance
Date: Wed, 19 Jan 2011 12:14:40 +0900
Message-ID: <AANLkTinNtL0v2cnhz7Ci+a8TqQTcQXBMVW5EkX8qujy+@mail.gmail.com>
References: <20110119000909.GA9412@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36661 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab1ASDOm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2011 22:14:42 -0500
In-Reply-To: <20110119000909.GA9412@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi Simon,

On Wed, Jan 19, 2011 at 9:09 AM, Simon Horman <horms@verge.net.au> wrot=
e:
> Hi,
>
> I am currently interested in the read performance of the SDHI driver.=
 =A0I
> ran the following tests on a Mackerel board using Linus's latest tree
> (6845a44a), which I believe has all of the outstanding patches from A=
rnd
> and Guennadi merged.

Nice, thanks for testing this.

> I have made the following crude performance measurements using
> several different cards.
>
> dd if=3D/dev/mmcblk1 of=3D/dev/null bs=3D512 count=3D100000
>
> SD1.1: =A0 =A0 =A0 =A0 =A07.0 MB/s
> SD2.0: =A0 =A0 =A0 =A0 =A07.0 MB/s
> SDHC Class 2: =A0 7.1 MB/s
> SDHC Class 10: =A07.2 MB/s
>
> Whereas I would expect something like:
>
> SD1.1 card: =A0 =A0 12 MB/s
> SD2.0 card: =A0 =A0 24 MB/s
> SDHC Class 2: =A0 24 MB/s
> SDHC Class 10: =A0Faster?

Please have a look at the clock frequency set by the SDHI MFD driver
(hclk), together with the tmio-mmc settings in tmio_mmc_set_clock().
=46or the clock to be bumped up properly some capability/feature flags
may be needed:

MMC_CAP_MMC_HIGHSPEED
MMC_CAP_SD_HIGHSPEED

Not sure if they are set properly. Probably not.

> Possibly relevant portions of my .config are:
>
> CONFIG_MFD_SH_MOBILE_SDHI=3Dy
> CONFIG_TMIO_MMC_DMA=3Dy
> CONFIG_MMC_TMIO=3Dy

These two are also relevant:

CONFIG_SH_DMAE=3Dy
CONFIG_DMA_ENGINE=3Dy

DMA controller platform data is also needed, not sure the state of
your board. You can check out the counters in /proc/interrupts to see
if the DMA controller is active or not.

Cheers,

/ magnus

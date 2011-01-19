From: Simon Horman <horms@verge.net.au>
Subject: SDHC Read Performance
Date: Wed, 19 Jan 2011 09:09:09 +0900
Message-ID: <20110119000909.GA9412@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

Hi,

I am currently interested in the read performance of the SDHI driver.  I
ran the following tests on a Mackerel board using Linus's latest tree
(6845a44a), which I believe has all of the outstanding patches from Arnd
and Guennadi merged.

I have made the following crude performance measurements using
several different cards.

dd if=/dev/mmcblk1 of=/dev/null bs=512 count=100000

SD1.1:		7.0 MB/s
SD2.0:		7.0 MB/s
SDHC Class 2:	7.1 MB/s
SDHC Class 10:	7.2 MB/s

Whereas I would expect something like:

SD1.1 card:	12 MB/s
SD2.0 card:	24 MB/s
SDHC Class 2:	24 MB/s
SDHC Class 10:	Faster?

Possibly relevant portions of my .config are:

CONFIG_MFD_SH_MOBILE_SDHI=y
CONFIG_TMIO_MMC_DMA=y
CONFIG_MMC_TMIO=y


Arnd, Guennadi, I believe that you have been working on SDHI recently.
If you have any suggestions I would be most grateful. Else I will
poke some more and see what I can come up with.


From: Franz <flash86@gmx.at>
Subject: Re: mmc_spi broken?
Date: Mon, 02 May 2016 11:17:27 +0200
Message-ID: <1462180647.21253.4.camel@gmx.at>
References: <1461400625.27953.5.camel@gmx.at>
	 <CAPDyKFoXmAbvZz61QRX1nBDXXKaXJgSEHVu8+Xa4oaN=qnw=kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:56779 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbcEBJRf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 May 2016 05:17:35 -0400
Received: from debian ([212.69.186.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Ld1CS-1bNjMB3h4K-00iBm9 for
 <linux-mmc@vger.kernel.org>; Mon, 02 May 2016 11:17:31 +0200
In-Reply-To: <CAPDyKFoXmAbvZz61QRX1nBDXXKaXJgSEHVu8+Xa4oaN=qnw=kw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I have new findings regarding this issue. It seems that udev is somehow
causing this problem. If I stop udev and mount the device manually
everything works fine. In the meantime I switched to mdev instead which
works like a charm.


On Mon, 2016-05-02 at 10:47 +0200, Ulf Hansson wrote:
> On 23 April 2016 at 10:37, Franz <flash86@gmx.at> wrote:
> > I am trying to get an SD Card to work via SPI interface. I am using a
> > RaspberryPI Compute Module with kernel Version 4.4, but I can't get it
> > to work properly. I've tried it with the native spi interface as well as
> > with the spi aux interface and also with a gpio bitbang spi interface.
> > It's always the same error:
> >
> > [ 2639.558282] mmc1: new SD card on SPI
> > [ 2639.566325] mmcblk1: mmc1:0000 SD256 243 MiB
> > [ 2639.646120]  mmcblk1: p1 < >
> > [ 2639.833759] mmcblk1: error -38 sending status command, retrying
> > [ 2639.839973] mmcblk1: error -38 sending status command, retrying
> > [ 2639.846170] mmcblk1: error -38 sending status command, aborting
> > [ 2639.853406] mmc1: SPI card removed
> > [ 2640.240223] mmc1: host does not support reading read-only switch,
> > assuming write-enable
> > [ 2640.248328] mmc1: new SD card on SPI
> > [ 2640.256373] mmcblk1: mmc1:0000 SD256 243 MiB
> > [ 2640.336068]  mmcblk1: p1 < >
> > [ 2640.523545] mmcblk1: error -38 sending status command, retrying
> > [ 2640.529757] mmcblk1: error -38 sending status command, retrying
> > [ 2640.535893] mmcblk1: error -38 sending status command, aborting
> > [ 2640.543129] mmc1: SPI card removed
> > [ 2640.930176] mmc1: host does not support reading read-only switch,
> > assuming write-enable
> > [ 2640.938313] mmc1: new SD card on SPI
> > [ 2640.946679] mmcblk1: mmc1:0000 SD256 243 MiB
> > [ 2641.026395]  mmcblk1: p1 < >
> > [ 2641.213996] mmcblk1: error -38 sending status command, retrying
> > [ 2641.220208] mmcblk1: error -38 sending status command, retrying
> > [ 2641.226344] mmcblk1: error -38 sending status command, aborting
> > [ 2641.233435] mmc1: SPI card removed
> > [ 2641.620177] mmc1: host does not support reading read-only switch,
> > assuming write-enable
> > [ 2641.628277] mmc1: new SD card on SPI
> > [ 2641.636530] mmcblk1: mmc1:0000 SD256 243 MiB
> > [ 2641.716114]  mmcblk1: p1 < >
> > [ 2641.903636] mmcblk1: error -38 sending status command, retrying
> > [ 2641.909852] mmcblk1: error -38 sending status command, retrying
> > [ 2641.915987] mmcblk1: error -38 sending status command, aborting
> > [ 2641.923056] mmc1: SPI card removed
> >
> > I don't have any RO or CD pins configured, just plain SPI interface
> > directly to the SD Card. I've tried it with different SD cards with
> > differen capacities. It's always the same error. The above messages
> > appear in a endless loop.The last time I've used the mmc_spi driver was
> > kernel 3.8 I think with this version everything worked without any
> > problems.  Does anyone know how to fix this?
> 
> So it seems to be a regression. I would try a bisect and see if it can
> pin-point us to a certain commit that causes the issue.
> 
> Kind regards
> Uffe



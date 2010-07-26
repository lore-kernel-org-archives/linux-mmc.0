From: Andreas Feuersinger <andreas.feuersinger@spintower.eu>
Subject: Re: MXC MMC and Libertas_sdio
Date: Mon, 26 Jul 2010 16:48:10 +0200
Message-ID: <20100726164810.6265bd75@speedy>
References: <20100723135938.619c6cb7@speedy>
	<876305ubqq.fsf@linux-g6p1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fep16.mx.upcmail.net ([62.179.121.36]:55911 "EHLO
	fep16.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab0GZOsT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Jul 2010 10:48:19 -0400
In-Reply-To: <876305ubqq.fsf@linux-g6p1.site>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: libertas-dev@lists.infradead.org


Hi,

I just managed to get the libertas card to work. Unfortunately the
data-rate is not too good (30 - 50K/s)

To get it work I changed block sizes to be multiples of 4.

Could somebody please point out a good place to increase buffer sizes
to multiples of 4 without influencing the performance/error rate of the
driver?
Are there other possibilities to increase data-rate for my
configuration?

thank you!

Andreas



On Fri, 23 Jul 2010 22:30:53 +0100
Matt Fleming <matt@console-pimps.org> wrote:

> On Fri, 23 Jul 2010 13:59:38 +0200, Andreas Feuersinger
> <andreas.feuersinger@spintower.eu> wrote:
> 
> Cc'ing libertas-dev@lists.infradead.org
> > 
> > I'm trying to use the libertas driver on MX27 based hardware. I'm
> > using kernel v2.6.22 with libertas and sdio driver ported (mainly
> > 2.6.34). The Wlan device is Marvel SD8686 connected via sdio.
> > 
> > Loading of firmware seems to work using a block size of 512
> >  sdio_set_block_size(card->func, 512);
> > 
> > after loading the firmware I get the following output:
> > 
[ ... ]
> > libertas: response packet too large (4294967292 bytes)
> > libertas: problem fetching packet from firmware
> > 
> > The latest output goes on forever. Canceling the modprobe command
> > results in a Network Interface:
> > 
> > Strg+C 
> > libertas: eth1: Marvell WLAN 802.11 adapter
> > 
> > However the problem fetching packet from firmware remains and the
> > device does not work.
> > I tried several Firmware Versions all resulting as described above.
> > 
> > If I use 32 instead of 512 for the block size the kernel hangs after
> > loading helper firmware during the loading process of the "real"
> > firmware.
> > 
> > I read about Daniel Mack doing similar stuff for mx31 based systems.
> > Did he/you has/have success in that and what were your problems?
> > 
> > I appreciate any help/hints where to dig for the error.
> > 
> > Thanks, 
> > Andreas
> > 


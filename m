From: Andreas Feuersinger <andreas.feuersinger@spintower.eu>
Subject: MXC MMC and Libertas_sdio
Date: Fri, 23 Jul 2010 13:59:38 +0200
Message-ID: <20100723135938.619c6cb7@speedy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fep31.mx.upcmail.net ([62.179.121.49]:40622 "EHLO
	fep31.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756746Ab0GWMPh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Jul 2010 08:15:37 -0400
Received: from edge04.upcmail.net ([192.168.13.239])
          by viefep14-int.chello.at
          (InterMail vM.8.01.02.02 201-2260-120-106-20100312) with ESMTP
          id <20100723115940.ESNC8381.viefep14-int.chello.at@edge04.upcmail.net>
          for <linux-mmc@vger.kernel.org>; Fri, 23 Jul 2010 13:59:40 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Hi,

I'm trying to use the libertas driver on MX27 based hardware. I'm using
kernel v2.6.22 with libertas and sdio driver ported (mainly 2.6.34).
The Wlan device is Marvel SD8686 connected via sdio.

Loading of firmware seems to work using a block size of 512
 sdio_set_block_size(card->func, 512);

after loading the firmware I get the following output:

libertas: waiting for firmware to boot
libertas: sdio read scratch
libertas: sdio scratch 0 ; ret: 0
libertas: sdio read scratch
libertas: sdio scratch 0 ; ret: 0
libertas: sdio read scratch
libertas: sdio scratch 0 ; ret: 0
libertas: sdio read scratch
libertas: sdio scratch 220 ; ret: 0
libertas: sdio host to card type 1, bytes 46
libertas: sdio host to card worker
libertas: sdio read scratch
libertas: sdio scratch 50 ; ret: 0
libertas: sdio card to host size 50
libertas: sdio card to host status: 10
libertas: card->buffer[0] 0 card->buffer[1] 0
packet of type 1 and size 0 bytes
libertas: sdio handle cmd
libertas: response packet too large (4294967292 bytes)
libertas: problem fetching packet from firmware

The latest output goes on forever. Canceling the modprobe command
results in a Network Interface:

Strg+C 
libertas: eth1: Marvell WLAN 802.11 adapter

However the problem fetching packet from firmware remains and the
device does not work.
I tried several Firmware Versions all resulting as described above.

If I use 32 instead of 512 for the block size the kernel hangs after
loading helper firmware during the loading process of the "real"
firmware.

I read about Daniel Mack doing similar stuff for mx31 based systems.
Did he/you has/have success in that and what were your problems?

I appreciate any help/hints where to dig for the error.

Thanks, 
Andreas








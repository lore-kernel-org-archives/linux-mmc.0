From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Thu, 18 Feb 2010 14:27:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002181412590.1946@xanadu.home>
References: <cover.1265801967.git.david.vrabel@csr.com>
 <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com>
 <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com>
 <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com>
 <004901cab001$6b19f6c0$544ff780@am.dhcp.ti.com> <4B7C4608.5010008@csr.com>
 <alpine.DEB.2.00.1002171254040.24812@utopia.booyaka.com>
 <4B7D3EAE.1010908@csr.com>
 <alpine.DEB.2.00.1002180951330.24812@utopia.booyaka.com>
 <004001cab0c9$b208b2b0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-reply-to: <004001cab0c9$b208b2b0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Paul Walmsley' <paul@pwsan.com>, 'David Vrabel' <david.vrabel@csr.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 18 Feb 2010, Madhusudhan wrote:

> If I look in the mainline kernel today there is only one SDIO card driver "
> sdio_uart.c". And at least I don't see a way I can test any of these
> features myself.

There are many other SDIO drivers in the kernel today:

 - The libertas wireless driver supports many interfaces, including 
   PCMCIA/CF, USB, SDIO and SPI.  Chips known to work with the SDIO 
   interface are the Marvell 8686 and 8688.

 - There is a BlueTooth HCI SDIO driver implementing the standard SDIO
   BlueTooth class.

 - The Marvell 8688 mentioned above is also a BlueTooth device through
   an additional SDIO "function".

 - Intel Wireless WiMAX Connection 2400 over SDIO.

And the sdio_uart.c driver can be used with SDIO GPS receivers for 
example.


Nicolas

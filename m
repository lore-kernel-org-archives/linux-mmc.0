From: Daniel Mack <daniel@caiaq.de>
Subject: Re: libertas: DAT1 signal IRQ in 1-bit SDIO mode
Date: Tue, 30 Mar 2010 11:05:40 +0200
Message-ID: <20100330090540.GM30801@buzzloop.caiaq.de>
References: <20100329182414.GJ30801@buzzloop.caiaq.de>
 <4BB0FE7A.6090709@embwise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:44022 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562Ab0C3JFp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2010 05:05:45 -0400
Content-Disposition: inline
In-Reply-To: <4BB0FE7A.6090709@embwise.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alagu Sankar <alagusankar@embwise.com>
Cc: libertas-dev@lists.infradead.org, linux-mmc@vger.kernel.org

Hi Alagu,

thanks a lot for your comprehensive answer.

On Tue, Mar 30, 2010 at 12:54:42AM +0530, Alagu Sankar wrote:
>    We have used at-least three different WiFi chipsets on an iMX31 host
>    including the Marvell 8686.  It was on a LogicPD reference platform
>    running an older 2.6.1x kernel with a commercial SDIO stack solution.  The
>    only problem we had with the platform was that it was not providing enough
>    current for the 8686 module, but again that is nothing to do with the
>    iMX31 as such.  It was not a smooth sailing developing the host driver for
>    iMX31.  After investing a lot of time on the driver, we figured out a way
>    of doing multi-block transfers.  For SDIO multi-block writes, we do

The MX31 has a silicon bug which leads to CRC corruption for multi-block
transfers. This is also what the SDHC signals in its error flags. I've
had technical support from Freescale and they confirmed this bug.
According the the Errata I've been sent, the only ways to get around
this are to use 1-bit transfers or single-block transfers only. The
latter isn't possible for 8686 as the firmware requires the 'real'
firmware to be downloaded with multiblock transfers (CMD53).

>    multiple DMA transfers each with the block size.  For example if you are
>    doing a multi-block write of 10 blocks of 256 byte each, then following is
>    the sequence that works fine
> 
>    - Configure the controller for 10 blocks and 256 byte block size (like any
>    other typical transfer)
>    - Configure the DMA controller to do only the first 256 bytes
>    - Wait for the DMA Completion handler and then initiate the next 256 bytes
>    - Continue this until all the blocks are transferred.

So what you're doing is you split up multiblock transfers into single
blocks? I might lack some knowledge here, but AFAIK that can't work for
every peripheral as the other side is well aware of the command it is
been issued, and can hence bail out if not fed correctly. Like the
firmware download of the 8686 does, according to my findings.

Did you ever try that technique without DMA?

>    If this is too much try for now and would like to still continue with the
>    1-bit mode, you can try setting the ECSI bit in CCCR - Bus Interface
>    Control Register (This should be done inside the libertas driver once
>    during the initialization).  This has helped us running the card in 1-bit
>    mode and get SDIO interrupts as well.

Ok, I'll give that a try later today.

Again, thanks for your help.

Daniel


From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: at91sam9263 sdio + wlan ti wl1271
Date: Wed, 4 Dec 2013 09:09:43 +0100
Message-ID: <20131204080943.GK3582@odulo-laptop>
References: <20131203095652.GA1329@hposo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:22834 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab3LDIJw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2013 03:09:52 -0500
Content-Disposition: inline
In-Reply-To: <20131203095652.GA1329@hposo>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-mmc@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>

Hi Olivier,

On Tue, Dec 03, 2013 at 10:59:28AM +0100, Olivier Sobrie wrote:
> Hi Ludovic,
> 
> I'm trying to use a wlan sdio TI wl1271 module with an at91sam9263
> processor. The wlan card is correctly recognized by the kernel but
> once the driver tries to initialize the card, then I observe sdio
> timeouts.
> 
> I enabled the traces in the atmel-mci driver and here is what I see
> when the problem occurs (kernel v3.11):
> 
> [   31.690000] atmel_mci fff84000.mmc: FSM: state=0
> [   31.900000] atmel_mci fff84000.mmc: MRQ: cmd 53
> [   31.900000] atmel_mci fff84000.mmc: start request: cmd 53
> [   31.900000] atmel_mci fff84000.mmc: IRQ: tx buffer empty
> [   31.900000] atmel_mci fff84000.mmc: (atmci_pdc_complete) set pending xfer complete
> [   31.900000] atmel_mci fff84000.mmc: IRQ: cmd ready
> [   31.900000] atmel_mci fff84000.mmc: set pending cmd rdy
> [   31.900000] atmel_mci fff84000.mmc: FSM: state=1
> [   31.900000] atmel_mci fff84000.mmc: FSM: cmd ready?
> [   31.900000] atmel_mci fff84000.mmc: set completed cmd ready
> [   31.900000] atmel_mci fff84000.mmc: command with data transfer
> [   31.900000] atmel_mci fff84000.mmc: FSM: state=2
> [   31.900000] atmel_mci fff84000.mmc: FSM: xfer complete?
> [   31.900000] atmel_mci fff84000.mmc: (atmci_tasklet_func) set completed xfer complete
> [   31.900000] atmel_mci fff84000.mmc: FSM: state=3
> [   31.900000] atmel_mci fff84000.mmc: FSM: not busy?
> [   33.900000] atmel_mci fff84000.mmc: software timeout
> [   33.900000] atmel_mci fff84000.mmc: FSM: state=5
> [   33.900000] atmel_mci fff84000.mmc: FSM: state=0
> 
> The driver uses PDC mode to perform the transfers, the chip version is
> 0x210. The data transferred in cmd53 is 4 bytes long.
> 
> It looks like the chip never sets the 'ATMCI_BLKE' flag.
> After the problem occured I observe this trace:
> [   37.650000] mmc_host mmc0: WARNING: IMR=0x00000008
> 
> The same wlan module on an at91sam9g45 (mci version: 0x410) in DMA mode
> works without problem.

Unfortunately I am aware of some issues with sdio modules and PDC mode
but I didn't have the time to correct it yet. I have done some fixes but
only for the DMA mode.

> 
> I also tested a Marvell 8385 (which uses the libertas driver) on
> at91sam9263 and it looks to work, I don't see any SDIO timeout.
> For this chip, the datasize sent is always >= 16 bytes.
> 

In fact I did some tests with Marvell 8686 and it works well but I have
recently heard about issues with other sdio wifi modules...

I will work on this topic as soon as possible.

> I'm wondering if the Errata "MMC data write operation with less than 12
> bytes is impossible.", mentionned in the sources (see function
> atmci_prepare_data()), also applies for this version of the chip?
> I didn't find this errata in the at91sam9263 datasheet...

>From the top of my head, I don't remember until which IP version this
errata applies. It only involves a controller reset.

> 
> If anyone has info or suggestions to make it work, please let me know.
> 

Regards

Ludovic

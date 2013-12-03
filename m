From: Olivier Sobrie <olivier@sobrie.be>
Subject: at91sam9263 sdio + wlan ti wl1271
Date: Tue, 3 Dec 2013 10:59:28 +0100
Message-ID: <20131203095652.GA1329@hposo>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:43581 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab3LCJ7j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Dec 2013 04:59:39 -0500
Received: by mail-ea0-f182.google.com with SMTP id o10so13168819eaj.13
        for <linux-mmc@vger.kernel.org>; Tue, 03 Dec 2013 01:59:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc@vger.kernel.org

Hi Ludovic,

I'm trying to use a wlan sdio TI wl1271 module with an at91sam9263
processor. The wlan card is correctly recognized by the kernel but
once the driver tries to initialize the card, then I observe sdio
timeouts.

I enabled the traces in the atmel-mci driver and here is what I see
when the problem occurs (kernel v3.11):

[   31.690000] atmel_mci fff84000.mmc: FSM: state=0
[   31.900000] atmel_mci fff84000.mmc: MRQ: cmd 53
[   31.900000] atmel_mci fff84000.mmc: start request: cmd 53
[   31.900000] atmel_mci fff84000.mmc: IRQ: tx buffer empty
[   31.900000] atmel_mci fff84000.mmc: (atmci_pdc_complete) set pending xfer complete
[   31.900000] atmel_mci fff84000.mmc: IRQ: cmd ready
[   31.900000] atmel_mci fff84000.mmc: set pending cmd rdy
[   31.900000] atmel_mci fff84000.mmc: FSM: state=1
[   31.900000] atmel_mci fff84000.mmc: FSM: cmd ready?
[   31.900000] atmel_mci fff84000.mmc: set completed cmd ready
[   31.900000] atmel_mci fff84000.mmc: command with data transfer
[   31.900000] atmel_mci fff84000.mmc: FSM: state=2
[   31.900000] atmel_mci fff84000.mmc: FSM: xfer complete?
[   31.900000] atmel_mci fff84000.mmc: (atmci_tasklet_func) set completed xfer complete
[   31.900000] atmel_mci fff84000.mmc: FSM: state=3
[   31.900000] atmel_mci fff84000.mmc: FSM: not busy?
[   33.900000] atmel_mci fff84000.mmc: software timeout
[   33.900000] atmel_mci fff84000.mmc: FSM: state=5
[   33.900000] atmel_mci fff84000.mmc: FSM: state=0

The driver uses PDC mode to perform the transfers, the chip version is
0x210. The data transferred in cmd53 is 4 bytes long.

It looks like the chip never sets the 'ATMCI_BLKE' flag.
After the problem occured I observe this trace:
[   37.650000] mmc_host mmc0: WARNING: IMR=0x00000008

The same wlan module on an at91sam9g45 (mci version: 0x410) in DMA mode
works without problem.

I also tested a Marvell 8385 (which uses the libertas driver) on
at91sam9263 and it looks to work, I don't see any SDIO timeout.
For this chip, the datasize sent is always >= 16 bytes.

I'm wondering if the Errata "MMC data write operation with less than 12
bytes is impossible.", mentionned in the sources (see function
atmci_prepare_data()), also applies for this version of the chip?
I didn't find this errata in the at91sam9263 datasheet...

If anyone has info or suggestions to make it work, please let me know.

Thanks,

-- 
Olivier

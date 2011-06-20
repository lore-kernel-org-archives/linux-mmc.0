From: Chris Ball <cjb@laptop.org>
Subject: Re: SDHCI I/O errors
Date: Mon, 20 Jun 2011 15:27:29 -0400
Message-ID: <m2y60wxpzy.fsf@bob.laptop.org>
References: <BANLkTik5wsSaLp_U1uCkoo5D68zBzH31PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50459 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344Ab1FTT1l (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jun 2011 15:27:41 -0400
In-Reply-To: <BANLkTik5wsSaLp_U1uCkoo5D68zBzH31PA@mail.gmail.com> (Andrew
	Lutomirski's message of "Mon, 20 Jun 2011 14:49:01 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: linux-mmc@vger.kernel.org

Hi Andy,

On Mon, Jun 20 2011, Andrew Lutomirski wrote:
> I have an SDHC card that works fine in a camera and in several
> different USB-based readers.  On my sdhci reader (the integrated one
> on a Lenovo X220), though, it spews stuff like:
>
> [  306.103556] mmcblk0: error -110 sending read/write command,
> response 0x0, card status 0x400b00
> [  306.103559] end_request: I/O error, dev mmcblk0, sector 410272
> [  306.103595] mmc0: Got data interrupt 0x00600000 even though no data
> operation was in progress.
> [  306.103597] sdhci: =========== REGISTER DUMP (mmc0)===========
> [  306.103602] sdhci: Sys addr: 0xf9253200 | Version:  0x00000502
> [  306.103607] sdhci: Blk size: 0x00007200 | Blk cnt:  0x00000001
> [  306.103613] sdhci: Argument: 0x000642a1 | Trn mode: 0x00000013
> [  306.103618] sdhci: Present:  0x01cf0000 | Host ctl: 0x00000003
> [  306.103623] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
> [  306.103628] sdhci: Wake-up:  0x00000000 | Clock:    0x00000107
> [  306.103634] sdhci: Timeout:  0x00000009 | Int stat: 0x00000000
> [  306.103639] sdhci: Int enab: 0x02ff00cb | Sig enab: 0x02ff00cb
> [  306.103644] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
> [  306.103649] sdhci: Caps:     0x21e8c8b2 | Caps_1:   0x00008073
> [  306.103654] sdhci: Cmd:      0x0000113a | Max curr: 0x00000040
> [  306.103655] sdhci: ===========================================
>
> all over the logs and fails some (but not all) attempts to read it.
> The startup messages are:
>
> [  830.308403] sdhci-pci 0000:0d:00.0: SDHCI controller found
> [1180:e823] (rev 4)
> [  830.308632] sdhci-pci 0000:0d:00.0: PCI INT A -> GSI 16 (level,
> low) -> IRQ 16
> [  830.308720] sdhci-pci 0000:0d:00.0: setting latency timer to 64
> [  830.308730] mmc0: no vmmc regulator found
> [  830.308802] Registered led device: mmc0::
> [  830.309059] mmc0: SDHCI controller on PCI [0000:0d:00.0] using DMA
>
> and lspci says:
>
> 0d:00.0 System peripheral: Ricoh Co Ltd Device e823 (rev 04)
>
> I see this on 2.6.39.1 and 3.0 git from today.

Any idea whether this is present in previous kernels too?  It'd be
great if you can test a few earlier ones and find out whether we're 
looking at a regression or just new hardware to add quirks for.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

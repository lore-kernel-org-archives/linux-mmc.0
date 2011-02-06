From: Chris Ball <cjb@laptop.org>
Subject: Re: [BUG] CMD52 sent as first command not CMD0
Date: Sun, 6 Feb 2011 00:38:45 +0000
Message-ID: <20110206003845.GA15019@void.printf.net>
References: <C85F98EE-B8C5-4037-A0FF-203265A7575C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33776 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab1BFAiu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 5 Feb 2011 19:38:50 -0500
Content-Disposition: inline
In-Reply-To: <C85F98EE-B8C5-4037-A0FF-203265A7575C@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Albert Herranz <albert_herranz@yahoo.es>

Hi Philip,

On Fri, Feb 04, 2011 at 02:53:59PM -0800, Philip Rakity wrote:
> using mmc-next -- NO changes -- last checkin was from linux Jan 26
[..]
> [    2.034998] mmc0: starting CMD52 arg 00000c00 flags 00000195
> [    2.052704] Waiting 15sec before mounting root device...
> [    2.068948] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.087707] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
> [    2.109069] mmc0: starting CMD52 arg 80000c08 flags 00000195
> [    2.126291] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
> [    2.145002] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
> [    2.166321] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
> [    2.190178] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [    2.206971] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> [    2.225689] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000

This looks to be intentional, and dates back to:

commit 516a82422209e078345d0ca54b16793d7bfd4782
Author: Albert Herranz <albert_herranz@yahoo.es>
Date:   Wed Mar 10 15:20:37 2010 -0800

    sdio: recognize io card without powercycle
    
    SDIO Simplified Specification V2.00 states that it is strongly recommended
    that the host executes either a power reset or issues a CMD52 (I/O Reset)
    to re-initialize an I/O only card or the I/O portion of a combo card.
    Additionally, the CMD52 must be issued first because it cannot be issued
    after a CMD0.
    
    With this patch the Nintendo Wii SDIO-based WLAN card is detected after a
    system reset, without requiring a complete system powercycle.

Are you seeing any negative effects from running the CMD52 before CMD0?

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

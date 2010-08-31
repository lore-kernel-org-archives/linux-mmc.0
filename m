From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v2] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Tue, 31 Aug 2010 19:51:11 +0900
Message-ID: <AANLkTimCyCVmFS4nxqZTc4S9E2LmeJGGUmkTSoMcrM9n@mail.gmail.com>
References: <6c0f551ff67fb9f67f4b565fbe4ffdc1f4c8bc49.1283164379.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60444 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab0HaKvM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2010 06:51:12 -0400
Received: by qyk36 with SMTP id 36so719563qyk.19
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2010 03:51:11 -0700 (PDT)
In-Reply-To: <6c0f551ff67fb9f67f4b565fbe4ffdc1f4c8bc49.1283164379.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Arnd Hannemann <arnd@arndnet.de>, Samuel Ortiz <sameo@linux.intel.com>, Ian Molton <ian@mnementh.co.uk>

Hi Matt,

On Mon, Aug 30, 2010 at 7:50 PM, Matt Fleming <matt@console-pimps.org> wrote:
> From: Yusuke Goda <yusuke.goda.sx@renesas.com>
>
> Adjust the tmio_mmc block size check to accept 2-byte requests in 4-bit
> mode if the hardware supports it.
>
> Tested with the SDHI hardware block included in sh7724.
>
> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---

So I've just tested this on AP4EVB with a b43 SDIO card.

Without this patch I get the following:
...
mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
mmc0: queuing unknown CIS tuple 0x80 (5 bytes)
mmc0: queuing unknown CIS tuple 0x80 (9 bytes)
mmc0: new SDIO card at address 0001
b43-sdio mmc0:0001:1: Chip ID 14e4:4318
ssb: Core 0 found: ChipCommon (cc 0x800, rev 0x0D, vendor 0x4243)
ssb: Core 1 found: IEEE 802.11 (cc 0x812, rev 0x09, vendor 0x4243)
ssb: Core 2 found: PCI (cc 0x804, rev 0x0C, vendor 0x4243)
ssb: Core 3 found: PCMCIA (cc 0x80D, rev 0x07, vendor 0x4243)
rtc-rs5c372 1-0032: hctosys: unable to read the hardware clock
b43-phy0: Broadcom 4318 WLAN found (core revision 9)
Freeing init memory: 2864K
mmc0: 2 byte block unsupported in 4 bit mode
b43-phy0 ERROR: FOUND UNSUPPORTED PHY (Analog 15, Type 15, Revision 255)
b43: probe of ssb0:0 failed with error -95
ssb: Sonics Silicon Backplane found on SDIO device mmc0:0001:1


With patch applied:
...
mmc0: queuing unknown CIS tuple 0x80 (3 bytes)
mmc0: queuing unknown CIS tuple 0x80 (5 bytes)
mmc0: queuing unknown CIS tuple 0x80 (9 bytes)
mmc0: new SDIO card at address 0001
b43-sdio mmc0:0001:1: Chip ID 14e4:4318
ssb: Core 0 found: ChipCommon (cc 0x800, rev 0x0D, vendor 0x4243)
ssb: Core 1 found: IEEE 802.11 (cc 0x812, rev 0x09, vendor 0x4243)
ssb: Core 2 found: PCI (cc 0x804, rev 0x0C, vendor 0x4243)
ssb: Core 3 found: PCMCIA (cc 0x80D, rev 0x07, vendor 0x4243)
rtc-rs5c372 1-0032: hctosys: unable to read the hardware clock
b43-phy0: Broadcom 4318 WLAN found (core revision 9)
Freeing init memory: 2864K
phy0: Selected rate control algorithm 'minstrel_ht'
ssb: Sonics Silicon Backplane found on SDIO device mmc0:0001:1


This patch is one step closer toward using the b43 driver on SDHI
hardware with polled SDIO.

Acked-by: Magnus Damm <damm@opensource.se>

Thanks!

/ magnus

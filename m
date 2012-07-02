From: Roland Stigge <stigge@antcom.de>
Subject: Re: mmci.c regression
Date: Mon, 02 Jul 2012 16:08:56 +0200
Message-ID: <4FF1AB78.5020901@antcom.de>
References: <4FF190A2.6@antcom.de> <20120702130757.GH16319@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:55980 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838Ab2GBOJA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Jul 2012 10:09:00 -0400
In-Reply-To: <20120702130757.GH16319@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, cjb@laptop.org, Alexandre Pereira da Silva <aletes.xgr@gmail.com>

On 07/02/2012 03:07 PM, Russell King - ARM Linux wrote:
> On Mon, Jul 02, 2012 at 02:14:26PM +0200, Roland Stigge wrote:
>> Hi,
>>
>> I'm getting a strange regression with mmci.c at v3.5-rc4 -> v3.5-rc5: Bootup:
>>[...]
> 
> Nothing changed with the mmci driver between these two, but there is this
> change:
> 
> commit d380443cd0271903bf9516bc04cead81676be034
> Author: Subhash Jadavani <subhashj@codeaurora.org>
> Date:   Wed Jun 13 17:10:43 2012 +0530
> 
>     mmc: block: fix the data timeout issue with ACMD22
> 
> You could try reverting that and seeing whether that fixes it, otherwise
> it's going to have to be a git bisect.
> 
> There's three things that would cause an -EIO error:
> 
> 1. if DMA is being used, and there is data left in the FIFO after the DMA
>    has allegedly completed.
> 2. an underrun on sending data to the card (you're trying to receive so
>    this doesn't apply)
> 3. an overrun on receiving data from the card (eg, the PIO interrupt handling
>    is not fast enough to keep up with the data coming off the card.)
> 
> I suspect (3) is your problem, and finding out what caused that is
> definitely going to be a matter for bisect - and this will probably be
> where you'd probably end up wishing that running all IRQ handlers
> exclusively wasn't done now.

Reverting the above commit didn't fix it. But your point about exclusive
interrupt handling is correct. As I'm posting below, the actual boot
log shows some usb messages interspersed in v3.5-rc5, which wasn't this way in
v3.5-rc4.

Indeed, disabling USB (just via dt) fixes the problem.

What would be the next logical step? Optimizing USB interrupt handling?
Serializing driver initialization on bootup somehow?

Thanks in advance!

And sorry for oversimplifying my initial report. ;-)

Roland


mmci-pl18x 20098000.sd: mmc0: PL180 manf 41 rev0 at 0x20098000 irq 15,13 (pio)
mmci-pl18x 20098000.sd: no DMA platform data
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 1 part 10 variant 9 rev 1
ssp-pl022 dev:ssp0: ARM PL022 driver, device ID: 0x00041022
rtc-lpc32xx 40024000.rtc: setting system clock to 1970-01-01 02:03:27 UTC (7407)
pl022: mapped registers from 0x20084000 to f2084000
at25 spi0.0: 32 KByte at25 eeprom, pagesize 64
mmc0: new SD card at address bd34
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
mmcblk0: mmc0:bd34 SD02G 1.83 GiB (ro)
     device=eth0, addr=192.168.32.44, mask=255.255.255.0, gw=255.255.255.255
     host=192.168.32.44, domain=, nis-domain=(none)
ISP1301 Vendor ID  : 0x04cc
     bootserver=255.255.255.255, rootserver=192.168.32.2, rootpath=
mmcblk0: error -110 sending status command, retrying
ISP1301 Product ID : 0x1301
ALSA device list:
mmcblk0: error -5 transferring data, sector 0, nr 8, cmd response 0x0, card status 0x900
mmcblk0: retrying using single block read
  No soundcards found.
ISP1301 Version ID : 0x0210
usb-ohci 31020000.ohci: at 0xf3120000, irq 0
usb-ohci 31020000.ohci: nxp OHCI
usb-ohci 31020000.ohci: new USB bus registered, assigned bus number 1
usb-ohci 31020000.ohci: irq 59, io mem 0x31020000
mmcblk0: error -5 transferring data, sector 0, nr 8, cmd response 0x0, card status 0x0
end_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on device mmcblk0, logical block 0
 mmcblk0: unable to read partition table
hub 1-0:1.0: USB hub found

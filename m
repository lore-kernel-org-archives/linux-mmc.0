From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: mmc0: Unexpected interrupt 0x04000000.
Date: Thu, 11 Jan 2018 11:12:16 +0200
Message-ID: <855b95e1-9baf-bcdd-784d-ad9770818040@intel.com>
References: <CA+7wUsyhKhGCHE5QEZ=dt2-v1sTQZpW38Gf2_wOmwJFHoJWNGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14530 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932566AbeAKJMt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Jan 2018 04:12:49 -0500
In-Reply-To: <CA+7wUsyhKhGCHE5QEZ=dt2-v1sTQZpW38Gf2_wOmwJFHoJWNGA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/01/18 14:44, Mathieu Malaterre wrote:
> Hi there,
> 
> I am trying to get sdhci-pci driver to work with the following hardware:
> 
> $ sudo lspci -s 03:00.1 -v -nn
> 03:00.1 SD Host controller [0805]: Broadcom Limited BCM57765/57785
> SDXC/MMC Card Reader [14e4:16bc] (rev 10) (prog-if 01)
> Subsystem: Broadcom Limited BCM57765/57785 SDXC/MMC Card Reader [14e4:96bc]
> Flags: bus master, fast devsel, latency 0, IRQ 17
> Memory at c1820000 (64-bit, prefetchable) [size=64K]
> Capabilities: [48] Power Management version 3
> Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
> Capabilities: [ac] Express Endpoint, MSI 00
> Capabilities: [100] Advanced Error Reporting
> Capabilities: [150] Power Budgeting <?>
> Capabilities: [160] Virtual Channel
> Kernel driver in use: sdhci-pci
> Kernel modules: sdhci_pci
> 
> I am using a MacBookPro10,1. I cannot get the driver to work when
> using a SDHC Samsung Evo 16GB (placed inside a card reader), it always
> report the following (1).
> 
> If I now place the card onto a USB reader (USB-HUB reader) then
> everything is fine (tested using f3: f3probe). Are there any options I
> can switch to make the driver more tolerant with my hardware ?
> 
> Thanks
> 
> Current system is Debian stable with kernel 4.14 (backport), modinfo returns:
> 
> $ /sbin/modinfo sdhci-pci
> filename:
> /lib/modules/4.14.0-0.bpo.2-amd64/kernel/drivers/mmc/host/sdhci-pci.ko
> license:        GPL
> description:    Secure Digital Host Controller Interface PCI driver
> author:         Pierre Ossman <pierre@ossman.eu>
> alias:          pci:v*d*sv*sd*bc08sc05i*
> alias:          pci:v00001022d*sv*sd*bc08sc05i*
> alias:          pci:v00001217d00008621sv*sd*bc*sc*i*
> alias:          pci:v00001217d00008620sv*sd*bc*sc*i*
> alias:          pci:v00001217d00008421sv*sd*bc*sc*i*
> alias:          pci:v00001217d00008420sv*sd*bc*sc*i*
> (...)
> alias:          pci:v00001524d00000551sv*sd*bc*sc*i*
> alias:          pci:v00001524d00000550sv*sd*bc*sc*i*
> alias:          pci:v00001180d0000E823sv*sd*bc*sc*i*
> alias:          pci:v00001180d0000E822sv*sd*bc*sc*i*
> alias:          pci:v00001180d00000843sv*sd*bc*sc*i*
> alias:          pci:v00001180d00000822sv*sd*bc*sc*i*
> depends:        sdhci,mmc_core
> intree:         Y
> name:           sdhci_pci
> vermagic:       4.14.0-0.bpo.2-amd64 SMP mod_unload modversions
> 
> 
> (1)
> [  220.210842] mmc0: Tuning timeout, falling back to fixed sampling clock
> [  220.210934] mmc0: new ultra high speed DDR50 SDHC card at address 59b4
> [  220.219075] mmcblk0: mmc0:59b4 00000 14.9 GiB
> [  230.362858] mmc0: Timeout waiting for hardware interrupt.
> [  230.362868] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  230.362918] mmc0: sdhci: Sys addr:  0x000000c8 | Version:  0x00001502
> [  230.362927] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
> [  230.362937] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0000003b
> [  230.362946] mmc0: sdhci: Present:   0x1fff0000 | Host ctl: 0x0000001f
> [  230.362955] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [  230.362964] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> [  230.362974] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
> [  230.362982] mmc0: sdhci: Int enab:  0x02ff008b | Sig enab: 0x02ff008b
> [  230.362992] mmc0: sdhci: AC12 err:  0x00000010 | Slot int: 0x00000000
> [  230.363001] mmc0: sdhci: Caps:      0x176ec8b0 | Caps_1:   0x03002177
> [  230.363011] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
> [  230.363020] mmc0: sdhci: Resp[0]:   0x00001201 | Resp[1]:  0x00000000
> [  230.363029] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> [  230.363035] mmc0: sdhci: Host ctl2: 0x0000804c
> [  230.363047] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x0000000457940204
> [  230.363049] mmc0: sdhci: ============================================
> [  230.363119] mmc0: Unexpected interrupt 0x04000000.

Tuning error presumably because it used fixed sampling because tuning
failed.  Strange considering that interrupt is not enabled.

If you can't get tuning to work, you may need to disable the transfer modes
that require tuning.


> [  230.363128] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  230.363157] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00001502
> [  230.363166] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
> [  230.363174] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000033
> [  230.363184] mmc0: sdhci: Present:   0x1fff0001 | Host ctl: 0x0000001f
> [  230.363193] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [  230.363203] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> [  230.363214] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
> [  230.363225] mmc0: sdhci: Int enab:  0x02ff008b | Sig enab: 0x02ff008b
> [  230.363234] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
> [  230.363244] mmc0: sdhci: Caps:      0x176ec8b0 | Caps_1:   0x03002177
> [  230.363253] mmc0: sdhci: Cmd:       0x00000c1a | Max curr: 0x00000000
> [  230.363263] mmc0: sdhci: Resp[0]:   0x00001201 | Resp[1]:  0x00000000
> [  230.363272] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> [  230.363278] mmc0: sdhci: Host ctl2: 0x0000800c
> [  230.363292] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x0000000457940204
> [  230.363294] mmc0: sdhci: ============================================
> [  230.363509] mmcblk0: error -110 sending stop command, original cmd
> response 0x0, card status 0x400900
> 


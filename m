From: Philip Rakity <prakity@marvell.com>
Subject: RFC:  Ricoh Controller sd
Date: Wed, 2 Nov 2011 05:10:53 -0700
Message-ID: <45FA27B2-1769-47BD-999B-58CA09F8A5BA@marvell.com>
References: <04757B09-064A-4E08-878C-15C2171B2299@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:58804 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752375Ab1KBMXe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Nov 2011 08:23:34 -0400
In-Reply-To: <04757B09-064A-4E08-878C-15C2171B2299@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Bing Zhao <bzhao@marvell.com>, "Arindam.Nath@amd.com Nath" <arindam.nath@amd.com>, Aaron Lu <Aaron.Lu@amd.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>


Folks,

We are working on some changes to support SDR50 and SDR104 for SDIO cards.  The code works on some controllers but not
on the ricoh r5c822.  The system is 64-bit Fedora 11 x86 with PCI-to-SD adapter card (Ricoh controller).
DMI: Hewlett-Packard HP Compaq dx2200 MT /0A48, BIOS MS7254 1.05 08/14/2006


The trace shows:

mmc0: no vmmc regulator found
Registered led device: mmc0::
mmc0: SDHCI controller on PCI [0000:03:00.0] using DMA
mmc_attach_sdio:mmc0 ocr = B1FF8000
mmc_attach_sdio:mmc0 R4_18V_PRESENT = 01000000, v18 = 1
mmc_sdio_init_card:mmc0 ocr = B1300000
mmc_sdio_init_card:mmc0: mmc_set_signal_voltage ret = 0
mmc0: error -110 whilst initialising SDIO card
mmc_attach_sdio:mmc0 ocr = 31FF8000
mmc_attach_sdio:mmc0 R4_18V_PRESENT = 01000000, v18 = 1
mmc_sdio_init_card:mmc0 ocr = B1300000
mmc_sdio_init_card:mmc0: mmc_set_signal_voltage ret = 0
mmc0: error -110 whilst initialising SDIO card
mmc_attach_sdio:mmc0 ocr = 31FF8000
mmc_attach_sdio:mmc0 R4_18V_PRESENT = 01000000, v18 = 1
mmc_sdio_init_card:mmc0 ocr = B1300000
mmc_sdio_init_card:mmc0: mmc_set_signal_voltage ret = 0
mmc0: error -110 whilst initialising SDIO card
mmc_attach_sdio:mmc0 ocr = 31FF8000
mmc_attach_sdio:mmc0 R4_18V_PRESENT = 01000000, v18 = 1
mmc_sdio_init_card:mmc0 ocr = B1300000
mmc_sdio_init_card:mmc0: mmc_set_signal_voltage ret = 0
mmc0: error -110 whilst initialising SDIO card
EXT4-fs (dm-0): re-mounted. Opts: (null)

We have narrowed this down to the sending of the CMD11.  If this is NOT done the the ultra high speed card works.
CMD11 is required for signal voltage switching.

The register dump from the host controller:

sdhci-pci 0000:03:00.0: SDHCI controller found [1180:0822] (rev 22)


[    2.030053] mmc1: SDHCI controller on PCI [0000:02:05.0] using ADMA
[    2.030187] sdhci: =========== REGISTER DUMP (mmc1)===========
[    2.030268] sdhci: Sys addr: 0x00000000 | Version:  0x00001002
[    2.030342] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    2.030425] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[    2.030503] sdhci: Present:  0x01ff0000 | Host ctl: 0x00000004
[    2.030589] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[    2.030668] sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
[    2.030753] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[    2.030832] sdhci: Int enab: 0x00ff0083 | Sig enab: 0x00ff0083
[    2.030917] sdhci: AC12 err: 0x00000000 | Slot int: 0x000000ff
[    2.030996] sdhci: Caps:     0x31fe32b2 | Caps_1:   0x00030503
[    2.031082] sdhci: Cmd:      0x00000000 | Max curr: 0x00c80064
[    2.031158] sdhci: Host ctl2: 0x00000000
[    2.031242] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
[    2.031315] sdhci: ===========================================


This shows that the controller is V3 and does support SDR50 and SDR104.

We can hack our way around this by adding a quirk to sdhci-pci.c for the controller to disable sending CMD11 

something along the lines of 
#define SDHCI_QUIRK_NO_VOLTAGE_SIGNAL_CMD11_SUPPORT

and check in core.c (mmc_set_signal_voltage()).  and just not send the CMD11.

very ugly.

Any other suggestions ?



Philip




On Nov 1, 2011, at 3:52 PM, Philip Rakity wrote:

> 
> Chris,
> 
> Testing my SDIO 3.0 changes UHS mode 100 m/bps   Code works find on MMP2.
> 
> Using the system
>> 64-bit Fedora 11 x86 with PCI-to-SD adapter card (Ricoh controller).
> 
> The code fails.  Bing found that if CMD11 is sent when doing the voltage switch timeout errors (-110) occur.
> If CMD11 is not sent then everything. works.   Unfortunately CMD11 is required.  No error is returned when the CMD11 is sent.
> 
> I know there are some quirks for the controller in sdhci-pci.  
> 
> Any ideas who to ask about this if you do not know the answer ?
> 
> regards,
> 
> Philip
> 


From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 15656] New: System sluggish when using ENE SD
 card reader
Date: Thu, 1 Apr 2010 15:30:35 -0700
Message-ID: <20100401153035.8668b681.akpm@linux-foundation.org>
References: <bug-15656-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55155 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756677Ab0DAWbQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2010 18:31:16 -0400
In-Reply-To: <bug-15656-10286@https.bugzilla.kernel.org/>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, theholyettlz@googlemail.com


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed, 31 Mar 2010 11:09:28 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=15656
> 
>            Summary: System sluggish when using ENE SD card reader
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.33 and earlier
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: MMC/SD
>         AssignedTo: drivers_mmc-sd@kernel-bugs.osdl.org
>         ReportedBy: theholyettlz@googlemail.com
>         Regression: No
> 
> 
> My system becomes incredibly sluggish (jerky X cursor, choppy audio) when
> accessing an SD card with my notebook's built-in ENE card reader. The kernel
> was compiled with full pre-emption enabled.
> 
> >From lspci -nn:
> 
> 
> 0c:07.0 FLASH memory [0501]: ENE Technology Inc ENE PCI Memory Stick Card
> Reader Controller [1524:0730]
> 0c:07.1 SD Host controller [0805]: ENE Technology Inc ENE PCI SmartMedia / xD
> Card Reader Controller [1524:0750]
> 0c:07.3 FLASH memory [0501]: ENE Technology Inc ENE PCI Secure Digital / MMC
> Card Reader Controller [1524:0751]
> 
> 
> >From dmesg|grep sdhci,
> 
> 
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pci 0000:0c:07.1: SDHCI controller found [1524:0750] (rev 0)
> sdhci-pci 0000:0c:07.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> sdhci-pci 0000:0c:07.3: SDHCI controller found [1524:0751] (rev 0)
> sdhci-pci 0000:0c:07.3: enabling device (0000 -> 0002)
> sdhci-pci 0000:0c:07.3: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> sdhci-pci 0000:0c:07.3: PCI INT A disabled
> sdhci-pci 0000:0c:07.1: PCI INT A disabled
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0xf (was 0x482001ff,
> writing 0x48200105)
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0x4 (was 0x0, writing
> 0xf0f00400)
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0x3 (was 0x800000,
> writing 0x802010)
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0x1 (was 0x2100000,
> writing 0x2100106)
> sdhci-pci 0000:0c:07.3: restoring config space at offset 0x4 (was 0x0, writing
> 0xf0f00100)
> sdhci-pci 0000:0c:07.3: restoring config space at offset 0x1 (was 0x2100000,
> writing 0x2100002)
> sdhci-pci 0000:0c:07.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> sdhci-pci 0000:0c:07.3: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> sdhci-pci 0000:0c:07.3: PCI INT A disabled
> sdhci-pci 0000:0c:07.1: PCI INT A disabled
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0xf (was 0x482001ff,
> writing 0x48200105)
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0x4 (was 0x0, writing
> 0xf0f00400)
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0x3 (was 0x800000,
> writing 0x802010)
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0x1 (was 0x2100000,
> writing 0x2100106)
> sdhci-pci 0000:0c:07.3: restoring config space at offset 0x4 (was 0x0, writing
> 0xf0f00100)
> sdhci-pci 0000:0c:07.3: restoring config space at offset 0x1 (was 0x2100000,
> writing 0x2100002)
> sdhci-pci 0000:0c:07.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> sdhci-pci 0000:0c:07.3: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> sdhci-pci 0000:0c:07.3: PCI INT A disabled
> sdhci-pci 0000:0c:07.1: PCI INT A disabled
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0xf (was 0x482001ff,
> writing 0x48200105)
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0x4 (was 0x0, writing
> 0xf0f00400)
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0x3 (was 0x800000,
> writing 0x802010)
> sdhci-pci 0000:0c:07.1: restoring config space at offset 0x1 (was 0x2100000,
> writing 0x2100106)
> sdhci-pci 0000:0c:07.3: restoring config space at offset 0x4 (was 0x0, writing
> 0xf0f00100)
> sdhci-pci 0000:0c:07.3: restoring config space at offset 0x1 (was 0x2100000,
> writing 0x2100002)
> sdhci-pci 0000:0c:07.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> sdhci-pci 0000:0c:07.3: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> 
> 
> and finally dmesg|grep mmc:
> 
> 
> sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
> Registered led device: mmc0::
> mmc0: SDHCI controller on PCI [0000:0c:07.1] using PIO
> Registered led device: mmc1::
> mmc1: SDHCI controller on PCI [0000:0c:07.3] using PIO
> mmc1: new high speed SDHC card at address 0007
> mmcblk0: mmc1:0007 SD16G 15.0 GiB 
>  mmcblk0: p1
> SELinux: initialized (dev mmcblk0p1, type vfat), uses genfs_contexts
> mmc1: card 0007 removed
> 


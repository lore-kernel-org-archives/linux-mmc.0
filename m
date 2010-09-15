From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 18602] New: mmc_block / tifm_sd not completely
 registering when a new sd card is inserted
Date: Wed, 15 Sep 2010 12:38:54 -0700
Message-ID: <20100915123854.e36e432c.akpm@linux-foundation.org>
References: <bug-18602-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44863 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753328Ab0IOTkD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2010 15:40:03 -0400
In-Reply-To: <bug-18602-10286@https.bugzilla.kernel.org/>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, pioto@pioto.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed, 15 Sep 2010 13:48:30 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=18602
> 
>            Summary: mmc_block / tifm_sd not completely registering when a
>                     new sd card is inserted
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.35.4
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: MMC/SD
>         AssignedTo: drivers_mmc-sd@kernel-bugs.osdl.org
>         ReportedBy: pioto@pioto.org
>         Regression: No
> 
> 
> After I insert an SD card once after booting, mount it, unmount it, then pop
> out the card, if I try to insert the card again, the /dev/mmcblk* devices do
> not show again. I have to unload the mmc_block and tifm_sd (and mmc_core)
> modules, then reload them, in order for the device node to apear again. I don't
> think this was always the case, but I can't remember the specific version that
> this problem first occurred.
> 
> On the first insertion cycle, dmsg looks like this:
> 
>   [204702.558153] tifm_core: MMC/SD card detected in socket 0:1
>   [204702.834915] mmc0: new SD card at address 4f9a
>   [204702.878743] mmcblk0: mmc0:4f9a SD02G 1.83 GiB 
>   [204702.878802]  mmcblk0: p1
>   # ... do stuff with the card
>   [204908.381864] tifm0 : demand removing card from socket 0:1
>   [204908.381936] mmc0: card 4f9a removed
> 
>   # now, insert the card again
>   [204913.581176] tifm_core: MMC/SD card detected in socket 0:1
>   # and remove it again
>   [204926.188570] tifm0 : demand removing card from socket 0:1
> 
> lspci identifies my SD card reader as:
> 
>   0f:06.3 SD Host controller: Texas Instruments PCIxx12 SDA Standard Compliant
> SD Host Controller
> 
> Any advice would be appreciated. Thanks.
> 


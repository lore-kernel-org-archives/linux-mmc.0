From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 15876] New: MMC initialisation: valid devices
 fail to init due to frequency check
Date: Fri, 21 May 2010 14:48:51 -0700
Message-ID: <20100521144851.d8c4342e.akpm@linux-foundation.org>
References: <bug-15876-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40313 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755483Ab0EUVtg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 May 2010 17:49:36 -0400
In-Reply-To: <bug-15876-10286@https.bugzilla.kernel.org/>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, nick@leverton.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Thu, 29 Apr 2010 10:26:39 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=15876
> 
>            Summary: MMC initialisation: valid devices fail to init due to
>                     frequency check
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.31
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Flash/Memory Technology Devices
>         AssignedTo: dwmw2@infradead.org
>         ReportedBy: nick@leverton.org
>         Regression: Yes
> 
> 
> I have a commercially available development board with MMC card socket (Atmel
> ATSTK1006 with AP7000).  Prior to 2.6.31 this board could successfully
> initialise and use MMC cards.  Since the minimum frequency enforcement to 400
> KHz was added in commit 8dfd0374be84793360db7fff2e635d2cd3bbcb21, this board
> can no longer detect MMC cards.
> 
> Thanks to the following diagnostic patch: http://lkml.org/lkml/2010/1/4/291  I
> narrowed down the frequency range supported by this board.  The host->f_min
> here is 136719 Hz.
> 
> atmel_mci atmel_mci.0: Atmel MCI controller at 0xfff02400 irq 28, 1 slots
>  mmc_rescan: trying 400000 Hz
>  Waiting for root device /dev/mmcblk0p1...
>  mmc_rescan: trying 300000 Hz
>  mmc_rescan: trying 200000 Hz
>  mmc_rescan: trying 136719 Hz
>  mmc0: host does not support reading read-only switch. assuming 
> write-enable.
>  mmc0: new SD card at address 8fe4
>  mmcblk0: mmc0:8fe4 SD02G 1.84 GiB
> 
> I understand that the MMC spec allows frequency ranges between about 400 KHZ
> and 138 KHz.  It seems that enforcing the minimum frequency to be the highest
> from the specification is causing the problem and causes an otherwise
> within-spec device such as this to fail to initialise.
> 
> Other AVR32/AP7000 boards such as NGW100 seem OK with the same cards (Sandisk
> 2Gb) by the way and do work at full speed.  It seems it may be due to this
> particular board layout that, although just about within spec, it is limited to
> the lower end of the range.
> 
> Could I please ask the MMC people to re-visit this frequency check issue ?  I'm
> opening this bug as a marker, thank you :)
> 


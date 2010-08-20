From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [Bugme-new] [Bug 16627] New: sdhci shows backtrace while
 resuming after s2disk
Date: Fri, 20 Aug 2010 10:27:26 +0300
Message-ID: <1282289246.4600.9.camel@maxim-laptop>
References: <bug-16627-10286@https.bugzilla.kernel.org/>
	 <20100819154539.31c4e6b9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65448 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab0HTH1c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2010 03:27:32 -0400
Received: by bwz11 with SMTP id 11so1869784bwz.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2010 00:27:31 -0700 (PDT)
In-Reply-To: <20100819154539.31c4e6b9.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, pfactum@gmail.com, David Woodhouse <dwmw2@infradead.org>

On Thu, 2010-08-19 at 15:45 -0700, Andrew Morton wrote: 
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Thu, 19 Aug 2010 10:01:14 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=16627
> > 
> >            Summary: sdhci shows backtrace while resuming after s2disk
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 2.6.35.2
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: MMC/SD
> >         AssignedTo: drivers_mmc-sd@kernel-bugs.osdl.org
> >         ReportedBy: pfactum@gmail.com
> >         Regression: No
> > 
> > 
> > Created an attachment (id=27506)
> >  --> (https://bugzilla.kernel.org/attachment.cgi?id=27506)
> > config, lspci and dmesg
> > 
> > The following strings appear in dmesg after resuming:
> > 
> > ===
> > [  199.151739] Call Trace:
> > [  199.151749]  [<c1073734>] ? __report_bad_irq+0x24/0x90
> > [  199.151753]  [<c10738f0>] ? note_interrupt+0x150/0x190
> > [  199.151757]  [<c10751f1>] ? move_native_irq+0x11/0x50
> > [  199.151762]  [<c107413b>] ? handle_fasteoi_irq+0xab/0xd0
> > [  199.151765]  [<c1074090>] ? handle_fasteoi_irq+0x0/0xd0
> > [  199.151768]  <IRQ>  [<c1004657>] ? do_IRQ+0x47/0xc0
> > [  199.151775]  [<c10030e9>] ? common_interrupt+0x29/0x30
> > [  199.151780]  [<c103007b>] ? __sched_setscheduler+0x26b/0x400
> > [  199.151786]  [<c122f581>] ? acpi_idle_enter_c1+0x9d/0xb2
> > [  199.151792]  [<c135e586>] ? cpuidle_idle_call+0x76/0xe0
> > [  199.151795]  [<c1001bef>] ? cpu_idle+0x3f/0x90
> > [  199.151800]  [<c15ee8d7>] ? start_kernel+0x2e9/0x2ee
> > [  199.151804]  [<c15ee42c>] ? unknown_bootoption+0x0/0x190
> > [  199.151806] handlers:
> > [  199.151808] [<f8bfac50>] (r852_irq+0x0/0x250 [r852])
> > [  199.151820] [<c136a080>] (sdhci_irq+0x0/0x570)
> 
> Both r852_irq() and sdhci_irq() are on that IRQ so the interrupt could
> have been for either one.
> 
> 
> > ===
> > ...
> > ===
> > [  208.256014] mmc0: Timeout waiting for hardware interrupt.
> > [  208.256019] sdhci: ============== REGISTER DUMP ==============
> > [  208.256025] sdhci: Sys addr: 0x00000000 | Version:  0x00000400
> > [  208.256030] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
> > [  208.256035] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
> > [  208.256040] sdhci: Present:  0x01f70000 | Host ctl: 0x00000001
> > [  208.256044] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
> > [  208.256049] sdhci: Wake-up:  0x00000000 | Clock:    0x00004007
> > [  208.256054] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
> > [  208.256058] sdhci: Int enab: 0x00ff00c3 | Sig enab: 0x00ff00c3
> > [  208.256063] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000001
> > [  208.256068] sdhci: Caps:     0x00c02120 | Max curr: 0x00000040
> > [  208.256070] sdhci: ===========================================
> > ===

This sounds a lot like what I had with CONFIG_MMC_RICOH_MMC enabled.

This doesn't happen very often I guess, right?
Also I guess that you loose SDHCI completely and if you reload it
(sudo modprobe -r sdhci-pci && sudo modprobe sdhci-pci), it won't load
telling you in kernel log that 'Hardware doesn't support any voltages'

If you can recompile kernel, try to disable CONFIG_MMC_RICOH_MMC
(This will make you loose the mmc support, but if you get 2.6.36-rc1,
you will get mmc support anyway via the non standard mmc controller,
which turned out to be almost standard SDHCI controller.)

Btw, I have written full support for memstick portion as well,
I have just posted patches on LKML, and I have a bit outdated version on
launchpad.
Therefore this is the first fully supported by Linux card reader.


Best regards,
Maxim Levitsky


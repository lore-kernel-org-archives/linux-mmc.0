From: Bringfried Stecklum <stecklum@tls-tautenburg.de>
Subject: Re: 2.36.1 sdhci R5C822 regression
Date: Sat, 18 Dec 2010 19:37:34 +0000 (UTC)
Message-ID: <loom.20101218T203354-286@post.gmane.org>
References: <4D0B380C.4000407@tls-tautenburg.de> <20101217153024.GA26910@void.printf.net> <4D0BA461.6050803@tls-tautenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59591 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932100Ab0LRTkF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Dec 2010 14:40:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1PU2dP-000222-So
	for linux-mmc@vger.kernel.org; Sat, 18 Dec 2010 20:40:03 +0100
Received: from i5E86D697.versanet.de ([94.134.214.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 18 Dec 2010 20:40:03 +0100
Received: from stecklum by i5E86D697.versanet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 18 Dec 2010 20:40:03 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I just tried with the irqpoll option which prevents the kernel oops indeed
(unlike without the patch) but I still get the timeout waiting for hardware
interrupt message. The number of irqs seems to be exceedingly high, e.g.
 
cat /proc/interrupts 
           CPU0       CPU1       
  0:      20239       2789   IO-APIC-edge      timer
  1:         84          2   IO-APIC-edge      i8042
  8:          0          1   IO-APIC-edge      rtc0
  9:          0          1   IO-APIC-fasteoi   acpi
 12:        181         73   IO-APIC-edge      i8042
 14:       1431        340   IO-APIC-edge      ata_piix
 15:          0          0   IO-APIC-edge      ata_piix
 16:          0          0   IO-APIC-fasteoi   pata_jmicron
 18:     933200          0   IO-APIC-fasteoi   r852, mmc0
...


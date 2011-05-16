From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: tmio: Fix race condition resulting in spurious
 interrupts
Date: Mon, 16 May 2011 23:59:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105162353450.29373@axis700.grange>
References: <753789.33501.qm@web29017.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58366 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab1EPV7W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2011 17:59:22 -0400
In-Reply-To: <753789.33501.qm@web29017.mail.ird.yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk

On Mon, 16 May 2011, Paul Parsons wrote:

> > I wouldn't call this a "race."
> 
> If the hardware sets the next status bit before the interrupt handler 
> reaches the bottom of the loop, then the loop repeats, and the 
> subsequent interrupt is reported as spurious.
> 
> If the interrupt handler reaches the bottom of the loop before the 
> hardware sets the next status bit, then the handler returns, and the 
> subsequent interrupt is handled normally.
> 
> Thus the handler is racing the hardware.
> 
> > Sorry, don't understand. Isn't a spurious interrupt
> > reported per "nobody 
> > cared" if an ISR returns IRQ_NONE? And the TMIO ISR never
> > does this. Is 
> > the IRQ number, reported as spurious, that of TMIO? Is it
> > shared?
> 
> tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000

Aha, ok, that's a different one, sorry. Also interesting, that the kernel 
is failing to disable it... Ok, then I understand, what your patch is 
addressing.

Thanks
Guennadi

> tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000
> tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000
> tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000
> tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000
> etc...
> 
> Regards,
> Paul
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

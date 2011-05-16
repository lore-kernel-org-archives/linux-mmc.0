From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH] mmc: tmio: Fix race condition resulting in spurious interrupts
Date: Mon, 16 May 2011 22:35:05 +0100 (BST)
Message-ID: <753789.33501.qm@web29017.mail.ird.yahoo.com>
References: <Pine.LNX.4.64.1105162258510.29373@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from nm3.bullet.mail.ird.yahoo.com ([77.238.189.60]:46786 "HELO
	nm3.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753297Ab1EPVfH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 May 2011 17:35:07 -0400
In-Reply-To: <Pine.LNX.4.64.1105162258510.29373@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk

> I wouldn't call this a "race."

If the hardware sets the next status bit before the interrupt handler reaches the bottom of the loop, then the loop repeats, and the subsequent interrupt is reported as spurious.

If the interrupt handler reaches the bottom of the loop before the hardware sets the next status bit, then the handler returns, and the subsequent interrupt is handled normally.

Thus the handler is racing the hardware.

> Sorry, don't understand. Isn't a spurious interrupt
> reported per "nobody 
> cared" if an ISR returns IRQ_NONE? And the TMIO ISR never
> does this. Is 
> the IRQ number, reported as spurious, that of TMIO? Is it
> shared?

tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000
tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000
tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000
tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000
tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000
etc...

Regards,
Paul

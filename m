From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH] mmc: tmio: Fix race condition resulting in spurious interrupts
Date: Mon, 16 May 2011 23:08:34 +0100 (BST)
Message-ID: <76514.92506.qm@web29001.mail.ird.yahoo.com>
References: <Pine.LNX.4.64.1105162353450.29373@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from nm15-vm0.bullet.mail.ird.yahoo.com ([77.238.189.216]:23457 "HELO
	nm15-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752860Ab1EPWIg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 May 2011 18:08:36 -0400
In-Reply-To: <Pine.LNX.4.64.1105162353450.29373@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk

> > tmio_mmc: Spurious irq, disabling! 0x00800780
> 0x833f0304 0x00000000
> 
> Aha, ok, that's a different one, sorry. Also interesting,
> that the kernel 
> is failing to disable it... Ok, then I understand, what
> your patch is 
> addressing.

Perhaps the driver's warning is somewhat misleading; the interrupt is not so much spurious as late. That's why the kernel is failing to disable it; the interrupt is valid for the tmio_mmc driver, just late.

Regards,
Paul

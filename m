From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio: Fix race condition resulting in spurious interrupts
Date: Thu, 30 Jun 2011 11:57:14 -0400
Message-ID: <m24o3771np.fsf@bob.laptop.org>
References: <E1QLbJK-0007cv-An@outmx05.plus.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37439 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab1F3P5Y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jun 2011 11:57:24 -0400
In-Reply-To: <E1QLbJK-0007cv-An@outmx05.plus.net> (Paul Parsons's message of
	"Sun, 15 May 2011 13:24:41 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk

Hi,

On Sun, May 15 2011, Paul Parsons wrote:
> There is a race condition in the tmio_mmc_irq() interrupt handler, caused by the presence of a while loop, which results in warnings of spurious interrupts. This was found on an HP iPAQ hx4700 whose HTC ASIC3 reportedly incorporates the Toshiba TC6380AF controller.
>
> Towards the end of a multiple read (CMD18) operation the handler clears the final RXRDY status bit in the first loop iteration, sees the DATAEND status bit at the bottom of the loop, and so clears the DATAEND status bit in the second loop iteration. However the DATAEND interrupt is still queued in the system somewhere and can't be delivered until the handler has returned. This second interrupt is then reported as spurious in the next call to the handler. Likewise for single read (CMD17) operations. And something similar occurs for multiple write (CMD25) and single write (CMD24) operations, where CMDRESPEND and TXRQ status bits are cleared in a single call.
>
> In these cases the interrupt handler clears two separate interrupts when it should only clear the one interrupt for which it was invoked. The fix is to remove the while loop.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>

Thanks, pushed to mmc-next after wrapping the commit message to <74 chars.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

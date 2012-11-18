From: Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH v3] MMC: SD/MMC Host Controller for Wondermedia
 WM8505/WM8650
Date: Mon, 19 Nov 2012 06:44:24 +1300
Message-ID: <1353260664.23933.0.camel@gitbox>
References: <1353205986-23476-1-git-send-email-linux@prisktech.co.nz>
	 <87k3tjipmi.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from server.prisktech.co.nz ([115.188.14.127]:52611 "EHLO
	server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab2KRRoH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 12:44:07 -0500
In-Reply-To: <87k3tjipmi.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: arm-linux-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, vt8500-wm8505-linux-kernel@googlegroups.com

On Sat, 2012-11-17 at 21:58 -0500, Chris Ball wrote:
> Hi Tony, thanks for the quick turnaround,
> 
> On Sat, Nov 17 2012, Tony Prisk wrote:
> > +	regular_irq = irq_of_parse_and_map(np, 0);
> > +	dma_irq = irq_of_parse_and_map(np, 1);
> > +
> > +	if ((!regular_irq) | (!dma_irq)) {
> > +		dev_err(&pdev->dev, "Getting IRQs failed!\n");
> 
> I think you meant ||, not |, and you could remove the redundant parens.
> 
> Other than that, I think this is ready -- if you want to ACK the above
> change I'll fold it in without having you resend the patch.
> 
> Thanks,
> 
> - Chris.

Oops - Good catch.
Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony P


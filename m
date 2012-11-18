From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3] MMC: SD/MMC Host Controller for Wondermedia WM8505/WM8650
Date: Sat, 17 Nov 2012 21:58:13 -0500
Message-ID: <87k3tjipmi.fsf@octavius.laptop.org>
References: <1353205986-23476-1-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48143 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535Ab2KRC6T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 21:58:19 -0500
In-Reply-To: <1353205986-23476-1-git-send-email-linux@prisktech.co.nz> (Tony
	Prisk's message of "Sun, 18 Nov 2012 15:33:06 +1300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: arm-linux-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, vt8500-wm8505-linux-kernel@googlegroups.com

Hi Tony, thanks for the quick turnaround,

On Sat, Nov 17 2012, Tony Prisk wrote:
> +	regular_irq = irq_of_parse_and_map(np, 0);
> +	dma_irq = irq_of_parse_and_map(np, 1);
> +
> +	if ((!regular_irq) | (!dma_irq)) {
> +		dev_err(&pdev->dev, "Getting IRQs failed!\n");

I think you meant ||, not |, and you could remove the redundant parens.

Other than that, I think this is ready -- if you want to ACK the above
change I'll fold it in without having you resend the patch.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

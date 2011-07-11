From: Ido Yariv <ido@wizery.com>
Subject: Re: [PATCH v2 1/6] arm: davinci: Fix low level gpio irq handlers'
 argument
Date: Mon, 11 Jul 2011 23:33:56 +0300
Message-ID: <20110711203356.GA5633@WorkStation>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
 <1310303679-17936-2-git-send-email-ido@wizery.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43281 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab1GKUeH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2011 16:34:07 -0400
Received: by wwe5 with SMTP id 5so4280911wwe.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2011 13:34:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

Hi Sekhar,

On Mon, Jul 11, 2011 at 05:28:44PM +0530, Nori, Sekhar wrote:
> Thanks for the bug fix.
> 
> How about setting the handler data for bank IRQ in
> davinci_gpio_irq_setup() to &chips[bank]?
> 
> chips[bank].regs should give you the register base address
> (g) and chips[bank].irq_base should give you 'n'.
> 
> Also please drop the rename of irq to bank_irq as it is not
> central to the bug fix.
> 
> If you spin in soon enough, we may make it to v3.0

Sure, I'll send a v3 in a few.

Thanks for the review,
Ido.

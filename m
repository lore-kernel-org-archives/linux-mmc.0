From: Ido Yariv <ido@wizery.com>
Subject: Re: [PATCH v3 1/6] arm: davinci: Fix low level gpio irq handlers'
 argument
Date: Wed, 13 Jul 2011 01:19:15 +0300
Message-ID: <20110712221915.GD5633@WorkStation>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
 <1310418191-27009-1-git-send-email-ido@wizery.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024DA7AEF2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60521 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964Ab1GLWTX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2011 18:19:23 -0400
Received: by wyg8 with SMTP id 8so154389wyg.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2011 15:19:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DA7AEF2@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

Hi Sekhar,

On Tue, Jul 12, 2011 at 02:52:17PM +0530, Nori, Sekhar wrote:
> > -	g = (__force struct davinci_gpio_regs __iomem *) irq_desc_get_handler_data(desc);
> > +	ctl = (struct davinci_gpio_controller *)irq_desc_get_handler_data(desc);
> > +	g = (struct davinci_gpio_regs __iomem *)ctl->regs;
> >  
> >  	/* we only care about one bank */
> >  	if (irq & 1)
> > @@ -278,7 +280,7 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
> >  			status >>= 16;
> >  
> >  		/* now demux them to the right lowlevel handler */
> > -		n = (int)irq_get_handler_data(irq);
> > +		n = ctl->irq_base;
> 
> I realized that this breaks for odd banks as the status is
> right shifted by 16. The GPIO you are using must have been
> in even bank?

You're absolutely right, I missed that. And yes, I have been using an
even bank GPIO.

> >  		while (status) {
> >  			res = ffs(status);
> >  			n += res;
> > @@ -424,7 +426,13 @@ static int __init davinci_gpio_irq_setup(void)
> >  
> >  		/* set up all irqs in this bank */
> >  		irq_set_chained_handler(bank_irq, gpio_irq_handler);
> > -		irq_set_handler_data(bank_irq, (__force void *)g);
> > +
> > +		/*
> > +		 * Each chip handles 32 gpios, and each irq bank consists of 16
> > +		 * gpio irqs. Pass the irq bank's corresponding controller to
> > +		 * the chained irq handler.
> > +		 */
> > +		irq_set_handler_data(bank_irq, &chips[bank * 16 / 32]);
> 
> This can simply be:
> 
> 		irq_set_handler_data(bank_irq, &chips[gpio / 32]);
> 
> In the interest of time, I did these fixes and pushed the
> patch to "fixes" branch of git://gitorious.org/linux-davinci/linux-davinci.git
> 
> Can you please test it out and let me know if it works.

This patch seems to work just fine. I'm afraid I can't test an odd bank
GPIO here to verify that this indeed fixed the issue you raised, but it
looks correct.

Thanks,
Ido.

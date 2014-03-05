From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 0/3] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Wed, 5 Mar 2014 10:55:45 -0800
Message-ID: <20140305185544.GI4983@atomide.com>
References: <1394008070-30138-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394008070-30138-1-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Andreas Fenkart <afenkart@gmail.com> [140305 00:39]:
> Hi Tony,
> 
> I had an infinite loop in hsmmc_disable_wake_irq. Since the SDIO
> irq is level triggered, I have to disable the IRQ in the handler
> otherwise it is called infinitely. 
> 
> Did some other minor changes see below.
> 
> v8
> - rebased on top of Tony Lindgren<tony@atomide.com> changes
>   - improved changelog describing the earlier work
>   - improved wakeup irq setup
>   - works on am3730 es platform now
> - my changes on top:
>   - compile tested with #undef CONFIG_OF
>   - disable wake_irq in handler to prevent infinite loop  
>   - fixed typo and added comment about wake-irq

Great, tested here and things work for me for waking omap3
from off-idle based on the SDIO interrupt.

Maybe leave out the trailing period from the Subject line
for the last patch? If you look at git log --pretty=oneline
the trailing period is rarely used :)

Balaji, care to queue or ack these for Chris? Looks like
Chris has a wrong email address (corrected in this mail),
so maybe one more repost of the series is needed.

Regards,

Tony

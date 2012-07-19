From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Thu, 19 Jul 2012 04:31:17 -0700
Message-ID: <20120719113116.GM6522@atomide.com>
References: <1342485005-5178-1-git-send-email-javier@dowhile0.org>
 <CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com>
 <CABxcv=nsmeVLspzXERYXebmPaNO6rKCsVnak7dMtvGjiYH4vOw@mail.gmail.com>
 <20120718065951.GH6522@atomide.com>
 <CAAwP0s1UB_Q33KhXp_gvKfTMHRiBaH60HmXsMKxVkAxT1byctg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:35891 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab2GSLbX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jul 2012 07:31:23 -0400
Content-Disposition: inline
In-Reply-To: <CAAwP0s1UB_Q33KhXp_gvKfTMHRiBaH60HmXsMKxVkAxT1byctg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin.Hilman.khilman@ti.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

* Javier Martinez Canillas <martinez.javier@gmail.com> [120718 01:31]:
> That was my first approach in fact, I sent this patch:
> https://patchwork.kernel.org/patch/1198401/
> 
> But then was told by Kevin Hilman that the right solution was to do
> the select on the drives to fix not only omap2plus_defconfig but any
> config.
> So I sent this patch and Santosh agrees with Kevin.
> 
> I don't really know the hardware nor the driver well enough to have a
> strong position on this.

Ideally we would not select it or have depends on it. DMA channels
can run out, and drivers need to work also without DMA. For doing
distro kernels, building everything as modules should be an option
rather than forcing to build in all kinds of code.

Regards,

Tony

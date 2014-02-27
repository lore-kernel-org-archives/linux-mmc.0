From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 3/4] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x.
Date: Thu, 27 Feb 2014 13:37:09 -0800
Message-ID: <20140227213709.GL11654@atomide.com>
References: <1393331866-28307-1-git-send-email-afenkart@gmail.com>
 <1393331866-28307-4-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393331866-28307-4-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Andreas Fenkart <afenkart@gmail.com> [140225 04:51]:
> The am335x can't detect pending cirq in PM runtime suspend.
> This patch reconfigures dat1 as a GPIO before going to suspend.
> SDIO interrupts are detected with the GPIO, the GPIO will only wake
> the module from suspend, SDIO irq detection will still happen through the
> IP block.

So this patch should no longer be needed after my updated
patches 1 and 2. But please check :)

Tony

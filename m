From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/22] OMAP: sDMA: descriptor autoloading feature
Date: Fri, 6 May 2011 09:22:53 +0300
Message-ID: <20110506062252.GT27860@atomide.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
 <1304596282-4095-2-git-send-email-adrian.hunter@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1304596282-4095-2-git-send-email-adrian.hunter@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Venkatraman S <svenkatr@ti.com>, Shilimkar Santosh <santosh.shilimkar@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

* Adrian Hunter <adrian.hunter@nokia.com> [110505 14:48]:
> From: Venkatraman S <svenkatr@ti.com>
> 
> Add sDMA driver support for descriptor autoloading feature.
>  Descriptor autoloading is OMAP sDMA v5 hardware capability that can be exploited for scatter gather
>  scenarios, currently available in OMAP3630 and OMAP4430.

I think we should not add this feature until after we've
converted omap DMA to use the common dmaengine for the
basic features.

Adding this will make it harder for us to do the converions.

Can you please separate out the DMA descriptor autoloading
patches?

Regards,

Tony

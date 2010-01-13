From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8] omap_hsmmc: RX51: set padconfs to pull down when
 powering off eMMC
Date: Wed, 13 Jan 2010 12:39:58 -0800
Message-ID: <20100113203958.GL2986@atomide.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
 <20100113114048.7615.51097.sendpatchset@ahunter-work.research.nokia.com>
 <20100113203745.GK2986@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100113203745.GK2986@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [100113 12:36]:
> 
> You might want to check what happens in omap off-idle mode in these cases
> and see if enabling OMAP_PIN_OFF_INPUT_PULLDOWN makes any difference in
> power consumption in off state. That probably does not matter unless the
> floating lines cause the eMMC to do something on it's own :)

Or OMAP_PIN_OFF_OUTPUT_LOW actually.

Tony

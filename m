From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/4] MMC: some omap_hsmmc fixes
Date: Sat, 13 Oct 2012 11:01:50 +0200
Message-ID: <50792DFE.9060609@gmail.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1350039495-360-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Linux MMC List <linux-mmc@vger.kernel.org>, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

On 12.10.2012 12:58, Daniel Mack wrote:
> Here are some assorted patches for the omap_hsmmc driver that I need on
> top Linus' current development branch to make it work on a AM33xx board.
> 
> 1/4 and 2/4 qualify as bug fixes and I'm puzzled that these didn't hit
> anyone else yet.
> 
> 
> Daniel Mack (4):
>   MMC: omap_hsmmc: set platform data after probe from DT node
>   MMC: omap_hsmmc: fix DMA config block
>   MMC: omap_hsmmc: claim pinctrl at probe time
>   MMC: omap_hsmmc: add DT property for max bus frequency

Ok, so 1/4 and 2/4 will be solved differently upstream, so they can be
dropped.

The other two remain, and 3/4 got an Acked-by Linus W.


Thanks for the feedback,
Daniel


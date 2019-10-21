From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 07/11] omap: remove old hsmmc.[ch] and in Makefile
Date: Mon, 21 Oct 2019 07:30:08 -0700
Message-ID: <20191021143008.GS5610@atomide.com>
References: <cover.1571510481.git.hns@goldelico.com>
 <9bd4c0bb0df26523d7f5265cdb06d86d63dafba8.1571510481.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9bd4c0bb0df26523d7f5265cdb06d86d63dafba8.1571510481.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, David Sterba <dsterba-IBi9RG/b67k@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Petr Mladek <pmladek-IBi9RG/b67k@public.gmane.org>, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Yangtao Li <tiny.windzz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexios Zavras <alexios.zavras-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Allison Randal <allison-wcfNWazeolPR7s880joybQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKldhl2p70BpVqQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

* H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [191019 18:43]:
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -216,7 +216,6 @@ obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
>  
>  # Platform specific device init code
>  
> -omap-hsmmc-$(CONFIG_MMC_OMAP_HS)	:= hsmmc.o
>  obj-y					+= $(omap-hsmmc-m) $(omap-hsmmc-y)

The related obj-y line can go now too, right?

And looks like common.h also has struct omap2_hsmmc_info
so maybe check by grepping for hsmmc_info to see it's gone.

Regards,

Tony

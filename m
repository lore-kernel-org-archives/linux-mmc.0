From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/7] spi: omap2-mcspi: Fix PM regression with deferred
 probe for pm_runtime_reinit
Date: Thu, 11 Feb 2016 07:08:06 -0800
Message-ID: <20160211150806.GS19432@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-4-git-send-email-tony@atomide.com>
 <20160211115128.GF13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160211115128.GF13270-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "Rafael J . Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

* Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [160211 03:52]:
> On Wed, Feb 10, 2016 at 03:02:46PM -0800, Tony Lindgren wrote:
> 
> > Mark, I'd like to merge this along with other related fixes via
> > the ARM SoC tree if no objections, please review and ack if this
> > look OK to you.
> 
> Why, I'm not seeing any dependencies here?  I'd also expect to be seeing
> an awful lot more changes like this, this shouldn't be an OMAP thing -
> do we need to fix the core API and then roll out the transition in a
> different way?

Please feel free to pick up this one if you have other fixes
lined up, nothing stopping that.

There will be likely more fixes like this to make drivers follow
the PM runtime API documentation. These were just the initial
ones that were obvious.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

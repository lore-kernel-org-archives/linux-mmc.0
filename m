From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 09/12] mmc: sdhci-xenon: add initial Xenon eMMC driver
Date: Thu, 09 Jun 2016 23:49:36 +0200
Message-ID: <7218454.U6xIsxs3Lc@wuerfel>
References: <201606092223.3kHMu0m3%fengguang.wu@intel.com> <87r3c6mmyp.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r3c6mmyp.fsf-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thursday, June 9, 2016 4:54:54 PM CEST Gregory CLEMENT wrote:
> >
> >    drivers/built-in.o: In function `sdhci_xenon_remove':
> >>> sdhci-xenon.c:(.text+0x311234): undefined reference to `sdhci_remove_host'
> >>> sdhci-xenon.c:(.text+0x31123c): undefined reference to `sdhci_pltfm_free'
> >    drivers/built-in.o: In function `sdhci_xenon_delay_adj_test':
> >>> sdhci-xenon.c:(.text+0x31213b): undefined reference to `card_alive'
> >    drivers/built-in.o: In function `sdhci_xenon_set_uhs_signaling':
> >>> sdhci-xenon.c:(.text+0x312456): undefined reference to `sdhci_set_uhs_signaling'
> >    drivers/built-in.o: In function `sdhci_xenon_probe':
> >>> sdhci-xenon.c:(.text+0x31258c): undefined reference to `sdhci_pltfm_init'
> >>> sdhci-xenon.c:(.text+0x3125d3): undefined reference to `mmc_of_parse'
> >>> sdhci-xenon.c:(.text+0x312651): undefined reference to `sdhci_get_of_property'
> >>> sdhci-xenon.c:(.text+0x312840): undefined reference to `sdhci_add_host'
> >    sdhci-xenon.c:(.text+0x312904): undefined reference to `sdhci_pltfm_free'
> >    drivers/built-in.o: In function `sdhci_xenon_reset':
> >>> sdhci-xenon.c:(.text+0x313c11): undefined reference to `sdhci_reset'
> >>> drivers/built-in.o:(.data+0x1d7df0): undefined reference to `sdhci_pltfm_pmops'
> >>> drivers/built-in.o:(.data+0x1d7eb0): undefined reference to `sdhci_set_clock'
> >>> drivers/built-in.o:(.data+0x1d7ef0): undefined reference to `sdhci_set_bus_width'
> 
> These symbols are part of the drivers/mmc/host/sdhci.c which is build
> when CONFIG_MMC_SDHCI is enabled. However CONFIG_MMC_XENON_SDHCI depends
> on CONFIG_MMC_SDHCI_PLTFM which depends on CONFIG_MMC_SDHCI.
> 
> So I wonder how we can have a sition with sdhci-xenon.c built but not
> sdhci.c.
> 
> Any idea?
> 

CONFIG_MMC_SDHCI is built as a module, but CONFIG_MMC_XENON_SDHCI is
a "bool" option, so it can only be built-in.

It should work if you make it a 'tristate' instead, so that Kconfig
can handle the dependency correctly.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

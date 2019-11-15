From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 00/12] OpenPandora: make wl1251 connected to mmc3 sdio
 port of OpenPandora work again
Date: Fri, 15 Nov 2019 10:29:46 +0100
Message-ID: <CAPDyKFr=Uk1i0c=3WvuOYCQ__Skpr-9mjVM2Yqst-hd8zY6OeQ@mail.gmail.com>
References: <cover.1573122644.git.hns@goldelico.com> <CAPDyKFrntf2Kd9Zf7uxRCUk_OrKD8B3xOKmvPaf04X21L5HwWA@mail.gmail.com>
 <5F5A5FC0-8F91-4D5B-9EF6-AF36FE38B588@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5F5A5FC0-8F91-4D5B-9EF6-AF36FE38B588-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Yangtao Li <tiny.windzz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Petr Mladek <pmladek-IBi9RG/b67k@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, Alexios Zavras <alexios.zavras-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David Sterba <dst>
List-Id: linux-mmc@vger.kernel.org

On Thu, 14 Nov 2019 at 16:16, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>
> Hi Ulf,
>
> > Am 14.11.2019 um 15:18 schrieb Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> >
> > On Thu, 7 Nov 2019 at 11:31, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
> >>
> >>
> >> * add a revisit note for special wl1251 handling code because it should
> >>  be solved more generic in mmc core - suggested by Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> * remove init_card callback from platform_data/hsmmc-omap.h - suggested by Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> * remove obstructive always-on for vwlan regulator - suggested by Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> * rename DT node - suggested by Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> * fix ARM: dts: subject prefix - suggested by Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> >> * also remove omap2_hsmmc_info and obc-y line in Makefile - suggested by Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> >
> > No further comments from my side. Let's just agree on how to deal with
> > the ti,power-gpio, then I can apply this.
>
> I'd say it can be a separate patch since it does not fix the Pandora
> issues, but is a new and independent optimization.
>
> And in case someone complains and uses it for some out-of tree purpose
> it can be discussed or even be reverted easier if it is a separate patch.
>
> I can do it in the next days.

Okay, that sounds reasonable.

In the meantime, I have queued up the series on my next branch (for v5.5).

I fixed up a couple of complaints from checkpatch, and also added
stable tags for the first two patches in the series, as that what
missing.

Kind regards
Uffe


>
> > Thanks a lot for fixing all this mess!
>
> I hope the users also appreciate our work.
>
> Best regards,
> Nikolaus
>
> >
> > Kind regards
> > Uffe
> >
> >>
> >> PATCH V2 2019-10-19 20:41:47:
> >> * added acked-by for wl1251 patches - Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >> * really removed old pdata-quirks code (not through #if 0)
> >> * splited out a partial revert of
> >>        efdfeb079cc3b ("regulator: fixed: Convert to use GPIO descriptor only")
> >>  because that was introduced after v4.19 and stops the removal of
> >>  the pdata-quirks patch from cleanly applying to v4.9, v4.14, v4.19
> >>  - reported by Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> * added a new patch to remove old omap hsmmc since pdata quirks
> >>  were last user - suggested by Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> >>
> >> PATCH V1 2019-10-18 22:25:39:
> >> Here we have a set of scattered patches to make the OpenPandora WiFi work again.
> >>
> >> v4.7 did break the pdata-quirks which made the mmc3 interface
> >> fail completely, because some code now assumes device tree
> >> based instantiation.
> >>
> >> Fixes: 81eef6ca9201 ("mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel")
> >>
> >> v4.11 did break the sdio qirks for wl1251 which made the driver no longer
> >> load, although the device was found as an sdio client.
> >>
> >> Fixes: 884f38607897 ("mmc: core: move some sdio IDs out of quirks file")
> >>
> >> To solve these issues:
> >> * we convert mmc3 and wl1251 initialization from pdata-quirks
> >>  to device tree
> >> * we make the wl1251 driver read properties from device tree
> >> * we fix the mmc core vendor ids and quirks
> >> * we fix the wl1251 (and wl1271) driver to use only vendor ids
> >>  from header file instead of (potentially conflicting) local
> >>  definitions
> >>
> >>
> >> H. Nikolaus Schaller (12):
> >>  Documentation: dt: wireless: update wl1251 for sdio
> >>  net: wireless: ti: wl1251 add device tree support
> >>  ARM: dts: pandora-common: define wl1251 as child node of mmc3
> >>  mmc: host: omap_hsmmc: add code for special init of wl1251 to get rid
> >>    of pandora_wl1251_init_card
> >>  omap: pdata-quirks: revert pandora specific gpiod additions
> >>  omap: pdata-quirks: remove openpandora quirks for mmc3 and wl1251
> >>  omap: remove omap2_hsmmc_info in old hsmmc.[ch] and update Makefile
> >>  mmc: host: omap-hsmmc: remove init_card pdata callback from pdata
> >>  mmc: sdio: fix wl1251 vendor id
> >>  mmc: core: fix wl1251 sdio quirks
> >>  net: wireless: ti: wl1251 use new SDIO_VENDOR_ID_TI_WL1251 definition
> >>  net: wireless: ti: remove local VENDOR_ID and DEVICE_ID definitions
> >>
> >> .../bindings/net/wireless/ti,wl1251.txt       |  26 +++
> >> arch/arm/boot/dts/omap3-pandora-common.dtsi   |  36 +++-
> >> arch/arm/mach-omap2/Makefile                  |   3 -
> >> arch/arm/mach-omap2/common.h                  |   1 -
> >> arch/arm/mach-omap2/hsmmc.c                   | 171 ------------------
> >> arch/arm/mach-omap2/hsmmc.h                   |  32 ----
> >> arch/arm/mach-omap2/pdata-quirks.c            | 105 -----------
> >> drivers/mmc/core/quirks.h                     |   7 +
> >> drivers/mmc/host/omap_hsmmc.c                 |  30 ++-
> >> drivers/net/wireless/ti/wl1251/sdio.c         |  23 ++-
> >> drivers/net/wireless/ti/wlcore/sdio.c         |   8 -
> >> include/linux/mmc/sdio_ids.h                  |   2 +
> >> include/linux/platform_data/hsmmc-omap.h      |   3 -
> >> 13 files changed, 111 insertions(+), 336 deletions(-)
> >> delete mode 100644 arch/arm/mach-omap2/hsmmc.c
> >> delete mode 100644 arch/arm/mach-omap2/hsmmc.h
> >>
> >> --
> >> 2.23.0
> >>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

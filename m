From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 07/11] omap: remove old hsmmc.[ch] and in Makefile
Date: Tue, 22 Oct 2019 08:58:44 +0200
Message-ID: <CAPDyKFryqo3wF-GphhytNqrDL4rbZ7Qou1Ki3e2_5w-yh2o=uw@mail.gmail.com>
References: <cover.1571510481.git.hns@goldelico.com> <9bd4c0bb0df26523d7f5265cdb06d86d63dafba8.1571510481.git.hns@goldelico.com>
 <20191021143008.GS5610@atomide.com> <3FDBE28F-B2C5-4EDE-905C-687F601462B6@goldelico.com>
 <20191021171104.GY5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191021171104.GY5610-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

- Trimmed cc-list (could be a good idea for next submission as well)

On Mon, 21 Oct 2019 at 19:11, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>
> * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [191021 17:08]:
> >
> > > Am 21.10.2019 um 16:30 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> > >
> > > * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [191019 18:43]:
> > >> --- a/arch/arm/mach-omap2/Makefile
> > >> +++ b/arch/arm/mach-omap2/Makefile
> > >> @@ -216,7 +216,6 @@ obj-$(CONFIG_MACH_NOKIA_N8X0)          += board-n8x0.o
> > >>
> > >> # Platform specific device init code
> > >>
> > >> -omap-hsmmc-$(CONFIG_MMC_OMAP_HS)  := hsmmc.o
> > >> obj-y                                      += $(omap-hsmmc-m) $(omap-hsmmc-y)
> > >
> > > The related obj-y line can go now too, right?
> >
> > Yes, I think so. It is a construction that I have never seen before :)
> > Therefore I did not recognize that it is related.
> >
> > > And looks like common.h also has struct omap2_hsmmc_info
> > > so maybe check by grepping for hsmmc_info to see it's gone.
> >
> > Yes, it is just a forward-declaration of the struct name with
> > no user anywhere.
> >
> > Scheduled for v3.
> >
> > BTW: should this series go through your tree since it is an
> > omap machine?
>
> Or MMC tree as that's where the code change really are.

I am okay with that. I will have a look at the series and provide some comments.

Kind regards
Uffe

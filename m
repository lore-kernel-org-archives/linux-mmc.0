From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/5] mmc: core: API to temporarily disable retuning for
 SDIO CRC errors
Date: Mon, 17 Jun 2019 09:53:20 +0200
Message-ID: <CAPDyKFqNUJospyV05ZC7Y894QB6a9LQ8cjdT+zrD9EQvm_OWRg@mail.gmail.com>
References: <20190613234153.59309-1-dianders@chromium.org> <20190613234153.59309-3-dianders@chromium.org>
 <CAPDyKFrgXGf_9=H7G40fiUQj=da5WWRys_oim2azgL4FEOeUVA@mail.gmail.com> <CAD=FV=UA9i1eEi3Mx0WF-DnCnr4O4-MfOxa=axZOJtXzxbV7Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=UA9i1eEi3Mx0WF-DnCnr4O4-MfOxa=axZOJtXzxbV7Tw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, brcm80211-dev-list.pdl@broadcom.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Double Lo <double.lo@cypress.com>, Brian Norris <briannorris@chromium.org>, linux-wireless <linux-wireless@vger.kernel.org>, Naveen Gupta <naveen.gupta@cypress.com>, Madhan Mohan R <madhanmohan.r@cypress.com>, Matthias Kaehlcke <mka@chromium.org>, Wright Feng <wright.feng@cypress.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, netdev <netdev@vger.kernel.org>, brcm80211-dev-list <brcm80211-dev-list@cypress.com>, Jiong Wu <lohengrin1024@gmail.com>, Ritesh Harjani <riteshh@codeaurora.org>, Allison Randal <allison@lohutok.net>
List-Id: linux-mmc@vger.kernel.org

[...]

> > > --- a/include/linux/mmc/sdio_func.h
> > > +++ b/include/linux/mmc/sdio_func.h
> > > @@ -167,4 +167,7 @@ extern void sdio_f0_writeb(struct sdio_func *func, unsigned char b,
> > >  extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
> > >  extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
> > >
> > > +extern void sdio_retune_crc_disable(struct sdio_func *func);
> > > +extern void sdio_retune_crc_enable(struct sdio_func *func);
> > > +
> > >  #endif /* LINUX_MMC_SDIO_FUNC_H */
> > > --
> > > 2.22.0.rc2.383.gf4fbbf30c2-goog
> > >
> >
> > Besides the minor comments, this looks good to me.
>
> Thank you for the reviews!
>
> I'll plan to send a v5 on my Monday with the fixes assuming no new
> heated discussion starts up.  If it's less work for you, I'm also
> happy if you just want to make the trivial fixes yourself when
> applying.

It really doesn't matter to me, feel free to pick the option you
prefer. At this point I am just awaiting acks for the broadcom patces
and some clarity of what stable releases we should target for
non-tagged patches.

Kind regards
Uffe

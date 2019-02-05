From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/3] mmc: sunxi: Filter out unsupported modes declared in
 the device tree
Date: Tue, 5 Feb 2019 16:42:53 +0800
Message-ID: <CAGb2v64RAfa1zTq+A0Vjc6TPZ7K9z7qU6qNd8nfKm1U87xDcxw@mail.gmail.com>
References: <20190203155628.16767-1-wens@csie.org> <20190203155628.16767-3-wens@csie.org>
 <20190204093427.vg63e5xmd7u52leh@flea> <CAGb2v64-3Cs_RaO4erAr96JStEUzZ7ZRDjAYYjK2QsWfxusKxQ@mail.gmail.com>
 <20190204134110.dvo3qvnhiksqig2l@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204134110.dvo3qvnhiksqig2l@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Chris Blake <chrisrblake93@gmail.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Feb 4, 2019 at 9:41 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Feb 04, 2019 at 06:16:24PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Feb 4, 2019 at 5:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sun, Feb 03, 2019 at 11:56:27PM +0800, Chen-Yu Tsai wrote:
> > > > The MMC device tree bindings include properties used to signal various
> > > > signalling speed modes. Until now the sunxi driver was accepting them
> > > > without any further filtering, while the sunxi device trees were not
> > > > actually using them.
> > > >
> > > > Since some of the H5 boards can not run at higher speed modes stably,
> > > > we are resorting to declaring the higher speed modes per-board.
> > > >
> > > > Regardless, having boards declare modes and blindly following them,
> > > > even without proper support in the driver, is generally a bad thing.
> > > >
> > > > Filter out all unsupported modes from the capabilities mask after
> > > > the device tree properties have been parsed.
> > > >
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > >
> > > > ---
> > > >
> > > > This should be backported to stable kernels in case people try to run
> > > > new device trees (that declare newly supported modes) with old kernels.
> > > > ---
> > > >  drivers/mmc/host/sunxi-mmc.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > > > index 7415af8c8ff6..a01433012db0 100644
> > > > --- a/drivers/mmc/host/sunxi-mmc.c
> > > > +++ b/drivers/mmc/host/sunxi-mmc.c
> > > > @@ -1415,6 +1415,22 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
> > > >       if (ret)
> > > >               goto error_free_dma;
> > > >
> > > > +     /*
> > > > +      * If we don't support delay chains in the SoC, we can't use any
> > > > +      * of the DDR speed modes. Mask them out in case the device
> > > > +      * tree specifies the properties for them, which gets added to
> > > > +      * the caps by mmc_of_parse() above.
> > > > +      */
> > > > +     if (!(host->cfg->clk_delays || host->use_new_timings))
> > > > +             mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
> > > > +                            MMC_CAP_1_2V_DDR);
> > > > +
> > > > +     /* TODO: UHS modes untested due to lack of supporting boards */
> > > > +     mmc->caps &= ~MMC_CAP_UHS;
> > >
> > > I've tested up to SDR104 and it works on the A64 at least
> >
> > That's good to know. What board was this on? I had given up hope waiting
> > for a vendor to produce a board that could do proper voltage switching for
> > SD cards.
>
> On a Sootech SoM, that had an HS400 eMMC and an SDR104 Marvell WiFi
> chip. I don't have that board anymore, and the website seems down now
> though :/

Bummer. So no commercially available board still. :/

> > > > +     /* TODO: This driver doesn't support HS200 and HS400 modes yet */
> > > > +     mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
> > >
> > > And HS200 works too.
> >
> > OK. I thought there was some special magic required in the driver. Maybe
> > that was for HS400 only? Again, what board was this on?
>
> Yeah, that was for HS400 only

OK. So would unblocking UHS and HS200, but not enabling them by default,
which is essentially the original behavior, work for you?

If so, I'll respin a version tonight.

ChenYu

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/12] mmc: omap_hsmmc: add DMA engine support
Date: Fri, 27 Apr 2012 20:03:32 +0100
Message-ID: <20120427190332.GG28062@n2100.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk> <E1SMLlv-0002WI-8a@rmk-PC.arm.linux.org.uk> <CACRpkdZPEnPTpp+vwJed4ZkXLNjEVUz==YVvwg_bhuUOyD3Fxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZPEnPTpp+vwJed4ZkXLNjEVUz==YVvwg_bhuUOyD3Fxg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 27, 2012 at 09:00:22PM +0200, Linus Walleij wrote:
> On Mon, Apr 23, 2012 at 6:05 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
>=20
> > Add DMA engine support to the OMAP HSMMC driver. =A0This supplement=
s the
> > private DMA API implementation contained within this driver, and th=
e
> > driver can be switched at build time between using DMA engine and t=
he
> > private DMA API.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>=20
> Great,
>=20
> > +#if 1
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig =3D host->dma_line_rx;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rx_chan =3D dma_request_channel=
(mask, omap_dma_filter_fn, &sig);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->rx_chan) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(mmc_dev(host=
->mmc), "unable to obtain RX DMA engine channel %u\n", sig);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +#endif
> > +#if 1
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig =3D host->dma_line_tx;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tx_chan =3D dma_request_channel=
(mask, omap_dma_filter_fn, &sig);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->tx_chan) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(mmc_dev(host=
->mmc), "unable to obtain TX DMA engine channel %u\n", sig);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +#endif
>=20
> Are these development artifacts?

Read the commit message. ;)

They're there (and removed by the next patch) so that the driver can
be easily switched between DMA engine and the private DMA API.  Simply
change the relevant #if to zero at build time.

I don't think it warrants config symbols or trying to do it via module
params as its just a stepping stone through the process.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

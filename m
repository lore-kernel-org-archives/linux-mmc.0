From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 8/8] mmc: sunxi: Add runtime_pm support
Date: Thu, 15 Mar 2018 11:04:11 +0100
Message-ID: <20180315100411.iqcnwqws623ws6yn@flea>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
 <052c21c000f64c28fd6b64c4db11e4b706bebf79.1520520655.git-series.maxime.ripard@bootlin.com>
 <CAPDyKFoJ0KftG1VxzdM97ubFJ25M+X0EjgOPc6HxewgyZMPipg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1856178775963326762=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFoJ0KftG1VxzdM97ubFJ25M+X0EjgOPc6HxewgyZMPipg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Quentin Schulz <quentin.schulz@bootlin.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


--===============1856178775963326762==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="onj42xyt7ehynl2m"
Content-Disposition: inline


--onj42xyt7ehynl2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Thu, Mar 15, 2018 at 10:30:54AM +0100, Ulf Hansson wrote:
> On 8 March 2018 at 15:52, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > So far, even if our card was not in use, we didn't shut down our main
> > clock, which meant that it was still output on the MMC bus.
> >
> > While this obviously means that we could save some power there, it also
> > created issues when it comes with EMC control since we'll have a perfect
> > peak at the card clock rate.
> >
> > Let's implement runtime_pm with autosuspend so that we will shut down t=
he
> > clock when it's not been in use for quite some time.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  drivers/mmc/host/sunxi-mmc.c | 46 ++++++++++++++++++++++++++++++++++++=
+-
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > index f6374066081b..0f98a5fcaade 100644
> > --- a/drivers/mmc/host/sunxi-mmc.c
> > +++ b/drivers/mmc/host/sunxi-mmc.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/of_gpio.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/reset.h>
> >  #include <linux/scatterlist.h>
> > @@ -973,6 +974,9 @@ static void sunxi_mmc_enable_sdio_irq(struct mmc_ho=
st *mmc, int enable)
> >         unsigned long flags;
> >         u32 imask;
> >
> > +       if (enable)
> > +               pm_runtime_get_noresume(host->dev);
> > +
> >         spin_lock_irqsave(&host->lock, flags);
> >
> >         imask =3D mmc_readl(host, REG_IMASK);
> > @@ -985,6 +989,9 @@ static void sunxi_mmc_enable_sdio_irq(struct mmc_ho=
st *mmc, int enable)
> >         }
> >         mmc_writel(host, REG_IMASK, imask);
> >         spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +       if (!enable)
> > +               pm_runtime_put_noidle(host->mmc->parent);
> >  }
> >
> >  static void sunxi_mmc_hw_reset(struct mmc_host *mmc)
> > @@ -1398,6 +1405,11 @@ static int sunxi_mmc_probe(struct platform_devic=
e *pdev)
> >         if (ret)
> >                 goto error_free_dma;
> >
> > +       pm_runtime_set_active(&pdev->dev);
> > +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> > +       pm_runtime_use_autosuspend(&pdev->dev);
> > +       pm_runtime_enable(&pdev->dev);
> > +
> >         ret =3D mmc_add_host(mmc);
> >         if (ret)
> >                 goto error_free_dma;
> > @@ -1418,6 +1430,7 @@ static int sunxi_mmc_remove(struct platform_devic=
e *pdev)
> >         struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> >
> >         mmc_remove_host(mmc);
> > +       pm_runtime_force_suspend(&pdev->dev);
> >         disable_irq(host->irq);
> >         sunxi_mmc_disable(host);
> >         dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg=
_dma);
> > @@ -1426,10 +1439,43 @@ static int sunxi_mmc_remove(struct platform_dev=
ice *pdev)
> >         return 0;
> >  }
> >
> > +static int sunxi_mmc_runtime_resume(struct device *dev)
> > +{
> > +       struct mmc_host *mmc =3D dev_get_drvdata(dev);
> > +       struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> > +       int ret;
> > +
> > +       ret =3D sunxi_mmc_enable(host);
> > +       if (ret)
> > +               return ret;
> > +
> > +       sunxi_mmc_power_up(mmc, &mmc->ios);
>=20
> Instead of doing power up, you may need restore some ios settings,
> such as the clock rate for example.
>=20
> You may also need to restore some registers in sunxi device, in case
> it's possible that the controller loses context at runtime suspend.

The thing I was precisely trying to avoid was this :)

I could save and restore registers when the MMC controller is put into
suspend, but that's pretty much exactly the same sequence than what is
done in the MMC_POWER_UP sequence in .set_ios.

So it just felt cleaner to just do the power_up sequence at resume
time. It avoids having to maintain the list of registers to save and
restore, and it involves less code overall.

It suprised me a bit that the core will not call .set_ios with
MMC_POWER_UP at resume by itself, but I guess there's a good reason
for that :)

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--onj42xyt7ehynl2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqqRRoACgkQ0rTAlCFN
r3RXmw/9GI2gL9sdHrLi5c52vvZ8MxiR6VQXllazIWO4jjSgT1iSlXqCfEY1RdkW
rfIP8zEz9KzO1xIWahbDcYVaFO+XNLeNnl2g2AufgLw2D34vPEOOoZ0SJbDzkpBL
4p+loHYIKAML4V8CRnUjSqIdR2cvROtjD30D5XLIfhhHRKMN4/li0vLBQoa816Xd
G2W6XJukueMOZl49/9qY/cfEHc3TVLew53V8VxX36jA/twcaq60pBvSc80fDx7pt
IUYJ+i6k0gdaBiV5cKZC/71VYFPMG/TSr8te1sl/6b/r7WlJjseu4tHMTaH38822
CvhKVsA/Y02rdDSy2sNT4nPWDYpT33YVFhCk5YQwTcEmEl3fO6tlEe9buc1Z/twS
PukU7cQLW2p++0GmLn5YgwPVV/aM6drYAcOWt1JywRf+L0HWHiFEF85CAhm88yT8
beWpU1114x7CsvQjADYhkwgX0uoWAaO4SUBu0irfMy7nJRYBdUD+w1jc/jod6Kfj
kbSvq97O8Bo1FlaIM/o5Zmv9Ngluh0x8XayJ/PhOhjCUrSgkT7svc0UsDQe+PNYw
6r/jKhyXdJAl73ezJG8J0mGYm9VyuU0deP4AzIFJD6yjPbND2CRMu8479owHqn49
SmtU8106OfACL4uPHHX6uEgnR8sHwjzKI6aCE37OVqEVQBEioSY=
=Rp30
-----END PGP SIGNATURE-----

--onj42xyt7ehynl2m--


--===============1856178775963326762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1856178775963326762==--

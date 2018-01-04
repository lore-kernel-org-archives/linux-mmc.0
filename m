From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/2] mmc: sunxi: Add runtime_pm support
Date: Thu, 4 Jan 2018 20:54:14 +0100
Message-ID: <20180104195414.tk6ycw7w2zukfo5l@flea.lan>
References: <cover.ac66a754953bedbb7529436b40a7996f4ba3cb95.1513766964.git-series.maxime.ripard@free-electrons.com>
 <412579f183c42f6fe2ea04f294dfb788be5e4875.1513766964.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFomRYaL=gCwY2Kq0PXRJ9WtsQVCi-3KfkfSNU3+mnJpow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eh5knmeals5x6ivi"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57036 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeADTy1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jan 2018 14:54:27 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFomRYaL=gCwY2Kq0PXRJ9WtsQVCi-3KfkfSNU3+mnJpow@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--eh5knmeals5x6ivi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Thu, Dec 21, 2017 at 01:21:51PM +0100, Ulf Hansson wrote:
> On 20 December 2017 at 11:50, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
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
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/mmc/host/sunxi-mmc.c | 90 ++++++++++++++++++++++++-------------
> >  1 file changed, 60 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > index 3ce46ebd3488..c6a0bd0e0476 100644
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
> > @@ -1217,29 +1218,11 @@ static int sunxi_mmc_resource_request(struct su=
nxi_mmc_host *host,
> >                 return ret;
> >         }
> >
> > -       ret =3D clk_prepare_enable(host->clk_mmc);
> > -       if (ret) {
> > -               dev_err(&pdev->dev, "Enable mmc clk err %d\n", ret);
> > -               goto error_disable_clk_ahb;
> > -       }
> > -
> > -       ret =3D clk_prepare_enable(host->clk_output);
> > -       if (ret) {
> > -               dev_err(&pdev->dev, "Enable output clk err %d\n", ret);
> > -               goto error_disable_clk_mmc;
> > -       }
> > -
> > -       ret =3D clk_prepare_enable(host->clk_sample);
> > -       if (ret) {
> > -               dev_err(&pdev->dev, "Enable sample clk err %d\n", ret);
> > -               goto error_disable_clk_output;
> > -       }
> > -
>=20
> Actually, I think you should keep all the above. Perhaps you may want
> to move it to a separate helper function though, which the
> ->runtime_resume() callbacks can invoke as well.
>=20
> More reasons to why, see the comment in the ->probe() function.
>=20
> >         if (!IS_ERR(host->reset)) {
> >                 ret =3D reset_control_reset(host->reset);
> >                 if (ret) {
> >                         dev_err(&pdev->dev, "reset err %d\n", ret);
> > -                       goto error_disable_clk_sample;
> > +                       goto error_disable_clk_ahb;
> >                 }
> >         }
> >
> > @@ -1258,12 +1241,6 @@ static int sunxi_mmc_resource_request(struct sun=
xi_mmc_host *host,
> >  error_assert_reset:
> >         if (!IS_ERR(host->reset))
> >                 reset_control_assert(host->reset);
> > -error_disable_clk_sample:
> > -       clk_disable_unprepare(host->clk_sample);
> > -error_disable_clk_output:
> > -       clk_disable_unprepare(host->clk_output);
> > -error_disable_clk_mmc:
> > -       clk_disable_unprepare(host->clk_mmc);
> >  error_disable_clk_ahb:
> >         clk_disable_unprepare(host->clk_ahb);
> >         return ret;
> > @@ -1280,6 +1257,7 @@ static int sunxi_mmc_probe(struct platform_device=
 *pdev)
> >                 dev_err(&pdev->dev, "mmc alloc host failed\n");
> >                 return -ENOMEM;
> >         }
> > +       platform_set_drvdata(pdev, mmc);
> >
> >         host =3D mmc_priv(mmc);
> >         host->mmc =3D mmc;
> > @@ -1340,12 +1318,16 @@ static int sunxi_mmc_probe(struct platform_devi=
ce *pdev)
> >         if (ret)
> >                 goto error_free_dma;
> >
> > +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> > +       pm_runtime_use_autosuspend(&pdev->dev);
> > +       pm_runtime_enable(&pdev->dev);
> > +
>=20
> This means in case you don't have CONFIG_PM set when compiling this
> driver, the clocks will never be enabled using runtime PM.
>=20
> I think it's good practice to deal with this, therefore I think you
> should enable the clocks as before, and instead indicate that the
> device is already runtime resumed.
>=20
> In other words, before you call pm_runtime_enable(), invoke
> pm_runtime_set_active().

That's a very good point, I'll do that in the next iteration.

> >         ret =3D mmc_add_host(mmc);
> >         if (ret)
> >                 goto error_free_dma;
> >
> >         dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host=
->irq);
> > -       platform_set_drvdata(pdev, mmc);
> > +
> >         return 0;
> >
> >  error_free_dma:
> > @@ -1361,27 +1343,75 @@ static int sunxi_mmc_remove(struct platform_dev=
ice *pdev)
> >         struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> >
> >         mmc_remove_host(mmc);
> > +       pm_runtime_force_suspend(&pdev->dev);
>=20
> Do you need the clocks to be enabled, while calling disable_irq() and
> sunxi_mmc_reset_host()?
>
> In such case you need to call pm_runtime_get_sync() here. Then move
> pm_runtime_force_suspend() a few lines below, and later call
> pm_runtime_put_noidle().

We don't for disable_irq, but we need it for
sunxi_mmc_reset_host. I'll do what you suggest.

> >         disable_irq(host->irq);
> >         sunxi_mmc_reset_host(host);
> >
> >         if (!IS_ERR(host->reset))
> >                 reset_control_assert(host->reset);
> >
> > -       clk_disable_unprepare(host->clk_sample);
> > +       dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg=
_dma);
> > +       mmc_free_host(mmc);
> > +
> > +       return 0;
> > +}
> > +
> > +static int sunxi_mmc_runtime_resume(struct device *dev)
> > +{
> > +       struct mmc_host *mmc =3D dev_get_drvdata(dev);
> > +       struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> > +       int ret;
> > +
> > +       ret =3D clk_prepare_enable(host->clk_mmc);
> > +       if (ret) {
> > +               dev_err(dev, "Enable mmc clk err %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret =3D clk_prepare_enable(host->clk_output);
> > +       if (ret) {
> > +               dev_err(dev, "Enable output clk err %d\n", ret);
> > +               goto error_disable_clk_mmc;
> > +       }
> > +
> > +       ret =3D clk_prepare_enable(host->clk_sample);
> > +       if (ret) {
> > +               dev_err(dev, "Enable sample clk err %d\n", ret);
> > +               goto error_disable_clk_output;
> > +       }
> > +
> > +       return 0;
> > +
> > +error_disable_clk_output:
> >         clk_disable_unprepare(host->clk_output);
> > +error_disable_clk_mmc:
> >         clk_disable_unprepare(host->clk_mmc);
> > -       clk_disable_unprepare(host->clk_ahb);
> > +       return ret;
> > +}
> >
> > -       dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg=
_dma);
> > -       mmc_free_host(mmc);
> > +static int sunxi_mmc_runtime_suspend(struct device *dev)
> > +{
> > +       struct mmc_host *mmc =3D dev_get_drvdata(dev);
> > +       struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> > +
> > +       clk_disable_unprepare(host->clk_sample);
> > +       clk_disable_unprepare(host->clk_output);
> > +       clk_disable_unprepare(host->clk_mmc);
> >
> >         return 0;
> >  }
> >
> > +static const struct dev_pm_ops sunxi_mmc_pm_ops =3D {
> > +       SET_RUNTIME_PM_OPS(sunxi_mmc_runtime_suspend,
> > +                          sunxi_mmc_runtime_resume,
> > +                          NULL)
> > +};
> > +
> >  static struct platform_driver sunxi_mmc_driver =3D {
> >         .driver =3D {
> >                 .name   =3D "sunxi-mmc",
> >                 .of_match_table =3D of_match_ptr(sunxi_mmc_of_match),
> > +               .pm =3D &sunxi_mmc_pm_ops,
> >         },
> >         .probe          =3D sunxi_mmc_probe,
> >         .remove         =3D sunxi_mmc_remove,
> > --
> > git-series 0.9.1
>=20
> Otherwise this looks good to me!
>=20
> BTW, isn't system wide suspend/resume() also important to save power
> for? That's rather simple to implement, after you have enabled runtime
> PM support.

We don't have (unfortunately) any kind of suspend support at the
moment, so I guess that'll come as a single step when we'll have it :)

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--eh5knmeals5x6ivi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpOhmUACgkQ0rTAlCFN
r3Rh4Q//cOZ4H2FrbKdDI8N9KzgkuZmb4yhThKxg3fvqfA3YSG8b5tDBkjIaNg98
3j93DvsiTbD/ZtZdAU5EIdOhJQa4o16AiM7zMeVnJQWpc3LutmmKi9JYalMJiZV7
s6nRqEWsFj40T1feqjf/cA0qzFd9FZ6K+6iuYBG1Zr+zPk50ENoC6AHuz7wkQ2si
S4XqvFGEKxFOZvc8nCS+L/tiZWLRVG6tA1gdwZjRe/oaQybYtKPgMomzOiM43hN3
mKwnIe422+6wy2vLtjKeFSp2iopgee0DlTi08NuClMQH/TDQlvSUTsYi2LMe0rDq
oZntxOQG0nBHjVL6tsWxAZUCyzR5DIKtVR9NacF15QpBs+B0PptB5bIcQJROsFJa
EDTwT8PZcmO2oUetfGHJoS0SebuPtABS0+28bw4ki6bJy7uhGA1oPubMdrSaaRBb
v63+FrzEL3aw07Ap5pMHA8olgvTf53BBQBS3CUTs8g1o9PEtB/NKlqhp3KPNRvO1
3Oc9wetDfE2DkPKjQKXW2krjBMJ7UcyYo6/cGNTpcO8hjHJGVrdwtHiv274fw+yY
LEx5pZUgmk62/OFaGpQAplNk5t4FVTARdOqSXxlivUDJQ9mMLT/fncO1fbTW/Mmy
VmX8ieT8IMnUcQodRrszjQ4dChwFzmCyoczgrwZqxbisw8XoXwY=
=LgNK
-----END PGP SIGNATURE-----

--eh5knmeals5x6ivi--

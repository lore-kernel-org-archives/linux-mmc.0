From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 2/3] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x.
Date: Mon, 25 Nov 2013 19:16:10 -0600
Message-ID: <20131126011610.GB21580@saruman.home>
References: <1385386009-14981-1-git-send-email-afenkart@gmail.com>
 <1385386009-14981-3-git-send-email-afenkart@gmail.com>
 <20131125224601.GX10023@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131125224601.GX10023@atomide.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2013 at 02:46:02PM -0800, Tony Lindgren wrote:
> * Andreas Fenkart <afenkart@gmail.com> [131125 05:30]:
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -452,10 +475,23 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_p=
latform_data *pdata)
> >  	} else
> >  		pdata->slots[0].gpio_wp =3D -EINVAL;
> > =20
> > +	if (gpio_is_valid(pdata->slots[0].gpio_cirq)) {
> > +		ret =3D gpio_request_one(pdata->slots[0].gpio_cirq, GPIOF_DIR_IN,
> > +				       "sdio_cirq");
> > +		if (ret)
> > +			goto err_free_ro;
> > +
> > +	} else {
> > +		pdata->slots[0].gpio_cirq =3D -EINVAL;
> > +	}
> > +
> > +
> >  	return 0;
> > =20
> > +err_free_ro:
> > +	if (gpio_is_valid(pdata->slots[0].gpio_wp))
> >  err_free_wp:
> > -	gpio_free(pdata->slots[0].gpio_wp);
> > +		gpio_free(pdata->slots[0].gpio_wp);
> >  err_free_cd:
> >  	if (gpio_is_valid(pdata->slots[0].switch_pin))
> >  err_free_sp:
>=20
> This patch we can now make a bit more generic with the recent addition
> of interrupts-extended property that's now merged in mainline tree :)
>=20
> We can optionally pass two interrupts to omap_hsmmc.c where the second
> interrupt is either the pinctrl-single wake-up interrupt, or the GPIO
> interrupt.
>=20
> Both the iochain wake interrupt or the GPIO interrupt are available with
> request_irq as long as configured in the .dts file. And can both use the
> SDIO interrupt handler. The only difference is that the GPIO wake-up
> still needs to do the dynamic remuxing of pins.

could that be done automatically if DTS provides "suspend" pinctrl
state ?

Would that be done before or after driver's ->{runtime_,}suspend()
methods ?

> mmc: mmc@4810abcd {
> 	compatible =3D "ti,omap33xx-hsmmc";

I would rather call it "ti,am33xx-hsmmc" just to make it match marketing
name of the device.

> Then the logic of enabling the dynamic remuxing can be done based
> on the ti,omap33xx-hsmmc compatible flag if there are two interrupts
> and the needed pin states are defined.

or maybe dynamic remuxing can be done by calling pinctrl_select_state()
with appropriate arguments ?

--=20
balbi

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk/ZaAAoJEIaOsuA1yqRE2g4QAJconHktsuECWWaQFvpbnM+2
/wnFRYXPVib9OvN4gyP2n6r5jThe5pLxqOaWw/6EL61eRh7Wu18REaRBOdWaFQ9x
hqWq9Nr7qVdHvshzDLpRz2wbIEOKbjgPTvjOxsqYVab3KhvI5nx6YVIAFCoZNQF8
FkQ+CTmLoshCWpt1Bdbkx6iH8epvqH3hXVAYRScnO6wnVaAtmWnjI0LxcEboIjk9
6erAgYUI7bv2gLN95zoABMzgmSbtfreGSt7tGVCu9oKz+Yu3AVOlzaXaa1D6PiNf
r2o43gI9z2ujPum8XfmtAvI+pIytHWZ+/ArY5+pl002KiCE2QviW666J17NG91g0
SRuL2uRPB1yDoTUMxxjAqHv1yd3WuheaNYder8NLFEXLxsLx1H8T/thsJbYqir9l
7PwIV6+WBYsJEBYBtyrGmOLjK1Gp9+8Z5rz13RwGMcze7Z3oWK6d7MvTP7WYzeHC
7biW1WwBLxskWYUnFlaVHsADkPCJE4HN0EkOWMkC02ejhfEr6erhg0UwlnmsnNVR
2f9VQ5Q2W9Vl9Fm9qZ/uK1G8NIaeqacD6rRruRpa/UjHbTf431wa1B8zu3R4gcBg
tMgo3XflH08YgmEGq1dgCTYKQFU9/NsfqAcb8V4K5Hv2ckBdXOcudqyqLgcvfwms
IiuIiMUBS3utp9XvFXvu
=OPU5
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

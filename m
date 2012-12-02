From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] SDIO / PM: Add empty bus-level suspend/resume callbacks
Date: Sun, 2 Dec 2012 22:01:06 +0100
Message-ID: <20121202210106.GB22086@avionic-0098.adnet.avionic-design.de>
References: <20120325203849.7a908e32@notabene.brown>
 <201203260029.24826.rjw@sisk.pl>
 <20121202194625.5d66e239@notabene.brown>
 <2147450.LFoExqrKEF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2147450.LFoExqrKEF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: NeilBrown <neilb@suse.de>, Chris Ball <cjb@laptop.org>, lkml <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2012 at 02:48:50PM +0100, Rafael J. Wysocki wrote:
> On Sunday, December 02, 2012 07:46:25 PM NeilBrown wrote:
> > On Mon, 26 Mar 2012 00:29:24 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wr=
ote:
> >=20
> >=20
> > > Thanks for the confirmation.
> > >=20
> > > Below it goes again with a changelog and tags.
> > >=20
> > > I don't really think that SDIO does the right thing here overall, but=
 that's
> > > all I can do to address the problem timely.
> > >=20
> > > Thanks,
> > > Rafael
> >=20
> > Hi Rafael,
> >  I just discovered that this patch has since been reverted - with an 'a=
ck'
> >  from you:
> > ----------
> > commit d8e2ac330f65bcf47e8894fe5331a7e8ee019c06
> > Author: Thierry Reding <thierry.reding@avionic-design.de>
> > Date:   Thu Aug 9 09:32:21 2012 +0000
> >=20
> >     mmc: sdio: Fix PM_SLEEP related build warnings
> >    =20
> >     Power management callbacks defined by SIMPLE_DEV_PM_OPS are only us=
ed if
> >     the PM_SLEEP Kconfig symbol has been defined. If not, the compiler =
will
> >     complain about them being unused. However, since the callback for t=
his
> >     driver doesn't do anything it can just as well be dropped.
> >    =20
> >     Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> >     Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> >     Signed-off-by: Chris Ball <cjb@laptop.org>
> > -----------
> >=20
> > Unsurprisingly the problem which your patch fixed has come back.
> >=20
> > Do you think we could get the patch back in again.  This time maybe we =
should
> > put some comments in there pointing out that having a function which do=
es
> > nothing is very different from not having any function at all?
>=20
> Well, I agree.  I didn't remember that the callback had been added for
> a purpose and hence my "ack" for that patch.
>=20
> What about applying the appended patch (hopefully, the build warnings sho=
uld
> be fixed properly this time)?
>=20
> Rafael
>=20
>=20
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: SDIO / PM: Add empty bus-level suspend/resume callbacks
>=20
> Suspend methods provided by SDIO drivers are not supposed to be
> called by the PM core.  Instead, when the SDIO core gets to suspend
> a device's ancestor, it calls the device driver's suspend routine.
> However, the PM core executes suspend callback routines directly for
> device drivers whose bus types don't provide suspend callbacks.
> In consequece, because the SDIO bus type doesn't provide a suspend
> callback, the SDIO drivers' suspend routines will be executed by the
> PM core (which shouldn't happen).
>=20
> To prevent this from happening, add empty system suspend/resume
> callbacks for the SDIO bus type.
>=20
> An analogous change had been made already by commit (e841a7c mmc:
> sdio: Use empty system suspend/resume callbacks at the bus level),
> but then it was reverted inadvertently by commit (d8e2ac3 mmc: sdio:
> Fix PM_SLEEP related build warnings) that attempted to fix build
> warnings introduced by commit e841a7c.
>=20
> Reported-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/mmc/core/sdio_bus.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> Index: linux/drivers/mmc/core/sdio_bus.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/mmc/core/sdio_bus.c
> +++ linux/drivers/mmc/core/sdio_bus.c
> @@ -193,7 +193,21 @@ static int sdio_bus_remove(struct device
>  }
> =20
>  #ifdef CONFIG_PM
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int pm_no_operation(struct device *dev)
> +{
> +	/*
> +	 * Prevent the PM core from calling SDIO device drivers' suspend
> +	 * callback routines, which it is not supposed to do, by using this
> +	 * empty function as the bus type suspend callaback for SDIO.
> +	 */
> +	return 0;
> +}
> +#endif
> +
>  static const struct dev_pm_ops sdio_bus_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_no_operation, pm_no_operation)
>  	SET_RUNTIME_PM_OPS(
>  		pm_generic_runtime_suspend,
>  		pm_generic_runtime_resume,
>=20

Hehe... if my memory serves me well, that's exactly (well, modulo the
comment) what my initial patch did before somebody suggested that the
empty callbacks should just be removed altogether. =3D)

Thierry

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQu8GSAAoJEN0jrNd/PrOhmsMP/AvZGjZDGAyNPdU6Z+JFMLJf
qnDpGfVDPG6lAdAVWhDtQQX49Y0/lLNSf2FnRZeAwHmMGzCClP1Las0umCtvcqVt
cGWSW65hF6E2q+pb1BLkcfaW1m+2thxx658Il/U7k/UOy4d9eIWoT1q6PPnQKOth
ZrGHzrgAm1TKEUXa0zhhgVleapxSO9Fluk5QkXnHYCVz9RSu/ETXx+1nJ1q1OFKI
a/WCTKHBaddlQ9Xh6QY2i3suweUghBt6k3cTOvL+BmaPxWxp00cpXd35DaS0uxCz
5dbC+bXn+CHLYG7IsUjee3H+9n0ORumDzDiJ+5mu3xjdYYcgUlA8fpaM/syq0sgy
a387RSoCANxet2K0Csj3bZC7k9eOj/PzWRctroDjH24fMkj/sDlI/jEoHh+kUzko
B5inX/abN6zZIvezFmPCzzTNjmfocBI2l35JJyQ0N0feQ5h6YNP/2MBcgpoaP//2
DDzVNRqvpA8rvtpH63TYpJ8xV8ETz73F4Xp2l1XBkrdX3JxIExsugjkeFiINjUar
F46/Kllj8M3e5KRLoHEINUQ31JIBn/qDKnLGTffthPNSgkHFVfOAUsOBi3yNxS+4
rvjJBgLmCMj5Hovi2LyvcrSEwmOHq2iKW8EkU9pdk06xPUrspYM4X4scp49Egbmd
w/PAxqoJl6pTFVkGySyT
=7Iq6
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

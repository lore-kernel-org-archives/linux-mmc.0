From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Tue, 29 Aug 2017 13:50:50 +0200
Message-ID: <20170829115050.3axlr5uysmqlhvd2@earth>
References: <20170821142132.GH6008@atomide.com>
 <20170823054246.23927-1-kishon@ti.com>
 <CAPDyKFp7gchVQ+JPNqv4LktvHRm2Lzx6KakOw85zEZxDEX0OhA@mail.gmail.com>
 <c9342689-f09e-44af-0975-d43ef122a477@ti.com>
 <CAPDyKFqCZFM7UmHyQCm=DwwZXJvzUde3pW0HqARKrsgfgxSuaw@mail.gmail.com>
 <0c7e0705-d9c2-4499-54ba-cbd84589dc01@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vvmy2soxjwr7yu7c"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0c7e0705-d9c2-4499-54ba-cbd84589dc01-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--vvmy2soxjwr7yu7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 29, 2017 at 04:50:22PM +0530, Kishon Vijay Abraham I wrote:
> Hi Uffe,
>=20
> On Thursday 24 August 2017 04:59 PM, Ulf Hansson wrote:
> > On 23 August 2017 at 15:56, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrot=
e:
> >> Hi Uffe,
> >>
> >> On Wednesday 23 August 2017 06:37 PM, Ulf Hansson wrote:
> >>> On 23 August 2017 at 07:42, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wr=
ote:
> >>>> Add binding for the TI's sdhci-omap controller. This now includes on=
ly
> >>>> a subset of properties documented in ti-omap-hsmmc.txt but will even=
tually
> >>>> include all the properties.
> >>>>
> >>>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> >>>> ---
> >>>> Changes from v2:
> >>>> *) Fixed example to use the updated compatible
> >>>>
> >>>> Changes from v1:
> >>>> *) Create a new sdhci-omap.txt document for TI's sdhci-omap controll=
er instead
> >>>>    of using the ti-omap-hsmmc.txt as suggested by Tony
> >>>>  .../devicetree/bindings/mmc/sdhci-omap.txt         | 22 +++++++++++=
+++++++++++
> >>>>  1 file changed, 22 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-omap=
=2Etxt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/=
Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> >>>> new file mode 100644
> >>>> index 000000000000..139695ad2d58
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> >>>> @@ -0,0 +1,22 @@
> >>>> +* TI OMAP SDHCI Controller
> >>>> +
> >>>> +Refer to mmc.txt for standard MMC bindings.
> >>>> +
> >>>> +Required properties:
> >>>> +- compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controll=
ers
> >>>> +- ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
> >>>> +
> >>>> +Optional properties:
> >>>> +- ti,dual-volt: boolean, supports dual voltage cards
> >>>> +- ti,non-removable: non-removable slot (like eMMC)
> >>>> +
> >>>> +Example:
> >>>> +       mmc1: mmc@0x4809c000 {
> >>>> +               compatible =3D "ti,dra7-sdhci";
> >>>> +               reg =3D <0x4809c000 0x400>;
> >>>> +               ti,hwmods =3D "mmc1";
> >>>> +               ti,dual-volt;
> >>>> +               bus-width =3D <4>;
> >>>> +               vmmc-supply =3D <&vmmc>; /* phandle to regulator nod=
e */
> >>>> +               ti,non-removable;
> >>>> +       };
> >>>> --
> >>>> 2.11.0
> >>>>
> >>>
> >>> I am wondering a bit on the long term plan here.
> >>>
> >>> Ideally at some point in future, we would like to remove the old
> >>> omap_hsmmc driver, but from compatible string point of view, that
> >>> means we first needs to deprecate the old ones for a while. Right?
> >>
> >> right but sdhci-omap is still lacking features that was present in oma=
p_hsmmc
> >> like context save/restore, SDIO support etc. I think we should depreca=
te
> >> omap_hsmmc compatible once we add all the features in sdhci-omap?
> >>>
> >>> That said, what is then the reason to why we should bring over the
> >>> existing omap_hsmmc bindings to the sdhci-omap bindings?
> >>
> >> This is mainly for old dt compatibility. Even after removing the omap_=
hsmmc
> >> driver, users should still be able to use newer kernel with their exis=
ting dtbs.
> >=20
> > I guess we have two options.
> >=20
> > 1) Allow us to invent and use new bindings - and a new compatible.
> > When everything is implemented in sdhci-omap, we can deprecate the old
> > omap_hsmmc driver and its corresponding compatible/bindings. At some
> > point later we can remove the legacy driver/bindings altogether - of
> > course that might take a while. This option allows us to re-think some
> > of the old bindings and really clean up some if its related code. For
> > example, I think "ti,dual-volt" is a bad binding. Instead it would be
> > better to use the existing mmc bindings about which speed mode the
> > controller/board supports (as the voltage level comes with it).
> >=20
> > 2) Invent only a new compatible, but stick to use the old omap hsmmc
> > bindings and thus also deploy the similar code dealing with them. When
> > everything is implemented move the old omap_hsmmc compatibles into the
> > new sdhci-omap driver and them remove the old omap_hsmmc driver. At
> > that point we could also deprecate the old omap hsmmc compatibles, but
> > to me that is rather pointless.
> >=20
> > The two options has different advantages, feel free to pick any of them!
>=20
> Okay. I'll send a new version with option '1' (new compatible/new binding=
s).
>=20
> And when we deprecate the omap_hsmmc driver (some time later), we'll add
> support for the legacy bindings in sdhci-omap driver (so that old dtbs co=
ntinue
> to work). Tony, are you okay with this?

I think you should Cc Rob Herring and Mark Rutland (DT binding
maintainers). This sounds like "I use DT to describe driver
behaviour" instead of "I use DT to describe hardware".

I would expect the conversion to look like the one done for UART,
see CONFIG_SERIAL_OMAP vs CONFIG_SERIAL_8250_OMAP. Both use the
same compatible value and you can choose using kernel configuration.

-- Sebastian

--vvmy2soxjwr7yu7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlVRcACgkQ2O7X88g7
+poyog//U2xl0Snja5iNtSSkPAB/LObrHAW/YcvFZeYqaK1/0adUESkxTVij8cb0
3ALfG5g//kBjbBU5ZBUOyPqmL1jqyXlladzi0TjUmHvX/CamCPKHUUiIH/HZQTuN
Yq3kOh/PqFkjYN3ppTzhttSK7rtmGlOG+vK9uO2Iv0fb2CgKeV/32Gmi4nTariOM
myTbyu/SeT/YVQVbvRCDOqCC69sq2fgvYoVB7nlyP4+LdmPJJcFBL41J3rz4f/Yn
H9llbLa85yTm0hxzVPEp8+DDBEHoV0WEQrLNjyE8czgsuayylaxb+HbqIp8x+GX7
qKQYeuOqimUSHElJWm3zEM82t336iGpyurIdxmliCHRI8AinTDVJ5/wig7ZNfRHE
QlISD6aSj+Jc8vRmSBmqmi8ILQ0Zcv3PWWUf+P8HPHYpxNptygxVKXsRIvlNOAKX
7rXIcWdG9+M9pOKbuQPWeVOdgGHryDtc9G77+kOCDIKLPdkRwZj3Ins2xqPH+fqh
WBHr0h6PsctHc00wXvq9n2WQLT8y8g05KX8ePjhCQfgKJyQJXQUqDQOs4rT0e+eA
2REdq8b+pPVqhPyb9MxefZ/d36yqGcZ/GsXr+hIw2FHRfjeVjFJz3G69Z3Biu6ds
T3oeZgQRixQA9YYXytMPOsEN4Mn85UefCUBtQcklQs4Xf+Uadpk=
=eP+m
-----END PGP SIGNATURE-----

--vvmy2soxjwr7yu7c--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

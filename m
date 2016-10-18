From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] mmc: core: Check regulator pointer
Date: Tue, 18 Oct 2016 11:47:04 +0200
Message-ID: <20161018094704.ohubpg4j3jhc7cay@lukather>
References: <20161018084343.680-1-maxime.ripard@free-electrons.com>
 <CAPDyKFquN_f1ZKW3G6ZsTnnGJa-7N4R4-RpF=E4PN+7OTrxhZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sflpdxdmg3mpcmk7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFquN_f1ZKW3G6ZsTnnGJa-7N4R4-RpF=E4PN+7OTrxhZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--sflpdxdmg3mpcmk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 18, 2016 at 11:03:02AM +0200, Ulf Hansson wrote:
> On 18 October 2016 at 10:43, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > mmc_regulator_get_supply might silently fail if the regulators are not
> > found, which is the right thing to do since both these regulators are
> > optional.
> >
> > However, the drivers then have no way to know whether or not they should
> > proceed and call mmc_regulator_set_ocr. And since this function doesn't
>=20
> Host drivers should check "if (!IS_ERR(mmc->supply.vmmc))" before
> invoking mmc_regulator_set_ocr(). I wasn't aware that some didn't.

Ok, so the sunxi one definitely doesn't:
http://lxr.free-electrons.com/source/drivers/mmc/host/sunxi-mmc.c#L735

> My point is, that in some cases the regulator is optional, then a host
> driver need to take other actions to power on/off the card.

What are those actions? Just power up the card through some other
mean, or is it more tied to the MMC protocol?

Also, I'm wondering if VMMC is actually optional at all. In all cases
I can think of, it would be represented as a regulator anyway.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--sflpdxdmg3mpcmk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYBe+TAAoJEBx+YmzsjxAgakcP/AzZu7qQb+s53pLQygBjxRn8
f7DhvLG/hbpdLfll6bWymVH9TUz4sn8ApGVefQupBJ5wmExym4VwegT8SvxqYl1D
eSjul1iPwDP306u/TIfBoY/Qlf810FSKQ0aHIH/JXezoMCfhEr0KoFCvtw4gFoBF
8ERB6WonYdDYksLAGZfA6KL9On9Urna3cYjkXhW9+bP7FKyKb65retVswwDoS/wv
PX63QhFiXSCNGzeKE7gg3xCt8dFwJegfP48790BHm0bhFg391yVfTJ1Fmj1p3w6j
8B8D5uXirewpQanOW9S3KiqrUTIMqqYt78kgISjv1DgwT9RVhur/XarAvoQxLTc8
ZFQKArxAH3/MOWnFbuGv6hp0Rag9GoIVA9GHJfSZTOBjdAi3NJt6AIOaqqMCEPM2
hdcx8y22W4w7a4YVTDgGxHo1anS5jBvAVky6pHjKhxyjsD9sXxfwMAAv1Rza+r8z
+sXwf39vEAXtj9uuQdTvZ6tA0MzLuyzNiL7cMfdwlJ4EpyOlU3iYoGvcts/GI0jq
M2SFZQDqVmCKZEQSZ8pRFaehhEnBYv1oBAg9irMF/Z27SBAmOtBuY2PCq5ohYqF3
J8aWPBfeCNfXKnnUWoKtBlpelRsOXJ97iWVwN8PKolVbkODWa5XQ38Eek/28AuBV
DEAw2O+niuHmiMYog2EN
=3LH8
-----END PGP SIGNATURE-----

--sflpdxdmg3mpcmk7--

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/5 v3] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Mon, 28 May 2012 05:20:06 +0200
Message-ID: <CAPDyKFrrxyk-JpLFge5+0xbYjJ=-24avWn8Optfg88-i006-Ng@mail.gmail.com>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
	<Pine.LNX.4.64.1205251208440.13353@axis700.grange>
	<Pine.LNX.4.64.1205251230540.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39972 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab2E1DUH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 May 2012 23:20:07 -0400
Received: by eeit10 with SMTP id t10so585341eei.19
        for <linux-mmc@vger.kernel.org>; Sun, 27 May 2012 20:20:06 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205251230540.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Guennadi,

On 25 May 2012 17:14, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wro=
te:
> Add a function to get a regulator, supplying card's Vdd on a specific=
 host.
> If such a regulator is found, the function checks, whether a valid OC=
R mask
> can be obtained from this regulator.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> v3: remove bogus attempts to ignore the dummy regulator, drop the che=
ck
> for whether the regulator can change status, do not assign
> MMC_CAP_POWER_OFF_CARD automatically. Thanks to Mark and Magnus for
> comments.
>
> =A0drivers/mmc/core/core.c =A0| =A0 17 +++++++++++++++++
> =A0include/linux/mmc/host.h | =A0 =A06 ++++++
> =A02 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b6141d..0f92ec0 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1013,6 +1013,23 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc=
,
> =A0}
> =A0EXPORT_SYMBOL(mmc_regulator_set_ocr);
>
> +struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc)
> +{
> + =A0 =A0 =A0 struct device *dev =3D mmc_dev(mmc);
> + =A0 =A0 =A0 struct regulator *supply =3D devm_regulator_get(dev, "v=
mmc");
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (IS_ERR(supply))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 ret =3D mmc_regulator_get_ocrmask(supply);
> + =A0 =A0 =A0 if (ret > 0)

Could we have an "else" were a dev_warn prints some info and as well
the "ret" maybe?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->ocr_avail =3D ret;
> +
> + =A0 =A0 =A0 return supply;
> +}
> +EXPORT_SYMBOL(mmc_regulator_get_vmmc);
> +
> =A0#endif /* CONFIG_REGULATOR */
>
> =A0/*
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0707d22..368b317 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -364,6 +364,7 @@ int mmc_regulator_get_ocrmask(struct regulator *s=
upply);
> =A0int mmc_regulator_set_ocr(struct mmc_host *mmc,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct regulator *supp=
ly,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned short vdd_bit=
);
> +struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc);
> =A0#else
> =A0static inline int mmc_regulator_get_ocrmask(struct regulator *supp=
ly)
> =A0{
> @@ -376,6 +377,11 @@ static inline int mmc_regulator_set_ocr(struct m=
mc_host *mmc,
> =A0{
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +
> +static inline struct regulator *mmc_regulator_get_vmmc(struct mmc_ho=
st *mmc)
> +{
> + =A0 =A0 =A0 return NULL;
> +}
> =A0#endif
>

Some follow-up thoughts, if mmc_regulator_get_vmmc is supposed to be
used from the host drivers, the mmc_regulator_get_ocrmask function do
no longer have to be an exported function, but instead a static
function on core.c I suppose this can be fixed in separate patch,
where we also add mmc_regulator_get_vmmc for all host drivers?

Kind regards
Ulf Hansson

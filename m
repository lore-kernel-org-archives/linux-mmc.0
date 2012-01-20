From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 05/31] ARM: amba: mxs: convert to use amba_device_alloc
Date: Fri, 20 Jan 2012 20:25:39 +0800
Message-ID: <20120120122535.GA25917@S2101-09.ap.freescale.net>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAhZ-0005EY-BZ@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:44284 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751820Ab2ATMOJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 07:14:09 -0500
Content-Disposition: inline
In-Reply-To: <E1RoAhZ-0005EY-BZ@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>, Sascha Hauer <kernel@pengutronix.de>

On Fri, Jan 20, 2012 at 09:24:05AM +0000, Russell King - ARM Linux wrot=
e:
> Convert MXS to use the new amba_device_alloc APIs.
>=20
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-mxs/devices.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-mxs/devices.c b/arch/arm/mach-mxs/devices.=
c
> index fe3e847..052d8dd 100644
> --- a/arch/arm/mach-mxs/devices.c
> +++ b/arch/arm/mach-mxs/devices.c
> @@ -77,16 +77,18 @@ struct platform_device *__init mxs_add_platform_d=
evice_dmamask(
> =20
>  int __init mxs_add_amba_device(const struct amba_device *dev)
>  {
> -	struct amba_device *adev =3D kmalloc(sizeof(*adev), GFP_KERNEL);
> +	struct amba_device *adev =3D amba_device_alloc(dev->init_name,

The 'dev->init_name' needs to be 'dev->dev.init_name'.  Otherwise, we
see the compile error below.

  CC      arch/arm/mach-mxs/devices.o
arch/arm/mach-mxs/devices.c: In function =E2=80=98mxs_add_amba_device=E2=
=80=99:
arch/arm/mach-mxs/devices.c:80:50: error: =E2=80=98const struct amba_de=
vice=E2=80=99 has no member named =E2=80=98init_name=E2=80=99

Other than that,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

> +		dev->res.start, resource_size(&dev->res));
> =20
>  	if (!adev) {
>  		pr_err("%s: failed to allocate memory", __func__);
>  		return -ENOMEM;
>  	}
> =20
> -	*adev =3D *dev;
> +	adev->irq[0] =3D dev->irq[0];
> +	adev->irq[1] =3D dev->irq[1];
> =20
> -	return amba_device_register(adev, &iomem_resource);
> +	return amba_device_add(adev, &iomem_resource);
>  }
> =20
>  struct device mxs_apbh_bus =3D {
> --=20

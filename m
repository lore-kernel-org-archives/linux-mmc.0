From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH v2 3/4] arm/dts: OMAP4: Add mmc controller nodes and board data
Date: Fri, 24 Feb 2012 15:46:44 +0530
Message-ID: <CANrkHUaP7cV_vSKQYZkeF-aS5CEi2CAp3_9aDJKCVOX-67oNPg@mail.gmail.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
	<1329998490-27555-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1329998490-27555-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, svenkatr@ti.com, linaro-dev@lists.linaro.org
List-Id: linux-mmc@vger.kernel.org

> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.d=
tsi
> index 29f4589..9204f60 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -25,6 +25,11 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial1 =3D &uart2;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial2 =3D &uart3;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial3 =3D &uart4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc1 =3D &mmc1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc2 =3D &mmc2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc3 =3D &mmc3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc4 =3D &mmc4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc5 =3D &mmc5;
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0cpus {
> @@ -155,5 +160,31 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ti,hwmods =3D "i2c4";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc1: mmc@1 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap=
4-hsmmc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "mmc1";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,dual-volt;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc2: mmc@2 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap=
4-hsmmc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "mmc2";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };

Hi Rajendra,
Is there a way to control the device registration order,
eMMC connected to mmc2 needs to be registered as /dev/mmcblk0p ...
irrespective of whether SD card is mount or not on mmc1 card slot.
So that bootargs would not have to be modified when filesystem is on eM=
MC.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc3: mmc@3 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap=
4-hsmmc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "mmc3";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc4: mmc@4 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap=
4-hsmmc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "mmc4";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc5: mmc@5 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,omap=
4-hsmmc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti,hwmods =3D "mmc5";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> =A0 =A0 =A0 =A0};
> =A0};
> --
> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

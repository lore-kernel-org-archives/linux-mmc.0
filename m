From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 6/8] ARM: dts: sun4i: Add support for mmc
Date: Tue, 11 Mar 2014 16:55:47 +0100
Message-ID: <531F3203.3010807@redhat.com>
References: <20140211190543.4568.83517.stgit@dizzy-6.o2s.ch> <20140211193423.4568.34947.stgit@dizzy-6.o2s.ch> <ac47de94-92ef-4b53-9983-34dd2f9924ea@googlegroups.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBE7E7SMAKGQE5QUPYVA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <ac47de94-92ef-4b53-9983-34dd2f9924ea-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

Oh, good catch, thanks! Fixed in the sunxi-devel branch
in my *personal* git repo. I'll also push this to the official linux-sunxi
sunxi-devel branch later today.

Regards,

Hans



On 03/10/2014 10:49 PM, mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> On Tuesday, February 11, 2014 1:34:25 PM UTC-6, David Lanzend=C3=B6rfer w=
rote:
>> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> index b139ee6..20b976a 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> @@ -33,6 +33,14 @@
>>  			};
>>  	=09
>>  		};
>> +		mmc0: mmc@01c0f000 {
>> +			pinctrl-names =3D "default", "default";
>> +			pinctrl-0 =3D <&mmc0_pins_a>;
>> +			pinctrl-1 =3D <&mmc0_cd_pin_reference_design>;
>> +			cd-gpios =3D <&pio 7 1 0>; /* PH1 */
>> +			status =3D "okay";
>> +		};
>> +
>>  		pinctrl@01c20800 {
>>  	=09
>>  			led_pins_cubieboard: led_pins@0 {
>>  		=09
>>  				allwinner,pins =3D "PH20", "PH21";
>> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi
>> b/arch/arm/boot/dts/sun4i-a10.dtsi
>> index 9044c53..d040d37 100644
>> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
>> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
>> @@ -330,6 +330,46 @@
>>  			#size-cells =3D <0>;
>>  	=09
>>  		};
>> +		mmc0: mmc@01c0f000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
>=20
> Should be "allwinner,sun4i-a10-mmc", or we will hang the MMC driver on A1=
0.
>=20
>> +		mmc1: mmc@01c10000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
> ditto
>=20
>> +		mmc2: mmc@01c11000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
> ditto
>=20
>> +		mmc3: mmc@01c12000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
> ditto
>=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

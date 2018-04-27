From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [PATCH 1/3] mmc: sunxi: add support for the MMC
 controller on H6
Date: Fri, 27 Apr 2018 16:38:29 +0800
Message-ID: <EECAFDD1-FEAC-42DF-BB17-F11C1C8612DE@aosc.io>
References: <20180426140728.43155-1-icenowy@aosc.io> <20180426140728.43155-2-icenowy@aosc.io> <f722ce51-2391-620c-df65-48f047b5f3d5@arm.com>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBI6DRPLQKGQEOIPGODA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <f722ce51-2391-620c-df65-48f047b5f3d5-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



=E4=BA=8E 2018=E5=B9=B44=E6=9C=8827=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=8812=
:45:24, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> =E5=86=99=E5=88=B0:
>Hi,
>
>On 26/04/18 15:07, Icenowy Zheng wrote:
>> The new Allwinner H6 SoC have 3 MMC controllers. The first and second
>> ones are similar to the ones on A64, but the third one adds EMCE
>> (Embedded Crypto Engine) support which does hardware transparent
>crypto
>> on the eMMC.
>>=20
>> As we still do not have support for EMCE, and the support of it is
>> disabled by defualt, we just duplicate the A64 mmc configurations and
>> change the compatible string.
>
>So if the A64 MMC part is compatible, we should express it like this:
>
>> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  2 ++
>>  drivers/mmc/host/sunxi-mmc.c                        | 16
>++++++++++++++++
>>  2 files changed, 18 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>> index 132e0007d7d6..e6aa5c7a5e12 100644
>> --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
>> @@ -16,6 +16,8 @@ Required properties:
>>     * "allwinner,sun9i-a80-mmc"
>>     * "allwinner,sun50i-a64-emmc"
>>     * "allwinner,sun50i-a64-mmc"
>> +   * "allwinner,sun50i-h6-emmc"
>> +   * "allwinner,sun50i-h6-mmc"
>
>This should be changed to:
>
>      * "allwinner,sun50i-h6-emmc", "allwinner,sun50i-a64-emmc"
>      * "allwinner,sun50i-h6-mmc", "allwinner,sun50i-a64-mmc"

This list shouldn't list pairs, and as I said in the reply,
these pairs are not valid.

>
>>   - reg : mmc controller base registers
>>   - clocks : a list with 4 phandle + clock specifier pairs
>>   - clock-names : must contain "ahb", "mmc", "output" and "sample"
>> diff --git a/drivers/mmc/host/sunxi-mmc.c
>b/drivers/mmc/host/sunxi-mmc.c
>> index 97c6b79b7d6f..05e2b5fd7aa4 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -1168,6 +1168,20 @@ static const struct sunxi_mmc_cfg
>sun50i_a64_emmc_cfg =3D {
>>  	.can_calibrate =3D true,
>>  };
>> =20
>> +static const struct sunxi_mmc_cfg sun50i_h6_cfg =3D {
>> +	.idma_des_size_bits =3D 16,
>> +	.clk_delays =3D NULL,
>> +	.can_calibrate =3D true,
>> +	.mask_data0 =3D true,
>> +	.needs_new_timings =3D true,
>> +};
>> +
>> +static const struct sunxi_mmc_cfg sun50i_h6_emmc_cfg =3D {
>> +	.idma_des_size_bits =3D 13,
>> +	.clk_delays =3D NULL,
>> +	.can_calibrate =3D true,
>> +};
>> +
>
>... and then we don't need those changes ...
>
>>  static const struct of_device_id sunxi_mmc_of_match[] =3D {
>>  	{ .compatible =3D "allwinner,sun4i-a10-mmc", .data =3D &sun4i_a10_cfg
>},
>>  	{ .compatible =3D "allwinner,sun5i-a13-mmc", .data =3D &sun5i_a13_cfg
>},
>> @@ -1176,6 +1190,8 @@ static const struct of_device_id
>sunxi_mmc_of_match[] =3D {
>>  	{ .compatible =3D "allwinner,sun9i-a80-mmc", .data =3D &sun9i_a80_cfg
>},
>>  	{ .compatible =3D "allwinner,sun50i-a64-mmc", .data =3D &sun50i_a64_cf=
g
>},
>>  	{ .compatible =3D "allwinner,sun50i-a64-emmc", .data =3D
>&sun50i_a64_emmc_cfg },
>> +	{ .compatible =3D "allwinner,sun50i-h6-mmc", .data =3D &sun50i_h6_cfg
>},
>> +	{ .compatible =3D "allwinner,sun50i-h6-emmc", .data =3D
>&sun50i_h6_emmc_cfg },
>
>... and those, at least yet.
>Should we ever extend the driver to support the EMCE, we can add them
>at
>this occasion.
>
>So this patch would just add the compatible pairs to the binding doc.
>
>Cheers,
>Andre.
>
>>  	{ /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
>>=20
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

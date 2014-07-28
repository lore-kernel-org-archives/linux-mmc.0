From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv6 1/5] mmc: dw_mmc: modify the dt-binding for removing
 slot-node and supports-highspeed
Date: Mon, 28 Jul 2014 11:11:17 +0900
Message-ID: <53D5B145.6020807@samsung.com>
References: <1406250713-22604-1-git-send-email-jh80.chung@samsung.com>
 <1406250713-22604-2-git-send-email-jh80.chung@samsung.com>
 <53D24988.9010208@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <53D24988.9010208@suse.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi, Andreas,

On 07/25/2014 09:11 PM, Andreas F=E4rber wrote:
> Hi Jaehoon,
>=20
> Am 25.07.2014 03:11, schrieb Jaehoon Chung:
>> Almost Soc is used the slot per a host.
>=20
> Something's very wrong with this sentence. What are you trying to say=
?
> Almost all SoCs use one slot only per host controller device?

If you are confusion for this sentence, sorry.
It means that we recommend only one slot per host controller.
Some controller can be supported the multiple slot per a host controlle=
r.
But i didn't find anywhere it used the multiple slot per a host control=
ler.


Best Regards,
Jaehoon Chung
>=20
>> Don't use the slot-node and deprecated the "supports-highsped" prope=
rty.
>=20
> s/deprecated/deprecate/ ?
> s/highsped/highspeed/
>=20
>> Instead, use the cap-mmc/sd-highspeed.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Reviewed-by: Tushar Behera <trblinux@gmail.com>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   17 +++++----=
--------
>>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   12 +++++----=
---
>>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   12 +++++----=
---
>>  3 files changed, 15 insertions(+), 26 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.tx=
t b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> index 532b1d4..9308325 100644
>> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> @@ -46,13 +46,14 @@ Required Properties:
>>        - if CIU clock divider value is 0 (that is divide by 1), both=
 tx and rx
>>          phase shift clocks should be 0.
>> =20
>> -Required properties for a slot:
>> +Required properties for a slot (Deprecated - Recommend to use one s=
lot per a host):
>=20
> "per host"
>=20
>> =20
>>  * gpios: specifies a list of gpios used for command, clock and data=
 bus. The
>>    first gpio is the command line and the second gpio is the clock l=
ine. The
>>    rest of the gpios (depending on the bus-width property) are the d=
ata lines in
>>    no particular order. The format of the gpio specifier depends on =
the gpio
>>    controller.
>> + (Deprecated - Refer to Documentaion/devicetree/binding/pinctrl/sam=
sung-pinctrl.txt)
>=20
> "Documentation/"
>=20
> Nit: Is the indentation intentional? (parenthesis not aligned with te=
xt)
>=20
>> =20
>>  Example:
>> =20
>> @@ -69,21 +70,13 @@ Example:
>> =20
>>  	dwmmc0@12200000 {
>>  		num-slots =3D <1>;
>> -		supports-highspeed;
>> +		cap-mmc-highspeed;
>> +		cap-sd-highspeed;
>>  		broken-cd;
>>  		fifo-depth =3D <0x80>;
>>  		card-detect-delay =3D <200>;
>>  		samsung,dw-mshc-ciu-div =3D <3>;
>>  		samsung,dw-mshc-sdr-timing =3D <2 3>;
>>  		samsung,dw-mshc-ddr-timing =3D <1 2>;
>> -
>> -		slot@0 {
>> -			reg =3D <0>;
>> -			bus-width =3D <8>;
>> -			gpios =3D <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
>> -				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
>> -				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
>> -				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
>> -				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
>> -		};
>> +		bus-width =3D <8>;
>>  	};
>> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/=
Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>> index e5bc49f..3b35449 100644
>> --- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>> @@ -34,13 +34,11 @@ Example:
>>  		num-slots =3D <1>;
>>  		vmmc-supply =3D <&ldo12>;
>>  		fifo-depth =3D <0x100>;
>> -		supports-highspeed;
>>  		pinctrl-names =3D "default";
>>  		pinctrl-0 =3D <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
>> -		slot@0 {
>> -			reg =3D <0>;
>> -			bus-width =3D <4>;
>> -			disable-wp;
>> -			cd-gpios =3D <&gpio10 3 0>;
>> -		};
>> +		bus-width =3D <4>;
>> +		disable-wp;
>> +		cd-gpios =3D <&gpio10 3 0>;
>> +		cap-mmc-highspeed;
>> +		cap-sd-highspeed;
>>  	};
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.=
txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> index 2d4a725..346c609 100644
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> @@ -67,7 +67,8 @@ Optional properties:
>>  * card-detect-delay: Delay in milli-seconds before detecting card a=
fter card
>>    insert event. The default value is 0.
>> =20
>> -* supports-highspeed: Enables support for high speed cards (up to 5=
0MHz)
>> +* supports-highspeed (DEPRECATED): Enables support for high speed c=
ards (up to 50MHz)
>> +			   (use "cap-mmc-highspeed" or "cap-sd-highspeed" instead)
>> =20
>>  * broken-cd: as documented in mmc core bindings.
>> =20
>> @@ -98,14 +99,11 @@ board specific portions as listed below.
>>  		clock-frequency =3D <400000000>;
>>  		clock-freq-min-max =3D <400000 200000000>;
>>  		num-slots =3D <1>;
>> -		supports-highspeed;
>>  		broken-cd;
>>  		fifo-depth =3D <0x80>;
>>  		card-detect-delay =3D <200>;
>>  		vmmc-supply =3D <&buck8>;
>> -
>> -		slot@0 {
>> -			reg =3D <0>;
>> -			bus-width =3D <8>;
>> -		};
>> +		bus-width =3D <8>;
>> +		cap-mmc-highspeed;
>> +		cap-sd-highspeed;
>>  	};
>=20
> Regards,
> Andreas
>=20

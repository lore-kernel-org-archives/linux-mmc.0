From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [linux-sunxi] Re: [PATCH v8 07/17] ARM: dts: sun5i: Add mmc controller
 nodes
Date: Wed, 23 Apr 2014 11:57:25 +0200
Message-ID: <53578E85.9000906@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com> <1398164497-14212-8-git-send-email-hdegoede@redhat.com> <20140423094840.GL24905@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5286 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009AbaDWJ6M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 23 Apr 2014 05:58:12 -0400
In-Reply-To: <20140423094840.GL24905@lukather>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, Mike Turquette <mturquette@linaro.org>, =?ISO-8859-1?Q?David_Lanzend=F6?= =?ISO-8859-1?Q?rfer?= <david.lanzendoerfer@o2s.ch>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

Hi,

On 04/23/2014 11:48 AM, Maxime Ripard wrote:
> On Tue, Apr 22, 2014 at 01:01:27PM +0200, Hans de Goede wrote:
>> From: David Lanzend=F6rfer <david.lanzendoerfer@o2s.ch>
>>
>> Add nodes for the 3 mmc controllers found on A10s SoCs and for the 2=
 mmc
>> controllers found on A13 SoCs.
>>
>> Signed-off-by: David Lanzend=F6rfer <david.lanzendoerfer@o2s.ch>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/arm/boot/dts/sun5i-a10s.dtsi | 27 +++++++++++++++++++++++++++
>>  arch/arm/boot/dts/sun5i-a13.dtsi  | 18 ++++++++++++++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/s=
un5i-a10s.dtsi
>> index 79989ed..12113f9 100644
>> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
>> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
>> @@ -338,6 +338,33 @@
>>  			#size-cells =3D <0>;
>>  		};
>> =20
>> +		mmc0: mmc@01c0f000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
>> +			reg =3D <0x01c0f000 0x1000>;
>> +			clocks =3D <&ahb_gates 8>, <&mmc0_clk>;
>> +			clock-names =3D "ahb", "mod";
>> +			interrupts =3D <32>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		mmc1: mmc@01c10000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
>> +			reg =3D <0x01c10000 0x1000>;
>> +			clocks =3D <&ahb_gates 9>, <&mmc1_clk>;
>> +			clock-names =3D "ahb", "mod";
>> +			interrupts =3D <33>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		mmc2: mmc@01c11000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
>> +			reg =3D <0x01c11000 0x1000>;
>> +			clocks =3D <&ahb_gates 10>, <&mmc2_clk>;
>> +			clock-names =3D "ahb", "mod";
>> +			interrupts =3D <34>;
>> +			status =3D "disabled";
>> +		};
>> +
>>  		usbphy: phy@01c13400 {
>>  			#phy-cells =3D <1>;
>>  			compatible =3D "allwinner,sun5i-a13-usb-phy";
>> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/su=
n5i-a13.dtsi
>> index f01c315..a0e55e8 100644
>> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
>> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
>> @@ -320,6 +320,24 @@
>>  			#size-cells =3D <0>;
>>  		};
>> =20
>> +		mmc0: mmc@01c0f000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
>> +			reg =3D <0x01c0f000 0x1000>;
>> +			clocks =3D <&ahb_gates 8>, <&mmc0_clk>;
>> +			clock-names =3D "ahb", "mod";
>> +			interrupts =3D <32>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		mmc2: mmc@01c11000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
>> +			reg =3D <0x01c11000 0x1000>;
>> +			clocks =3D <&ahb_gates 10>, <&mmc2_clk>;
>> +			clock-names =3D "ahb", "mod";
>> +			interrupts =3D <34>;
>> +			status =3D "disabled";
>> +		};
>> +
>=20
> The A13 user manual reports that there is 3 of them in the A13, just
> like on the A10s. Have you forgotten one?

mmc1 is likely there, but it is not usable as it is not routed to the o=
utside,
so I've left it out deliberately.

Regards,

Hans

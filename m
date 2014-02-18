From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 5/8] ARM: dts: sun7i: Add support for mmc
Date: Tue, 18 Feb 2014 16:10:38 +0100
Message-ID: <530377EE.8010909@redhat.com>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch> <20140217100241.15040.24836.stgit@pagira.o2s.ch> <20140218142221.GJ3142@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBAPQRWMAKGQEX53W6RA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140218142221.GJ3142@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?ISO-8859-1?Q?Davi?= =?ISO-8859-1?Q?d_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 02/18/2014 03:22 PM, Maxime Ripard wrote:
> On Mon, Feb 17, 2014 at 11:02:41AM +0100, David Lanzend=F6rfer wrote:
>> Signed-off-by: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |    8 +++
>>   arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |    8 +++
>>   arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |   23 +++++++++
>>   arch/arm/boot/dts/sun7i-a20.dtsi                |   61 +++++++++++++++=
++++++++
>>   4 files changed, 100 insertions(+)
>>
>
> I'd prefer to have three patches here:
>     - One that add the controllers
>     - One that add the pin muxing options
>     - One that enable the controllers on the various boards.
>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot=
/dts/sun7i-a20-cubieboard2.dts
>> index 5c51cb8..ae800b6 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
>> @@ -34,6 +34,14 @@
>>   			};
>>   		};
>>
>> +		mmc0: mmc@01c0f000 {
>> +			pinctrl-names =3D "default", "default";
>> +			pinctrl-0 =3D <&mmc0_pins_a>;
>> +			pinctrl-1 =3D <&mmc0_cd_pin_reference_design>;
>
> This can be made a single pinctrl group, you don't need the pinctrl-1
> stuff, it only complicates the node.

Then how do we deal with boards which use a different gpio for card-detect =
?

In that case we don't want to change the mux setting of the reference
design cd pin. IOW I believe that having 2 separate pinctrl settings for
this is the rigt thing todo. I would prefer using just mmc0_cd_pin_a instea=
d
of _reference_design though.

Oh wait, you're probably talking about using:
			pinctrl-0 =3D <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;

Yes that would be better.

>
>> +			cd-gpios =3D <&pio 7 1 0>; /* PH1 */
>> +			status =3D "okay";
>> +		};
>> +
>>   		pinctrl@01c20800 {
>>   			led_pins_cubieboard2: led_pins@0 {
>>   				allwinner,pins =3D "PH20", "PH21";
>> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/=
dts/sun7i-a20-cubietruck.dts
>> index f9dcb61..370cef84 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>> @@ -19,6 +19,14 @@
>>   	compatible =3D "cubietech,cubietruck", "allwinner,sun7i-a20";
>>
>>   	soc@01c00000 {
>> +		mmc0: mmc@01c0f000 {
>> +			pinctrl-names =3D "default", "default";
>> +			pinctrl-0 =3D <&mmc0_pins_a>;
>> +			pinctrl-1 =3D <&mmc0_cd_pin_reference_design>;
>> +			cd-gpios =3D <&pio 7 1 0>; /* PH1 */
>> +			status =3D "okay";
>> +		};
>> +
>>   		pinctrl@01c20800 {
>>   			led_pins_cubietruck: led_pins@0 {
>>   				allwinner,pins =3D "PH7", "PH11", "PH20", "PH21";
>> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/=
boot/dts/sun7i-a20-olinuxino-micro.dts
>> index ead3013..685ec06 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>> @@ -34,7 +34,30 @@
>>   			};
>>   		};
>>
>> +		mmc0: mmc@01c0f000 {
>> +			pinctrl-names =3D "default", "default";
>> +			pinctrl-0 =3D <&mmc0_pins_a>;
>> +			pinctrl-1 =3D <&mmc0_cd_pin_reference_design>;
>> +			cd-gpios =3D <&pio 7 1 0>; /* PH1 */
>> +			status =3D "okay";
>> +		};
>> +
>> +		mmc3: mmc@01c12000 {
>> +			pinctrl-names =3D "default", "default";
>> +			pinctrl-0 =3D <&mmc3_pins_a>;
>> +			pinctrl-1 =3D <&mmc3_cd_pin_olinuxinom>;
>> +			cd-gpios =3D <&pio 7 11 0>; /* PH11 */
>> +			status =3D "okay";
>> +		};
>> +
>>   		pinctrl@01c20800 {
>> +			mmc3_cd_pin_olinuxinom: mmc3_cd_pin@0 {
>> +				allwinner,pins =3D "PH11";
>> +				allwinner,function =3D "gpio_in";
>> +				allwinner,drive =3D <0>;
>> +				allwinner,pull =3D <1>;
>> +			};
>> +
>>   			led_pins_olinuxino: led_pins@0 {
>>   				allwinner,pins =3D "PH2";
>>   				allwinner,function =3D "gpio_out";
>> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-=
a20.dtsi
>> index 9ff0948..5b55414 100644
>> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>> @@ -355,6 +355,46 @@
>>   			#size-cells =3D <0>;
>>   		};
>>
>> +		mmc0: mmc@01c0f000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
>> +			reg =3D <0x01c0f000 0x1000>;
>> +			clocks =3D <&ahb_gates 8>, <&mmc0_clk>;
>> +			clock-names =3D "ahb", "mod";
>> +			interrupts =3D <0 32 4>;
>> +			bus-width =3D <4>;
>
> This belongs to the board, the controller itself is able to handle
> several bus width.

I believe that providing some form of default in the dtsi makes sense
here and all boards we've seen sofar always use 4 bits, we can always
override this from the dts file itself.

>
>> +			status =3D "disabled";
>> +		};
>> +
>> +		mmc1: mmc@01c10000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
>> +			reg =3D <0x01c10000 0x1000>;
>> +			clocks =3D <&ahb_gates 9>, <&mmc1_clk>;
>> +			clock-names =3D "ahb", "mod";
>> +			interrupts =3D <0 33 4>;
>> +			bus-width =3D <4>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		mmc2: mmc@01c11000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
>> +			reg =3D <0x01c11000 0x1000>;
>> +			clocks =3D <&ahb_gates 10>, <&mmc2_clk>;
>> +			clock-names =3D "ahb", "mod";
>> +			interrupts =3D <0 34 4>;
>> +			bus-width =3D <4>;
>> +			status =3D "disabled";
>> +		};
>> +
>> +		mmc3: mmc@01c12000 {
>> +			compatible =3D "allwinner,sun5i-a13-mmc";
>> +			reg =3D <0x01c12000 0x1000>;
>> +			clocks =3D <&ahb_gates 11>, <&mmc3_clk>;
>> +			clock-names =3D "ahb", "mod";
>> +			interrupts =3D <0 35 4>;
>> +			bus-width =3D <4>;
>> +			status =3D "disabled";
>> +		};
>> +
>>   		pio: pinctrl@01c20800 {
>>   			compatible =3D "allwinner,sun7i-a20-pinctrl";
>>   			reg =3D <0x01c20800 0x400>;
>> @@ -432,6 +472,27 @@
>>   				allwinner,drive =3D <0>;
>>   				allwinner,pull =3D <0>;
>>   			};
>> +
>> +			mmc0_pins_a: mmc0@0 {
>> +				allwinner,pins =3D "PF0","PF1","PF2","PF3","PF4","PF5";
>> +				allwinner,function =3D "mmc0";
>> +				allwinner,drive =3D <3>;
>> +				allwinner,pull =3D <0>;
>> +			};
>> +
>> +			mmc0_cd_pin_reference_design: mmc0_cd_pin@0 {
>> +				allwinner,pins =3D "PH1";
>> +				allwinner,function =3D "gpio_in";
>> +				allwinner,drive =3D <0>;
>> +				allwinner,pull =3D <1>;
>> +			};
>> +
>> +			mmc3_pins_a: mmc3@0 {
>> +				allwinner,pins =3D "PI4","PI5","PI6","PI7","PI8","PI9";
>> +				allwinner,function =3D "mmc3";
>> +				allwinner,drive =3D <3>;
>> +				allwinner,pull =3D <0>;
>> +			};
>>   		};
>>
>>   		timer@01c20c00 {
>>
>
> Looks good otherwise.
>
> Thanks!
> Maxime
>


Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.

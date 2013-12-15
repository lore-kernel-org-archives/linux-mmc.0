From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH 2/5] ARM: dts: sun4i: Add support for mmc
Date: Sun, 15 Dec 2013 15:31:29 +0100
Message-ID: <52ADBD41.4050104@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com> <1387058295-20641-3-git-send-email-hdegoede@redhat.com> <20131215135854.GF3651@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBRP2W2KQKGQEO4T7BFA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131215135854.GF3651@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 12/15/2013 02:58 PM, Maxime Ripard wrote:
> Hi Hans,
>
> On Sat, Dec 14, 2013 at 10:58:12PM +0100, Hans de Goede wrote:
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
> Commit-log :)

Heh.

Note as said before I expect David to take things from here.

>
>> ---
>>   arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 16 ++++++++++++++++
>>   arch/arm/boot/dts/sun4i-a10.dtsi           | 16 ++++++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> index 425a7db..d193937 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> @@ -42,7 +42,23 @@
>>   			};
>>   		};
>>
>> +		sdc0: sdc@01c0f000 {
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&sdc0_pins_a>;
>> +			pinctrl-1 = <&mmc0_cd_pin_cubieboard>;
>> +			cd-gpios = <&pio 7 1 0>; /* PH1 */
>> +			cd-mode = <1>;
>> +			status = "okay";
>> +		};
>> +
>>   		pinctrl@01c20800 {
>> +			mmc0_cd_pin_cubieboard: mmc0_cd_pin@0 {
>> +				allwinner,pins = "PH1";
>> +				allwinner,function = "gpio_in";
>> +				allwinner,drive = <0>;
>> +				allwinner,pull = <0>;
>> +			};
>> +
>
> You seem to be using mmc and sdc without any real distinction. Please
> try to be consistent and use only one of the two (and I have a slight
> preference for mmc :))

I just took what David was using. I agree picking one and staying with
it would be better.

>
>>   			led_pins_cubieboard: led_pins@0 {
>>   				allwinner,pins = "PH20", "PH21";
>>   				allwinner,function = "gpio_out";
>> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
>> index 4dccdb0..13bccd5 100644
>> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
>> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
>> @@ -306,6 +306,15 @@
>>   			#size-cells = <0>;
>>   		};
>>
>> +		sdc0: sdc@01c0f000 {
>> +			compatible = "allwinner,sun4i-mmc";
>> +			reg = <0x01c0f000 0x1000>;
>> +			clocks = <&ahb_gates 8>, <&mmc0>;
>> +			interrupts = <32>;
>> +			bus-width = <4>;
>> +			status = "disabled";
>> +		};
>> +
>
> The A10 has much more mmc controller doesn't it?

Yes 4 of them.

> Could you add all of them in the DT ?
>
>>   		intc: interrupt-controller@01c20400 {
>>   			compatible = "allwinner,sun4i-ic";
>>   			reg = <0x01c20400 0x400>;
>> @@ -376,6 +385,13 @@
>>   				allwinner,drive = <0>;
>>   				allwinner,pull = <0>;
>>   			};
>> +
>> +			sdc0_pins_a: sdc0@0 {
>> +				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
>> +				allwinner,function = "mmc0";
>> +				allwinner,drive = <3>;
>> +				allwinner,pull = <1>;
>
> Wow, you need both the pullups and a 40mA output?

Yes and no. The pullups are enabled by uboot and the allwinner
sources, most of my testing has been done without them, which
seems to work fine. I've enabled them to be consisten with the
allwinner sources and u-boot.

As for drive = <3>, we need drive = <2> for normal modes,
and drive = <3> for ddr mode. I simply picked <3> to keep
things KISS. It should not matter much in power usage, as
it will only make the flanks of the signal more steep. Once the
desired output level is reached the current will drop off. It will
use more current when changing the level, but for half the time,
so the effective power usage (current * time) is the same.

> Ideally, I'd like this patch to be splitted into three:
>    - One that adds the MMC controller nodes to the DTSI
>    - One that adds the muxing options you need to the pinctrl node
>    - One that enables the controller on the boards

Sounds like a good job for David. Note I've a lot more boards for
which I would like to add mmc support or dts files in general
(will do so as time permits).

For those boards which already have a dts I'll send mmc adding dts
patches to David for now so he can add the changes to the patch-set.

How do you want to deal with new boards ? Send the addition of the
base board to you (and CC David as he will need them in his tree too),
and then send a patch to add mmc to the dts to David ?

Or should I simply make it one big patch including mmc in the initial
commit ?

Regards,

Hans

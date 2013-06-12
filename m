From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v2 09/10] ARM: dts: omap3: add pbias and mmc_init pinctrl
 states
Date: Wed, 12 Jun 2013 23:13:58 +0530
Message-ID: <51B8B35E.20307@ti.com>
References: <20130523184045.GD13507@atomide.com> <1370546059-24181-1-git-send-email-balajitk@ti.com> <1370546059-24181-10-git-send-email-balajitk@ti.com> <20130612143548.GZ8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58274 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754290Ab3FLRoP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 Jun 2013 13:44:15 -0400
In-Reply-To: <20130612143548.GZ8164@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org

On Wednesday 12 June 2013 08:05 PM, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [130606 12:20]:
>> add pbias states for pbias 0, 1.8V, 3V
>> add omap3 sd/mmc2 loop back clock config for devconf1 in mmc2_init pinctrl state
>> add OMAP3430 sd/mmc1 loop back clock config for devconf0 in mmc1_init pinctrl state
>> add OMAP3630 sd/mmc1 speed mode config for prog_io1 in mmc1_init pinctrl state
>
> Looks OK to me, except these should be under mmc1 for omap[345].dtsi files.
>

I think I can move &omap3_pmx_general to omap3.dtsi and override
&pbias_1v8, &pbias_3v in omap36xx.dtsi, but I doubt pinctrl-[0,1,2,3,4]
since pull up setting can vary between boards.

> Regards,
>
> Tony
>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> ---
>>   arch/arm/boot/dts/omap3-beagle-xm.dts |   42 +++++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/omap3-beagle.dts    |   42 +++++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/omap3.dtsi          |   10 ++++++++
>>   3 files changed, 94 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
>> index 3046d1f..45d1642 100644
>> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
>> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
>> @@ -59,6 +59,40 @@
>>   	};
>>   };
>>
>> +&omap3_pmx_general {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <>;
>> +	pbias_off: pinmux_pbias_off {
>> +		pinctrl-single,bits = <
>> +			0x2b0 0x1 0x3	/* pbias */
>> +		>;
>> +	};
>> +
>> +	pbias_1v8: pinmux_pbias_1v8 {
>> +		pinctrl-single,bits = <
>> +			0x2b0 0x2 0x3	/* pbias */
>> +		>;
>> +	};
>> +
>> +	pbias_3v: pinmux_pbias_3v {
>> +		pinctrl-single,bits = <
>> +			0x2b0 0x3 0x3	/* pbias */
>> +		>;
>> +	};
>> +
>> +	mmc1_init: pinmux_mmc1_init {
>> +		pinctrl-single,bits = <
>> +			0x1d8 0x100000 0x100000	/* prog_io1 */
>> +		>;
>> +	};
>> +
>> +	mmc2_init: pinmux_mmc2_init {
>> +		pinctrl-single,bits = <
>> +			0x68 0x40 0x40	/* devconf1 */
>> +		>;
>> +	};
>> +};
>> +
>>   &i2c1 {
>>   	clock-frequency = <2600000>;
>>


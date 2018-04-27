From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 04/15] ARM: dts: dra74x-mmc-iodelay: Add a new pinctrl
 group for clk line without pullup
Date: Fri, 27 Apr 2018 16:49:48 +0530
Message-ID: <859a6ba4-3dd7-2507-d536-e6b559372f32@ti.com>
References: <20180425125449.19755-1-kishon@ti.com>
 <20180425125449.19755-5-kishon@ti.com> <20180425133529.GU5671@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425133529.GU5671@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Tony,

On Wednesday 25 April 2018 07:05 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [180425 12:57]:
>> --- a/arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
>> +++ b/arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
>> @@ -49,6 +49,17 @@
>>  		>;
>>  	};
>>  
>> +	mmc1_pins_default_no_clk_pu: mmc1_pins_default_no_clk_pu {
>> +		pinctrl-single,pins = <
>> +			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mmc1_clk.clk */
>> +			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
>> +			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
>> +			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
>> +			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
>> +			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
>> +		>;
>> +	};
>> +
>>  	mmc1_pins_sdr12: mmc1_pins_sdr12 {
>>  		pinctrl-single,pins = <
>>  			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_clk.clk */
>> -- 
> 
> If this data is the same for all of them, why don't you add something
> like dra7-iodelay.dtsi that can be included as needed?

okay, I'll add dra7-mmc-iodelay.dtsi and send a new revision.

Thanks
Kishon

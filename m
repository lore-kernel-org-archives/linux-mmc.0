From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v7 5/7] ARM: dts: add pbias dt node
Date: Tue, 7 Jan 2014 17:53:43 +0530
Message-ID: <52CBF1CF.4040706@ti.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com> <1387560955-6547-6-git-send-email-balajitk@ti.com> <20140106181928.GK24664@e106331-lin.cambridge.arm.com> <52CBD467.6060909@ti.com> <20140107105738.GA4180@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37779 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbaAGMXz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Jan 2014 07:23:55 -0500
In-Reply-To: <20140107105738.GA4180@e106331-lin.cambridge.arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "broonie@kernel.org" <broonie@kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Tuesday 07 January 2014 04:27 PM, Mark Rutland wrote:
> On Tue, Jan 07, 2014 at 10:18:15AM +0000, Balaji T K wrote:
>> On Monday 06 January 2014 11:49 PM, Mark Rutland wrote:
>>> On Fri, Dec 20, 2013 at 05:35:53PM +0000, Balaji T K wrote:
>>>> Add pbias regulator node as a child of system control
>>>> module - syscon.
>>>>
>>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>>> ---
>>>>    arch/arm/boot/dts/dra7.dtsi     |   18 ++++++++++++++++++
>>>>    arch/arm/boot/dts/omap2430.dtsi |   18 ++++++++++++++++++
>>>>    arch/arm/boot/dts/omap3.dtsi    |   18 ++++++++++++++++++
>>>>    arch/arm/boot/dts/omap4.dtsi    |   18 ++++++++++++++++++
>>>>    arch/arm/boot/dts/omap5.dtsi    |   18 ++++++++++++++++++
>>>>    5 files changed, 90 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>>> index d0df4c4..4e68df1 100644
>>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>>> @@ -110,6 +110,23 @@
>>>>    			ti,hwmods = "counter_32k";
>>>>    		};
>>>>
>>>> +		dra7_ctrl_general: tisyscon@4a002e00 {
>>>> +			compatible = "ti,control-syscon", "syscon", "simple-bus";
>>>
>>> Please, don't use simple-bus like that. The components below this node
>>> depend on it. It is _NOT_ a simple bus. Make the ti,control-syscon
>>> driver probe it's children.
>>
>> Hi Mark,
>>
>> Actually ti,control-syscon driver does not exist, so I can remove it,
>> and simple-bus is needed for child creation.
>
> This still shows up as a syscon node, with a reg property, and syscon is
> not an extension of simple-bus.
>
> There are properties in the parent node that children depend on, and
> that makes me wary of describing it as a simple bus. I'd expect to be
> able to move child nodes out of a simple-bus if ranges provided an
> idmap, and I can't do that here.
>
Hi Mark,

Not sure if I am understanding here, can you please add more info.


> Thanks,
> Mark.
>
>>
>>>
>>>> +			reg = <0x4a002e00 0x7c>;
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <1>;
>>>> +			ranges;
>>>> +			pbias_regulator: pbias_regulator {
>>>> +				compatible = "ti,pbias-omap";
>>>> +				reg = <0 0x4>;
>>>> +				pbias_mmc_reg: pbias_mmc_omap5 {
>>>> +					regulator-name = "pbias_mmc_omap5";
>>>> +					regulator-min-microvolt = <1800000>;
>>>> +					regulator-max-microvolt = <3000000>;
>>>> +				};
>>>> +			};
>>>> +		};
>>>> +
>>>
>>> Thanks,
>>> Mark.
>>>
>>


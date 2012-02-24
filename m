From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 4/4] arm/dts: OMAP3: Add mmc controller nodes and board
 data
Date: Fri, 24 Feb 2012 09:30:49 +0530
Message-ID: <4F470B71.1020308@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com> <1329998490-27555-5-git-send-email-rnayak@ti.com> <20120223185718.GZ18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120223185718.GZ18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, svenkatr@ti.com, linaro-dev@lists.linaro.org
List-Id: linux-mmc@vger.kernel.org

On Friday 24 February 2012 12:27 AM, Tony Lindgren wrote:
>> --- a/arch/arm/boot/dts/omap3.dtsi
>> +++ b/arch/arm/boot/dts/omap3.dtsi
>> @@ -113,5 +113,31 @@
>>   			#size-cells =<0>;
>>   			ti,hwmods = "i2c3";
>>   		};
>> +
>> +		mmc1: mmc@1 {
>> +			compatible = "ti,omap2-hsmmc";
>> +			ti,hwmods = "mmc1";
>> +			ti,dual-volt;
>> +		};
>> +
>> +		mmc2: mmc@2 {
>> +			compatible = "ti,omap2-hsmmc";
>> +			ti,hwmods = "mmc2";
>> +		};
>> +
>> +		mmc3: mmc@3 {
>> +			compatible = "ti,omap2-hsmmc";
>> +			ti,hwmods = "mmc3";
>> +		};
>> +
>> +		mmc4: mmc@4 {
>> +			compatible = "ti,omap2-hsmmc";
>> +			ti,hwmods = "mmc4";
>> +		};
>> +
>> +		mmc5: mmc@5 {
>> +			compatible = "ti,omap2-hsmmc";
>> +			ti,hwmods = "mmc5";
>> +		};
>>   	};
>>   };
>
> These all should all be "ti,omap3-hsmmc" I guess?

Well, I defined the binding such that both omap2 and omap3
can use the same compatible "ti,omap2-hsmmc" since there is
no difference in the way they are defined or handled. If thats
confusing, I can have separate compatibles.
Btw, I guess we do the same with a few other re-used IPs as well,
I just checked and mcpsi does the same.

>
> Tony


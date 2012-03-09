From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 4/4] arm/dts: OMAP3: Add mmc controller nodes and board
 data
Date: Fri, 09 Mar 2012 14:56:07 +0530
Message-ID: <4F59CCAF.1090806@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com> <1329998490-27555-5-git-send-email-rnayak@ti.com> <20120223185718.GZ18185@atomide.com> <4F470B71.1020308@ti.com> <20120224184859.GN18185@atomide.com> <20120309054608.647473E0901@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:44273 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751014Ab2CIJ0Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Mar 2012 04:26:16 -0500
Received: by mail-gx0-f172.google.com with SMTP id i1so931895ggm.17
        for <linux-mmc@vger.kernel.org>; Fri, 09 Mar 2012 01:26:15 -0800 (PST)
In-Reply-To: <20120309054608.647473E0901@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, balajitk@ti.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On Friday 09 March 2012 11:16 AM, Grant Likely wrote:
> On Fri, 24 Feb 2012 10:49:00 -0800, Tony Lindgren<tony@atomide.com>  wrote:
>> * Rajendra Nayak<rnayak@ti.com>  [120223 19:29]:
>>> On Friday 24 February 2012 12:27 AM, Tony Lindgren wrote:
>>>>> --- a/arch/arm/boot/dts/omap3.dtsi
>>>>> +++ b/arch/arm/boot/dts/omap3.dtsi
>>>>> @@ -113,5 +113,31 @@
>>>>>   			#size-cells =<0>;
>>>>>   			ti,hwmods = "i2c3";
>>>>>   		};
>>>>> +
>>>>> +		mmc1: mmc@1 {
>>>>> +			compatible = "ti,omap2-hsmmc";
>>>>> +			ti,hwmods = "mmc1";
>>>>> +			ti,dual-volt;
>>>>> +		};
>>>>> +
>>>>> +		mmc2: mmc@2 {
>>>>> +			compatible = "ti,omap2-hsmmc";
>>>>> +			ti,hwmods = "mmc2";
>>>>> +		};
>>>>> +
>>>>> +		mmc3: mmc@3 {
>>>>> +			compatible = "ti,omap2-hsmmc";
>>>>> +			ti,hwmods = "mmc3";
>>>>> +		};
>>>>> +
>>>>> +		mmc4: mmc@4 {
>>>>> +			compatible = "ti,omap2-hsmmc";
>>>>> +			ti,hwmods = "mmc4";
>>>>> +		};
>>>>> +
>>>>> +		mmc5: mmc@5 {
>>>>> +			compatible = "ti,omap2-hsmmc";
>>>>> +			ti,hwmods = "mmc5";
>>>>> +		};
>>>>>   	};
>>>>>   };
>>>>
>>>> These all should all be "ti,omap3-hsmmc" I guess?
>>>
>>> Well, I defined the binding such that both omap2 and omap3
>>> can use the same compatible "ti,omap2-hsmmc" since there is
>>> no difference in the way they are defined or handled. If thats
>>> confusing, I can have separate compatibles.
>>> Btw, I guess we do the same with a few other re-used IPs as well,
>>> I just checked and mcpsi does the same.
>>
>> Yeah let's use separate compatibles to avoid confusion.
>> For omap2 we also have the ti,omap2-mmc in addition to
>> ti,omap2-hsmmc..
>
> Yes, absolutely use separate compatible values.  It is always important
> to be specific as to the silicon implementing the IP.  The omap3 instance
> can also carry the omap2 string in its compatible list:
>
> 	compatible = "ti,omap3-hsmmc", "ti,omap2-hsmmc";

Sure, will repost with seperate compatible strings. Also missed adding
the 'status = "disable";' for unused mmc blocks in the board .dts file
causing unused mmc modules to get probed too. Will fix that as well.

thanks,
Rajendra

>
> g.


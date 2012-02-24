From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/4] arm/dts: OMAP4: Add mmc controller nodes and board
 data
Date: Fri, 24 Feb 2012 15:56:52 +0530
Message-ID: <4F4765EC.1000102@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>	<1329998490-27555-4-git-send-email-rnayak@ti.com> <CANrkHUaP7cV_vSKQYZkeF-aS5CEi2CAp3_9aDJKCVOX-67oNPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:46139 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754527Ab2BXK1A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Feb 2012 05:27:00 -0500
Received: by mail-gy0-f182.google.com with SMTP id r20so226373ghr.13
        for <linux-mmc@vger.kernel.org>; Fri, 24 Feb 2012 02:26:59 -0800 (PST)
In-Reply-To: <CANrkHUaP7cV_vSKQYZkeF-aS5CEi2CAp3_9aDJKCVOX-67oNPg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, svenkatr@ti.com, linaro-dev@lists.linaro.org

On Friday 24 February 2012 03:46 PM, T Krishnamoorthy, Balaji wrote:
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 29f4589..9204f60 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -25,6 +25,11 @@
>>                 serial1 =&uart2;
>>                 serial2 =&uart3;
>>                 serial3 =&uart4;
>> +               mmc1 =&mmc1;
>> +               mmc2 =&mmc2;
>> +               mmc3 =&mmc3;
>> +               mmc4 =&mmc4;
>> +               mmc5 =&mmc5;
>>         };
>>
>>         cpus {
>> @@ -155,5 +160,31 @@
>>                         #size-cells =<0>;
>>                         ti,hwmods = "i2c4";
>>                 };
>> +
>> +               mmc1: mmc@1 {
>> +                       compatible = "ti,omap4-hsmmc";
>> +                       ti,hwmods = "mmc1";
>> +                       ti,dual-volt;
>> +               };
>> +
>> +               mmc2: mmc@2 {
>> +                       compatible = "ti,omap4-hsmmc";
>> +                       ti,hwmods = "mmc2";
>> +               };
>
> Hi Rajendra,
> Is there a way to control the device registration order,
> eMMC connected to mmc2 needs to be registered as /dev/mmcblk0p ...
> irrespective of whether SD card is mount or not on mmc1 card slot.
> So that bootargs would not have to be modified when filesystem is on eMMC.

I don't know if we can, but even if we could, we take care of the same
bootargs working on two boards (say sdp and panda) *if* on sdp I have my
filesystem on eMMC and on panda I have it on external card.
What happens if I want to use my filesystem on both boards on external
card?

>
>> +
>> +               mmc3: mmc@3 {
>> +                       compatible = "ti,omap4-hsmmc";
>> +                       ti,hwmods = "mmc3";
>> +               };
>> +
>> +               mmc4: mmc@4 {
>> +                       compatible = "ti,omap4-hsmmc";
>> +                       ti,hwmods = "mmc4";
>> +               };
>> +
>> +               mmc5: mmc@5 {
>> +                       compatible = "ti,omap4-hsmmc";
>> +                       ti,hwmods = "mmc5";
>> +               };
>>         };
>>   };
>> --
>> 1.7.1
>>


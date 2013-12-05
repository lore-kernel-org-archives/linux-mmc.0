From: Balaji T K <balajitk@ti.com>
Subject: Re: [RFC PATCH v3 6/8] ARM: dts: add pbias-supply
Date: Thu, 5 Dec 2013 20:25:01 +0530
Message-ID: <52A093C5.9030402@ti.com>
References: <20130613174554.GB1403@sirena.org.uk> <1385043627-30439-1-git-send-email-balajitk@ti.com> <1385043627-30439-7-git-send-email-balajitk@ti.com> <20131121170351.GN10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20131121170351.GN10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thursday 21 November 2013 10:33 PM, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [131121 06:21]:
>> Add pbias-supply to mmc1/sd card.
> ...
>
>> --- a/arch/arm/boot/dts/dra7-evm.dts
>> +++ b/arch/arm/boot/dts/dra7-evm.dts
>> @@ -261,6 +261,7 @@
>>   &mmc1 {
>>   	status = "okay";
>>   	vmmc-supply = <&ldo1_reg>;
>> +	pbias-supply = <&pbias_regulator>;
>>   	bus-width = <4>;
>>   };
>
> You may not need to patch this in at all. I think the PBIAS is there
> only for the first slot and it's hardwired so it's always there. If
> that's the case, then you can just always request it. Or use the
> compatible flag if needed.

pbias is not applicable for mmc1 on am33xx and is applicable for
only for OMAP2-OMAP5, so I can add pbias-supply to omapx.dtsi files

>
> Regards,
>
> Tony
>

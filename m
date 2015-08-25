From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 12/17] ARM: dts: am57xx-beagle-x15: Fix regulator populated
 in MMC1 dt node
Date: Tue, 25 Aug 2015 12:06:55 +0530
Message-ID: <55DC0D07.7030504@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com> <1438168187-1614-13-git-send-email-kishon@ti.com> <55B92B88.1080409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B92B88.1080409-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, afenkart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Tony,

On Thursday 30 July 2015 01:07 AM, Nishanth Menon wrote:
> On 07/29/2015 06:09 AM, Kishon Vijay Abraham I wrote:
>> For beagle x15, both the vdd and io lines are connected to the
>> same regulator (ldo1_reg). However vmmc_aux is populated to vdd_3v3.
>> Remove it.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/am57xx-beagle-x15.dts |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
>> index a63bf78..d0db5c5 100644
>> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
>> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
>> @@ -579,7 +579,6 @@
>>  	pinctrl-0 = <&mmc1_pins_default>;
>>  
>>  	vmmc-supply = <&ldo1_reg>;
>> -	vmmc_aux-supply = <&vdd_3v3>;
>>  	pbias-supply = <&pbias_mmc_reg>;
>>  	bus-width = <4>;
>>  	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
>>
> Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Can you pick this one or you want me to resend it?

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Scott Wood <scott.wood@nxp.com>
Subject: Re: [PATCH 1/2] powerpc/85xx: adapt QorIQ eSDHC to the new clocking
 model
Date: Tue, 26 Apr 2016 06:31:14 +0000
Message-ID: <DB5PR0401MB1928ABB01CEAF524071C851591630@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1461147644-18041-1-git-send-email-yangbo.lu@nxp.com>
 <1461280096.32510.213.camel@buserror.net>
 <HE1PR04MB0889A9EA3955E0723146A2A9F8630@HE1PR04MB0889.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db3on0081.outbound.protection.outlook.com ([157.55.234.81]:60409
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751115AbcDZGbS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2016 02:31:18 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, Scott Wood <oss@buserror.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>

On 04/26/2016 01:29 AM, Yangbo Lu wrote:
> 
> 
>> -----Original Message-----
>> From: Yangbo Lu
>> Sent: Tuesday, April 26, 2016 2:19 PM
>> To: 'Scott Wood'; linux-mmc@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org; devicetree@vger.kernel.org
>> Cc: ulf.hansson@linaro.org; Rob Herring; Scott Wood
>> Subject: RE: [PATCH 1/2] powerpc/85xx: adapt QorIQ eSDHC to the new
>> clocking model
>>
>>> -----Original Message-----
>>> From: Scott Wood [mailto:oss@buserror.net]
>>> Sent: Friday, April 22, 2016 7:08 AM
>>> To: Yangbo Lu; linux-mmc@vger.kernel.org;
>>> linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org
>>> Cc: ulf.hansson@linaro.org; Rob Herring; Scott Wood
>>> Subject: Re: [PATCH 1/2] powerpc/85xx: adapt QorIQ eSDHC to the new
>>> clocking model
>>>
>>> On Wed, 2016-04-20 at 18:20 +0800, Yangbo Lu wrote:
>>>> Provide clocks property instead of clock-frequency for QorIQ eSDHC
>>>> dts node to adapt to the new clocking model, so that the driver
>>>> could get clock value by the common clk API and the u-boot could
>>>> remove the clock fixup.
>>>>
>>>> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
>>>> ---
>>>>  arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
>>>> b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
>>>> index 20835ae..ddbe562 100644
>>>> --- a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
>>>> +++ b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
>>>> @@ -36,5 +36,5 @@ sdhc: sdhc@114000 {
>>>>  	compatible = "fsl,esdhc";
>>>>  	reg = <0x114000 0x1000>;
>>>>  	interrupts = <48 2 0 0>;
>>>> -	clock-frequency = <0>;
>>>> +	clocks = <&clockgen 4 1>;
>>>>  };
>>>
>>> Binding update?
>>>
>>> -Scott
>>
>> [Lu Yangbo-B47093] Sorry, did you mean the doc update? ...
>> It has already had a description in
>> Documentation/devicetree/bindings/clock/qoriq-clock.txt
>>
>> - clock-frequency: Input system clock frequency (SYSCLK)
>> - clocks: If clock-frequency is not specified, sysclk may be provided
>>         as an input clock.  Either clock-frequency or clocks must be
>>         provided.
> 
> [Lu Yangbo-B47093] Or update mmc doc?

Yes, mmc.  This patch has nothing to do with the clockgen node's input
clock...

-Scott


From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv4 2/2] ARM: dts: unuse the slot-node and deprecated
 support-highspeed for dw-mmc.
Date: Thu, 05 Jun 2014 13:34:02 +0900
Message-ID: <538FF33A.3020104@samsung.com>
References: <1401934928-7300-1-git-send-email-jh80.chung@samsung.com>
 <1401934928-7300-3-git-send-email-jh80.chung@samsung.com>
 <538FDF5D.9060400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28228 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbaFEEeF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 00:34:05 -0400
In-reply-to: <538FDF5D.9060400@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tushar Behera <trblinux@gmail.com>, linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, mark.rutland@arm.com, tushar.behera@linaro.org

On 06/05/2014 12:09 PM, Tushar Behera wrote:
> On 06/05/2014 07:52 AM, Jaehoon Chung wrote:
>> dw-mmc controller can support the multiple slot.
> 
> 'the' can be omitted, /s/slot/slots/
> 
>> But, there is not use-case anywhere. So we don't need to support the
> 
> /s/is not use-case/are no use-cases/

Will fix.
> 
>> slot-node for dw-mmc controller.
>> And "support-highspeed" property in dw-mmc is deprecated.
>> "support-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> [ ... ]
> 
>> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> index 532b1d4..60d90c9 100644
>> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> @@ -46,13 +46,14 @@ Required Properties:
>>        - if CIU clock divider value is 0 (that is divide by 1), both tx and rx
>>          phase shift clocks should be 0.
>>  
>> -Required properties for a slot:
>> +Required properties for a slot (Deprecated - Support the one slot per host):
> 
> "Support only one slot per host" ?
Don't need to support the multiple slots at dw-mmc controller.
Recommend to use one slot per a host.
> 
>>  
>>  * gpios: specifies a list of gpios used for command, clock and data bus. The
>>    first gpio is the command line and the second gpio is the clock line. The
>>    rest of the gpios (depending on the bus-width property) are the data lines in
>>    no particular order. The format of the gpio specifier depends on the gpio
>>    controller.
>> + (Deprecated - Refer to Documentaion/devicetree/binding/samsung-pinctrl.txt)
> 
> Update reference:
> Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
Will Fix

Thanks for comments.

Best Regards,
Jaehoon Chung
> 


From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
Date: Wed, 6 May 2015 09:45:15 +0200
Message-ID: <5549C68B.9090602@xilinx.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <CAL_JsqK0pCtL2pbG7RttYd7BDxQHxdECHN_9X9MpLTuVEOxzsQ@mail.gmail.com>
 <CAOHikRC1dYd0BqhUCzdeZ8=PhSOj77sQR9kzrM8Gus3AJS1ejw@mail.gmail.com>
 <4635229.bceBxngCoe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0082.outbound.protection.outlook.com ([157.56.110.82]:63663
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756275AbbEFHp0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 May 2015 03:45:26 -0400
In-Reply-To: <4635229.bceBxngCoe@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Suman Tripathi <stripathi@apm.com>
Cc: Rob Herring <robherring2@gmail.com>, "chris@printf.net" <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Michal Simek <michal.simek@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, "patches@apm.com" <patches@apm.com>

On 05/06/2015 09:31 AM, Arnd Bergmann wrote:
> On Wednesday 06 May 2015 10:41:07 Suman Tripathi wrote:
>>>> @@ -533,6 +567,16 @@
>>>>                         interrupts = <0x0 0x4f 0x4>;
>>>>                 };
>>>>
>>>> +               sdhc0: sdhc@1c000000 {
>>>> +                       device_type = "sdhc";
>>>
>>> device_type generally should not be used (there are a few exceptions).
>>
>> Okay !!
>>
> 
> While we're at it, please change sdhc@1c000000 to mmc@1c000000.
> Even though Linux does not care, we try to use the standard device
> names for consistency.

Do we have a list of these names somewhere?
Normally I do use ePARP - generic names recommendation but mmc or sdhci
are not listed there.
Both combination mmc@ or sdhci@ are used in the kernel.

On zynq and zynqmp we do use shdci@.

Thanks,
Michal




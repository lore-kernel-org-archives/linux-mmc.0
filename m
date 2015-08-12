From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] DT: mmc: sh_mmcif: fix "compatible" property text
Date: Wed, 12 Aug 2015 13:41:40 +0300
Message-ID: <55CB22E4.5040904@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <1643858.nkRxsQo3O3@wasted.cogentembedded.com>
 <20150812005628.GE15957@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34121 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbbHLKln (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2015 06:41:43 -0400
Received: by lbbtg9 with SMTP id tg9so7101263lbb.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2015 03:41:42 -0700 (PDT)
In-Reply-To: <20150812005628.GE15957@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On 8/12/2015 3:56 AM, Simon Horman wrote:

>> The "compatible" property text contradicts even the example given in the MMCIF
>> binding document itself;  moreover, the Renesas MMCIF driver only matches on
>> the generic "compatible" string and doesn't look for the SoC specific strings
>> at all. Thus describe "renesas,sh-mmcif" as a fallback value.

>> Fixes: b4c27763d749 ("mmc: sh_mmcif: Document DT bindings")
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> I don't believe this file is the appropriate place to describe
> best-practice for the ordering of compatible strings which must surely be
> documented elsewhere.

    Where? I have no idea what you mean...
    And let me reiterate: this text is *wrong* and needs to be fixed anyway.

>> ---
>> The patch is against Ulf Hansson's 'mmc.git' repo's 'fixes' and 'next' branches.
>>
>> Changes in version 2:
>> - kept the SoC specific "compatible" property values mandatory and made the
>>    generic string a fallback.
>>
>>   Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
>> ===================================================================
>> --- mmc.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
>> +++ mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
>> @@ -10,7 +10,7 @@ Required properties:
>>   	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>>   	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>>   	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
>> -	- "renesas,sh-mmcif" for the generic MMCIF
>> +  followed by "renesas,sh-mmcif".
 >>
>>   - clocks: reference to the functional clock

MBR, Sergei


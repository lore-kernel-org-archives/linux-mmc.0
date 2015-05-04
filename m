From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v3 3/3] Documentation: mmc: Update Arasan SDHC
 documentation to support 4.9a version of Arasan SDHC controller.
Date: Mon, 4 May 2015 11:33:17 +0530
Message-ID: <CAOHikRBbOYHOmnzA6Ycu6hwdNL6SgmXKVK0NLtJQfJL9KULuxg@mail.gmail.com>
References: <1430456052-8888-1-git-send-email-stripathi@apm.com>
	<1430456052-8888-4-git-send-email-stripathi@apm.com>
	<f442e594-ac5c-4e77-ab80-3055fb791066@BN1AFFO11FD021.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og102.obsmtp.com ([64.18.0.143]:58415 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751084AbbEDGDU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2015 02:03:20 -0400
Received: by wizk4 with SMTP id k4so109442323wiz.1
        for <linux-mmc@vger.kernel.org>; Sun, 03 May 2015 23:03:18 -0700 (PDT)
In-Reply-To: <f442e594-ac5c-4e77-ab80-3055fb791066@BN1AFFO11FD021.protection.gbl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, patches <patches@apm.com>

Hi,

On Mon, May 4, 2015 at 11:30 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 05/01/2015 06:54 AM, Suman Tripathi wrote:
>> This patch updates Arasan SDHC documentation to support
>> 4.9a version of Arasan SDHC controller.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index 98ee2ab..f01d41a 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -8,7 +8,8 @@ Device Tree Bindings for the Arasan SDHCI Controller
>>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>
>>  Required Properties:
>> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
>> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
>> +                'arasan,sdhci-4.9a'
>>    - reg: From mmc bindings: Register location and length.
>>    - clocks: From clock bindings: Handles to clock inputs.
>>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>> @@ -18,7 +19,7 @@ Required Properties:
>>
>>  Example:
>>       sdhci@e0100000 {
>> -             compatible = "arasan,sdhci-8.9a";
>> +             compatible = "arasan,sdhci-8.9a", "arasan,sdhci-4.9a";
>
> Is there any reason to change this example?

Thought that if dts is updated so why not update the binding too.

> You probably want to have just one compatible string not both.

Okay will remove in next version.

>
> Thanks,
> Michal
>
>
>
>



-- 
Thanks,
with regards,
Suman Tripathi

From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
Date: Wed, 6 May 2015 10:41:07 +0530
Message-ID: <CAOHikRC1dYd0BqhUCzdeZ8=PhSOj77sQR9kzrM8Gus3AJS1ejw@mail.gmail.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
	<1430817426-5241-2-git-send-email-stripathi@apm.com>
	<CAL_JsqK0pCtL2pbG7RttYd7BDxQHxdECHN_9X9MpLTuVEOxzsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og121.obsmtp.com ([64.18.0.139]:53787 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752044AbbEFFLJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 01:11:09 -0400
Received: by wgyo15 with SMTP id o15so204753475wgy.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 22:11:07 -0700 (PDT)
In-Reply-To: <CAL_JsqK0pCtL2pbG7RttYd7BDxQHxdECHN_9X9MpLTuVEOxzsQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "chris@printf.net" <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Don Dutile <ddutile@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, "patches@apm.com" <patches@apm.com>

On Wed, May 6, 2015 at 1:11 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, May 5, 2015 at 4:17 AM, Suman Tripathi <stripathi@apm.com> wrote:
>> This patch adds the arasan sdhc nodes to reuse the of-arasan
>> driver for APM X-Gene SoC.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> ---
>>  arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
>>  arch/arm64/boot/dts/apm/apm-storm.dtsi  | 44 +++++++++++++++++++++++++++++++++
>>  2 files changed, 48 insertions(+)
>
> [...]
>
>> @@ -533,6 +567,16 @@
>>                         interrupts = <0x0 0x4f 0x4>;
>>                 };
>>
>> +               sdhc0: sdhc@1c000000 {
>> +                       device_type = "sdhc";
>
> device_type generally should not be used (there are a few exceptions).

Okay !!

>
>> +                       compatible = "arasan,sdhci-4.9a";
>
> If you ever have an integration or xgene specific problem, you need a
> chip specific compatible.

No it;s a IP level problem. If it's a SoC level then probably we
cann't reuse the existing  arasan version. If anything happens
in future we might need our own version.

>
> Rob



-- 
Thanks,
with regards,
Suman Tripathi

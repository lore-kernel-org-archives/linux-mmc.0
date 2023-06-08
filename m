Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B49C7EE25
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jun 2023 20:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjFHUH5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jun 2023 16:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjFHUHz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2023 16:07:55 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602682D7C
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 13:07:47 -0700 (PDT)
Received: from [192.168.1.103] (31.173.86.116) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 8 Jun 2023
 23:07:39 +0300
Subject: Re: [PATCH RFC 02/13] mmc: meson-gx: fix deferred probing
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Christian Hewitt <christianshewitt@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        MMC <linux-mmc@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        AML <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211223171202.8224-1-s.shtylyov@omp.ru>
 <20211223171202.8224-3-s.shtylyov@omp.ru>
 <2E930ABF-DA2A-4BB0-A2A2-56495305118D@gmail.com>
 <cc2f4e45-497b-7c2c-3fdd-1591903813cf@omp.ru>
Organization: Open Mobile Platform
Message-ID: <16b74882-d65b-93c9-f72b-1d53bfefa22f@omp.ru>
Date:   Thu, 8 Jun 2023 23:07:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cc2f4e45-497b-7c2c-3fdd-1591903813cf@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [31.173.86.116]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 06/08/2023 19:38:57
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 177946 [Jun 08 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 516 516 efd4d74ff4b68f90ca62ae34a19f27bf46d81db5
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_no_received}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.116 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.116 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;31.173.86.116:7.1.2;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.116
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/08/2023 19:47:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/8/2023 5:02:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello!

On 4/2/23 8:58 PM, Sergey Shtylyov wrote:

[...]
 
>>> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
>>> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
>>> permanently instead of the deferred probing. Switch to propagating the error
>>> codes upstream. IRQ0 is no longer returned by platform_get_irq(), so we now
>>> can safely ignore it...
>>>
>>> Fixes: cbcaac6d7dd2 ("mmc: meson-gx-mmc: Fix platform_get_irq's error checking
>>> ")
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> ---
>>> drivers/mmc/host/meson-gx-mmc.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>> index 8f36536cb1b6..c765653ee4d0 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -1182,8 +1182,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>> 	}
>>>
>>> 	host->irq = platform_get_irq(pdev, 0);
>>> -	if (host->irq <= 0) {
>>> -		ret = -EINVAL;
>>> +	if (host->irq < 0) {
>>> +		ret = host->irq;
>>> 		goto free_host;
>>> 	}
>>
>> Can I ask if this patch/series [0] has been superseded or forgotten or ??
> 
>    I'm sorry, I actually did forget to re-post this series, as asked by Ulf.
> Partly because the patch that this series depended on took about 4 months to
> hit the kernel and partly because I suspended my platform_get_irq() related
> work as I got into PATA development and struggling with a static analyzer's
> reports...
>    Also, the series doesn't seem superseded as all the patches still apply,
> sometimes with small offsets...
> 
>> The series it depended upon [1]
> 
>    That was a single patch. :-)
> 
>> appears to have been merged a year ago as I
>> can see ce753ad1549c ("platform: finally disallow IRQ0 in platform_get_irq()
>> and its ilk”) in upstream code.
> 
>    Not a whole year yet but 11 months surely... :-/
> 
>> I’ve had this patch in my testing kernel for
>> 12+ months now with no observable negative impacts so am wondering if it can
>> be resent and merged or I should drop the patch from my tree?
> 
>    It? You mean my fix patches, surely? Or you mean you care about patch #2
> only? Anyway, I need to find the time to refresh/repost it...

  Now that I'm on vacation, I have found the time -- see the v2 series here:

https://lore.kernel.org/all/20230608194519.10665-1-s.shtylyov@omp.ru/

[...]

MBR, Sergey

Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA11EB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 21:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjFMVIu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 17:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjFMVIt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 17:08:49 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD08199C
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 14:08:48 -0700 (PDT)
Received: from [192.168.1.103] (31.173.84.45) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 14 Jun
 2023 00:08:40 +0300
Subject: Re: [PATCH v2 01/12] mmc: bcm2835: fix deferred probing
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230608194519.10665-1-s.shtylyov@omp.ru>
 <20230608194519.10665-2-s.shtylyov@omp.ru>
 <13fd5204-4670-264d-5553-1475af3b203e@i2se.com>
 <988ec49f-5d73-c8ad-4bba-348f336688b7@omp.ru>
 <79a57fc6-7681-45bc-51f0-78758aaca730@i2se.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d53addd6-6298-b1df-14d2-ec6aa53d73e8@omp.ru>
Date:   Wed, 14 Jun 2023 00:08:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <79a57fc6-7681-45bc-51f0-78758aaca730@i2se.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [31.173.84.45]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 06/13/2023 20:37:24
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 178009 [Jun 13 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_no_received}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.84.45 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;31.173.84.45:7.4.1,7.7.3;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.84.45
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/13/2023 20:46:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/13/2023 6:42:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/13/23 11:56 AM, Stefan Wahren wrote:
[...]

>>>> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
>>>> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
>>>> permanently instead of the deferred probing. Switch to propagating the error
>>>> codes upstream.  IRQ0 is no longer returned by platform_get_irq(), so we now
>>>> can safely ignore it...
>>>>
>>>> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
>>>
>>> I know this is very theoretical, but does the statement "IRQ0 is no longer returned by platform_get_irq()" also applies to the time of the fixes commit?
>>
>>     Unfortunately, no. IRQ0 finally ceased to be returned in 5.19; there was a fat
>> warning in platform_get_irq() and friends before that (which is still there)...
> 
> Okay, in this case the usage of the fixes tag is wrong.

   Why? Returning -EPROBE_DEFER from platform_get_irq() predates this driver.

> Maybe we should refer to the commit which changed platform_get_irq()?

   No, IRQ0 is a different issue than that I'm trying to solve here.

>>> I'm asking because the fix could be backported to Linux 4.14.
>>
>>     I think the deferred probing can currently occur only with DT platforms

   ACPI too (I was too lazy to look on the code yesterday).

>> (I may be wrong here). Is this your case?
> 
> AFAIK Raspberry Pi was always a DT platform in the mainline kernel. At least in Linux 4.14.

   Good to know. :-)

>>> Best regards
>>>
>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> [...]

MBR, Sergey

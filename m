Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B94DC7619A
	for <linux-mmc@archiver.kernel.org>; Sun,  2 Apr 2023 17:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjDBR6b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 2 Apr 2023 13:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBR6a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Apr 2023 13:58:30 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C149FF
        for <linux-mmc@vger.kernel.org>; Sun,  2 Apr 2023 10:58:28 -0700 (PDT)
Received: from [192.168.1.103] (31.173.81.234) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sun, 2 Apr 2023
 20:58:18 +0300
Subject: Re: [PATCH RFC 02/13] mmc: meson-gx: fix deferred probing
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
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <cc2f4e45-497b-7c2c-3fdd-1591903813cf@omp.ru>
Date:   Sun, 2 Apr 2023 20:58:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2E930ABF-DA2A-4BB0-A2A2-56495305118D@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [31.173.81.234]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 04/02/2023 17:39:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 176439 [Apr 02 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 507 507 08d345461d9bcca7095738422a5279ab257bb65a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.234 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.234 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;marc.info:7.1.1;www.spinics.net:7.1.1;31.173.81.234:7.1.2,7.7.3,7.4.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.234
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/02/2023 17:42:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/2/2023 2:00:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello!

On 4/1/23 9:38 AM, Christian Hewitt wrote:
[...]

>> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
>> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
>> permanently instead of the deferred probing. Switch to propagating the error
>> codes upstream. IRQ0 is no longer returned by platform_get_irq(), so we now
>> can safely ignore it...
>>
>> Fixes: cbcaac6d7dd2 ("mmc: meson-gx-mmc: Fix platform_get_irq's error checking
>> ")
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>> drivers/mmc/host/meson-gx-mmc.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 8f36536cb1b6..c765653ee4d0 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -1182,8 +1182,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>> 	}
>>
>> 	host->irq = platform_get_irq(pdev, 0);
>> -	if (host->irq <= 0) {
>> -		ret = -EINVAL;
>> +	if (host->irq < 0) {
>> +		ret = host->irq;
>> 		goto free_host;
>> 	}
> 
> Can I ask if this patch/series [0] has been superseded or forgotten or ??

   I'm sorry, I actually did forget to re-post this series, as asked by Ulf.
Partly because the patch that this series depended on took about 4 months to
hit the kernel and partly because I suspended my platform_get_irq() related
work as I got into PATA development and struggling with a static analyzer's
reports...
   Also, the series doesn't seem superseded as all the patches still apply,
sometimes with small offsets...

> The series it depended upon [1]

   That was a single patch. :-)

> appears to have been merged a year ago as I
> can see ce753ad1549c ("platform: finally disallow IRQ0 in platform_get_irq()
> and its ilk”) in upstream code.

   Not a whole year yet but 11 months surely... :-/

> I’ve had this patch in my testing kernel for
> 12+ months now with no observable negative impacts so am wondering if it can
> be resent and merged or I should drop the patch from my tree?

   It? You mean my fix patches, surely? Or you mean you care about patch #2
only? Anyway, I need to find the time to refresh/repost it...

> Thx. Christian
> 
> [0] https://www.spinics.net/lists/linux-mmc/msg68102.html
> [1] https://marc.info/?l=linux-kernel&m=163623041902285

MBR, Sergey

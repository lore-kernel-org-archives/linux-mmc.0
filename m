Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58C5C7EE43
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Jun 2023 19:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjFLTsd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Jun 2023 15:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjFLTsc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jun 2023 15:48:32 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22DD7
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jun 2023 12:48:31 -0700 (PDT)
Received: from [192.168.1.103] (31.173.80.226) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Mon, 12 Jun
 2023 22:48:29 +0300
Subject: Re: [PATCH v2 00/12] Fix deferred probing in the MMC/SD drivers
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>
References: <20230608194519.10665-1-s.shtylyov@omp.ru>
 <CAPDyKFqHXqs7rcJQgBzGh_k-9023vopjcxowMLaHsFd7TykS5w@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <c03bfce0-64b2-02b8-3679-85a682000c8e@omp.ru>
Date:   Mon, 12 Jun 2023 22:48:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqHXqs7rcJQgBzGh_k-9023vopjcxowMLaHsFd7TykS5w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.80.226]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 06/12/2023 19:28:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 177980 [Jun 12 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 516 516 efd4d74ff4b68f90ca62ae34a19f27bf46d81db5
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_no_received}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.226
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/12/2023 19:34:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/12/2023 4:16:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/12/23 5:16 PM, Ulf Hansson wrote:
[...]
>> Here are 12 patches against the 'fixes' branch of Ulf Hansson's 'mmc.git' repo.
>> The affected MMC/SD drivers call platform_get_irq[_byname]() but override its
>> result in case of error which prevents the deferred probing from working. Some
>> of these patches logically depend on commit ce753ad1549c ("platform: finally
>> disallow IRQ0 in platform_get_irq() and its ilk")...
> 
> The above patch is available in v5.19. If someone wants any of the
> patches in $subject series to be backported to an older kernel
> version, the commit above needs backporting too.

   Mmm... not quite correct: the abovementioned commit matters only when
the IRQ check in the driver is changed from <= 0 to < 0 (there's an extra
passage about IRQ0 at the end of the patch description).

> Therefore I am adding the tag below for the series and leaving
> anything that older to be managed separately.
> 
> Cc: stable@vger.kernel.org # v5.19+

   Please only add such tag where it is _actually_ needed. TIA!

[...]
> Kind regards
> Uffe

MBR, Sergey

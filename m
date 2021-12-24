Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED4EC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Dec 2021 17:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbhLXRhm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:37:42 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:35110 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhLXRhm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Dec 2021 12:37:42 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 4FE9E235CB5C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH RFC 02/13] mmc: meson-gx: fix deferred probing
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211223171202.8224-1-s.shtylyov@omp.ru>
 <20211223171202.8224-3-s.shtylyov@omp.ru>
 <CAFBinCAd4QTZ78S7QrT0Zsduvk=09rJa3gHHb15HLpwspQzuTw@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a32767cb-9e6e-6d72-85e7-757399419916@omp.ru>
Date:   Fri, 24 Dec 2021 20:37:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCAd4QTZ78S7QrT0Zsduvk=09rJa3gHHb15HLpwspQzuTw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/24/21 8:35 PM, Martin Blumenstingl wrote:

>> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
>> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
>> permanently instead of the deferred probing. Switch to propagating the error
>> codes upstream. IRQ0 is no longer returned by platform_get_irq(), so we now
>> can safely ignore it...
>>
>> Fixes: cbcaac6d7dd2 ("mmc: meson-gx-mmc: Fix platform_get_irq's error checking
>> ")
> I suggest putting the ") on the previous line. Most "Fixes" tag I have
> seen don't use any line-break at all, even if the line gets long.

   Sorry, was a cut & paste artifact that I didn't notice... :-/

>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> with above comment addressed you can add my:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

   Thank you!

> Best regards,
> Martin
> 

MBR, Sergey

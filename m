Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3632FC77B7A
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 09:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbjFMJCW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240635AbjFMJCV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 05:02:21 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512251BF
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 02:02:19 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mtfa5-1prJSJ0tSh-00v6MO; Tue, 13 Jun 2023 10:56:32 +0200
Message-ID: <79a57fc6-7681-45bc-51f0-78758aaca730@i2se.com>
Date:   Tue, 13 Jun 2023 10:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/12] mmc: bcm2835: fix deferred probing
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230608194519.10665-1-s.shtylyov@omp.ru>
 <20230608194519.10665-2-s.shtylyov@omp.ru>
 <13fd5204-4670-264d-5553-1475af3b203e@i2se.com>
 <988ec49f-5d73-c8ad-4bba-348f336688b7@omp.ru>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <988ec49f-5d73-c8ad-4bba-348f336688b7@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:z08X9iSZ+rFpAWp/A1Umh/dPVoihREevUlhrIX/EBsScC6LcPXd
 VKNKkUI8oswMoUyvs3zD7kg1M5o5v5T+KzmYtXhTCnco7eJyaGdqlrESsUWQ2k/y51fYGJL
 2EliNO2G6DXDEeSX+ZWcb7QYoix1Ygx/AkN7vQql4hnTKypFBj85n1aducQ6W67qvZrMpFM
 M9LxfWdBYejZIZX1Z6klw==
UI-OutboundReport: notjunk:1;M01:P0:N52SMpZFHQ0=;jwdl2/rnYnUMvlikfVZKhQRLSRo
 BQC6EhL1At5E4jSTO8KKk69fdzuxeTjUq5KAEeJLhVKN/mcmK0pDug2EzOtqljgISAOGbRRL9
 A3Ym4/GtUtwZ4V8mMRTjinnEdkph4ORXC4D0Dx4jwkzoqVlU9UIR/bApRYykMcEx0dhu5ZOwM
 /BEJJr985m7kIjYwCp86Rfxkqhc/NzKZT6qPi+rZrpa49vZ+gIIvdY7aKf4i8DlYS0bgTi4XF
 UjqlPPZwYfk8AV6dtyE/SL2NgZgN0P86HLYxB7X4bN2eeDX9ZXxPkzh394DVpqu4Dbw5184Yv
 MW++o9nFfQh21/WbURCD+90m8pn/SJ+mvdYnG33HtzoO9ihCcGQXtNmmmsbLdvYBwamVkuSBR
 5w19J9cXHUO40T/joA9pwS1sA3RBf7uj4hEflFzRLOekSIa8clpi/eM0XhSpzXmtFMnNk82uY
 o2tMS+ZciGzF7FpXqREJIhNT7IlZOZ3fGvgA6PAcmzo2zcme8H4vPgUU7t16BMTfruxR+VIh7
 HmLquOVmYdfF8DZnO85lrSPCP1HhDM2wnBd2hgucxFoAZOdLn8zDzYd5aCdnl7zIm9Cdo9fmF
 gznLNS8UiD76v9wgdJdlhEDItOeSXiLv1A91FH3x3irwEEQsyl83od4A5OC4ePKiEUE3srVOV
 evWw8JcgKMH4vQftqSozocsbV941D/JWyd0q+2KfOQ==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 12.06.23 um 21:43 schrieb Sergey Shtylyov:
> On 6/9/23 12:39 AM, Stefan Wahren wrote:
> [...]
> 
>>> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
>>> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
>>> permanently instead of the deferred probing. Switch to propagating the error
>>> codes upstream.  IRQ0 is no longer returned by platform_get_irq(), so we now
>>> can safely ignore it...
>>>
>>> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
>>
>> I know this is very theoretical, but does the statement "IRQ0 is no longer returned by platform_get_irq()" also applies to the time of the fixes commit?
> 
>     Unfortunately, no. IRQ0 finally ceased to be returned in 5.19; there was a fat
> warning in platform_get_irq() and friends before that (which is still there)...

Okay, in this case the usage of the fixes tag is wrong. Maybe we should 
refer to the commit which changed platform_get_irq()?

> 
>> I'm asking because the fix could be backported to Linux 4.14.
> 
>     I think the deferred probing can currently occur only with DT platforms
> (I may be wrong here). Is this your case?

AFAIK Raspberry Pi was always a DT platform in the mainline kernel. At 
least in Linux 4.14.

> 
>> Best regards
>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> [...]
> 
> MBR, Sergey
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

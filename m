Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95997C48BCD
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C6B613B9
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 15:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhFIPDN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:03:13 -0400
Received: from foss.arm.com ([217.140.110.172]:33900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238784AbhFIPDL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Jun 2021 11:03:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50636D6E;
        Wed,  9 Jun 2021 08:01:16 -0700 (PDT)
Received: from [10.57.6.115] (unknown [10.57.6.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C3DE3F73D;
        Wed,  9 Jun 2021 08:01:14 -0700 (PDT)
Subject: Re: [RFC] mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        ulf.hansson@linaro.org
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20210608153357eucas1p24cbc7a2ddb00beada8cdd51ae2337c53@eucas1p2.samsung.com>
 <20210608153344.3813661-1-narmstrong@baylibre.com>
 <e9f057f6-324e-0637-b57a-cc2f87e0d108@samsung.com>
 <ebb1421c-e55c-eee3-ea42-09ae051659d4@baylibre.com>
 <92024ca5-c6fa-0e6a-b6ba-f35f92222e76@arm.com>
 <a59a4dd3-9a09-a9b4-71f2-7e37c92cf40e@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f1dbc6e2-e956-e582-4368-fcad95d596bf@arm.com>
Date:   Wed, 9 Jun 2021 16:01:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a59a4dd3-9a09-a9b4-71f2-7e37c92cf40e@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021-06-09 15:55, Neil Armstrong wrote:
> Hi Robin,
> 
> On 09/06/2021 16:45, Robin Murphy wrote:
>> On 2021-06-09 14:07, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 08/06/2021 17:50, Marek Szyprowski wrote:
>>>> Hi
>>>>
>>>> On 08.06.2021 17:33, Neil Armstrong wrote:
>>>>> It has been reported that usage of memcpy() to/from an iomem mapping is invalid,
>>>>> and and recent arm64 memcpy update [1] triggers a memory abort when dram-access-quirk
>>>>> is used on the G12A/G12B platforms.
>>>>>
>>>>> This adds a local sg_copy_to_buffer which makes usage of io versions of memcpy
>>>>> when dram-access-quirk is enabled.
>>>>>
>>>>> Fixes: acdc8e71d9bb ("mmc: meson-gx: add dram-access-quirk")
>>>>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>
>>>>> [1] 285133040e6c ("arm64: Import latest memcpy()/memmove() implementation")
>>>>>
>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>> ---
>>>>> Hi Ulf, Marek, Mark,
>>>>>
>>>>> I haven't tested the patch yet, but should fix issue reported at [2].
>>>>
>>>> Works fine here and fixed the issue.
>>>>
>>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>
>>> Thanks, I'll need to rework to pass an __iomem pointer to memcpy_to/fromio so sparse doesn't scream anymore.
>>
>> Hmm, might it be worth factoring out general sg_copy_{to,from}_iomem() helpers? From a quick grep I found at least mv_cesa_sg_copy() already doing essentially the same thing as meson_mmc_copy_buffer().
> 
> It's definitely worth it, but since we need a quick fix, we should have meson_mmc_copy_buffer() as a fix then we should definitely move to sg_copy_{to,from}_iomem() helpers

Oh, that makes sense for sure - I was just doing some general thinking 
out loud before I forget about the whole thing :)

Cheers,
Robin.

Return-Path: <SRS0=M0Y2=63=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1E4C2D0FC
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 12:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8892312A
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 12:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbgEMMYX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 May 2020 08:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731271AbgEMMYX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 13 May 2020 08:24:23 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CCC423126;
        Wed, 13 May 2020 12:24:20 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] m68k: mcf5441x: add support for esdhc mmc
 controller
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-m68k@vger.kernel.org
References: <20200501235907.3978-1-angelo.dureghello@timesys.com>
 <CAPDyKFoLpMTQD+3SnXBNnqVLBMKDf6y=3X+MoPep42SCiQ6+TQ@mail.gmail.com>
 <bde7080c-298d-c28b-5986-dbabc95985bf@westnet.com.au>
 <CAPDyKFqdGGfCurSRG8poO2aCbOmRb9so7-zarKEb1yUnBP=GXA@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <37824363-3769-d0ad-99ba-610e5f5b6562@linux-m68k.org>
Date:   Wed, 13 May 2020 22:24:16 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqdGGfCurSRG8poO2aCbOmRb9so7-zarKEb1yUnBP=GXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 13/5/20 9:59 pm, Ulf Hansson wrote:
> On Tue, 12 May 2020 at 17:09, Greg Ungerer <gregungerer@westnet.com.au> wrote:
>>
>> Hi Ulf,
>>
>> On 7/5/20 7:13 pm, Ulf Hansson wrote:
>>> + Geert
>>>
>>> On Sat, 2 May 2020 at 01:54, Angelo Dureghello
>>> <angelo.dureghello@timesys.com> wrote:
>>>>
>>>> Add support for sdhci-edshc mmc controller.
>>>>
>>>> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
>>>> ---
>>>> Changes for v3:
>>>> - removed volatile cast from clk.c
>>>> ---
>>>>    arch/m68k/coldfire/clk.c                    | 15 ++++++++++
>>>>    arch/m68k/coldfire/device.c                 | 33 +++++++++++++++++++--
>>>>    arch/m68k/coldfire/m5441x.c                 | 12 +++++++-
>>>>    arch/m68k/include/asm/m5441xsim.h           | 19 ++++++++++++
>>>>    arch/m68k/include/asm/mcfclk.h              |  2 ++
>>>>    include/linux/platform_data/mmc-esdhc-mcf.h | 17 +++++++++++
>>>>    6 files changed, 95 insertions(+), 3 deletions(-)
>>>>    create mode 100644 include/linux/platform_data/mmc-esdhc-mcf.h
>>>
>>> Not sure what's the best way to deal with this patch. I looped in
>>> Geert to get some input.
>>>
>>> If it looks okay and the risk is minimal for conflicts, I can carry it
>>> via my tree, but then I need an ack from Geert.
>>
>> I can carry just this patch in the m68knommu git tree it you prefer.
>> Should be no conflicts that way. But really if you want to carry it
>> with all the others I don't have a problem with that either.
> 
> It looks like the new platform data header file is being used by the
> mmc patch in 3/3, so it's probably easiest if I take them all via my
> mmc tree.
> 
> Anyway, I will wait for a v4 from Angelo to address the comments.

Ok, no problem.

Regards
Greg


> [...]
> 
> Kind regards
> Uffe
> 

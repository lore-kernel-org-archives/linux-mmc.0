Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B324FC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 11:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B8B2073B
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 11:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390067AbgEYLPQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 07:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389897AbgEYLPQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 May 2020 07:15:16 -0400
Received: from [192.168.1.101] (60-242-121-52.tpgi.com.au [60.242.121.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37C320723;
        Mon, 25 May 2020 11:15:13 +0000 (UTC)
Subject: Re: [PATCH v6 1/4] m68k: mcf5441x: add support for esdhc mmc
 controller
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20200518191742.1251440-1-angelo.dureghello@timesys.com>
 <fdfe557a-49fe-410a-cb05-5bff5e04fdd0@linux-m68k.org>
 <CALJHbkAsiFGUD3hWzgd1WqnoMekcC60i6Sn66SZS4nde4ksSdg@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <30643b0e-dc50-097a-088a-25bc194d4dac@linux-m68k.org>
Date:   Mon, 25 May 2020 21:15:10 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CALJHbkAsiFGUD3hWzgd1WqnoMekcC60i6Sn66SZS4nde4ksSdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Angelo,

On 25/5/20 6:51 pm, Angelo Dureghello wrote:
> Hi Greg,
> 
> On Mon, May 25, 2020 at 8:02 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>>
>> Hi Angelo,
>>
>> Have you seen this breakage being reported in linux-next?
>>
>>       arch/m68k/coldfire/clk.c:78:60: error: 'MCFSDHC_CLK' undeclared (first
>>       use in this function); did you mean 'MCF_CLK'?
>>       arch/m68k/coldfire/clk.c:83:61: error: 'MCFSDHC_CLK' undeclared (first
>>       use in this function); did you mean 'MCF_CLK'?
>>       make[2]: *** [scripts/Makefile.build:272: arch/m68k/coldfire/clk.o]
>>       Error 1
>>       make[1]: *** [Makefile:1736: arch/m68k/coldfire] Error 2
>>       make: *** [Makefile:185: __sub-make] Error 2
>>
>> This is when compiling for pretty much anything other than an mcf5441x
>> target.
> 
> 
>>
>>
>> MCFSDHC_CLK will not be defiend for anything other than mcf5441x targets.
>>
>> This mechanism looks a little out of place here, given how specific
>> it is to the sdhc hardware module of the 5441x. Can you move this
>> to the m5441x specific code resolving this?
>>
> 
> i apologize. Couldn't catch that since building for this target.
> Fixing, re-testing and sending patch in short.

There is a bunch of default ColdFire target configurations in
arch/m68k/configs/M* that you can test compile for. Gives you
pretty good coverage across various ColdFire types.

Regards
Greg



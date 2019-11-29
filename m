Return-Path: <SRS0=5U+E=ZV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8700BC43215
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Nov 2019 07:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA7A217F5
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Nov 2019 07:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pGiAdvSh";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VMlf4bxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfK2Hed (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Nov 2019 02:34:33 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:39556
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfK2Hed (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Nov 2019 02:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575012872;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=rhr7M/9VQSLL9ItyaTuW8gPDFzO9OiKg/pTfRZGl9ZI=;
        b=pGiAdvShf1ywSsWV4nL+/IGFbc04fRtHhMX/XAsxsnPsBG1Nz/gG/zmJ1ldctHyz
        kzOt96S5/b20z7GINQao+gwh8X28w5tlWO9RRGhW/wwumjJ5qIoYD0/4R44JlL82/zS
        PDK+pqkiC8CRMsMuOMEMNHIrm3u6N4/eeXCEfhqo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575012872;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=rhr7M/9VQSLL9ItyaTuW8gPDFzO9OiKg/pTfRZGl9ZI=;
        b=VMlf4bxtgZh3pn7RXe36jmGsEtn3Dc7ECNWHWRRcVw9bZHXCmwlKQZe9dkqR8w5S
        rPemt/CDkv2i8m/AR0ZdL3UZ+a5u1GmOcXIdzYx4TDelkOeOvbaXSimnmPbanQomMb/
        imd22SD5cwFZL3oOZqEK0O7A4RzfNyfw7+Qqtlzw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Nov 2019 07:34:32 +0000
From:   rampraka@codeaurora.org
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        cang@codeaurora.org, ppvk@codeaurora.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, dianders@google.com
Subject: Re: [RFC 0/6] mmc: Add clock scaling support for mmc driver
In-Reply-To: <CAPDyKFoZEc-m7NMnaAa5bjtCSp4wyJqic3cLHk95xracoWcCUA@mail.gmail.com>
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
 <CAPDyKFoZEc-m7NMnaAa5bjtCSp4wyJqic3cLHk95xracoWcCUA@mail.gmail.com>
Message-ID: <0101016eb6152f28-3f0e44c8-2cc5-4ed2-a9a3-f830ef6e3adf-000000@us-west-2.amazonses.com>
X-Sender: rampraka@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2019.11.29-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

Seems some setting issue with my thunderbird application.
Sorry for spams, please ignore my last responses as unsupported
characters got added.

Typing my response again from browser and re-sending.

Thanks,
Ram

On 2019-10-22 14:10, Ulf Hansson wrote:
> On Mon, 21 Oct 2019 at 16:30, Ram Prakash Gupta 
> <rampraka@codeaurora.org> wrote:
>> 
>> This change adds the use of devfreq based clock scaling to MMC.
>> This applicable for eMMC and SDCard.
>> For some workloads, such as video playback, it isn't necessary
>> for these cards to run at high speed. Running at lower
>> frequency, in such cases can still meet the deadlines for data
>> transfers.
>> 
>> Scaling down the clock frequency dynamically has power savings
>> not only because the bus is running at lower frequency but also
>> has an advantage of scaling down the system core voltage, if
>> supported. Provide an ondemand clock scaling support similar
>> to the cpufreq ondemand governor having two thresholds,
>> up_threshold and down_threshold to decide whether to increase
>> the frequency or scale it down respectively as per load.
> 
> This sounds simple, but what the series is doing is far more
> complicated but scaling the bus clock, as it also re-negotiates the
> bus speed mode.
> 
> Each time the triggering point for scaling up/down is hit, then a
> series of commands needs to be sent to the card, including running the
> tuning procedure. The point is, for sure, this doesn't come for free,
> both from a latency point of view, but also from an energy cost point
> of view. So, whether this really improves the behaviour, seems like
> very use case sensitive, right!?

Switching modes would incur some latency for sending commands to switch
modes, but tuning is not needed as most of the emmc devices used now a
days are with enhanced strobe support, so tuning would not add up any
latency as it is not required in hs400 enhanced strobe mode.

This feature is implemented for video playback case, where data transfer
request is less, where this feature helps with saving power consumption.

And when there is burst of data transfer request, load will remain 
_high_
so there won't be any switching and hence it won't affect any existing
use cases from latency point of view.

Also if hw supports to switch clk frequency without changing mode. I 
will
make change in code. For this I have seek input from hw team.

 From collected data, I see this feature is helping in saving power
consumption. And no energy penalty is observed. Please share if I am
missing any specific. Power saving using this feature is quite good
and considerable. Please find the data below.

Use Case                             Delta at Battery  Power Impact
30 fps at HD 1080p decode 20Mbps       10 mA               11%
30 fps at UHD 8b H.264 42 Mbps         20.93 mA            19%

> 
> Overall, when it comes to use cases, we have very limited knowledge
> about them at the mmc block layer level. I think it should remain like
> that. If at any place at all, this information is better maintained by
> the generic block layer and potentially the configured I/O scheduler.

I think, generic block layer do not have knowledge of use case for data
transfer request. And devfreq framework have been used to implement this
feature, which should be same in any layer.

Also mobile platforms comes mostly with emmc and ufs as storage media.
And clock scaling is already implemented in upstream ufs driver using
devfreq framework. On similar line, this feature is implemented for mmc
driver. So I believe, clk scaling implementation is better placed in mmc
driver rather in generic block layer.

> 
> This brings me to a question about the tests you have you run. Can you
> share some information and data about that?

Test case used are 1080p and 4k video playback use case. As this feature
is implemented specifically for video playback use case.
> 
>> 
>> 
>> Ram Prakash Gupta (6):
>>   mmc: core: Parse clk scaling dt entries
>>   mmc: core: Add core scaling support in driver
>>   mmc: core: Initialize clk scaling for mmc and SDCard
>>   mmc: core: Add debugfs entries for scaling support
>>   mmc: sdhci-msm: Add capability in platfrom host
>>   dt-bindings: mmc: sdhci-msm: Add clk scaling dt parameters
>> 
>>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  19 +
> 
> I noticed that the DT patch was put last in the series, but the
> parsing is implemented in the first patch. Please flip this around. If
> you want to implement DT parsing of new bindings, please make sure to
> discuss the new bindings first.

I will update in next post.

> 
>>  drivers/mmc/core/block.c                           |  19 +-
>>  drivers/mmc/core/core.c                            | 777 
>> +++++++++++++++++++++
>>  drivers/mmc/core/core.h                            |  17 +
>>  drivers/mmc/core/debugfs.c                         |  90 +++
>>  drivers/mmc/core/host.c                            | 226 ++++++
>>  drivers/mmc/core/mmc.c                             | 246 ++++++-
>>  drivers/mmc/core/queue.c                           |   2 +
>>  drivers/mmc/core/sd.c                              |  84 ++-
>>  drivers/mmc/host/sdhci-msm.c                       |   2 +
>>  include/linux/mmc/card.h                           |   7 +
>>  include/linux/mmc/host.h                           |  66 ++
>>  12 files changed, 1550 insertions(+), 5 deletions(-)
> 
> This is a lot of new code in the mmc core, which I would then need to
> maintain, of course. I have to admit, I am a bit concerned about that,
> so you have to convince me that there are good reasons for me to apply
> this.
> 
> As I stated above, I think the approach looks quite questionable in
> general. And even if you can share measurement, that it improves the
> behaviour, I suspect (without a deeper code review) that some of the
> code better belongs in common block device layer.

 From the collected power data, I see this as good reason to have this
feature in mmc driver as number is quite considerable.

For approach, it would be helpful if you share your inputs regarding 
this
approach. And as you have stated, this can be further discussed after a
review from you.

> 
> Kind regards
> Uffe

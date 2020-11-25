Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B36C56202
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 03:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF70B20782
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 03:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgKYD0p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:26:45 -0500
Received: from foss.arm.com ([217.140.110.172]:45562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgKYD0p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 22:26:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E0AF106F;
        Tue, 24 Nov 2020 19:26:44 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 302DB3F718;
        Tue, 24 Nov 2020 19:26:44 -0800 (PST)
Subject: Re: [PATCH] mmc: sdhci: Update firmware interface API
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201120233831.447365-1-jeremy.linton@arm.com>
 <CAPDyKFq-pMKAJdS8qPpkR_QZ_QLW70Y7PPGxA=d_HOBRd-Su=A@mail.gmail.com>
 <be00e2df-572b-2bdb-85c2-675ca16e5d01@intel.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <6383172b-912f-39f9-f446-1f600d1262b5@arm.com>
Date:   Tue, 24 Nov 2020 21:26:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <be00e2df-572b-2bdb-85c2-675ca16e5d01@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 11/24/20 8:51 AM, Adrian Hunter wrote:
> On 24/11/20 4:25 pm, Ulf Hansson wrote:
>> On Sat, 21 Nov 2020 at 00:39, Jeremy Linton <jeremy.linton@arm.com> wrote:
>>>
>>> The device_* calls were added a few years ago to abstract
>>> DT/ACPI/fwnode firmware interfaces. Lets convert the two
>>> sdhci caps fields to use the generic calls rather than the OF
>>> specific ones. This has the side effect of allowing
>>> ACPI based devices to quirk themselves when the caps field
>>> is broken.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>
>> Applied for next, thanks!
>>
>> Kind regards
>> Uffe
>>
>>
>>> ---
>>>   drivers/mmc/host/sdhci.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 592a55a34b58..feba64fbde16 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3992,10 +3992,10 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
>>>          if (host->v4_mode)
>>>                  sdhci_do_enable_v4_mode(host);
>>>
>>> -       of_property_read_u64(mmc_dev(host->mmc)->of_node,
>>> -                            "sdhci-caps-mask", &dt_caps_mask);
>>> -       of_property_read_u64(mmc_dev(host->mmc)->of_node,
>>> -                            "sdhci-caps", &dt_caps);
>>> +       device_property_read_u64_array(mmc_dev(host->mmc),
>>> +                                      "sdhci-caps-mask", &dt_caps_mask, 1);
>>> +       device_property_read_u64_array(mmc_dev(host->mmc),
>>> +                                      "sdhci-caps", &dt_caps, 1);
> 
> But why not use device_property_read_u64()?

That would be more concise in this case.

I will post and update.

Thanks,

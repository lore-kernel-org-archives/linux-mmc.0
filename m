From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH V2 15/15] mmc: core: Don't print reset warning if reset is
 not supported
Date: Mon, 9 Feb 2015 17:05:10 +0100
Message-ID: <CA+20K0D6peyZ46b_P2Zydah9xoXLSvsznbiCt58pGRhLBYEuLg@mail.gmail.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
	<1422522030-17793-16-git-send-email-adrian.hunter@intel.com>
	<54D87EFC.9060404@broadcom.com>
	<54D88214.5000204@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:60296 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760712AbbBIQFL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Feb 2015 11:05:11 -0500
Received: by mail-qg0-f44.google.com with SMTP id j5so6758230qga.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2015 08:05:10 -0800 (PST)
In-Reply-To: <54D88214.5000204@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arend van Spriel <arend@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>

Hi Adrian and Arend,

2015-02-09 10:47 GMT+01:00 Adrian Hunter <adrian.hunter@intel.com>:
> On 09/02/15 11:33, Arend van Spriel wrote:
>> On 01/29/15 10:00, Adrian Hunter wrote:
>>> Check the error code for EOPNOTSUPP and do not print
>>> reset warning in that case.
>>>
>>> Signed-off-by: Adrian Hunter<adrian.hunter@intel.com>
>>> ---
>>>   drivers/mmc/core/core.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 392a150..d439bf0 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -2368,7 +2368,8 @@ int mmc_hw_reset(struct mmc_host *host)
>>>       ret = host->bus_ops->reset(host);
>>>       mmc_bus_put(host);
>>>
>>> -    pr_warn("%s: tried to reset card\n", mmc_hostname(host));
>>> +    if (ret != -EOPNOTSUPP)
>>> +        pr_warn("%s: tried to reset card\n", mmc_hostname(host));
>>
>> Guess you don't want this message either if ret is zero.
>
> Thanks for your comment.
>
> I assumed the original author wants to see the message whenever reset is
> attempted, which is OK by me because it is on the recovery path i.e.
> hopefully rare. The EOPNOTSUPP case is consistent with the code further up
> which returns EOPNOTSUPP when there is no ->reset() callback.

Speaking as the original author, yes, this was the idea. Thank you for
this patch.

BR, Johan

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 00/15] mmc: host: Add facility to support re-tuning
Date: Fri, 10 Apr 2015 12:52:02 +0200
Message-ID: <CAPDyKFp8gyK8aXSK3ZM4V4RoB_ws5MWO6n2NYJp7CxxUV8LFgg@mail.gmail.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
	<551B8E7B.9020605@intel.com>
	<5527A877.9030204@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33376 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932277AbbDJKwD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Apr 2015 06:52:03 -0400
Received: by qkx62 with SMTP id 62so24966328qkx.0
        for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2015 03:52:02 -0700 (PDT)
In-Reply-To: <5527A877.9030204@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 10 April 2015 at 12:39, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 01/04/15 09:21, Adrian Hunter wrote:
>> On 27/03/15 22:57, Adrian Hunter wrote:
>>> Hi
>>>
>>> Here is V4 of some patches to move re-tuning support
>>> out of sdhci and into the core, and add support for HS400
>>> re-tuning.
>>>
>>> Currently sdhci does re-tuning transparently by
>>> calling sdhci_execute_tuning() from its ->request()
>>> function.
>>>
>>> The problem with HS400 re-tuning is that it must be
>>> done in HS200 mode. That means using switch commands
>>> and making ios changes. That means it potentially
>>> conflicts with other command sequences. The new
>>> re-tuning support accomodates that.
>>>
>>> These patches now depend on Ulf's patch:
>>>
>>>     mmc: core: Enable runtime PM management of host devices
>>>
>>>
>>> Changes in V4:
>>>
>>>     mmc: host: Add facility to support re-tuning
>>>
>>>      Assume mmc_claim_host() runtime resumes the host
>>>      controller so there are no races with runtime pm.
>>>      Consequently remove now un-needed re-tuning host
>>>      operations.
>>>
>>>     mmc: core: Add support for re-tuning before each request
>>>
>>>      Call mmc_retune() prior to ->request()
>>>
>>>     mmc: sdhci: Change to new way of doing re-tuning
>>>
>>>      Updated to reflect the changes above.
>>
>> Hi
>>
>> What is the status of this?
>
> Hi
>
> What needs to be done to move this forward?

I need some more time to think about it, from a design perspective.
Give me a few days, please.

Kind regards
Uffe

>
> Regards
> Adrian
>

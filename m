From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/5] mmc: core: change quirks.c to be a header file
Date: Tue, 14 Feb 2017 09:54:56 +0100
Message-ID: <CAPDyKFrmSmqi8YbD7K05G9ZwosSBgSmWt2rDpqf01vBjwk0dKg@mail.gmail.com>
References: <1486516546-187771-1-git-send-email-shawn.lin@rock-chips.com>
 <1486516546-187771-2-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFrXkcXbcwiEbBzZJbpKL9-34C7jBap5rfBkpD0YtP+VUA@mail.gmail.com> <dbb5a0f4-b1cd-84cb-7ff2-adf59b0e0714@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35716 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdBNIy5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 03:54:57 -0500
Received: by mail-vk0-f45.google.com with SMTP id x75so76029885vke.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 00:54:57 -0800 (PST)
In-Reply-To: <dbb5a0f4-b1cd-84cb-7ff2-adf59b0e0714@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 10 February 2017 at 10:41, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2017/2/8 19:15, Ulf Hansson wrote:
>>
>> [...]
>>
>>> diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.h
>>> similarity index 95%
>>> rename from drivers/mmc/core/quirks.c
>>> rename to drivers/mmc/core/quirks.h
>>> index bf25a9c..f3bbfcb7 100644
>>> --- a/drivers/mmc/core/quirks.c
>>> +++ b/drivers/mmc/core/quirks.h
>>
>>
>> As you are rename this to become a header file, please also clean up
>> the included headers from the new quirks.h.
>>
>> For example, you don't need these:
>>
>> #include <linux/kernel.h>
>> #include <linux/export.h>
>>
>> Instead you need:
>> #include <linux/device.h>
>> #include <linux/string.h>
>>
>
> Sure.
>
>>
>>> @@ -53,7 +53,8 @@
>>>         END_FIXUP
>>>  };
>>>
>>> -void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup
>>> *table)
>>> +static inline void __maybe_unused
>>
>>
>> The "__maybe_unused" shouldn't be needed here, or is it?
>>
>
> I tried to keep a C file to include quirk.h to make sure it will
> be compiled standalone cleanly. Otherwise the gcc cast a warning
> with W=1 about "defined but not used"..

I see.

However those kind of warnings isn't relevant when compiling the
header standalone.

[...]

Kind regards
Uffe

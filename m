From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 1/5] mmc: core: change quirks.c to be a header file
Date: Fri, 10 Feb 2017 17:41:33 +0800
Message-ID: <dbb5a0f4-b1cd-84cb-7ff2-adf59b0e0714@rock-chips.com>
References: <1486516546-187771-1-git-send-email-shawn.lin@rock-chips.com>
 <1486516546-187771-2-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFrXkcXbcwiEbBzZJbpKL9-34C7jBap5rfBkpD0YtP+VUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:41829 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdBJJz4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Feb 2017 04:55:56 -0500
In-Reply-To: <CAPDyKFrXkcXbcwiEbBzZJbpKL9-34C7jBap5rfBkpD0YtP+VUA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2017/2/8 19:15, Ulf Hansson wrote:
> [...]
>
>> diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.h
>> similarity index 95%
>> rename from drivers/mmc/core/quirks.c
>> rename to drivers/mmc/core/quirks.h
>> index bf25a9c..f3bbfcb7 100644
>> --- a/drivers/mmc/core/quirks.c
>> +++ b/drivers/mmc/core/quirks.h
>
> As you are rename this to become a header file, please also clean up
> the included headers from the new quirks.h.
>
> For example, you don't need these:
>
> #include <linux/kernel.h>
> #include <linux/export.h>
>
> Instead you need:
> #include <linux/device.h>
> #include <linux/string.h>
>

Sure.

>
>> @@ -53,7 +53,8 @@
>>         END_FIXUP
>>  };
>>
>> -void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
>> +static inline void __maybe_unused
>
> The "__maybe_unused" shouldn't be needed here, or is it?
>

I tried to keep a C file to include quirk.h to make sure it will
be compiled standalone cleanly. Otherwise the gcc cast a warning
with W=1 about "defined but not used"..


>> +mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
>>  {
>>         const struct mmc_fixup *f;
>>         u64 rev = cid_rev_card(card);
>> @@ -82,4 +83,3 @@ void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
>>                 }
>>         }
>>  }
>> -EXPORT_SYMBOL(mmc_fixup_device);
>
> [...]
>
> Kind regards
> Uffe
>
>
>


-- 
Best Regards
Shawn Lin


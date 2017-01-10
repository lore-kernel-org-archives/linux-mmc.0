From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 09/21] mmc: sdhci: Include leds.h
Date: Tue, 10 Jan 2017 16:32:47 +0100
Message-ID: <CAPDyKFoB2C8VJk8eTM+S9EgpbazvV3mZ=1YF8tBxvaaQ=qVVDg@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
 <1483102054-1752-10-git-send-email-ulf.hansson@linaro.org> <59d6e628-3553-5811-1fd4-a92359347085@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f182.google.com ([209.85.210.182]:33641 "EHLO
        mail-wj0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752854AbdAJPct (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 10:32:49 -0500
Received: by mail-wj0-f182.google.com with SMTP id kq3so38986449wjc.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 07:32:49 -0800 (PST)
In-Reply-To: <59d6e628-3553-5811-1fd4-a92359347085@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mateusz Nowak <mateusz.nowak@linux.intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 30 December 2016 at 14:35, Mateusz Nowak
<mateusz.nowak@linux.intel.com> wrote:
> Hi Ulf,
>
> On 12/30/2016 13:47, Ulf Hansson wrote:
>>
>> Don't rely on host.h to include the mmc.h header, but instead include it
>> explicitly because the driver depends on it.
>
> You refer in description to header file (mmc.h) not related to this patch.

Ahh, copy/paste error. Thanks, for reviewing!

Kind regards
Uffe

>
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 0b66f21..a10a7b6 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -17,6 +17,7 @@
>>  #include <linux/compiler.h>
>>  #include <linux/types.h>
>>  #include <linux/io.h>
>> +#include <linux/leds.h>
>>
>>  #include <linux/mmc/host.h>
>>
>>
>
> Regards,
> Mateusz.

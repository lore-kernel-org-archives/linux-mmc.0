From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 07/15] mmc: core: Move public functions from core.h to
 private headers
Date: Tue, 17 Jan 2017 16:07:10 +0100
Message-ID: <CAPDyKFrrftAgiPyGOpfsvXNBXpPBhY24d5H46CO2Zp51+JEJSg@mail.gmail.com>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-8-git-send-email-ulf.hansson@linaro.org> <87e14348-b6fa-4962-ef3b-ac9a35d37da3@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:35956 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdAQPHT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2017 10:07:19 -0500
Received: by mail-io0-f169.google.com with SMTP id j13so116421658iod.3
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jan 2017 07:07:11 -0800 (PST)
In-Reply-To: <87e14348-b6fa-4962-ef3b-ac9a35d37da3@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 16 January 2017 at 04:01, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2017/1/13 21:14, Ulf Hansson wrote:
>>
>> A significant amount of functions are available through the public mmc
>> core.h header file. Let's slim down this public mmc interface, as to
>> prevent users from abusing it, by moving some of the functions to private
>> mmc header files.
>>
>> This change concentrates on moving the functions into private mmc headers,
>> following changes may continue with additional clean-ups, as an example
>> some functions can be turned into static.
>>
>
> [...]
>
>> @@ -16,6 +16,7 @@
>>  #include <linux/mmc/sdio_func.h>
>>
>>  #include "sdio_ops.h"
>> +#include "core.h"
>>
>
> Should we need move it before sdio_ops.h to
> slightly keep the order? The same for sdio_orq.c change :)

One of the points in this series is also to fix header dependencies
properly. In other words, each header must be able to build
standalone. This removes any constraints on the order of how we
include them. To test each header for this, I have some local
Makefiles and c-files.

That said, I don't think there is an existing order we need or should
maintain (unless because we think it looks nice). If that would be the
case, it's should be considered as a bug.

[...]

Kind regards
Uffe

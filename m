From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 10/15] mmc: core: Remove unused struct _mmc_csd from
 public mmc.h header
Date: Tue, 17 Jan 2017 16:07:02 +0100
Message-ID: <CAPDyKFo0eRRftuV=HRwzrOQ_8nEFE06SmHDyeB5WqKqiDJGkLw@mail.gmail.com>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-11-git-send-email-ulf.hansson@linaro.org> <0757437b-77ca-134a-8844-9c003e184ced@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:33162 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdAQPHT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2017 10:07:19 -0500
Received: by mail-it0-f44.google.com with SMTP id d9so27802714itc.0
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jan 2017 07:07:03 -0800 (PST)
In-Reply-To: <0757437b-77ca-134a-8844-9c003e184ced@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 16 January 2017 at 04:07, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2017/1/13 21:14, Ulf Hansson wrote:
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  include/linux/mmc/mmc.h | 44 --------------------------------------------
>>  1 file changed, 44 deletions(-)
>>
>
> Looks quite strightforward, but it will be better if adding a
> commit msg body here. Anyway,

I didn't know what to put there besides what is already said in the header. :-)

Anyway, I try to elaborate a bit and add something.

[...]

Kind regards
Uffe

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/6] mmc: tmio: set tmio_mmc_host to driver data
Date: Mon, 20 Nov 2017 17:18:58 +0900
Message-ID: <CAK7LNAQZQ13O1pSd5Ah7VDWrZF1MSkLT_QoTDS+uT7C-r09b+g@mail.gmail.com>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
 <1510042172-27220-3-git-send-email-yamada.masahiro@socionext.com> <20171119194930.npqfzqvmh4zbcb34@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:33347 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbdKTITo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Nov 2017 03:19:44 -0500
In-Reply-To: <20171119194930.npqfzqvmh4zbcb34@tetsubishi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

2017-11-20 4:49 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Tue, Nov 07, 2017 at 05:09:28PM +0900, Masahiro Yamada wrote:
>> The remove, suspend, resume hooks need tmio_mmc_host.  It is tedious
>> to get mmc_host from the driver_data and pass it to mmc_priv().
>> We can directly set tmio_mmc_host to driver data to clean up the code.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> ...
>
>> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
>> index 64b7e9f..ccfbc15 100644
>> --- a/drivers/mmc/host/tmio_mmc.c
>> +++ b/drivers/mmc/host/tmio_mmc.c
>> @@ -128,15 +128,11 @@ static int tmio_mmc_probe(struct platform_device *pdev)
>>  static int tmio_mmc_remove(struct platform_device *pdev)
>>  {
>>       const struct mfd_cell *cell = mfd_get_cell(pdev);
>> -     struct mmc_host *mmc = platform_get_drvdata(pdev);
>> +     struct tmio_mmc_host *host = platform_get_drvdata(pdev);
>>
>> -     if (mmc) {
>> -             struct tmio_mmc_host *host = mmc_priv(mmc);
>> -
>> -             tmio_mmc_host_remove(host);
>> -             if (cell->disable)
>> -                     cell->disable(pdev);
>> -     }
>> +     tmio_mmc_host_remove(host);
>> +     if (cell->disable)
>> +             cell->disable(pdev);
>
> Hmmm, this changes the code logic. Any reason this driver checks for a
> valid 'mmc' and can we safely drop it?
>

This code has been here since the initial support of TMIO
by commit  4a48998fa16121d0fe3436cce43afd6f47424103.

So, we have no way to know the reason
except asking the author, Ian Molton.

My best guess is unnecessary if-conditional was added
and overlooked in the review process.

mmc has been allocated, and platform_set_drvdata() has been called
in the driver probe.

I do not see any case for mmc==NULL.



-- 
Best Regards
Masahiro Yamada

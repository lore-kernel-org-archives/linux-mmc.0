From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/9] mmc: core: Don't export some eMMC specific functions
 from core.c
Date: Fri, 9 Jun 2017 15:32:53 +0200
Message-ID: <CAPDyKFqjdC7HbYfESMhLsyoCww0G1y4YmFhN3zYOQk5KA=FpPg@mail.gmail.com>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
 <1496928465-25004-2-git-send-email-ulf.hansson@linaro.org> <CACRpkdaMEJkHznewPdUmaKc454tqEVaqF3aAMvEep6FOjnJSmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34993 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdFINcy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 09:32:54 -0400
Received: by mail-qt0-f169.google.com with SMTP id w1so75412162qtg.2
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 06:32:54 -0700 (PDT)
In-Reply-To: <CACRpkdaMEJkHznewPdUmaKc454tqEVaqF3aAMvEep6FOjnJSmA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On 9 June 2017 at 15:22, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jun 8, 2017 at 3:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> The mmc_start|stop_bkops(), mmc_read_bkops_status() and mmc_interrupt_hpi()
>> functions are all used from within the mmc core module, thus there are no
>> need to use EXPORT_SYMBOL() for them, so let's remove it.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
>> @@ -428,7 +428,6 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>>  out:
>>         mmc_release_host(card->host);
>>  }
>> -EXPORT_SYMBOL(mmc_start_bkops);
>
> For this one, you can also mark it static, and remove the prototype in
> mmc_ops.h.
>
> It is only called from inside the same file!

Nope, used from core.c

>
>>  int mmc_read_bkops_status(struct mmc_card *card)
>>  {
>> @@ -887,7 +884,6 @@ int mmc_read_bkops_status(struct mmc_card *card)
>>         kfree(ext_csd);
>>         return 0;
>>  }
>> -EXPORT_SYMBOL(mmc_read_bkops_status);
>
> Same for this, but you may have to move the function above
> the call site so it compiles.

Done in patch2.

>
> Yours,
> Linus Walleij

Kind regards
Uffe

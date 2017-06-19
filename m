From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/6 v3] mmc: debugfs: No blocklayer = no card status and extcsd
Date: Mon, 19 Jun 2017 13:14:46 +0200
Message-ID: <CACRpkdb17Cm-bS8mbHRfqZtwJL7MJUp6mNiiziUYtJ4WMjVE4w@mail.gmail.com>
References: <20170608085403.11795-1-linus.walleij@linaro.org>
 <20170608085403.11795-3-linus.walleij@linaro.org> <CAPDyKFqbS0wLqQiPVPviPZ7o9WsGtQ2=46+e4NY_=MF2Gg6nDA@mail.gmail.com>
 <CACRpkdZR1rkuJpkfcYSF32kY9gp4DrBva9Zyr1fhUK-n=_wzeg@mail.gmail.com> <CAPDyKFpan9gyMkgsUK4rihJn79bPyL49s4JN_U_sGgcnLvyyQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38855 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753711AbdFSLOs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2017 07:14:48 -0400
Received: by mail-it0-f49.google.com with SMTP id b205so41427369itg.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2017 04:14:47 -0700 (PDT)
In-Reply-To: <CAPDyKFpan9gyMkgsUK4rihJn79bPyL49s4JN_U_sGgcnLvyyQw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On Mon, Jun 19, 2017 at 12:04 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 19 June 2017 at 11:25, Linus Walleij <linus.walleij@linaro.org> wrote:

>> This is not really related, since I have all the debugfs files for the
>> block layer as static functions in this patch, i.e. if the block layer
>> is inserted, the debugfs files come up.
>
> If that would be the case, the I am fine. But, I am not sure. See comment below.
>
>> On a broader note, AFAIK it is already impossible to insert the block
>> module after the core module (if it was selected as "m" at compile time),
>> as the block module must be inserted first, or the core module cannot
>> resolve the symbols it needs from the block module.
>
> No, this is wrong. It's actually the opposite.
>
> Currently there are no dependency from the core module on the block
> module. However, the block module uses exported functions from the
> core module, so the dependency is the opposite.

Aha, I see how you mean.

> This is exactly what I was trying to say, we must not create a
> circular dependency of the modules.

I think modprobe resolves circular dependencies by inserting
both modules at the same time, actually. insmod will not work.

> To solve this, you must move the entire creation of the debugfs nodes
> to be done when the block device driver probes, in other words from
> mmc_blk_probe().

Yes and this is done in patch 6/6.

If you think it is dangerous to have this as an intermediary step, we
can just squash the patches.

Yours,
Linus Walleij

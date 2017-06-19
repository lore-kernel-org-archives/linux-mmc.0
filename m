From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/6 v3] mmc: debugfs: No blocklayer = no card status and extcsd
Date: Mon, 19 Jun 2017 11:25:43 +0200
Message-ID: <CACRpkdZR1rkuJpkfcYSF32kY9gp4DrBva9Zyr1fhUK-n=_wzeg@mail.gmail.com>
References: <20170608085403.11795-1-linus.walleij@linaro.org>
 <20170608085403.11795-3-linus.walleij@linaro.org> <CAPDyKFqbS0wLqQiPVPviPZ7o9WsGtQ2=46+e4NY_=MF2Gg6nDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37830 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbdFSJZp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2017 05:25:45 -0400
Received: by mail-it0-f54.google.com with SMTP id m47so54080421iti.0
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2017 02:25:44 -0700 (PDT)
In-Reply-To: <CAPDyKFqbS0wLqQiPVPviPZ7o9WsGtQ2=46+e4NY_=MF2Gg6nDA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Jun 16, 2017 at 11:32 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 8 June 2017 at 10:53, Linus Walleij <linus.walleij@linaro.org> wrote:

>> +#else /* !IS_ENABLED(CONFIG_MMC_BLOCK) */
>> +
>> +static int mmc_add_block_debugfs(struct mmc_card *card, struct dentry *root)
>> +{
>
> So does this really work as expected?
>
> Currently one can build the mmc block as a separate module. If that
> module is inserted after the mmc core module attempts to register the
> debugfs nodes, we would end up in this stub function, right?

Not really. IS_ENABLED() is a compile-time flag. The stub is not even
compiled in if the block layer is selected as module.

I.e. if CONFIG_MMC_BLOCK is "y" or "m" then the real function gets
compiled in. If it is "n" the stub gets compiled in.

> In other words, those system that for some odd reason decide to insmod
> the mmc block module at a later point, won't be given the debugfs
> nodes?

This is not really related, since I have all the debugfs files for the
block layer as static functions in this patch, i.e. if the block layer
is inserted, the debugfs files come up.

On a broader note, AFAIK it is already impossible to insert the block
module after the core module (if it was selected as "m" at compile time),
as the block module must be inserted first, or the core module cannot
resolve the symbols it needs from the block module.

insmod will fail, and modprobe will load the required modules first,
so it orders the block layer to load before the core so that the symbols
are resolved.

Yours,
Linus Walleij

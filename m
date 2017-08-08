From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Tue, 8 Aug 2017 19:02:09 +0200
Message-ID: <CAPDyKFo7a1snT6kiDu8TmvMEOnhMUuXkr44Q9PxyyJJ2O4gTog@mail.gmail.com>
References: <1502152045-150457-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFqqjyOmAQkaa6DjJKs+BF-sOdN_jAtAR4CZg+vYVCLt0w@mail.gmail.com> <20170808114757.GB1674@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33093 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbdHHRCK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2017 13:02:10 -0400
Received: by mail-qt0-f179.google.com with SMTP id a18so23259941qta.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2017 10:02:10 -0700 (PDT)
In-Reply-To: <20170808114757.GB1674@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On 8 August 2017 at 13:47, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Tue, Aug 08, 2017 at 12:37:31PM +0200, Ulf Hansson wrote:
>> On 8 August 2017 at 02:27, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> > We to some extent should tolerate R1_OUT_OF_RANGE for open-ending
>> > mode as it is expected behaviour and most of the backup partition
>> > tables should be located near some of the last blocks which will
>> > always make open-ending read exceed the capacity of cards.
>> >
>> > Fixes: 9820a5b11101 ("mmc: core: for data errors, take response of stop cmd into account")
>> > Fixes: a04e6bae9e6f ("mmc: core: check also R1 response for stop commands")
>> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> > Tested-by: Shawn Guo <shawnguo@kernel.org>
>> > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>
>> Thanks, applied for fixes!
>
> Ulf, I would like some more discussion about this patch but need time to
> think about it some more. I'll try to have my answer ready by this
> evening, but I'd appreciate to have at least one day to respond to a
> patch. Otherwise it is difficult for me to focus on the other work I
> have. Could that meet your workflow?

My apologies, trying to catch up with everything and I was too fast. :-)

I have dropped the change from my fixes and next branch. Awaiting an
ack/reviewed by from you first before I apply again.

Kind regards
Uffe

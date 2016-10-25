From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] mmc: core: Don't use ->card_busy() and CMD13 in
 combination when polling
Date: Tue, 25 Oct 2016 10:44:19 +0200
Message-ID: <CAPDyKFrH=ZanAFTGan47mM0rR_1H0CKrawAoVtT28jWq58EA5w@mail.gmail.com>
References: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
 <1476951579-26125-5-git-send-email-ulf.hansson@linaro.org> <CACRpkdbASwAgV2kTzVAMTHwC5fsGuEsJuYXq5n5VKgXmUqMfgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38644 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbcJYIoW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2016 04:44:22 -0400
Received: by mail-wm0-f49.google.com with SMTP id d128so13691081wmf.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2016 01:44:21 -0700 (PDT)
In-Reply-To: <CACRpkdbASwAgV2kTzVAMTHwC5fsGuEsJuYXq5n5VKgXmUqMfgA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>

On 24 October 2016 at 09:49, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Oct 20, 2016 at 10:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> When polling for busy after sending a MMC_SWITCH command, both the optional
>> ->card_busy() callback and CMD13 are being used in conjunction.
>>
>> This doesn't make sense. Instead it's more reasonable to rely solely on the
>> ->card_busy() callback when it exists. Let's change that and instead use
>> the CMD13 as a fall-back. In this way we avoid sending CMD13, unless it's
>> really needed.
>>
>> Within this context, let's also take the opportunity to make some
>> additional clean-ups and clarifications to the related code.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Tried these four patches but it doesn't make my root mount before
> 20 minutes on the Dragonboard, but I don't know if that was the
> intention even? Just cleanup? Sorry if I got it wrong...

Apologize if this was confusing, these changes was not intended to fix
your reported problem. They are clean-ups and the last change improves
the polling loop for switch commands a bit.

I will post a patch for the reported regression asap and will keep you
on cc. Appreciate if you could help in testing!

Kind regards
Uffe

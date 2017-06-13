From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: "refcount_t: underflow; use-after-free" when removing a SD card
Date: Tue, 13 Jun 2017 11:00:21 +0200
Message-ID: <CACRpkdZMG1WoJDgiJCEgUcEXXLi6qB-=FL7mc+2WpZTuJeTJJQ@mail.gmail.com>
References: <636ebd78-d813-aad2-bb24-b52ad75ff192@gmail.com>
 <CAPDyKFrmKUj2jv_HOxVJfAQD1emzXLv_80__Bddm2_EABqqRVQ@mail.gmail.com>
 <993cbd83-7e11-7655-ffab-1f352a16fd4b@gmail.com> <e9ff53a6-2863-0d69-ba7c-eab80b9b5552@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:35173 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbdFMJAX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2017 05:00:23 -0400
Received: by mail-it0-f46.google.com with SMTP id m62so37113389itc.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2017 02:00:23 -0700 (PDT)
In-Reply-To: <e9ff53a6-2863-0d69-ba7c-eab80b9b5552@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Jun 13, 2017 at 12:05 AM, Heiner Kallweit <hkallweit1@gmail.com> wrote:

>> Mentioned commit added a call to blk_cleanup_queue to mmc_cleanup_queue.
>> Now blk_cleanup_queue is called twice and I'm not sure whether this is correct.
>>
> By the way: Removing the new call to blk_cleanup_queue in mmc_cleanup_queue
> fixed the issue for me, but whether this is the correct fix I can't tell.

It's the right fix.

I sent a patch with your Reported-by.

Thanks a lot for reporting this (and suggesting the fix).

Yours,
Linus Walleij

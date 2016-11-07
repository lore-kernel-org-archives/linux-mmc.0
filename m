From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmc: Use 500ms as the default generic CMD6 timeout
Date: Mon, 7 Nov 2016 11:50:28 +0100
Message-ID: <CAPDyKFrB5GBcUnYcuHFYFQG2LC0pkD8hQY-xeSbtOw83hm0PYA@mail.gmail.com>
References: <1478280753-2482-1-git-send-email-ulf.hansson@linaro.org> <CACRpkdZQCo9=TbwjJNppdQGArWLNxHSLuZVYnNOadnOt3773CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37460 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbcKGLtC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 06:49:02 -0500
Received: by mail-wm0-f51.google.com with SMTP id t79so171866442wmt.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2016 03:49:02 -0800 (PST)
In-Reply-To: <CACRpkdZQCo9=TbwjJNppdQGArWLNxHSLuZVYnNOadnOt3773CQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, stable <stable@vger.kernel.org>

On 7 November 2016 at 11:03, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Nov 4, 2016 at 6:32 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> In the eMMC 4.51 version of the spec, an EXT_CSD field called
>> GENERIC_CMD6_TIME[248] was added. This allows cards to specify the maximum
>> time it may need to move out from its busy state, when a CMD6 command has
>> been sent.
>>
>> In cases when the card is compliant to versions < 4.51 of the eMMC spec,
>> obviously the core needs to use a fall-back value for this timeout, which
>> currently is set to 10 minutes. This value is completely in the wrong range
>> and importantly in some cases it causes a card initialization to take more
>> than 10 minute to complete.
>>
>> Earlier this scenario was avoided as the mmc core used CMD13 to poll the
>> card, to find out when it stopped signaling busy. Commit 08573eaf1a70
>> ("mmc: mmc: do not use CMD13 to get status after speed mode switch")
>> changed this behavior.
>>
>> Instead of reverting that commit, which would cause other issues, let's
>> instead start by picking a simple solution for the problem, by using a
>> 500ms default generic CMD6 timeout.
>>
>> The reason for using exactly 500ms, comes from observations that shows it's
>> quite common for cards to specify 250ms. 500ms is two times that value so
>> likely it should be enough for most cards.
>>
>> Cc: <stable@vger.kernel.org> # v4.8+
>> Fixes: 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed
>> mode switch")
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> This fixes my rootfs issue. It still doesn't appear immediately as it did
> before, but maybe before was wrong then. (Or we should hammer
> a bit with  CMD13 and wait for a correct CRC?)

Yes, I see this as a quick fix for stable/rc.

So, I intend to submit a new series which builds on top of this and
which hopefully will improves the behaviour.

>
> Anyways: things are a lot better now, so:
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for testing!

Kind regards
Uffe

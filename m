From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: core: Fix CMD6 timeout issue
Date: Thu, 19 Jan 2017 22:13:15 +0100
Message-ID: <CAPDyKFrx99Cqg8V2Jek3zV-KqNbkrpKJoYWxB-iSiNjk5bUibw@mail.gmail.com>
References: <1483433397-11756-1-git-send-email-yong.mao@mediatek.com>
 <1483433397-11756-2-git-send-email-yong.mao@mediatek.com> <CAPDyKFrkehvdnYgau1zFmgcHUniMbcat_NOLkB7bSGWF+b=c9Q@mail.gmail.com>
 <1484816328.19281.43.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38679 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdASVNS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 16:13:18 -0500
Received: by mail-wm0-f44.google.com with SMTP id r144so13363391wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 13:13:17 -0800 (PST)
In-Reply-To: <1484816328.19281.43.camel@mhfsdcap03>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mediatek@lists.infradead.org

>
>> This leads to my following question:
>> Why do you get a CRC error at the first CMD6 attempt? That shouldn't
>> happen, right?
>>
> Host needs to ensure that there is no CRC error when sampling the
> signal from device. However, in the high frequency mode, it is
> inevitable that there will be CRC error.
> Because of the presence of CRC error, we have the re-tune mechanism in
> the mmc core layer to handle.

Hmm. I assume your issue is only when sending a CMD6 and quite far
into the HS400 mode enabling sequence.

> But in this case, it will occur CMD timeout error after re-sending the
> R1B CMD. Currently, we still do not have mechanism to handle this case
> in the mmc core layer.
>
>> Perhaps you can elaborate on what of the CMD6 commands in the HS400
>> enabling sequence that fails. It may help us to understand, perhaps
>> there may be something in that sequence that should be changed.
>>
> Sorry. Maybe I didn't describe this issue clearly.
> The CMD6 command issue in my commit message is only a specific example
> of this type of issue we actually encounter.
>
> I describe the issue step by step as below:
> Step 1: Send a R1B command and then get command CRC error.
> Step 2: According to the current logic of mmc core layer code,
>         it will resend this R1B command again.
> Step 3: Because card may be in the busy state while resending this
>         R1B command, card will not response this R1B command.
>         And then this R1B command will fail with the reason
>         of timeout.

Thanks for the clarification!

>
>> >
>> > Not only CMD6 here has this issue, but also other R1B CMD has
>> > the same issue.
>>
>> Yes, agree!
>>
>> However, can you please try to point out some other commands than CM6
>> that you see uses *retries*, has R1B response, and which you believe
>> may not be properly managed.
>>
> Actually, we just met this CMD6 timeout issue in our project.
> However, according to the analysis, all R1b command may have the same
> issue.

Okay. I see.

To me it seems like you have two options to fix this

1. Try fix the problem your host driver. I think it's odd to a CRC
error, immediately after you have done a tuning. Maybe the tuning
actually failed in the first step?
2.  Implement some kind of re-try mechanism specific for the HS400
enabling sequence when sending the CMD6 command you refer to, and if
so that in conjunction of removing the retries for CMD6 in
__mmc_switch().

>
>> Dealing with R1B responses isn't always straight forward. Therefore I
>> am wondering whether we perhaps should just not allow "automatic
>> retries" in cases when R1B responses is used.
>>
>> The reason why I think that is easier, is because of the complexity we
>> have when dealing with R1B responses.
> We think "automatic retries" should still be used in this case.
> With "automatic retries", it have re-tune mechanism to let host
> re-select a better parameters to handle command CRC error.
>
>>
>> As for example the timeout may differ depending on the command, so
>> just guessing that 500 ms might work, isn't good enough. Moreover we
>> would need to deal with MMC_CAP_WAIT_WHILE_BUSY, etc. Currently I am
>> not saying that we shouldn't do this, but then I first need to
>> understand how big of problem this is.
>>
> Yes. You are right. We need to deal with MMC_CAP_WAIT_WHILE_BUSY here.
> If the host has the capability of MMC_CAP_WAIT_WHILE_BUSY, it does not
> need this patch. But the host, like our host, does not have this
> capability, it needs this patch. I will add this logic in next version.
> According to our experience, 500ms is enough here.

It seems the problem mostly concerns switching to HS400 mode. Perhaps,
in the end it's actually a tuning issue specific to your controller?

Therefore, I would rather suggest you to try one of the two approaches
I suggested above, than continuing this path.

[...]

Kind regards
Uffe

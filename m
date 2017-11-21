From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: card: increase wait time
Date: Tue, 21 Nov 2017 12:38:58 +0100
Message-ID: <CAPDyKFq298BCPBSBxtHC7JPx=jNmv6qn78TjM0_Wkz_CFuBgUQ@mail.gmail.com>
References: <CGME20171114024825eucas1p218873c4ff649c17d4061b6660aa6264f@eucas1p2.samsung.com>
 <1510627683-5209-1-git-send-email-huijin.park@samsung.com>
 <CAPDyKFo6M+TzrtPmfc2xJzKUaRhbiFp9UR8f+AQf_RgKYu5M9w@mail.gmail.com>
 <CAFwFC8QL4oyz9oDyidjkByRUCqWo_UufHiHgMf1GEho+TMmnpg@mail.gmail.com>
 <CAPDyKFrBzeYiYXD7hbw6P+_cji9c2prpnhvOjsdZsLOnJNVBZw@mail.gmail.com> <ebc54dbc-b983-d3f8-a05a-8bf239429cde@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:45470 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdKULi7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Nov 2017 06:38:59 -0500
Received: by mail-it0-f52.google.com with SMTP id x13so1606549iti.4
        for <linux-mmc@vger.kernel.org>; Tue, 21 Nov 2017 03:38:59 -0800 (PST)
In-Reply-To: <ebc54dbc-b983-d3f8-a05a-8bf239429cde@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Park Huijin <bbang.huijin.park@gmail.com>, Huijin Park <huijin.park@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jungseung Lee <js07.lee@gmail.com>

On 21 November 2017 at 10:34, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi Ulf,
>
> On 2017/11/21 17:02, Ulf Hansson wrote:
>>
>> On 20 November 2017 at 05:50, Park Huijin <bbang.huijin.park@gmail.com>
>> wrote:
>>>
>>> 2017-11-15 18:13 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>>>>
>>>>
>>>> On 14 November 2017 at 03:48, Huijin Park <huijin.park@samsung.com>
>>>> wrote:
>>>>>
>>>>> Some eMMC products keep busy time a little longer intermittently.
>>>>> (eg. prepare free blocks, garbage collection...)
>>>>> In this case, we recommend to wait a little longer than fail.
>>>>
>>>>
>>>> Is this an rpmb specific problem, because the code seems only to change
>>>> that.
>>>>
>>>> Is it write and read or only write?
>>>
>>> Yes. It's rpmb specific problem.
>>> RPMB R/W use same flow. but only 'write' case makes the problem(long
>>> busy state) sometimes.
>>> When I test it, the 5~25ms is not enough although there is not max
>>> busy time in the spec.
>>
>>
>> As a matter of fact this isn't specific to RPMB writes at all but to
>> all data writes. That's why we call card_busy_detect() after a data
>> write.
>
>
> Further more, we should cover all transfer pattern from userspace, not
> just data writes. :)
>
> https://www.spinics.net/lists/linux-mmc/msg46147.html

Ack!

Kind regards
Uffe

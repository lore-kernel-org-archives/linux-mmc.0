From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/3] mmc: replacing hardcoded value for runtime PM suspend
Date: Thu, 13 Oct 2016 16:30:26 +0800
Message-ID: <9277d105-9603-c011-25c4-083590fb4709@rock-chips.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
 <1472739890-3384-2-git-send-email-alex.lemberg@sandisk.com>
 <cc6129e7-5250-8c2e-73e0-1134e2a7146d@rock-chips.com>
 <2D82096E-231C-43BA-801D-381F8191F26C@sandisk.com>
 <CAPDyKFo=xUkGvqghr3zFB_anvzVQDJgkjFziveceQ+jpjjxdbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:37699 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbcJMImI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2016 04:42:08 -0400
In-Reply-To: <CAPDyKFo=xUkGvqghr3zFB_anvzVQDJgkjFziveceQ+jpjjxdbQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>

在 2016/10/13 15:36, Ulf Hansson 写道:
> On 4 September 2016 at 15:30, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:
>> Hi Shawn,
>>
>> On 9/2/16, 10:39 AM, "Shawn Lin" <shawn.lin@rock-chips.com> wrote:
>>
>>> Hi
>>>
>>> On 2016/9/1 22:24, alex lemberg wrote:
>>>> Add MMC_AUTOSUSPEND_DELAY_MS define
>>>
>>> I'm thinking should we expose it to userspace
>>> via sysfs, since I don't know why it should be 3ms, not 4ms, 5ms, etc.
>>
>> Agree, we can consider exposing it to the user space.
>> The exposure to the user space is less critical to the current
>> patchset, but we can do it as a “follow-up change” once its approved.
>
> No need for that, is already available for user-space. :-)
>
> Each device with runtime PM autosuspend enabled, allows userspace to
> change the delay via the "autosuspend_delay_ms" sysfs file.

Indeed， I just check it when enabling runtime PM for dw_mmc and could
able to change the value of autosuspend_delay_ms.

Thanks for sharing this.

>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin


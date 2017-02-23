From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 05/39] mmc: mmc: Add functions to enable / disable the
 Command Queue
Date: Thu, 23 Feb 2017 15:54:32 +0100
Message-ID: <CACRpkdbDBNH=Mxp95X7dTU3TZiS=KPm5My4RMjOOxWrfkVZ+7A@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
 <1486731352-8018-6-git-send-email-adrian.hunter@intel.com>
 <CACRpkdbW4nDA=e6zM3095N9y_hy2Rsktzmuf8g8=xOaJCeLbGA@mail.gmail.com> <CAPDyKFph+WPzrNT9_eeGuzDRoWsg+sg1+j2sthpP9+XAdwZ18w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:37907 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdBWOye (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2017 09:54:34 -0500
Received: by mail-it0-f43.google.com with SMTP id y135so2471217itc.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Feb 2017 06:54:34 -0800 (PST)
In-Reply-To: <CAPDyKFph+WPzrNT9_eeGuzDRoWsg+sg1+j2sthpP9+XAdwZ18w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 17, 2017 at 1:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 15 February 2017 at 13:52, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>>> Add helper functions to enable or disable the Command Queue.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> I think I asked this before but why?
>
> There are certain other requests, like for RPMB, which requires CMDQ
> to be "temporary" disabled.

Ah my comment is stupid.

I specifically want to know why we should be able to disable
it from sysfs.

I don't see the point in that, just giving userspace another gun
to shoot itself in the foot.

Yours,
Linus Walleij

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 05/39] mmc: mmc: Add functions to enable / disable the
 Command Queue
Date: Fri, 17 Feb 2017 13:21:14 +0100
Message-ID: <CAPDyKFph+WPzrNT9_eeGuzDRoWsg+sg1+j2sthpP9+XAdwZ18w@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
 <1486731352-8018-6-git-send-email-adrian.hunter@intel.com> <CACRpkdbW4nDA=e6zM3095N9y_hy2Rsktzmuf8g8=xOaJCeLbGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35781 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932941AbdBQMVQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2017 07:21:16 -0500
Received: by mail-qk0-f173.google.com with SMTP id u25so42296370qki.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2017 04:21:15 -0800 (PST)
In-Reply-To: <CACRpkdbW4nDA=e6zM3095N9y_hy2Rsktzmuf8g8=xOaJCeLbGA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On 15 February 2017 at 13:52, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
>> Add helper functions to enable or disable the Command Queue.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>
> I think I asked this before but why?

There are certain other requests, like for RPMB, which requires CMDQ
to be "temporary" disabled.

Seems like a little more information the change log would be
appreciated to understand why we need to add these functions.

>
> If the card has this feature, certainly we should just exploit it?
>
> If some card has a problem with it, I guess it is broken and should
> simply have this operation blacklisted.
>
> Yours,
> Linus Walleij

Kind regards
Uffe

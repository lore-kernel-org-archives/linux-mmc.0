From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH] mmc: core: Restore parts of the polling policy when
 switch to HS/HS DDR
Date: Tue, 17 Jan 2017 09:43:53 +0800
Message-ID: <CAA+hA=SkBi4jXVBMsyvJH-WEL4-U5peuPXD52UQiO4NmYWQfEQ@mail.gmail.com>
References: <1484305503-30723-1-git-send-email-ulf.hansson@linaro.org>
 <CAA+hA=QU8Uq9zCyg_-bmSVuPPLEnUrsbXJCgMZtab7Aw4FVrnw@mail.gmail.com> <CAPDyKFoyv36YVf9WeRd8avsWk15i60xPfr6LW_rP2y6rA+U0Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35602 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdAQBoF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2017 20:44:05 -0500
Received: by mail-qt0-f193.google.com with SMTP id f4so18122088qte.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2017 17:43:55 -0800 (PST)
In-Reply-To: <CAPDyKFoyv36YVf9WeRd8avsWk15i60xPfr6LW_rP2y6rA+U0Zw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, Haibo Chen <haibo.chen@nxp.com>

Hi Ulf,

On Mon, Jan 16, 2017 at 11:13 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 16 January 2017 at 04:48, Dong Aisheng <dongas86@gmail.com> wrote:
>> Hi Ulf,
>>
>> On Fri, Jan 13, 2017 at 7:05 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Regressions for not being able to detect an eMMC HS DDR mode card has been
>>> reported for the sdhci-esdhc-imx driver, but potentially other sdhci
>>> variants may suffer from the similar problem.
>>>
>>> The commit e173f8911f09 ("mmc: core: Update CMD13 polling policy when
>>> switch to HS DDR mode"), is causing the problem. It seems that change moved
>>> one step to far, regarding changing the host's timing before polling for a
>>> busy card.
>>>
>>> To fix this, let's move back to the behaviour when the host's timing is
>>> updated after the polling, but before the switch status is fetched and
>>> validated.
>>>
>>> In cases when polling with CMD13, we keep validating the switch status at
>>> each attempt. However, to align with the other card busy detections
>>> mechanism, let's fetch and validate the switch status also after the host's
>>> timing is updated.
>>>
>>> Reported-by: Clemens Gruber <clemens.gruber@pqgruber.com>
>>> Reported-by: Gary Bisson <gary.bisson@boundarydevices.com>
>>> Fixes: e173f8911f09 ("mmc: core: Update CMD13 polling policy when switch..")
>>> Cc: Shawn Lin <shawn.lin@rock-chips.com>
>>> Cc: Dong Aisheng <aisheng.dong@nxp.com>
>>> Cc: Haibo Chen <haibo.chen@nxp.com>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Thanks for the fix.
>>
>> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
>
> Thanks for reviewing!
>
>>
>> BTW, i wonder if we could then remove the CMD13 Polling method or give a
>> temporarily WARN_ONCE to indicate OBSOLETED using and force all hosts
>> to provide card_busy() callback.
>> Then we can permanently fix the potential timing mismatch issue.
>
> In the end it seems like the issue is host specific. I have
> successfully used CM13 polling on my ux500 board (mmci.c, with some
> hacks to force CMD13).
>
> If we see any further issues, perhaps we should invent a new host cap,
> which forbids the CMD13 polling and then those host drivers that has
> issues, can set it. Wouldn't that be okay for you?
>

I'm fine with it.
Thanks

Regards
Dong Aisheng

> [...]
>
> Kind regards
> Uffe

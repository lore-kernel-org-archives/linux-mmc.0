From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] mmc: core: remove issue_fn indirect function call
Date: Thu, 26 Sep 2013 14:56:47 -0700
Message-ID: <CANEJEGt9E3apwKMpLFL8_5cy8GW9EdcNgXtm-XGAmQWgYftVjw@mail.gmail.com>
References: <1379611214-1089-1-git-send-email-grundler@chromium.org>
	<CAPDyKFr0h=uTz4xOAULLc0Ff23xB-xVuuk+XnBz_Uq5YMryHbA@mail.gmail.com>
	<87fvss2uh9.fsf@octavius.laptop.org>
	<8738os2tqt.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:37302 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab3IZV4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2013 17:56:48 -0400
Received: by mail-oa0-f51.google.com with SMTP id h16so1453176oag.38
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2013 14:56:47 -0700 (PDT)
In-Reply-To: <8738os2tqt.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Grant Grundler <grundler@chromium.org>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Sep 25, 2013 at 7:37 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Wed, Sep 25 2013, Chris Ball wrote:
>> Hi,
>>
>> On Fri, Sep 20 2013, Ulf Hansson wrote:
>>> On 19 September 2013 19:20, Grant Grundler <grundler@chromium.org> =
wrote:
>>>> struct mmc_queue defines issue_fn as an indirect function call.
>>>> issue_fn field only gets set to mmc_blk_issue_rq and only gets
>>>> invoked immediately after calling blk_fetch_request().
>>>> Don't bother with indirect function call - it's pointless and just
>>>> obfuscates the code.
>>>>
>>>> Signed-off-by: Grant Grundler <grundler@chromium.org>
>>>
>>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Thanks, pushed to mmc-next for 3.13.
>
> Have dropped this, it's breaking my build:
>
> /home/cjb/git/mmc/drivers/mmc/card/block.c:1955:12: warning: =E2=80=98=
mmc_blk_issue_rq=E2=80=99 defined but not used [-Wunused-function]

The function is declared static. :(  Let me respin to remove the
static and add a function prototype to a header file. I just got lucky
when I built this in an earlier tree.

sorry about that...

grant

> /home/cjb/git/mmc/drivers/mmc/card/queue.c: In function =E2=80=98mmc_=
queue_thread=E2=80=99:
> /home/cjb/git/mmc/drivers/mmc/card/queue.c:70:4: error: implicit decl=
aration of function =E2=80=98mmc_blk_issue_rq=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]


>
> Grant, please could you take a look and resubmit?
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>

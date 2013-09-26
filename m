From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] mmc: core: remove issue_fn indirect function call
Date: Thu, 26 Sep 2013 15:16:32 -0700
Message-ID: <CANEJEGuGWKVudcKMrZKLPEMEpQ5sJFJn4xwOOe7N6q9_qfy3bw@mail.gmail.com>
References: <1379611214-1089-1-git-send-email-grundler@chromium.org>
	<CAPDyKFr0h=uTz4xOAULLc0Ff23xB-xVuuk+XnBz_Uq5YMryHbA@mail.gmail.com>
	<87fvss2uh9.fsf@octavius.laptop.org>
	<8738os2tqt.fsf@octavius.laptop.org>
	<CANEJEGt9E3apwKMpLFL8_5cy8GW9EdcNgXtm-XGAmQWgYftVjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:57214 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab3IZWQc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2013 18:16:32 -0400
Received: by mail-oa0-f50.google.com with SMTP id j1so1446700oag.23
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2013 15:16:32 -0700 (PDT)
In-Reply-To: <CANEJEGt9E3apwKMpLFL8_5cy8GW9EdcNgXtm-XGAmQWgYftVjw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Sep 26, 2013 at 2:56 PM, Grant Grundler <grundler@chromium.org>=
 wrote:
> On Wed, Sep 25, 2013 at 7:37 PM, Chris Ball <cjb@laptop.org> wrote:
>> Hi,
>>
>> On Wed, Sep 25 2013, Chris Ball wrote:
>>> Hi,
>>>
>>> On Fri, Sep 20 2013, Ulf Hansson wrote:
>>>> On 19 September 2013 19:20, Grant Grundler <grundler@chromium.org>=
 wrote:
>>>>> struct mmc_queue defines issue_fn as an indirect function call.
>>>>> issue_fn field only gets set to mmc_blk_issue_rq and only gets
>>>>> invoked immediately after calling blk_fetch_request().
>>>>> Don't bother with indirect function call - it's pointless and jus=
t
>>>>> obfuscates the code.
>>>>>
>>>>> Signed-off-by: Grant Grundler <grundler@chromium.org>
>>>>
>>>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>> Thanks, pushed to mmc-next for 3.13.
>>
>> Have dropped this, it's breaking my build:
>>
>> /home/cjb/git/mmc/drivers/mmc/card/block.c:1955:12: warning: =E2=80=98=
mmc_blk_issue_rq=E2=80=99 defined but not used [-Wunused-function]
>
> The function is declared static. :(  Let me respin to remove the
> static and add a function prototype to a header file.

block.o and queue.o are linked together into one .ko all the time:
obj-$(CONFIG_MMC_BLOCK)         +=3D mmc_block.o
mmc_block-objs                  :=3D block.o queue.o

Two ways to handle this: I can
1) add a local function prototype of mmc_blk_issue_rq() to queue.c
2) move mmc_init_queue() and mmc_queue_thread() from queue.c to block.c

(2) actually makes sense since both functions are block IO specific.

Thoughts? Preference? Other ideas?

thanks,
grant

ps. It's more obvious now that the return value from
mmc_blk_issue_rq() is getting ignored. *sigh*

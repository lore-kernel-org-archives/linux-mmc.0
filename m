From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] mmc: block: Preinitialize ret in mmc_blk_issue_drv_op()
Date: Wed, 5 Jul 2017 17:07:17 +0200
Message-ID: <CAMuHMdU179SU6ieCBLLRCa=qFEqEF5a5Ut0gdpKyFGCqMOO8aw@mail.gmail.com>
References: <1499245637-28870-1-git-send-email-geert@linux-m68k.org> <CAK8P3a1ANjdbHt0x=o2WXB9AHbSj1xr1B-GOqzoKUagma3bBnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:32831 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdGEPHT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jul 2017 11:07:19 -0400
In-Reply-To: <CAK8P3a1ANjdbHt0x=o2WXB9AHbSj1xr1B-GOqzoKUagma3bBnA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Arnd,

On Wed, Jul 5, 2017 at 2:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jul 5, 2017 at 11:07 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> With gcc 4.1.2:
>>
>>     drivers/mmc/core/block.c: In function =E2=80=98mmc_blk_issue_drv_op=
=E2=80=99:
>>     drivers/mmc/core/block.c:1178: warning: =E2=80=98ret=E2=80=99 may be=
 used uninitialized in this function
>>
>> Indeed, if mq_rq->ioc_count is zero, an uninitialized value will be
>> stored in mq_rq->drv_op_result and passed to blk_end_request_all().
>>
>> Can mq_rq->ioc_count be zero?
>>   - mmc_blk_ioctl_cmd() sets ioc_count to 1, so this is safe,
>>   - mmc_blk_ioctl_multi_cmd() obtains ioc_count from user space in
>>     response to the MMC_IOC_MULTI_CMD ioctl, and does allow zero.
>>
>> Preinitialize ret to -EINVAL to fix this for current and future callers.
>>
>> Fixes: 0493f6fe5bdee8ac ("mmc: block: Move boot partition locking into a=
 driver op")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> I assume -EINVAL is the error we want to return here if ioc_count is
>> zero.
>> Or should it return success (zero), like mmc_blk_ioctl_multi_cmd() used
>> to do?
>
> I would suggest adding the initialization after "case MMC_DRV_OP_IOCTL:"
> instead, to keep getting compile-time checks on the state of the 'ret'
> variable. In that case, returning '0' is probably good.

Makes sense, I actually did consider that, but went with (shared) -EINVAL.

Will send v2 shortly.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

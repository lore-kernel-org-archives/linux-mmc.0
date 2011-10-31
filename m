From: Jun Nie <niej0001@gmail.com>
Subject: Re: Question: kick SDIO irq when resume
Date: Mon, 31 Oct 2011 22:06:59 +0800
Message-ID: <CAGA24MLv9Z8USwCeGdKgW06Fdz7b55qyS-m03hVHkun-7i0TFA@mail.gmail.com>
References: <CAGA24MKE-FLRBk2zHk_Wy2Apg8-epC6Q38W2csTs7YSN1gHzhg@mail.gmail.com>
	<alpine.LFD.2.02.1110310824120.3307@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64357 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab1JaOHB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2011 10:07:01 -0400
Received: by faan17 with SMTP id n17so5533951faa.19
        for <linux-mmc@vger.kernel.org>; Mon, 31 Oct 2011 07:06:59 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1110310824120.3307@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Bing Zhao <bzhao@marvell.com>, frankh@marvell.com, yongd@marvell.com, tianfh@marvell.com, njun@marvell.com, linux-mmc@vger.kernel.org

2011/10/31 Nicolas Pitre <nicolas.pitre@linaro.org>:
> On Mon, 31 Oct 2011, Jun Nie wrote:
>
>> Hi Nico,
>> =A0 =A0 We are debugging fake SDIO irq when 8787 SDIO card resume an=
d
>> found below patch. The issue is that 8787 driver can not handle card
>> irq if neither 8787 nor host trigger resume event in some cases. Do
>> you remember what SDIO card need below patch? What's your idea on th=
is
>> issue? How about add a SDIO function flag to decide the irq thread
>> kick off in resume?
>
> This is needed because in some cases the card interrupt is already
> consumed for the wake-up event. =A0Kicking this thread shouldn't caus=
e any
> issue though, as the card is just polled for the actual presence of a=
n
> IRQ ...
>
> ... or maybe not. =A0In this case commit 06e8935feb "optimized SDIO I=
RQ
> handling for single irq" may certainly cause problems.
>
> The fix here would be to clear card->sdio_single_irq before calling
> mmc_signal_sdio_irq() in mmc_sdio_resume() and restore its original
> value eventually, or better yet ignore that flag when the IRQ thread =
is
> ran for the first time after a resume.
8787 case(bug) is similar with sdio_signel_irq case, but not same.
8787 can not response to reading sdio card interrupt status correctly
if 8787 is still in suspend mode. The read operation will get value of
previous CMD52 read, no matter previous CMD52 is for what purpose. So
host should avoid read from 8787 before call sdio function resume in
normal resume process. Otherwise, 8787 may lead lead host to handle
fake interrupt and result further error.
>
> In any case you may disable that optimization in the IRQ demux handle=
r
> to see if this fixes your problem.
So the fix to 8787 is either adding a flag, such as NO_LOST_WAKEUP_IRQ
for func/card, or moving kick off to after sdio function resume. I do
not know which one you prefer.
>
>
> Nicolas
>

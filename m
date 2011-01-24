From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: clear all interrupt in suspend before free_irq
Date: Sun, 23 Jan 2011 21:10:05 -0500
Message-ID: <AANLkTim-FiqiUM2Gc45VGHfPzMHDX20eGZMHBnkY=R4m@mail.gmail.com>
References: <AANLkTi=M5M=uaGJ-+8K0fLDssDR7bnD=K0Saxz-Gww6y@mail.gmail.com>
	<alpine.LFD.2.00.1101211431050.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40061 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab1AXCKH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Jan 2011 21:10:07 -0500
Received: by fxm20 with SMTP id 20so3549426fxm.19
        for <linux-mmc@vger.kernel.org>; Sun, 23 Jan 2011 18:10:06 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101211431050.8580@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Bing Zhao <bzhao@marvell.com>, Chris Ball <cjb@laptop.org>

On Fri, Jan 21, 2011 at 2:33 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Fri, 21 Jan 2011, zhangfei gao wrote:
>
>> >From b7be39e0bbac3950057078ac66900ebc0871f77e Mon Sep 17 00:00:00 2=
001
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Fri, 21 Jan 2011 18:02:47 -0500
>> Subject: [PATCH] mmc: clear all interrupt in suspend before free_irq
>>
>> =A0 =A0 =A0 When debugging wifi host sleep, race condition about
>> SDHCI_INT_CARD_INT happens.
>> =A0 =A0 =A0 Host free_irq in suspend and request_irq when resume bac=
k.
>> =A0 =A0 =A0 However SDHCI_INT_CARD_INT is not cleared, so interrupt =
will
>> immediately happen after request_irq.
>> =A0 =A0 =A0 mmc_signal_sdio_irq will be called and wakeup sdio_irq_t=
hread.
>> =A0 =A0 =A0 As a result irq_handler in sdio driver is called even be=
fore host resume back.
>>
>> =A0 =A0 =A0 The correct case is mmc_sdio_resume calls mmc_signal_sdi=
o_irq to
>> wakeup sdio_irq_thread
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>
> That makes sense, as long as the masking of interrupts doesn't preven=
t
> a SDIO card interrupt from waking up the host system.

Thanks Nicolas for comments

Masking interrupt does not impact wake up cpu.
1. irq is already freed in suspend, and request again when resume backe=
d
2. cpu is wake up first, then irq service is handled, so irq does not
impact cpu wake up or not.
3. mmc_signal_sdio_irq is serviced in mmc_sdio_resume.

>
>
>> ---
>> =A0drivers/mmc/host/sdhci.c | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index aacd78c..97074ae 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1707,6 +1707,7 @@ int sdhci_suspend_host(struct sdhci_host *host=
,
>> pm_message_t state)
>> =A0 =A0 =A0 ret =3D mmc_suspend_host(host->mmc);
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, 0);
>>
>> =A0 =A0 =A0 free_irq(host->irq, host);
>>
>> --
>> 1.7.0.4
>>
>

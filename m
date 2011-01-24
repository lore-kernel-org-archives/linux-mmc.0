From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: clear all interrupt in suspend before free_irq
Date: Mon, 24 Jan 2011 01:46:08 -0500
Message-ID: <AANLkTi=AwffD80d9-9Bdwyp7EPNRuiMhAeFwXj9Yrw1G@mail.gmail.com>
References: <AANLkTi=M5M=uaGJ-+8K0fLDssDR7bnD=K0Saxz-Gww6y@mail.gmail.com>
	<alpine.LFD.2.00.1101211431050.8580@xanadu.home>
	<AANLkTim-FiqiUM2Gc45VGHfPzMHDX20eGZMHBnkY=R4m@mail.gmail.com>
	<AD81E867-067B-4031-9594-52CA45F2D0C9@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32958 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab1AXGqJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 01:46:09 -0500
Received: by fxm20 with SMTP id 20so3681516fxm.19
        for <linux-mmc@vger.kernel.org>; Sun, 23 Jan 2011 22:46:08 -0800 (PST)
In-Reply-To: <AD81E867-067B-4031-9594-52CA45F2D0C9@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Bing Zhao <bzhao@marvell.com>, Chris Ball <cjb@laptop.org>

On Sun, Jan 23, 2011 at 9:17 PM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> I am confused. =A0Your patch modifiies
>
> sdhci_suspend_host () to
>>>> + =A0 =A0 sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, 0);
>>>
>
>
>
> #define SDHCI_INT_ALL_MASK =A0 =A0 =A0((unsigned int)-1)
>
> static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, =
u32 set)
> {
> =A0 =A0 =A0 =A0u32 ier;
>
> =A0 =A0 =A0 =A0ier =3D sdhci_readl(host, SDHCI_INT_ENABLE);
> =A0 =A0 =A0 =A0ier &=3D ~clear;
> =A0 =A0 =A0 =A0ier |=3D set;
> =A0 =A0 =A0 =A0sdhci_writel(host, ier, SDHCI_INT_ENABLE);
> =A0 =A0 =A0 =A0sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
> }
>
>
> The code clears all the interrupts. =A0 =A0How is a card insert detec=
ted ?

In sdhci.c, sdhci_disable_card_detection is called in suspend_host,
and card does not be detected when cpu is suspended.
>
>
>
>
> On Jan 23, 2011, at 6:10 PM, zhangfei gao wrote:
>
>> On Fri, Jan 21, 2011 at 2:33 PM, Nicolas Pitre <nico@fluxnic.net> wr=
ote:
>>> On Fri, 21 Jan 2011, zhangfei gao wrote:
>>>
>>>>> From b7be39e0bbac3950057078ac66900ebc0871f77e Mon Sep 17 00:00:00=
 2001
>>>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>> Date: Fri, 21 Jan 2011 18:02:47 -0500
>>>> Subject: [PATCH] mmc: clear all interrupt in suspend before free_i=
rq
>>>>
>>>> =A0 =A0 =A0 When debugging wifi host sleep, race condition about
>>>> SDHCI_INT_CARD_INT happens.
>>>> =A0 =A0 =A0 Host free_irq in suspend and request_irq when resume b=
ack.
>>>> =A0 =A0 =A0 However SDHCI_INT_CARD_INT is not cleared, so interrup=
t will
>>>> immediately happen after request_irq.
>>>> =A0 =A0 =A0 mmc_signal_sdio_irq will be called and wakeup sdio_irq=
_thread.
>>>> =A0 =A0 =A0 As a result irq_handler in sdio driver is called even =
before host resume back.
>>>>
>>>> =A0 =A0 =A0 The correct case is mmc_sdio_resume calls mmc_signal_s=
dio_irq to
>>>> wakeup sdio_irq_thread
>>>>
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>>
>>> That makes sense, as long as the masking of interrupts doesn't prev=
ent
>>> a SDIO card interrupt from waking up the host system.
>>
>> Thanks Nicolas for comments
>>
>> Masking interrupt does not impact wake up cpu.
>> 1. irq is already freed in suspend, and request again when resume ba=
cked
>> 2. cpu is wake up first, then irq service is handled, so irq does no=
t
>> impact cpu wake up or not.
>> 3. mmc_signal_sdio_irq is serviced in mmc_sdio_resume.
>>
>>>
>>>
>>>> ---
>>>> =A0drivers/mmc/host/sdhci.c | =A0 =A01 +
>>>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index aacd78c..97074ae 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -1707,6 +1707,7 @@ int sdhci_suspend_host(struct sdhci_host *ho=
st,
>>>> pm_message_t state)
>>>> =A0 =A0 =A0 ret =3D mmc_suspend_host(host->mmc);
>>>> =A0 =A0 =A0 if (ret)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>>> + =A0 =A0 sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, 0);
>>>>
>>>> =A0 =A0 =A0 free_irq(host->irq, host);
>>>>
>>>> --
>>>> 1.7.0.4
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>

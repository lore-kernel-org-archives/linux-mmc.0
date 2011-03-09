From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Wed, 9 Mar 2011 17:11:57 -0600
Message-ID: <AANLkTinKiLF2+Yb0q9UmA21h1-uVRCSRmXNXzOWJNtnJ@mail.gmail.com>
References: <20110308213921.00625208186@grundler.mtv.corp.google.com>
	<AANLkTik3vKKs+Sxe1g+igFOpqmdYDMec7MH1mKjv0qGw@mail.gmail.com>
	<AANLkTikwapQ_Qe-U=Noan45kztNrLzZA39Oj8jLBuzV+@mail.gmail.com>
	<AANLkTikBm00dzzGU_Rap9A0RmebnW6TOvG4LS3cXs1XW@mail.gmail.com>
	<AANLkTi==6jPPBJQou8KAGZCKtmmN44Q85PR5x2_KOR2J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:60102 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab1CIXMG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 18:12:06 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p29NCFgw020957
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 18:12:15 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p29N8jNi019496
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 18:12:14 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 10so1286180vws.15
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 15:11:57 -0800 (PST)
In-Reply-To: <AANLkTi==6jPPBJQou8KAGZCKtmmN44Q85PR5x2_KOR2J@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Dmitry Shmidt <dimitrysh@google.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Venkat Rao <vrao@broadcom.com>, Sandeep Kumar <sandeepm@broadcom.com>

On Wed, Mar 9, 2011 at 4:00 PM, Grant Grundler <grundler@google.com> wr=
ote:
>
>> I see why above patch is necessary now.
>
> I don't understand the relationship between the two. Can you
> elaborate? Or point at docs?
> I'd be happy to add comments to the code.
>

Ok, let me rephrase my original statement. I think I might see. SDIO
interrupts are received
as Card Interrupts on the SDHCI side. MMC_CAP_SDIO_IRQ is set by
sdhci.c if SDHCI_QUIRK_NO_SDIO_IRQ is not present.
MMC_CAP_SDIO_IRQ means that ops->enable_sdio_irq will be invoked by
code in sdio_irq.c. enable_sdio_irq in the sdhci case enables
SDHCI_INT_CARD_INT. When you get an
SDHCI interrupt with SDHCI_INT_CARD_INT as a reason, the SDIO irq
handling thread is woken up. That thread processes SDIO IRQs. If the
host doesn't have SDHCI_QUIRK_NO_SDIO_IRQ, the thread will sleep for
MAX_SCHEDULE_TIMEOUT. Otherwise it will periodcally awake to scan for
pending IRQs.

If you have SDHCI_QUIRK_NO_SDIO_IRQ, then you have periodic scanning
for SDIO IRQs for each card. Otherwise, you need to actually get an
interrupt from SDHCI. If you suspend+resume, and SDHCI_INT_CARD_INT is
lost, then you just lost your SDIO interrupts forever.

> In a followup you wrote
> The dependency bothers me since it suggests that if
> SDHCI_QUIRK_NO_SDIO_IRQ flag is set, we should not be touching this
> register. Is that correct?

It just means that your SDHCI controller doesn't support SDIO
interrupts and allows you to use SDIO cards in slots which technically
don't support SDIO cards. I believe. It means you need to poll for
card IRQs.

>
>
>> This is bit OT, but are the LP2 idle gains significant here?
>
> I don't know if CPU pwer is reduced or if that was intentional or jus=
t
> a side effect. Venkat or Sandeep (Broadcom) might be able to answer
> that.
>
>
> In a follow up, you also wrote:
>> As an additional comment, I think the way this patch is made it hide=
s
>> the reason for why this is necessary.
>
> TBH, even after this conversation, it's still not clear to me why.
>
> The dependency bothers me since it suggests that if
> SDHCI_QUIRK_NO_SDIO_IRQ flag is set, we should not be touching this
> register. Is that correct?

But you don't have it set? If you have it set, then your patch
shouldn't be necessary? It's necessary for cases where you are
expecting SDHCI host to signal you on a card interrupt.

>
>> The patch should explicitly record if SDHCI_INT_CARD_INT is
>> enabled on suspend and set it back again on resume.
>
> Would this be better?
> =A0 =A0 host->save_intmask =3D sdhci_readl(host, SDHCI_INT_ENABLE) &
> SDHCI_INT_CARD_INT;
>

I'd verify that the card interrupt is really the reason (I believe it
is as far as I can tell), but this is probably
self documenting enough.

> Does kernel.org still need something to deal with state of
> SDHCI_QUIRK_NO_SDIO_IRQ quirk bit?

I'm confused. I see this quirk added as part of Tegra sdhci support in
our K36 tree. I suppose with this patch the should be no need for this
quirk. I'll apply your change today and see what I get.

Thanks,
A

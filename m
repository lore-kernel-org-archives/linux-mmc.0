From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Mon, 5 Nov 2012 15:07:35 +0100
Message-ID: <CA+20K0DmMPDv0SJgd6-zoHN+eZr1fROT7=HY-mEWgAO9-gmSPg@mail.gmail.com>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
	<1351584769-16662-2-git-send-email-r66093@freescale.com>
	<CA+20K0AfmJSrPO9-_-yNk4HhEVYPj8cMaa+jCZAZhp23Vb817g@mail.gmail.com>
	<110EED8CC96DFC488B7E717A2027A27C210A6D@039-SN1MPN1-004.039d.mgd.msft.net>
	<CA+20K0A3myrosOGK2dcstX06QOS1SRHaaz-zYqoFSA7ZYcEJvQ@mail.gmail.com>
	<110EED8CC96DFC488B7E717A2027A27C213E8A@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51550 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276Ab2KEOHf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Nov 2012 09:07:35 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7955892iea.19
        for <linux-mmc@vger.kernel.org>; Mon, 05 Nov 2012 06:07:35 -0800 (PST)
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C213E8A@039-SN1MPN1-004.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

Hi,

2012/11/5 Huang Changming-R66093 <r66093@freescale.com>:
>>
>> 2012/11/2 Huang Changming-R66093 <r66093@freescale.com>:
>> > Hi, Johan,
>> > When quicks SDHCI_QUIRK_BROKEN_CARD_DETECTION is set, the driver will
>> poll the card status with the command CMD13 periodically, then many
>> interrupts will be generated, which affect the performance.
>>
>> Ok, just to see if I understand the scenario correctly:
>> SDHCI_QUIRK_BROKEN_CARD_DETECTION causes the MMC_CAP_NEEDS_POLL cap to be
>> set, which will cause mmc_rescan to be run at a one second interval.
>> mmc_rescan calls bus_ops->detect (mmc_sd_detect) and this in turn calls
>> _mmc_detect_card_removed, which will do the bus_ops->alive and send CMD13.
>> So in this case, one CMD13 is sent per second, right?
>> Is this the cause of the performance issue?
>
> Yes, You are right.

Ok, it's a bit hard to understand how this can lead to a noticeable
performance impact, but OK. :)

>> A thought: if the host hardware does have a GPIO card detect pin hooked
>> up, would it not be possible to make this pin generate an IRQ whenever a
>> card is inserted or removed? This is what we do in the MMCI driver, for
>> instance (mmci_cd_irq).
>
> Our silicones has this pin to do card detect, but some boards don't generate the interrupt when card is inserted or removed. So I have to use the poll mode.
>
>> > Yes, some cases to detect GPIO can't be trusted, so I only just
>> implement this callback in eSDHC-of driver. that is to say, just when the
>> platform support it, this callback can be implement, if not, continue to
>> send the command CMD13.
>>
>> I'm just wondering how this will affect our system, where we use the cd
>> GPIO to generate detect jobs on card insert/remove, but where the cd pin
>> is not 100% synchronized with the electrical connection of the power and
>> cmd line of the SD-card. So if I remember correctly, the cd pin may
>> report that the card has been removed, but there is still an electric
>> connection and the card is alive...
>>
> I don't see this on our board, when card is inserted or removed, the register field can reflect this state correctly.

We see a difference on our boards with this patch, but no functional
change (actually a removed card is detected earlier now), so from my
perspective:

Reviewed-By: Johan Rudholm <johan.rudholm@stericsson.com>

//Johan

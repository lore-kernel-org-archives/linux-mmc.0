From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH v4] mmc: meson: Add driver for the SD/MMC host found on
 Amlogic MesonX SoCs
Date: Tue, 2 Feb 2016 22:54:08 +0100
Message-ID: <CAOQ7t2aS0yRDhM3+8wW5xrycG371uthDJy6U_oDAZip4jHRiRA@mail.gmail.com>
References: <1448988109-32630-1-git-send-email-carlo@caione.org>
	<CAPDyKFp=buvJ8Li3XC8XSUAUO7BsE+U6vEQH2xTrgcHAkdG8bQ@mail.gmail.com>
	<CAOQ7t2aJAPWd3Xmvu7n0EWL-KC8ZriM3KryfsYEh556uXhuR+g@mail.gmail.com>
	<CAPDyKFpcsKihuOiF5=RwoWrF0Jf7hRsXVSU5uV8qZf1mUsa-iQ@mail.gmail.com>
	<CAOQ7t2afXxStCsj=M-FX7eMep1gLt4jkyXDiLas_SQ1UwHc0=Q@mail.gmail.com>
	<CAPDyKFpX+_fHvv_bJUKZmSufKKnuONC582E7u3b20a+Rbbggng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34218 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942AbcBBVyJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 16:54:09 -0500
Received: by mail-wm0-f66.google.com with SMTP id p63so4378414wmp.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Feb 2016 13:54:08 -0800 (PST)
In-Reply-To: <CAPDyKFpX+_fHvv_bJUKZmSufKKnuONC582E7u3b20a+Rbbggng@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-meson@googlegroups.com, linux@endlessm.com

On Tue, Feb 2, 2016 at 12:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 1 February 2016 at 23:05, Carlo Caione <carlo@caione.org> wrote:
>> On Tue, Dec 8, 2015 at 9:35 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

[cut]

>> I still fail to see what the correct behaviour should be.
>> Using the v4 of this driver with a "broken-cd" binding and a timeout
>> of 10s my SD card takes 30s to be identified as removed after I take
>> it out from the SD slot.
>> Also, if I take it out and insert it again, I still have to wait 30s
>> to be able to access it again. Is this a limitation / bug of my driver
>> or is this the expected behaviour when we do not have a dedicated GPIO
>> for card detection?
>
> It's *not* an expected a behaviour.
>
> Using MMC_CAP_NEEDS_POLL, means that the mmc core will send CMD13
> commands in a polling manner to find out whether a card has been
> removed.
>
> It seems like when the card is removed, the host driver doesn't get an
> IRQ which indicates a command timeout. Instead it waits for the 10 s
> timeout to expire.
>
> My question is then; why don't the driver get an IRQ for the command
> timeout? Is that because of non-correct setup of the IRQ masks or
> because the controller HW doesn't support this?

I just verified that apparently the HW doesn't support this (no
register for commands timeout and no IRQ generated).
Anything wrong with implementing this in software with a timer on
mrq->data->timeout_ns?

-- 
Carlo Caione

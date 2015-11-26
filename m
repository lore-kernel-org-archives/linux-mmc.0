From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: Introduce MMC_CAP2_NO_SDIO cap
Date: Thu, 26 Nov 2015 12:04:47 +0100
Message-ID: <CAPDyKFoHvvx5AEHA-c8ViTsNpdEhV2aahWh0+3Tq_hTOAVTtYw@mail.gmail.com>
References: <1448462391-22480-1-git-send-email-carlo@caione.org>
	<CAPDyKFrL8Wi7bFxjxZD1m=mkRa+C_tco5o6RX8H93meWt7bXmg@mail.gmail.com>
	<CAL9uMOFmZtQeEwML8c01He2Q3mKmMk4o88X-GvXV6fOP28+5jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33955 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbbKZLEs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2015 06:04:48 -0500
Received: by ykfs79 with SMTP id s79so86932882ykf.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2015 03:04:47 -0800 (PST)
In-Reply-To: <CAL9uMOFmZtQeEwML8c01He2Q3mKmMk4o88X-GvXV6fOP28+5jA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Carlo Caione <carlo@endlessm.com>
Cc: Carlo Caione <carlo@caione.org>, linux-mmc <linux-mmc@vger.kernel.org>, Daniel Drake <drake@endlessm.com>

On 25 November 2015 at 18:16, Carlo Caione <carlo@endlessm.com> wrote:
> On Wed, Nov 25, 2015 at 5:34 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 25 November 2015 at 15:39, Carlo Caione <carlo@caione.org> wrote:
>>> From: Carlo Caione <carlo@endlessm.com>
>>>
>>> This patch introduce a new MMC_CAP2_NO_SDIO cap used to tell the mmc
>>> core to not send SDIO specific commands.
>>
>> I guess there are two reasons to why such capability is useful.
>> 1) The host controller/driver doesn't support SDIO.
>> 2) There is an embedded/non-removable eMMC/SD card.
>>
>> Within that context, we might also want to add MMC_CAP2_NO_MMC|SD, or
>> what do you think?
>
> Is there really any driver / controller not supporting MMC|SD commands?

Probably not.

I was thinking of optimizing the time it takes to detect a card. For
example, if we know it's a non-removable eMMC, we can skip the SDIO
and SD part in the initialization sequence. Whether that's really
worth to optimize I don't know without measuring the times.

[...]

Kind regards
Uffe

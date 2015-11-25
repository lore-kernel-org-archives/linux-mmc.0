From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH v2] mmc: core: Introduce MMC_CAP2_NO_SDIO cap
Date: Wed, 25 Nov 2015 18:16:37 +0100
Message-ID: <CAL9uMOFmZtQeEwML8c01He2Q3mKmMk4o88X-GvXV6fOP28+5jA@mail.gmail.com>
References: <1448462391-22480-1-git-send-email-carlo@caione.org>
	<CAPDyKFrL8Wi7bFxjxZD1m=mkRa+C_tco5o6RX8H93meWt7bXmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36793 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbKYRQi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 12:16:38 -0500
Received: by iofh3 with SMTP id h3so60168201iof.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 09:16:37 -0800 (PST)
In-Reply-To: <CAPDyKFrL8Wi7bFxjxZD1m=mkRa+C_tco5o6RX8H93meWt7bXmg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, linux-mmc <linux-mmc@vger.kernel.org>, Daniel Drake <drake@endlessm.com>

On Wed, Nov 25, 2015 at 5:34 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 25 November 2015 at 15:39, Carlo Caione <carlo@caione.org> wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> This patch introduce a new MMC_CAP2_NO_SDIO cap used to tell the mmc
>> core to not send SDIO specific commands.
>
> I guess there are two reasons to why such capability is useful.
> 1) The host controller/driver doesn't support SDIO.
> 2) There is an embedded/non-removable eMMC/SD card.
>
> Within that context, we might also want to add MMC_CAP2_NO_MMC|SD, or
> what do you think?

Is there really any driver / controller not supporting MMC|SD commands?

> Because of 2), we might also want to add a new mmc DT binding or
> perhaps try interpret a combination of them to enable
> MMC_CAP2_NO_SDIO!?

Probably I'm missing something but what would be the difference with
the 'non-removable' parameter we already have?

>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>
> Thanks, applied for next!

Thanks,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless

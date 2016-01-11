From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH RESEND] mmc: core: Enable tuning according to the actual timing
Date: Mon, 11 Jan 2016 15:17:20 +0100
Message-ID: <CAOQ7t2bhL3Ueiz0z1SQhPBydiXaD6k9Ei47gQtAi+o2W7G_0tQ@mail.gmail.com>
References: <1451942158-32409-1-git-send-email-carlo@caione.org>
	<CAPDyKFqxNbABOBrh0it3zJf_BzhOuv_aBhCDCKXgya9MzSUu_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34915 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289AbcAKORV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jan 2016 09:17:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id f206so26486438wmf.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2016 06:17:20 -0800 (PST)
In-Reply-To: <CAPDyKFqxNbABOBrh0it3zJf_BzhOuv_aBhCDCKXgya9MzSUu_A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, "Yang, York" <weijuny@qti.qualcomm.com>, Barry Song <21cnbao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, "Song, Barry" <baohuas@qti.qualcomm.com>, Carlo Caione <carlo@endlessm.com>

On Mon, Jan 11, 2016 at 1:22 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 January 2016 at 22:15, Carlo Caione <carlo@caione.org> wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> While in sdhci_execute_tuning() the choice whether or not to enable the
>> tuning is done on the actual timing, in the mmc_sdio_init_uhs_card() the
>> check is done on the capability of the card.
>>
>> This difference is causing some issues with some SDIO cards in DDR50
>> mode where the CDM19 is wrongly issued.
>
> I wonder if this statement is really correct, because for SDIO cards
> in DDR50 the tuning command wasn't being issued. Right!?

Not quite. In my case the issue of the tuning command was the problem.
This patch is basically what was suggested by Yang here
http://permalink.gmane.org/gmane.linux.kernel.mmc/35055

>> With this patch we modify the check in both
>> mmc_(sd|sdio)_init_uhs_card() functions to take the proper decision
>> only according to the actual timing specification.
>
> Certainly there's a bug in the way how we initiate SDIO cards from the
> mmc core perspective, but how is the SD case wrong?

The SD case is not wrong. I changed it also to be more aligned with
the SDIO case

> Anyway, I do like the change as such as the code gets more aligned to
> check the "ios.timing" parameter.

Agree

> Please add "stable" tag, unless we can find a reasonable commit it
> fixes and add a fixes tag instead.

Ok

Thanks,

-- 
Carlo Caione

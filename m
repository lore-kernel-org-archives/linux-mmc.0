From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: use card pointer as the first parameter of execute_tuning()
Date: Wed, 4 Feb 2015 13:54:01 +0100
Message-ID: <CAPDyKFr-vjYP-hN7PvWx1NWaEh2Yi=fagkLJASkVemQXFXh6Zw@mail.gmail.com>
References: <1422271175-19445-1-git-send-email-addy.ke@rock-chips.com>
	<1422271175-19445-2-git-send-email-addy.ke@rock-chips.com>
	<CAPDyKFp=5epMggHu0+u_LU7ETujcoeP2xOpB7iD6JF2bs8BnEA@mail.gmail.com>
	<CAD=FV=X9x0gW5TyLi4ERm8nxixQB__Y=5bRAtOax-_w+T33rCg@mail.gmail.com>
	<CAPDyKFqjG=yxDcwnk4jbXMZ05hMkWR2x37uVpRNd_11-eB4G7w@mail.gmail.com>
	<CAD=FV=VQg+sQUpgbKw7Zz=-f+jPM=6O-+3gUpohWhj8JeSPu6Q@mail.gmail.com>
	<CAPDyKFqjY-Sn2mNqjy1FH3RPFuJSfhTX_esQDao1Yb4qumHYcg@mail.gmail.com>
	<CAD=FV=XCBebTzWpNPn9GaTRU3O1BMurhoTDWcXHYXBChBRnOjQ@mail.gmail.com>
	<54CAD98F.3070805@rock-chips.com>
	<54CF2966.2000105@rock-chips.com>
	<CAPDyKFrZb0jYG7zFjGz6K2Ss=JG4JXMELpjrQi0SgazaEEnW4w@mail.gmail.com>
	<CAPDyKFoRK1VfzR1JN8z3XYh5a1MEKMwsiSqzPh7OgT+C0SA25w@mail.gmail.com>
	<54CF3D26.7020004@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:38012 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965729AbbBDMyD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Feb 2015 07:54:03 -0500
Received: by mail-qc0-f179.google.com with SMTP id w7so949310qcr.10
        for <linux-mmc@vger.kernel.org>; Wed, 04 Feb 2015 04:54:01 -0800 (PST)
In-Reply-To: <54CF3D26.7020004@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: addy ke <addy.ke@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

On 2 February 2015 at 10:02, addy ke <addy.ke@rock-chips.com> wrote:
>
>
> On 2015/2/2 16:17, Ulf Hansson wrote:
>> On 2 February 2015 at 09:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>>
>>>>> about bus_ops->alive, I think it can't use in tuning state.
>>>>> Because:
>>>>> bus_ops->alive() --> mmc_sd_alive(host) /* sd card */ -->mmc_send_status(host->card, NULL);
>>>>> But host->card == NULL in tuning state(mmc_sd_init_card->mmc_sd_init_uhs_card).
>>>>>
>>>>> Only if sd is initialized successfully, we can get card pointer by host->card.
>>>>> see: mmc_sd_init_card(drivers/mmc/core/sd.c), the end of this function: host->card = card
>>>> And bus_ops->alive only check whether mmc is alive or not, the second parameter(*status) is NULL,
>>>> We can not get the card status.
>>>> But in tuning state, we need wait until card is idle, if the previous tuning is failed.
>>>
>>> You are right that we can't use bus_ops->alive() in its current form.
>>> Changing it to take "card" and "status" as parameter should fix this
>>> for us. My point was more that we can't use mmc_send_status() since
>>> that doesn't work for SDIO.
>
> For sdio, I think maybe we can use CMD7 to get sdio status.
>
> And there are 3 file which need get card status at least:
> 1. drivers/mmc/core/mmc_ops.c: mmc_send_status()
> 2. drivers/mmc/card/block.c: get_card_status()
> 3. drivers/mmc/card/mmc_test.c: mmc_test_wait_busy()
> Maybe we need merge them and provide uniform interface for them.
>
>>>
>>> Anyway, it seems like we need to put this patchset on hold for a while.
>>>
>>> You I merge the below patch instead so we at least have something
>>
>> /s /You / Should
>>
>>> working for 3.20?
> This patch can work, but it need delay 10ms each tuning.
> It is too slow to initialize the card(tuning time >= (10 * tuning_count) ms)

Yes, it seems like it's not the perfect solution, but what options do
we have right now? Leave it as is or should I apply below patch?

Jaehoon, what's your view on this?

>>>
>>> [PATCH] mmc: dw_mmc: rockchip: Add DW_MCI_QUIRK_RETRY_DELAY
>>> https://lkml.org/lkml/2015/1/13/562
>>>

Kind regards
Uffe

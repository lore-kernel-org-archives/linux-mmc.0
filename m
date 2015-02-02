From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: use card pointer as the first parameter of execute_tuning()
Date: Mon, 2 Feb 2015 09:17:04 +0100
Message-ID: <CAPDyKFoRK1VfzR1JN8z3XYh5a1MEKMwsiSqzPh7OgT+C0SA25w@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:52243 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbbBBIRE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Feb 2015 03:17:04 -0500
Received: by mail-qc0-f172.google.com with SMTP id x3so5095061qcv.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Feb 2015 00:17:04 -0800 (PST)
In-Reply-To: <CAPDyKFrZb0jYG7zFjGz6K2Ss=JG4JXMELpjrQi0SgazaEEnW4w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: addy ke <addy.ke@rock-chips.com>, Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

On 2 February 2015 at 09:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>> about bus_ops->alive, I think it can't use in tuning state.
>>> Because:
>>> bus_ops->alive() --> mmc_sd_alive(host) /* sd card */ -->mmc_send_status(host->card, NULL);
>>> But host->card == NULL in tuning state(mmc_sd_init_card->mmc_sd_init_uhs_card).
>>>
>>> Only if sd is initialized successfully, we can get card pointer by host->card.
>>> see: mmc_sd_init_card(drivers/mmc/core/sd.c), the end of this function: host->card = card
>> And bus_ops->alive only check whether mmc is alive or not, the second parameter(*status) is NULL,
>> We can not get the card status.
>> But in tuning state, we need wait until card is idle, if the previous tuning is failed.
>
> You are right that we can't use bus_ops->alive() in its current form.
> Changing it to take "card" and "status" as parameter should fix this
> for us. My point was more that we can't use mmc_send_status() since
> that doesn't work for SDIO.
>
> Anyway, it seems like we need to put this patchset on hold for a while.
>
> You I merge the below patch instead so we at least have something

/s /You / Should

> working for 3.20?
>
> [PATCH] mmc: dw_mmc: rockchip: Add DW_MCI_QUIRK_RETRY_DELAY
> https://lkml.org/lkml/2015/1/13/562
>
> Kind regards
> Uffe
